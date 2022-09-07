Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CA35B09B7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiIGQHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiIGQGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:06:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562F1A2DB7;
        Wed,  7 Sep 2022 09:05:27 -0700 (PDT)
Received: from nazgul.tnic (unknown [84.201.196.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E5A681EC068D;
        Wed,  7 Sep 2022 18:05:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1662566722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jgNWsBoBSXWNUzswLsLjK+/VN0ef25YJ6b11A0o0dh0=;
        b=ANOb/YoU74sl6o8ATWokQlofsEAbLbhiPYAeFjTUgsqLPpTTN+Xg7YTj/sbMwziDtlHiLj
        zkyzmsYH9Cf717QwJJ+jyGCZR1VrjQR5xhii4Q+XC2+xR9XraxBXtETsVI7ZOGqDBv4i+T
        Vl4QrqyPsIM/ZmCvg2Dxrtx6hXRKJuU=
Date:   Wed, 7 Sep 2022 18:05:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     dan.j.williams@intel.com, x86@kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, a.manzanares@samsung.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] memregion: Add arch_flush_memregion() interface
Message-ID: <YxjBSxtoav7PQVei@nazgul.tnic>
References: <20220829212918.4039240-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220829212918.4039240-1-dave@stgolabs.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 02:29:18PM -0700, Davidlohr Bueso wrote:
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 1abd5438f126..18463cb704fb 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -330,6 +330,20 @@ void arch_invalidate_pmem(void *addr, size_t size)
>  EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
>  #endif
>  
> +#ifdef CONFIG_ARCH_HAS_MEMREGION_INVALIDATE
> +bool arch_has_flush_memregion(void)
> +{
> +	return !cpu_feature_enabled(X86_FEATURE_HYPERVISOR);

This looks really weird. Why does this need to care about HV at all?

Does that nfit stuff even run in guests?

> +EXPORT_SYMBOL(arch_has_flush_memregion);

...

> +EXPORT_SYMBOL(arch_flush_memregion);

Why aren't those exports _GPL?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
