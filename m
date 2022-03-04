Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90ACD4CDB1B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiCDRkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiCDRke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:40:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0A82158D86
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646415585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lPgI5KBDMxO+9gfbk0fo+LKFfqiPLnIuJyBRw1R+UJk=;
        b=P8zvlBmjjZfk2mjJOGNe2e1eDR8m9V1XYt4GLF+jjCo9gdNJJBQ2tr3zox/pnFaBHkPvWv
        ahBtmP6g74Uso8DcvNG76X/5oStw4FP9JJIaz1R4Tsk1CCe1Dt+cDW+k62HHXBhYEyamb0
        /OSOYCsQ83zN51ag88Rx6P402CyaZu4=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-TJt8zkqvPYqelExP_u39VQ-1; Fri, 04 Mar 2022 12:39:44 -0500
X-MC-Unique: TJt8zkqvPYqelExP_u39VQ-1
Received: by mail-oo1-f71.google.com with SMTP id u13-20020a4ab5cd000000b002e021ad5bbcso6126696ooo.17
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 09:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lPgI5KBDMxO+9gfbk0fo+LKFfqiPLnIuJyBRw1R+UJk=;
        b=b+a1tElajm1P7pYp356cGmDeZu79A9asFab3xw18D9qd94HqRoB0J2lxzZl7iQDlpI
         VECtc2+u0onIZ2MMp/uhqb4qUatVvLz9FHrnQ58aqgt0/VjncaaxU5lyd9cJuACN3Rbo
         vucaHd+X2RXvepvXp3R+2j7H/OTS5xfzjtKokZZUJUoctu8hqSFeQ3WVBeyf9/Rc2BnD
         bZq4EYfpmloRyYLplSKLBHWf/N3n6VaNaYu3TLPWM053TbSQ5UefKMJlnXv4t9Xj6t8A
         /8JWB+gpYiBQ5zddLsX8BpTe1rk8JsD5/rCqlg6qGsvr3ZTaBq0yAsJcwyvZRsncuWxm
         BiiA==
X-Gm-Message-State: AOAM530FA/2oEozzGdMHh5z+YAgYtrjqPQ5n0JjeFOlZiGPVFSrBl4P4
        Lw8tKgC9k2gT+bEWqDutUHzY1mpQcffOoOHEGFVXXOoPiytlBXKbto1nXxif9/f+GdwUIWqRcSm
        SVPFXdgMQxIhb0qBUsHhBN9Hk
X-Received: by 2002:a05:6808:308e:b0:2d9:a01a:48a2 with SMTP id bl14-20020a056808308e00b002d9a01a48a2mr180638oib.237.1646415583289;
        Fri, 04 Mar 2022 09:39:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzfCC5LGdrrnBfiKqlqU7ceAnut51+V2E9Fz7RfzPGdXifWJEhhr9Eqw2bTucadAyvx3VSqQ==
X-Received: by 2002:a05:6808:308e:b0:2d9:a01a:48a2 with SMTP id bl14-20020a056808308e00b002d9a01a48a2mr180615oib.237.1646415583038;
        Fri, 04 Mar 2022 09:39:43 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id k25-20020a9d7019000000b005af14095afdsm2586483otj.0.2022.03.04.09.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 09:39:42 -0800 (PST)
Date:   Fri, 4 Mar 2022 09:39:39 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 25/39] x86/bugs: Disable Retpoline when IBT
Message-ID: <20220304173939.rea2ud2h45l2gcpj@treble>
References: <20220303112321.422525803@infradead.org>
 <20220303112826.481793874@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220303112826.481793874@infradead.org>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 12:23:46PM +0100, Peter Zijlstra wrote:
> Retpoline and IBT are mutually exclusive. IBT relies on indirect
> branches (JMP/CALL *%reg) while retpoline avoids them by design.
> 
> Demote to LFENCE on IBT enabled hardware.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/cpu/bugs.c |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -891,6 +891,7 @@ static void __init spectre_v2_select_mit
>  {
>  	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
>  	enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
> +	bool silent_demote = false;
>  
>  	/*
>  	 * If the CPU is not affected and the command line mode is NONE or AUTO
> @@ -906,6 +907,7 @@ static void __init spectre_v2_select_mit
>  
>  	case SPECTRE_V2_CMD_FORCE:
>  	case SPECTRE_V2_CMD_AUTO:
> +		silent_demote = true;
>  		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
>  			mode = SPECTRE_V2_IBRS_ENHANCED;
>  			/* Force it so VMEXIT will restore correctly */
> @@ -938,6 +940,7 @@ static void __init spectre_v2_select_mit
>  	retpoline_amd:
>  		if (!boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
>  			pr_err("Spectre mitigation: LFENCE not serializing, switching to generic retpoline\n");
> +			silent_demote = false;
>  			goto retpoline_generic;
>  		}
>  		mode = SPECTRE_V2_RETPOLINE_AMD;
> @@ -947,6 +950,16 @@ static void __init spectre_v2_select_mit
>  	retpoline_generic:
>  		mode = SPECTRE_V2_RETPOLINE_GENERIC;
>  		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
> +
> +		/*
> +		 * ROP defeats IBT, make sure not to use Retpolines and IBT together.
> +		 */
> +		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT)) {
> +			if (!silent_demote)
> +				pr_warn("Spectre mitigation: Switching to LFENCE due to IBT\n");
> +			mode = SPECTRE_V2_RETPOLINE_AMD;
> +			setup_force_cpu_cap(X86_FEATURE_RETPOLINE_AMD);
> +		}

This is better.  But AFAIK, the 'silent_demote' case should only happen
on a hypothetically weird/broken virt setup, right?  Why silence the
warning?  It still seems legit.  If you have IBT on non-eIBRS Intel, and
you get silently demoted from retpoline to lfence, it presumably opens
up some Spectre v2 attack vectors, despite IBT's implicit promise of
providing *more* protection overall.

And actually, after thinking about it, my most preferred approach would
be to do the converse of this patch: only enable IBT if
!X86_FEATURE_RETPOLINE.  And do a real warning, like "your setup is
broken, IBT is disabled".  Maybe even make it a real WARN() so we could
find out if it's a real possibility.  Since this feature is much newer
than retpoline, that would probably be the simplest and least surprising
option.

-- 
Josh

