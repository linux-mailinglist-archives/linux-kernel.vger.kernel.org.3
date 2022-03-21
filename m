Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D7F4E22C8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345508AbiCUJBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345353AbiCUJBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:01:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD73710FA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:59:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 42178210EC;
        Mon, 21 Mar 2022 08:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647853190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rerL71kehnz2q1cuLKpY1j8XERV8cV3bZj87Fo6jIys=;
        b=poiCcF7d/51GTWfnNu2CbvHJnzPs2yUjE5Y7L3EkTLobZrTCOGqy2oYA7niyWrfBCVNWPQ
        3MDrFE82IngFzzAbTGUR2NDZ4PM13k/05MI58h48sOPbvbs7TN65SMiQQxFVNo6P2fQSdz
        NT6zcFxbSGWCQWWTd/B+mbAmx256Gmw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 09E3DA3B87;
        Mon, 21 Mar 2022 08:59:49 +0000 (UTC)
Date:   Mon, 21 Mar 2022 09:59:49 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kosaki.motohiro@jp.fujitsu.com, mgorman@suse.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mempolicy: fix potential mpol_new leak in
 shared_policy_replace
Message-ID: <Yjg+hVuJBPGhkfeJ@dhcp22.suse.cz>
References: <20220311093624.39546-1-linmiaohe@huawei.com>
 <Yi9w7TCYbj+OLGXJ@dhcp22.suse.cz>
 <26577566-ae1e-801c-8c64-89c2c89a487d@huawei.com>
 <YjCwYpTbGzAj9kmg@dhcp22.suse.cz>
 <24b2a9ef-eea0-09bd-6842-121d8436e56a@huawei.com>
 <YjG0PsF25wpAEOY3@dhcp22.suse.cz>
 <6ebebfd6-6356-e956-4fbc-0abaa58308ff@huawei.com>
 <YjL5Y6ZrZ2eLnnTv@dhcp22.suse.cz>
 <207bbd69-6678-5120-3760-e2bcd9803a14@huawei.com>
 <36b0ea44-39ab-bc52-1ae5-eca2cf832900@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36b0ea44-39ab-bc52-1ae5-eca2cf832900@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 19-03-22 18:42:33, Miaohe Lin wrote:
[...]
> This would be triggered easily with below code snippet in my virtual machine:
> 
> 	shmid = shmget((key_t)5566, 1024 * PAGE_SIZE, 0666|IPC_CREAT);
> 	shm = shmat(shmid, 0, 0);
> 	loop {
> 		mbind(shm, 1024 * PAGE_SIZE, MPOL_LOCAL, mask, maxnode, 0);
> 		mbind(shm + 128 * PAGE_SIZE, 128 * PAGE_SIZE, MPOL_DEFAULT, mask, maxnode, 0);
> 	}
> 
> If there're many process doing the above work, mpol_new will be leaked easily.
> So should I resend this patch with Cc stable? But it seems I'am not supposed
> to make this decision and the maintainer will take care of this?

I would just add
Fixes: 42288fe366c4 ("mm: mempolicy: Convert shared_policy mutex to spinlock")
Cc: stable # 3.8

And also add your above reproducer snippet added to the original changelog.
This would be more then enough to conclude the importance.

Thank you for working hard on this!
-- 
Michal Hocko
SUSE Labs
