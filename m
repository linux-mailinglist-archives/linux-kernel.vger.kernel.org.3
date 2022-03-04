Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63984CDDFE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiCDULG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiCDUIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:08:45 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564F3246377
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:03:39 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bu29so16122998lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 12:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ezyv1VQurSCvMLPyyjSXdpAtKbFJe7/Z+K4sj3jG0wM=;
        b=hxPBJ3m48XyNYVJVoIRVY+1Xdmo1N815wvrVTc8ULWIJ83HYLTDLzqiThHtfRr7X21
         xA4R++rxKPYmV+93S4dazGkJTPW2qu9PE4Pafcr7+m2972BnsapIxHO0eEJt2BW1GRlx
         xh5bHEXV89rwpx36KQa8GJg6ZYevDFP+EN4NEcphNX+j++JExCXBk0g+74vY5DbN716r
         I2Ah5EORgpdfgiXtHNYtIC48NbjJVz+D7nnqOBxVKBMdjRWwTtH2MEKkMaupkD38PNey
         ymEYxsMgLgmiQlLNi1ojRG9ck3XlkKMtOz9O29vaV9KzAG8rt/yUR4PN46ESd6XfjOg8
         imDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ezyv1VQurSCvMLPyyjSXdpAtKbFJe7/Z+K4sj3jG0wM=;
        b=8LiWbeGbbkZ7THE58Js2JnBL1TLnmEhIIItXkXLNzdz4aYKbR/XINY92IqgMrprkDY
         e34ecLV3Xf1tjK20411TZBx/XIIGZ7H/eVdZ4ORMJQduzISSaYcjdOT53cZL6tzNA41k
         acii511f7dEhBoebQUEZ3LMZavglPqoIJu2w99Dx/qPRGESIoWt5SpFkC9EXPVFJsmwB
         oGA5apvtFIfak1Bn8CKjiQluzle6HGH2UivbmiFvDaglZyXBfL1OHCzkdfaa36LQzPW/
         +vYhdw539LwYmg/kZPFNhctvU283XMDIS2f3wMcUtXAK6gD3Vz83d6LaYDJYPsuOlYwK
         7BHw==
X-Gm-Message-State: AOAM530xqy9c2zLw1HhiRX8j7BcdEIYqoXbG0G0ZxY5sWPRD/kPb/Bz+
        DSES9xLqfB5vNzJ60k5psgeR2+S7KC6Cl5f6y14T+srr3Vyjjw==
X-Google-Smtp-Source: ABdhPJyeJI+eEvcLyb1Yk9T/jvj7tly4lTwlit2+iut4SgJgn8zcqd01rrN5NCgScbj3UFMKz3cBEbz+2WJy7ZB3XEc=
X-Received: by 2002:a05:6512:10c2:b0:437:96e3:3a86 with SMTP id
 k2-20020a05651210c200b0043796e33a86mr175445lfg.87.1646422019803; Fri, 04 Mar
 2022 11:26:59 -0800 (PST)
MIME-Version: 1.0
References: <20220303110755.24147-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20220303110755.24147-1-mailhol.vincent@wanadoo.fr>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 4 Mar 2022 11:26:47 -0800
Message-ID: <CAKwvOd=Fyu6S=pK-tGeYgoJL3ntGRSC0EQ6si8Cdg9q2pn0a6A@mail.gmail.com>
Subject: Re: [PATCH] x86/bug: __WARN_FLAGS: prevent shadowing by renaming
 local variable f to __flags
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 3, 2022 at 3:08 AM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> The macro __WARN_FLAGS() uses a local variable named "f". This being a
> common name, there is a risk of shadowing other variables.
>
> For example:
>
> | In file included from ./include/linux/bug.h:5,
> |                  from ./include/linux/cpumask.h:14,
> |                  from ./arch/x86/include/asm/cpumask.h:5,
> |                  from ./arch/x86/include/asm/msr.h:11,
> |                  from ./arch/x86/include/asm/processor.h:22,
> |                  from ./arch/x86/include/asm/timex.h:5,
> |                  from ./include/linux/timex.h:65,
> |                  from ./include/linux/time32.h:13,
> |                  from ./include/linux/time.h:60,
> |                  from ./include/linux/stat.h:19,
> |                  from ./include/linux/module.h:13,
> |                  from virt/lib/irqbypass.mod.c:1:
> | ./include/linux/rcupdate.h: In function 'rcu_head_after_call_rcu':
> | ./arch/x86/include/asm/bug.h:80:21: warning: declaration of 'f' shadows a parameter [-Wshadow]
> |    80 |         __auto_type f = BUGFLAG_WARNING|(flags);                \
> |       |                     ^
> | ./include/asm-generic/bug.h:106:17: note: in expansion of macro '__WARN_FLAGS'
> |   106 |                 __WARN_FLAGS(BUGFLAG_ONCE |                     \
> |       |                 ^~~~~~~~~~~~
> | ./include/linux/rcupdate.h:1007:9: note: in expansion of macro 'WARN_ON_ONCE'
> |  1007 |         WARN_ON_ONCE(func != (rcu_callback_t)~0L);
> |       |         ^~~~~~~~~~~~
> | In file included from ./include/linux/rbtree.h:24,
> |                  from ./include/linux/mm_types.h:11,
> |                  from ./include/linux/buildid.h:5,
> |                  from ./include/linux/module.h:14,
> |                  from virt/lib/irqbypass.mod.c:1:
> | ./include/linux/rcupdate.h:1001:62: note: shadowed declaration is here
> |  1001 | rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
> |       |                                               ~~~~~~~~~~~~~~~^
>
> This patch renames the variable from f to __flags (with two underscore
> prefixes as suggested in the Linux kernel coding style [1]) in order
> to prevent collisions.
>
> [1] Linux kernel coding style, section 12) Macros, Enums and RTL,
> paragraph 5) namespace collisions when defining local variables in
> macros resembling functions
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html#macros-enums-and-rtl

Ah, thanks for the patch. I missed that coding style recommendation.
Might want to link to a newer (or evergreen) version of the docs
though:
https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-enums-and-rtl
Not sure what happens when we start shadowing variables named __flags,
but maybe we cross that bridge if/when we get there.

Thanks for the fix!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
