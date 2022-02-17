Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B6D4BA721
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243715AbiBQR3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:29:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiBQR3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:29:32 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93E226A2C9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:29:16 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id w20so5104785plq.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GGqa2dUUjBxrMHhzGOK6UxPbD0noYUoQJRB1vqXsV8Q=;
        b=BvptpOqFENbCnYy2v0SFJ3RtUpZRORi7aifdATrLbrZ/tFc7pqTsYmbttEpgguIZ0u
         jZMfrZJzdCiUm1MYvf32LwQcrqEetXjYXRpbJi+iUc+0++vnSlP6W2Pkm51Mjpbhct0U
         cbxyaoqYxK/d9S/gQrgG+RsyCQWU/rZOV4l+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GGqa2dUUjBxrMHhzGOK6UxPbD0noYUoQJRB1vqXsV8Q=;
        b=N31Ta8SKp5Da9EZGfvzpWWwL5fyA9ZYxUlgNbaKGCmWOQyDv8vlC5gY0gnew1nZU1v
         /sroiXZMWR5udIWRDcUekdfJplHMgqxWnh0dNAnkQLPTL05vM6Tod1YmlMtBsBBRGtm1
         z5mHLG0mjWhFndw91pDE3Pm1tyrFH7KLC52FDvg5suMaWAHUsdC0OKcoViK5cAd9m+58
         Trr4kz7S52rjJNsR3pI2hWSPKCIbgTyZ8Yct6/9ICDPyISum9ZW7PwNy3hNFxKOX42sO
         TOeA6Qz2c7chsn93jg3Dg2JsxRkJYaaZnyQ3+ksGsmMGd0BHfLfeydIVihGNCkwpykt8
         EqVA==
X-Gm-Message-State: AOAM531zd3lfi4qvVP8/PmjF/Jo48lb7YyHlGxCSxthMc8RDy+0ubOK/
        nKoo/gaJ3a9HXGYdwu3324xd8Q==
X-Google-Smtp-Source: ABdhPJyJQiP7APGWLovv/1NEYmHF6Vt3hq6S6WQdSy5kF3kArgSgJhYGCOtQO/pSPyyQKpqMAmzySA==
X-Received: by 2002:a17:90a:d243:b0:1b9:cbac:a775 with SMTP id o3-20020a17090ad24300b001b9cbaca775mr4155225pjw.196.1645118956169;
        Thu, 17 Feb 2022 09:29:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 16sm8894041pgz.76.2022.02.17.09.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 09:29:15 -0800 (PST)
Date:   Thu, 17 Feb 2022 09:29:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Al Viro <viro@zeniv.linux.org.uk>, x86@kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] um: Cleanup syscall_handler_t definition/cast, fix
 warning
Message-ID: <202202170928.F02D6F41@keescook>
References: <20220210034353.1065703-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220210034353.1065703-1-davidgow@google.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 11:43:53AM +0800, David Gow wrote:
> The syscall_handler_t type for x86_64 was defined as 'long (*)(void)',
> but always cast to 'long (*)(long, long, long, long, long, long)' before
> use. This now triggers a warning (see below).
> 
> Define syscall_handler_t as the latter instead, and remove the cast.
> This simplifies the code, and fixes the warning.
> 
> Warning:
> In file included from ../arch/um/include/asm/processor-generic.h:13
>                  from ../arch/x86/um/asm/processor.h:41
>                  from ../include/linux/rcupdate.h:30
>                  from ../include/linux/rculist.h:11
>                  from ../include/linux/pid.h:5
>                  from ../include/linux/sched.h:14
>                  from ../include/linux/ptrace.h:6
>                  from ../arch/um/kernel/skas/syscall.c:7:
> ../arch/um/kernel/skas/syscall.c: In function ‘handle_syscall’:
> ../arch/x86/um/shared/sysdep/syscalls_64.h:18:11: warning: cast between incompatible function types from ‘long int (*)(void)’ to ‘long int (*)(long int,  long int,  long int,  long int,  long int,  long int)’ [
> -Wcast-function-type]
>    18 |         (((long (*)(long, long, long, long, long, long)) \
>       |           ^
> ../arch/x86/um/asm/ptrace.h:36:62: note: in definition of macro ‘PT_REGS_SET_SYSCALL_RETURN’
>    36 | #define PT_REGS_SET_SYSCALL_RETURN(r, res) (PT_REGS_AX(r) = (res))
>       |                                                              ^~~
> ../arch/um/kernel/skas/syscall.c:46:33: note: in expansion of macro ‘EXECUTE_SYSCALL’
>    46 |                                 EXECUTE_SYSCALL(syscall, regs));
>       |                                 ^~~~~~~~~~~~~~~
> 
> Signed-off-by: David Gow <davidgow@google.com>

Thanks for this! I was just about to go figure this out too. :)

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
