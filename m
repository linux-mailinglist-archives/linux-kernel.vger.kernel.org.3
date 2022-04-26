Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A7A51006D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351637AbiDZO3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351430AbiDZO3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:29:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C37C60AAB;
        Tue, 26 Apr 2022 07:26:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 149EBB8204E;
        Tue, 26 Apr 2022 14:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916BFC385AA;
        Tue, 26 Apr 2022 14:26:31 +0000 (UTC)
Date:   Tue, 26 Apr 2022 15:26:28 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
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
Subject: Re: [PATCH v22 4/9] arm64: kdump: Don't force page-level mappings
 for memory above 4G
Message-ID: <YmgBFPMbyyOH/52y@arm.com>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
 <20220414115720.1887-5-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414115720.1887-5-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 07:57:15PM +0800, Zhen Lei wrote:
> @@ -540,13 +540,31 @@ static void __init map_mem(pgd_t *pgdp)
>  	for_each_mem_range(i, &start, &end) {
>  		if (start >= end)
>  			break;
> +
> +#ifdef CONFIG_KEXEC_CORE
> +		if (eflags && (end >= SZ_4G)) {
> +			/*
> +			 * The memory block cross the 4G boundary.
> +			 * Forcibly use page-level mappings for memory under 4G.
> +			 */
> +			if (start < SZ_4G) {
> +				__map_memblock(pgdp, start, SZ_4G - 1,
> +					       pgprot_tagged(PAGE_KERNEL), flags | eflags);
> +				start  = SZ_4G;
> +			}
> +
> +			/* Page-level mappings is not mandatory for memory above 4G */
> +			eflags = 0;
> +		}
> +#endif

That's a bit tricky if a SoC has all RAM above 4G. IIRC AMD Seattle had
this layout. See max_zone_phys() for how we deal with this, basically
extending ZONE_DMA to the whole range if RAM starts above 4GB. In that
case, crashkernel reservation would fall in the range above 4GB.

BTW, we changed the max_zone_phys() logic with commit 791ab8b2e3db
("arm64: Ignore any DMA offsets in the max_zone_phys() calculation").

-- 
Catalin
