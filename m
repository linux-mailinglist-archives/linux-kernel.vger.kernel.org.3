Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BD34BC4BE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 03:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241087AbiBSCP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 21:15:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiBSCPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 21:15:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5705E268365
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 18:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645236936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VmMABEHyE6c0Nw2VYo3JbB3nEB3uWtcgbJm0UG43gd0=;
        b=STxdv8IGm3EPKTXKQWsbInUMAeD/HkgmVbn41RQRj/lh76jr3lrnqg/NvqoU7nA7IOq3JM
        OFs0jjEuRNIsQsFeSl58xspkpAVUNsuLGOwbqYk8K+4/Isfp6CmQM/NNeoaWuOH4CEKwA0
        wZC9dTT7DoCvOVfI/5KJmRAxxWcVZIU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-Ay-b69n0M-WEH8oTeX9OFA-1; Fri, 18 Feb 2022 21:15:35 -0500
X-MC-Unique: Ay-b69n0M-WEH8oTeX9OFA-1
Received: by mail-qv1-f70.google.com with SMTP id eu2-20020ad44f42000000b0042bfcac4a52so10707967qvb.16
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 18:15:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VmMABEHyE6c0Nw2VYo3JbB3nEB3uWtcgbJm0UG43gd0=;
        b=TMriyQhETRlzRPNrn0b/p9xvkneF3Ms+GcvrW8kB/Px3NYzKzjQD8m3K71LoyRsCJq
         97El2czJ+Yc8IsqxJXKxqM757/2omYj2xYk3hvt5A4JpAx8dBQFA0eNj1bTC9Hss87Uy
         YGz6raRZy6A3GqGvZNg/NGrwte8IO4AFfzvATSIWxD6ShyPCqwgmU9s0B1Dw/k+aBg3L
         kwq1rY1mzE6719ZGfN+dfPc2parELMpMoI8WZr1roRFmOeVtzsdnYO31hSUx87t0oOqJ
         b73bud/AIdLramOcKFQ0wSksaj8OjvC2NwD0sZsFg4dcXbhdiZnZXJwoyk6z2YoDRP60
         JW2g==
X-Gm-Message-State: AOAM531QWMombrisd6T2ij0lbaSebu104eDRPfK2myiFrst+EnyUIqI7
        8SRVd4uELoE75cPycbVm4D6GeAMoygaBpOo9TbSqBsVrnPB3qX69Bh/PkA4aE3jwcugeJ4cXYgx
        f7an2q/7sxrOKpO3lDY/uNG9p
X-Received: by 2002:ae9:ea06:0:b0:46c:e3c1:71f1 with SMTP id f6-20020ae9ea06000000b0046ce3c171f1mr6517373qkg.684.1645236934629;
        Fri, 18 Feb 2022 18:15:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxruQkIZP1dlD88uAr2ky1hnzUZHMCld1uUsFqRtrj/PEqi15cxxkwPlsi03WWZHsLIA6fthQ==
X-Received: by 2002:ae9:ea06:0:b0:46c:e3c1:71f1 with SMTP id f6-20020ae9ea06000000b0046ce3c171f1mr6517364qkg.684.1645236934380;
        Fri, 18 Feb 2022 18:15:34 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id j128sm1991902qkd.61.2022.02.18.18.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 18:15:33 -0800 (PST)
Date:   Fri, 18 Feb 2022 18:15:30 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 16/29] x86/bugs: Disable Retpoline when IBT
Message-ID: <20220219021530.hq6po7uexc4w36qo@treble>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.520731494@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220218171409.520731494@infradead.org>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 05:49:18PM +0100, Peter Zijlstra wrote:
> Retpoline and IBT are mutually exclusive. IBT relies on indirect
> branches (JMP/CALL *%reg) while retpoline avoids them by design.
> 
> Demote to LFENCE on IBT enabled hardware.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/cpu/bugs.c |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -937,6 +937,11 @@ static void __init spectre_v2_select_mit
>  	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
>  	retpoline_amd:
>  		if (!boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
> +			if (IS_ENABLED(CONFIG_X86_IBT) &&
> +			    boot_cpu_has(X86_FEATURE_IBT)) {
> +				pr_err("Spectre mitigation: LFENCE not serializing, generic retpoline not available due to IBT, switching to none\n");
> +				return;
> +			}
>  			pr_err("Spectre mitigation: LFENCE not serializing, switching to generic retpoline\n");
>  			goto retpoline_generic;
>  		}
> @@ -945,6 +950,26 @@ static void __init spectre_v2_select_mit
>  		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
>  	} else {
>  	retpoline_generic:
> +		/*
> +		 *  Full retpoline is incompatible with IBT, demote to LFENCE.
> +		 */
> +		if (IS_ENABLED(CONFIG_X86_IBT) &&
> +		    boot_cpu_has(X86_FEATURE_IBT)) {
> +			switch (cmd) {
> +			case SPECTRE_V2_CMD_FORCE:
> +			case SPECTRE_V2_CMD_AUTO:
> +			case SPECTRE_V2_CMD_RETPOLINE:
> +				/* silent for auto select */
> +				break;
> +
> +			default:
> +				/* warn when 'demoting' an explicit selection */
> +				pr_warn("Spectre mitigation: Switching to LFENCE due to IBT\n");
> +				break;

This code is confusing, not helped by the fact that the existing code
already looks like spaghetti.

Assuming IBT systems also have eIBRS (right?), I don't think the above
SPECTRE_V2_CMD_{FORCE,AUTO} cases would be possible.

AFAICT, if execution reached the retpoline_generic label, the user
specified either RETPOLINE or RETPOLINE_GENERIC.

I'm not sure it makes sense to put RETPOLINE in the "silent" list.  If
the user boots an Intel system with spectre_v2=retpoline on the cmdline,
they're probably expecting a traditional retpoline and should be warned
if that changes, especially if it's a "demotion".

In that case the switch statement isn't even needed.  It can instead
just unconditinoally print the warning.


Also, why "demote" retpoline to LFENCE rather than attempting to
"promote" it to eIBRS?  Maybe there's a good reason but it probably at
least deserves some mention in the commit log.

-- 
Josh

