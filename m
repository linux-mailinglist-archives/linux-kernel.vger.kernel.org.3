Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D6E5395FD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346917AbiEaSOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346878AbiEaSNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:13:53 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C188CCCB
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:13:46 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d12-20020a17090abf8c00b001e2eb431ce4so3048420pjs.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fC3UkvWOG+QmFlfZQIlGHU889ZsG1Db1WvDJ8i9YBsM=;
        b=ld8O+fyZnmR7brIc1eUdB/k5VS0H7xLdq6W000QIFS+eJmuMrcwOa06jYK3TBK8OjJ
         VcsylE0GjOnWA3R6yX+3k0c71K5ZhkjueM36n38a74gRBL0bAr52+IDakG8cTvjQwYjm
         /550UJPyKL6O1KC6Q75oVDO5MzvYunATn1c4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fC3UkvWOG+QmFlfZQIlGHU889ZsG1Db1WvDJ8i9YBsM=;
        b=qsxL2I3bvGoATplea4q48AceH8kr29tOjR81/tQaCjQgjiBh5fvBVO2FATjo6n3Zax
         nOb4jg9hhUHIZ8NESod8qq7uFvDouzG35eoKNrg5mCNrTgHM9nfsoFGZPVYvoR59HkBQ
         7JgycewILHdwb84UwYSmrQDpI3IH4VreGz2EKQOJECHL6EwL9B+Uqw7FYdPvzHNx4ZWr
         zkFMPXTKsKIecG2W7ZC6rN4L5MGNIIeOCLS6S9QzUvr/HyNDZnVBZHIIyuGi84mb3dRN
         OdkhjwDqSNseipBt/2tq+Q20rJ+ylHA4rpFGknmdttuWWwhk1I/kby3GHmptRmAkpljI
         493w==
X-Gm-Message-State: AOAM530/LM5PO9zHFwf+Z1DX361BZHfvZRz0bC1D/l+0Azy3utHtKCDx
        8vihLw+j+H3RlLLe70GxFAMpFQ==
X-Google-Smtp-Source: ABdhPJxy0oanyehmUSaDd8NgjuZe98D1SD/vq/qC2ZS9dS5eOJTBxze4un0W7pOhM4liLACJKTna7A==
X-Received: by 2002:a17:90a:181:b0:1e0:6535:b616 with SMTP id 1-20020a17090a018100b001e06535b616mr29350041pjc.154.1654020825425;
        Tue, 31 May 2022 11:13:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q11-20020a170903204b00b00163be997587sm6420695pla.100.2022.05.31.11.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 11:13:45 -0700 (PDT)
Date:   Tue, 31 May 2022 11:13:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, will@kernel.org
Subject: Re: [PATCH v2 07/13] stackleak: rework poison scanning
Message-ID: <202205311108.40D216E6@keescook>
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-8-mark.rutland@arm.com>
 <268ea8f7-472b-f1d4-6b8b-0c8fefccc0fa@linux.com>
 <YnplFtdEr8dBOvZU@FVFF77S0Q05N>
 <02e40030-52a5-f23c-85be-be59a7d3211c@linux.com>
 <YozeTA/69F7rYvVi@FVFF77S0Q05N>
 <73e3a82b-fbf6-5448-56ba-adda130230d3@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73e3a82b-fbf6-5448-56ba-adda130230d3@linux.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 02:25:12AM +0300, Alexander Popov wrote:
> On 24.05.2022 16:31, Mark Rutland wrote:
> > [...]
> > It's also worth noting that `noinstr` code will also not be instrumented
> > regardless of frame size -- we might want some build-time assertion for those.
> 
> I developed a trick that shows noinstr functions that stackleak would like to instrument:
> 
> diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
> index 42f0252ee2a4..6db748d44957 100644
> --- a/scripts/gcc-plugins/stackleak_plugin.c
> +++ b/scripts/gcc-plugins/stackleak_plugin.c
> @@ -397,6 +397,9 @@ static unsigned int stackleak_cleanup_execute(void)
>  	const char *fn = DECL_NAME_POINTER(current_function_decl);
>  	bool removed = false;
> 
> +	if (verbose)
> +		fprintf(stderr, "stackleak: I see noinstr function %s()\n", fn);
> +
>  	/*
>  	 * Leave stack tracking in functions that call alloca().
>  	 * Additional case:
> @@ -464,12 +467,12 @@ static bool stackleak_gate(void)
>  		if (STRING_EQUAL(section, ".meminit.text"))
>  			return false;
>  		if (STRING_EQUAL(section, ".noinstr.text"))
> -			return false;
> +			return true;
>  		if (STRING_EQUAL(section, ".entry.text"))
>  			return false;
>  	}
> 
> -	return track_frame_size >= 0;
> +	return false;
>  }
> 
>  /* Build the function declaration for stackleak_track_stack() */
> @@ -589,8 +592,6 @@ __visible int plugin_init(struct plugin_name_args *plugin_info,
>  				build_for_x86 = true;
>  		} else if (!strcmp(argv[i].key, "disable")) {
>  			disable = true;
> -		} else if (!strcmp(argv[i].key, "verbose")) {
> -			verbose = true;
>  		} else {
>  			error(G_("unknown option '-fplugin-arg-%s-%s'"),
>  					plugin_name, argv[i].key);
> @@ -598,6 +599,8 @@ __visible int plugin_init(struct plugin_name_args *plugin_info,
>  		}
>  	}
> 
> +	verbose = true;
> +
>  	if (disable) {
>  		if (verbose)
>  			fprintf(stderr, "stackleak: disabled for this translation unit\n");
> 
> 
> Building defconfig for x86_64 gives this:
> 
> stackleak: I see noinstr function __do_fast_syscall_32()
> stackleak: instrument __do_fast_syscall_32(): calls_alloca
> --
> stackleak: I see noinstr function do_syscall_64()
> stackleak: instrument do_syscall_64(): calls_alloca
> --
> stackleak: I see noinstr function do_int80_syscall_32()
> stackleak: instrument do_int80_syscall_32(): calls_alloca

As you say, these are from RANDOMIZE_KSTACK_OFFSET, and are around
bounds-checked, and should already be getting wiped since these will
call into deeper (non-noinst) functions.

> stackleak: I see noinstr function do_machine_check()
> stackleak: instrument do_machine_check()
> --
> stackleak: I see noinstr function exc_general_protection()
> stackleak: instrument exc_general_protection()
> --
> stackleak: I see noinstr function fixup_bad_iret()
> stackleak: instrument fixup_bad_iret()
> 
> 
> The cases with calls_alloca are caused by CONFIG_RANDOMIZE_KSTACK_OFFSET=y.
> Kees knows about that peculiarity.
> 
> Other cases are noinstr functions with large stack frame:
> do_machine_check(), exc_general_protection(), and fixup_bad_iret().
> 
> I think adding a build-time assertion is not possible, since it would break
> building the kernel.

Do these functions share the syscall behavior of always calling into
non-noinst functions that _do_ have stack depth instrumentation?

> [...]
> > In security/Kconfig.hardening we have:
> > 
> > | config STACKLEAK_TRACK_MIN_SIZE
> > |         int "Minimum stack frame size of functions tracked by STACKLEAK"
> > |         default 100
> > |         range 0 4096
> > |         depends on GCC_PLUGIN_STACKLEAK
> > |         help
> > |           The STACKLEAK gcc plugin instruments the kernel code for tracking
> > |           the lowest border of the kernel stack (and for some other purposes).
> > |           It inserts the stackleak_track_stack() call for the functions with
> > |           a stack frame size greater than or equal to this parameter.
> > |           If unsure, leave the default value 100.
> > 
> > ... where the vast majority of that range is going to lead to a BUILD_BUG().
> 
> Honestly, I don't like the idea of having the STACKLEAK_TRACK_MIN_SIZE option in the Kconfig.
> 
> I was forced by the maintainers to introduce it when I was working on the stackleak patchset.
> 
> How about dropping CONFIG_STACKLEAK_TRACK_MIN_SIZE from Kconfig?
> 
> That would also allow to drop this build-time assertion.

Should this be arch-specific? (i.e. just make it a per-arch Kconfig
default, instead of user-selectable into weird values?)

-- 
Kees Cook
