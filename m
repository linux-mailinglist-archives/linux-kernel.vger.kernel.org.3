Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8004C57D6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 20:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiBZTmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 14:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiBZTmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 14:42:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D27E81CDDE5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 11:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645904535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ygE8hYEkePfKnpRd3x5FFTPK9obsB+BoDwK2l1WEiQY=;
        b=QI4O5doOCkSa4hLdpS+RubWxeUgFKwFqqlInZwrRBlY7zFOfqkrAwXBbFCllsuUB6wyzbS
        LKbqFDDvp3XA3RHocyM/GuHZQOpQ3Vy4eQ/p2PxM3bPYfb5r2O9PvK5oKmTePyDZjw22RK
        asa7e1nb0fTJGetTqtwvoiCPgAU5wRg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-VHEGS6cKMUyBBu0QnAYH_Q-1; Sat, 26 Feb 2022 14:42:14 -0500
X-MC-Unique: VHEGS6cKMUyBBu0QnAYH_Q-1
Received: by mail-qk1-f197.google.com with SMTP id t10-20020a37aa0a000000b00605b9764f71so7789918qke.22
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 11:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ygE8hYEkePfKnpRd3x5FFTPK9obsB+BoDwK2l1WEiQY=;
        b=N7sdRfAHEqT3Yqjv83yZYNo6+Nug9An3Quu0I1QkrHCJoqf+QvQ0vKyJmK3JnO4rJx
         VZJDVcVmMJXuRNjyRxhBO1wYBlYclQHWJ94+xN1Zc/2r0nm8QRMtoJpKr95QGC1AyBRj
         fgINi6W/cFsDHFYYYuXYy/3PlHEYQKs65iNVGQjrs5EqmTmbt/JRWEHoiVPrlwcArmtP
         UJzAqeYTXe8//ZryRJcz/unmP58unDON4RiKXyWd7nW59hMTrozjfsa6T/HF9iay/FWe
         OH+CoLLDKXuNlqdy9s0DLrCkbVudFUYfJQplwaTugbpeS1Hj/xGYrJruKCKh2obDy6SK
         Xc5g==
X-Gm-Message-State: AOAM533d/V1FN6ONn5S2qSNub5wWH+HB/gatZ0iu2X021kX8a/0Qloqq
        rPngeAIuYq9cho/EqUMj/iujSrQtf5bQBTfltrqJX1iwKMWM58Q0HuxExc8das1rPXlqjpuosjs
        /AvtMlTeK5Pgr/i56bs62i2rB
X-Received: by 2002:ae9:d842:0:b0:547:b883:932d with SMTP id u63-20020ae9d842000000b00547b883932dmr7706872qkf.646.1645904533887;
        Sat, 26 Feb 2022 11:42:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwrFauNVR8ZHBl4y07McPVExnedeitPmsJ0iBZfAtmM1PCZ+H3qxGbheYcBqI60gQavq4FOwQ==
X-Received: by 2002:ae9:d842:0:b0:547:b883:932d with SMTP id u63-20020ae9d842000000b00547b883932dmr7706862qkf.646.1645904533616;
        Sat, 26 Feb 2022 11:42:13 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id n8-20020ac85a08000000b002de658d6748sm3934292qta.55.2022.02.26.11.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 11:42:13 -0800 (PST)
Date:   Sat, 26 Feb 2022 11:42:09 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 21/29] objtool: Rename --duplicate to --lto
Message-ID: <20220226194209.bvv3t65hhtnwltmk@treble>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.814392411@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220218171409.814392411@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 05:49:23PM +0100, Peter Zijlstra wrote:
> In order to prepare for LTO like objtool runs for modules, rename the
> duplicate argument to lto.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  scripts/link-vmlinux.sh                 |    2 +-
>  tools/objtool/builtin-check.c           |    4 ++--
>  tools/objtool/check.c                   |    7 ++++++-
>  tools/objtool/include/objtool/builtin.h |    2 +-
>  4 files changed, 10 insertions(+), 5 deletions(-)
> 
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -115,7 +115,7 @@ objtool_link()
>  			objtoolcmd="orc generate"
>  		fi
>  
> -		objtoolopt="${objtoolopt} --duplicate"
> +		objtoolopt="${objtoolopt} --lto"
>  
>  		if is_enabled CONFIG_FTRACE_MCOUNT_USE_OBJTOOL; then
>  			objtoolopt="${objtoolopt} --mcount"
> --- a/tools/objtool/builtin-check.c
> +++ b/tools/objtool/builtin-check.c
> @@ -20,7 +20,7 @@
>  #include <objtool/objtool.h>
>  
>  bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
> -     validate_dup, vmlinux, mcount, noinstr, backup, sls, dryrun;
> +     lto, vmlinux, mcount, noinstr, backup, sls, dryrun;
>  
>  static const char * const check_usage[] = {
>  	"objtool check [<options>] file.o",
> @@ -40,7 +40,7 @@ const struct option check_options[] = {
>  	OPT_BOOLEAN('b', "backtrace", &backtrace, "unwind on error"),
>  	OPT_BOOLEAN('a', "uaccess", &uaccess, "enable uaccess checking"),
>  	OPT_BOOLEAN('s', "stats", &stats, "print statistics"),
> -	OPT_BOOLEAN('d', "duplicate", &validate_dup, "duplicate validation for vmlinux.o"),
> +	OPT_BOOLEAN(0, "lto", &lto, "whole-archive like runs"),

"--lto" is a confusing name, since this "feature" isn't specific to LTO.

Also, it gives no indication of what it actually does.

What it does is, run objtool on vmlinux or module just like it's a
normal object, and *don't* do noinstr validation.  Right?

It's weird for the noinstr-only-mode to be the default.

BTW "--duplicate" had similar problems...

So how about:

- Default to normal mode on vmlinux/module, i.e. validate and/or
  generate ORC like any other object.  This default is more logically
  consistent and makes sense for the future once we get around to
  parallelizing objtool.

- Have "--noinstr", which does noinstr validation, in addition to all
  the other objtool validation/generation.  So it's additive, like any
  other cmdline option.  (Maybe this option isn't necessarily needed for
  now.)

- Have "--noinstr-only" which only does noinstr validation and nothing
  else.  (Alternatively, "--noinstr --dry-run")

?

-- 
Josh

