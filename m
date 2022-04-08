Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545364F90F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiDHIg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiDHIgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:36:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49052FF599;
        Fri,  8 Apr 2022 01:34:20 -0700 (PDT)
Received: from zn.tnic (p200300ea971561a9329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:61a9:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5116B1EC0445;
        Fri,  8 Apr 2022 10:34:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649406855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+UM7gmu9BXYvquOX3OamJYimXfFmDeZA/dtmCZUBglw=;
        b=k1y/zw+J9AQWVow8qwgv05yji5qd8InFZbomSek/ZxF0rApG5eH5fq0qUwCQ5FXz4ni7HF
        IhPcVjKeKNKkaiAie5vHf5rYNByHSJt4ZoZuogfwB3JVkLi0qaxdvnKjhNR9BbZcB01V1X
        1oK94rVdY/dg5+zzOYYOC+4r6XIWWwY=
Date:   Fri, 8 Apr 2022 10:34:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jithu Joseph <jithu.joseph@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v2 01/10] x86/microcode/intel: expose
 collect_cpu_info_early() for IFS
Message-ID: <Yk/zhV3SGib6TaI5@zn.tnic>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
 <20220407191347.9681-2-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220407191347.9681-2-jithu.joseph@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 12:13:38PM -0700, Jithu Joseph wrote:
> diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
> index d85a07d7154f..cf0fd1d712b4 100644
> --- a/arch/x86/include/asm/microcode_intel.h
> +++ b/arch/x86/include/asm/microcode_intel.h
> @@ -68,6 +68,10 @@ static inline u32 intel_get_microcode_revision(void)
>  	return rev;
>  }
>  
> +int cpu_collect_info_early(struct ucode_cpu_info *uci);
> +bool cpu_signatures_match(unsigned int s1, unsigned int p1,
> +			  unsigned int s2, unsigned int p2);
> +

So you can't move the functions to cpu/intel.c but put the
prototype declarations in the microcode header - they should go to
arch/x86/include/asm/cpu.h or so.


>  #ifdef CONFIG_MICROCODE_INTEL
>  extern void __init load_ucode_intel_bsp(void);
>  extern void load_ucode_intel_ap(void);
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 8321c43554a1..2008c8267fd3 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -181,6 +181,53 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
>  	return false;
>  }
>  
> +bool cpu_signatures_match(unsigned int s1, unsigned int p1,

That function is Intel-specific:

intel_cpu_signatures_match()

and it is small enough to stick it in the above header and make it an
inline without the need for an export.

> +			  unsigned int s2, unsigned int p2)
> +{
> +	if (s1 != s2)
> +		return false;
> +
> +	/* Processor flags are either both 0 ... */
> +	if (!p1 && !p2)
> +		return true;
> +
> +	/* ... or they intersect. */
> +	return p1 & p2;
> +}
> +EXPORT_SYMBOL_GPL(cpu_signatures_match);
> +
> +int cpu_collect_info_early(struct ucode_cpu_info *uci)

intel_collect_cpu_info_early()

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
