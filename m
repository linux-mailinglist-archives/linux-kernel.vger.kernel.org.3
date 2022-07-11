Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3420A570BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiGKUbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiGKUbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:31:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74D0187357
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657571390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YA3t12kUx6TRUZ4J3klDSw0cDfONNOfIRji5CEtBg00=;
        b=aSVQYCDgOqRXoI5BMjM5mED/Ng3eYSdShmHZPYEI/VgIBbmQX9eOJbfSMUmF1mDruGCGFP
        dM1Fr1TCC109ulsuaznUFvOQksntF1tBFEn/5xVSYqSpuYoTxYmeibFrdo+NRtxd8WZhHd
        O6o0ACNR/SRn3YnFiq57o/W/3/B3TSQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-tGj4wBT0OT2vJjeuLyCFEA-1; Mon, 11 Jul 2022 16:29:47 -0400
X-MC-Unique: tGj4wBT0OT2vJjeuLyCFEA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4310101E985;
        Mon, 11 Jul 2022 20:29:46 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 810D92166B26;
        Mon, 11 Jul 2022 20:29:46 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 26BKTkAL005368;
        Mon, 11 Jul 2022 16:29:46 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 26BKTjIX005364;
        Mon, 11 Jul 2022 16:29:45 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 11 Jul 2022 16:29:45 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Mike Snitzer <msnitzer@redhat.com>
cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH] dm writecache: fix inaccurate reads/writes stats
In-Reply-To: <20220706093146.1961598-1-yukuai1@huaweicloud.com>
Message-ID: <alpine.LRH.2.02.2207111627260.5249@file01.intranet.prod.int.rdu2.redhat.com>
References: <20220706093146.1961598-1-yukuai1@huaweicloud.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Jul 2022, Yu Kuai wrote:

> From: Yu Kuai <yukuai3@huawei.com>
> 
> Test procedures:
> 
> 1) format a dm writecache device with 4k blocksize.
> 2) flush cache.
> 3) cache 1G data through write.
> 4) clear stats.
> 5) read 2G data with bs=1m.
> 6) read stats.
> 
> Expected result:
> cache hit ratio is 50%.
> 
> Test result:
> stats: 0, 1011345, 749201, 0, 263168, 262144, 0, 0, 0, 0, 0, 0, 0, 0
> ratio is 99% (262144/263168)

Hi

Here I'm providing patches that change the dm-writecache counting from 
requests to blocks.

Mike, you can queue them for the next merge window.

Mikulas

