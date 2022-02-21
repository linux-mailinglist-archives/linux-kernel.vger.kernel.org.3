Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40874BD429
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 04:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243681AbiBUDXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 22:23:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239659AbiBUDXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 22:23:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC16A31DF7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 19:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645413805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UbQQFCgnQIVIZZPgSlksdQLecjmzQ0HCcY6adsazJww=;
        b=cgNV9Q5/gGiB93CUnARdkwWtpVfz8iLZYHjuc90xCU/6B2AtS1NuggKjvfYC1/YyKPas9e
        LuNXhDfCm47nKPiD0xI8cOtKwQGrigynhDhxdchgU32GVXMuZ2v1G0wcHPM6In8PMYMR5k
        nN2/qkSR134WQrbMUIMgBnRl/L96RVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-WvW5EuPqM1-kJoFwBDMQ6Q-1; Sun, 20 Feb 2022 22:23:22 -0500
X-MC-Unique: WvW5EuPqM1-kJoFwBDMQ6Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 119AD2F4A;
        Mon, 21 Feb 2022 03:23:19 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 574A7E2E5;
        Mon, 21 Feb 2022 03:23:01 +0000 (UTC)
Date:   Mon, 21 Feb 2022 11:22:58 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v20 2/5] arm64: kdump: introduce some macros for crash
 kernel reservation
Message-ID: <YhMFkgkqnZ4A3ysK@MiWiFi-R3L-srv>
References: <20220124084708.683-1-thunder.leizhen@huawei.com>
 <20220124084708.683-3-thunder.leizhen@huawei.com>
 <YgY89RxkAl12n/dd@MiWiFi-R3L-srv>
 <69da7ed5-4ef4-3655-8965-4181c7d7bf0b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69da7ed5-4ef4-3655-8965-4181c7d7bf0b@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/22 at 02:22pm, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/2/11 18:39, Baoquan He wrote:
> > On 01/24/22 at 04:47pm, Zhen Lei wrote:
> >> From: Chen Zhou <chenzhou10@huawei.com>
> >>
> >> Introduce macro CRASH_ALIGN for alignment, macro CRASH_ADDR_LOW_MAX
> >> for upper bound of low crash memory, macro CRASH_ADDR_HIGH_MAX for
> >> upper bound of high crash memory, use macros instead.
> >>
> >> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> >> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> >> ---
> >>  arch/arm64/mm/init.c | 11 ++++++++---
> >>  1 file changed, 8 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >> index 90f276d46b93bc6..6c653a2c7cff052 100644
> >> --- a/arch/arm64/mm/init.c
> >> +++ b/arch/arm64/mm/init.c
> >> @@ -65,6 +65,12 @@ EXPORT_SYMBOL(memstart_addr);
> >>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
> >>  
> >>  #ifdef CONFIG_KEXEC_CORE
> >> +/* Current arm64 boot protocol requires 2MB alignment */
> >> +#define CRASH_ALIGN		SZ_2M
> >> +
> >> +#define CRASH_ADDR_LOW_MAX	arm64_dma_phys_limit
> >> +#define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
> > 
> > MEMBLOCK_ALLOC_ACCESSIBLE is obvoiously a alloc flag for memblock
> > allocator, I don't think it's appropriate to make HIGH_MAX get its value.
> 
> Right, thanks.
> 
> > You can make it as memblock.current_limit, or do not define it, but using
> > MEMBLOCK_ALLOC_ACCESSIBLE direclty in memblock_phys_alloc_range() with
> > a code comment. 
> 
> This patch is not required at present. These macros are added to eliminate
> differences to share code with x86.

So this patch may not be needed in this series. It can be added in
another post when you start to do the clean up and code unification
among ARCHes, with my udnerstanding. At that time you can consider how
to abstract the common code to handle the difference.

