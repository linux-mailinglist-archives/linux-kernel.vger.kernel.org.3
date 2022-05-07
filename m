Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A7551E933
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 20:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386784AbiEGS04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 14:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiEGS0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 14:26:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8D624970;
        Sat,  7 May 2022 11:23:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C246613F5;
        Sat,  7 May 2022 18:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08741C385A5;
        Sat,  7 May 2022 18:23:00 +0000 (UTC)
Date:   Sat, 7 May 2022 19:22:57 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH v24 6/6] docs: kdump: Update the crashkernel description
 for arm64
Message-ID: <Yna5AVli1IIUd2kg@arm.com>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
 <20220506114402.365-7-thunder.leizhen@huawei.com>
 <20220506231451.GB122876@MiWiFi-R3L-srv>
 <6e662eae-e788-13d3-368a-e88ed159fc85@huawei.com>
 <YnXn87JnfUxI2lC2@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnXn87JnfUxI2lC2@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 11:30:59AM +0800, Baoquan He wrote:
> On 05/07/22 at 09:41am, Leizhen (ThunderTown) wrote:
> > On 2022/5/7 7:14, Baoquan He wrote:
> > > On 05/06/22 at 07:44pm, Zhen Lei wrote:
> > >> Now arm64 has added support for "crashkernel=X,high" and
> > >> "crashkernel=Y,low". Unlike x86, crash low memory is not allocated if
> > >> "crashkernel=Y,low" is not specified.
> > >>
> > >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > >> ---
> > >>  Documentation/admin-guide/kernel-parameters.txt | 9 +++++++--
> > >>  1 file changed, 7 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > >> index 3f1cc5e317ed4a5..aa44c61114aa4b8 100644
> > >> --- a/Documentation/admin-guide/kernel-parameters.txt
> > >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> > >> @@ -808,7 +808,7 @@
> > >>  			Documentation/admin-guide/kdump/kdump.rst for an example.
> > >>  
> > >>  	crashkernel=size[KMG],high
> > >> -			[KNL, X86-64] range could be above 4G. Allow kernel
> > >> +			[KNL, X86-64, ARM64] range could be above 4G. Allow kernel
> > >>  			to allocate physical memory region from top, so could
> > >>  			be above 4G if system have more than 4G ram installed.
> > >>  			Otherwise memory region will be allocated below 4G, if
> > >> @@ -821,7 +821,7 @@
> > >>  			that require some amount of low memory, e.g. swiotlb
> > >>  			requires at least 64M+32K low memory, also enough extra
> > >>  			low memory is needed to make sure DMA buffers for 32-bit
> > >> -			devices won't run out. Kernel would try to allocate at
> > >> +			devices won't run out. Kernel would try to allocate
> > >>  			at least 256M below 4G automatically.
> > >>  			This one let user to specify own low range under 4G
> > >>  			for second kernel instead.
> > >> @@ -829,6 +829,11 @@
> > >>  			It will be ignored when crashkernel=X,high is not used
> > >>  			or memory reserved is below 4G.
> > >>  
> > >> +			[KNL, ARM64] range in low memory.
> > >> +			This one let user to specify a low range in DMA zone for
> > >                                           ^ not needed,
> > >                         Maybe Catalin can fix it when merging.
> > 
> > Delete "This one let user to" or the entire sentence? I understand it to be the former.
> 
> Oh, I mean the 'to' is not needed. "This one let user specify ....". The
> 'to' is a grammer mistake.

Slightly more correct is "This one lets the user specify..."

I can fix them up when applying.

-- 
Catalin
