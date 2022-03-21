Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F95E4E2F09
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351850AbiCUR2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237671AbiCUR2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:28:44 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54B918463C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:27:17 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d5so6552988lfj.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjlWSgDYCbI3M0HlDfM+vRBeQFnG0r9FgmdbuPnrgqQ=;
        b=aVvx3FDfpN2WfwpjlyxpAb5Fwswxlfi/0LDhMZdxBX1bJ4kqbt7F9JwUIf4M2YGi+A
         +Wnc0mnQTa5PhVU9lA/PnyGKLEnXuH89p3UwUuSoj5zvNzipTCWhi8oYbyzjlZ+P7/bf
         WHY1ioGhcshdkuE1zdzW3HsrHW2LidtQE0aXvGDbh9W0ZBivvNYFkFRbyEaLU1p/PkrR
         YqnjBZe9cWSaE1WsqyzmpquwIAyvR0Y5piDM1O9Gs37X6CSORvAEy7NhCpZsbLwgAXl1
         a9vy260QEtWazFypwCq7q+O33a7nkhm4ra1V5zP6OaPHpRUvrjGs7Xj0WY6U0JMggzFP
         kVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjlWSgDYCbI3M0HlDfM+vRBeQFnG0r9FgmdbuPnrgqQ=;
        b=O5CgBVkV7DnMser6+gsg5TYRmNtuiXmlqgD1RtG9EPtcUWRO3MNUg2zTxpkH2GjlX8
         ztbQ4pVd+oCi7b1mCGdjIKx/1V1Xm5OmmBJXO5hQGqJVXlVz4oq4jM5Ep6QMG+w2TOSk
         tppfWuEN9DaBM/BvBxbj0NE7jj39M+I17ZP3P1J1gThg9dEnk+hyjCWDI/LieZZhvJE3
         JbKjlPmzImOIoovyJQ2TEujIynvKUWvjddc4OD+7gPTdpuE60+NtnVfWR11VfzaRwm21
         65PfQUMeFJdx3Ms6B1r6HaY//Vh6aKJCO1El/22u3qAHnIwFrghXpl7i4MacKkEO4MRV
         nYzg==
X-Gm-Message-State: AOAM530BEFZeSADYuZA1PzUuMlZKR+1SZOjig2reTed213IhQ5NO/gbz
        rM1/CjSdIcB1hxJbRTgjWprLHPQPwcYhhdwQSM2S5Q==
X-Google-Smtp-Source: ABdhPJy4rZuO7vtP7+8b/Mnd+Mllf2Xr2hwf83Dz2QNhS8sDUM8I/x5BFB4QCsYPBIVI5J7rSfIgJWZP/6BJmllE6vs=
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id
 y1-20020a056512334100b00433b033bd22mr15309077lfd.190.1647883634694; Mon, 21
 Mar 2022 10:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
 <20220320093750.159991-3-ammarfaizi2@gnuweeb.org> <20220320191619.GA27312@1wt.eu>
 <9e69af8e-74c1-f35b-98dd-e2a77153ea09@gnuweeb.org>
In-Reply-To: <9e69af8e-74c1-f35b-98dd-e2a77153ea09@gnuweeb.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 21 Mar 2022 10:27:03 -0700
Message-ID: <CAKwvOdmfscdQQvmDmVqX3RvH55_EnqHokC+G9jSjckYqLG-psw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/6] tools/nolibc: Make the entry point not weak
 for clang
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 4:38 AM Ammar Faizi <ammarfaizi2@gnuweeb.org> wrote:
>
> On 3/21/22 2:16 AM, Willy Tarreau wrote:
> > Hi Ammar,
> >
> > I've had a look at this one.
> >
> > On Sun, Mar 20, 2022 at 04:37:46PM +0700, Ammar Faizi wrote:
> >> Budilig with clang yields the following error:
> >    ^^^^^^^
> > BTW please fix the typo in the final commit message.
> >
> >> @@ -183,7 +183,9 @@ struct sys_stat_struct {
> >>
> >>   /* startup code */
> >>   asm(".section .text\n"
> >> +#if !defined(__clang__)
> >>       ".weak _start\n"
> >> +#endif
> >>       ".global _start\n"
> >>       "_start:\n"
> >
> > So it seems that I was wrong and that .weak is an alternate for .global
> > and not a complement. As such, instead of adding all these #if, please
> > simply remove all .global.

See also:
commit 4d6ffa27b8e5 ("x86/lib: Change .weak to SYM_FUNC_START_WEAK for
arch/x86/lib/mem*_64.S")
commit ec9d78070de9 ("arm64: Change .weak to SYM_FUNC_START_WEAK_PI
for arch/arm64/lib/mem*.S")

Also, please note in the commit message that this diagnostic comes
from using clang as the assembler (which is clang's default behavior
unless -fno-integrated-as is passed).

>
> Will fix this in the next version.
>
> --
> Ammar Faizi
>


-- 
Thanks,
~Nick Desaulniers
