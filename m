Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3694F16F2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377198AbiDDO2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236290AbiDDO2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D5983ED36
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649082410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=00SPdiBN792DGmNNXEFWtbT6biOctwV+DhqAskQIi4U=;
        b=LsiFqKKTVp6ip+LKZv6iNsUI0twPPKv5tx43v4XvyC31hO1oByphWEWgeQ0Qv67FUTIIv2
        gfWTDaVAnkkqvZjqSyKHPrNIb7H7wvEXwLSSCVj9pnRyCPMZme2WTQzHqU94PIrbNZE7fj
        jPvJj/FtIaGOhyKPKBhb2xWfh6BKp1w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-gDmr3tXONoS5HHquW1K0cg-1; Mon, 04 Apr 2022 10:26:48 -0400
X-MC-Unique: gDmr3tXONoS5HHquW1K0cg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDA448117B0;
        Mon,  4 Apr 2022 14:26:47 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.8.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9216540679D;
        Mon,  4 Apr 2022 14:26:47 +0000 (UTC)
Date:   Mon, 4 Apr 2022 10:26:46 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        kernel-team@android.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] arch/arm64: Fix topology initialization for core
 scheduling
Message-ID: <YksAJv//TJ6+j778@lorien.usersys.redhat.com>
References: <20220331153926.25742-1-pauld@redhat.com>
 <164906426317.23108.12415745228600027656.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164906426317.23108.12415745228600027656.b4-ty@kernel.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 11:10:48AM +0100 Will Deacon wrote:
> On Thu, 31 Mar 2022 11:39:26 -0400, Phil Auld wrote:
> > Arm64 systems rely on store_cpu_topology() to call update_siblings_masks()
> > to transfer the toplogy to the various cpu masks. This needs to be done
> > before the call to notify_cpu_starting() which tells the scheduler about
> > each cpu found, otherwise the core scheduling data structures are setup
> > in a way that does not match the actual topology.
> > 
> > With smt_mask not setup correctly we bail on `cpumask_weight(smt_mask) == 1`
> > for !leaders in:
> > 
> > [...]
> 
> Applied to arm64 (for-next/fixes), thanks!
>

Thanks, Will!


Cheers,
Phil

> [1/1] arch/arm64: Fix topology initialization for core scheduling
>       https://git.kernel.org/arm64/c/5524cbb1bfcd
> 
> Cheers,
> -- 
> Will
> 
> https://fixes.arm64.dev
> https://next.arm64.dev
> https://will.arm64.dev
> 

-- 

