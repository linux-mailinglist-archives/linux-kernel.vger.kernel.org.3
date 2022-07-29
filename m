Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9255853F9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 18:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbiG2Qsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 12:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238346AbiG2Qsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 12:48:32 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E796F8967E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 09:48:18 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id b4so739748uaw.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 09:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uucvDhQU54rvdSGYVFVAXcb4PeRvpWkxMM335asLR68=;
        b=kYqeU4Nc+cAcargVo8kzsjclGiFvlkwUULDKGb+BwEDYbHGNeYN2ZyErJUAyGt1m3H
         JC3XZoYCDJeUnd6pT0YnYuiIDDIO6zbDP28lEnHTWHV6y/zY7atdTmRcCJ30BuviN2hy
         Qv188FOlmlDWX0e2ArrFlQXYHWtUcoAZx8ELmz8uWn/nquDn+fLzm/K7E+1164b94KDj
         cB+J1txzExGtb4UAV3t2vVhL6tZYRu9ltRRigrICDaRbRHh09pbK6JeJ/nnzhIYO9Kfg
         KQ4mxzEKGuc9RMV8gDyVnovdhO8ye8oSrLQ2SA/OEjmnK+es47gHaud+VFsj1Cmi/jFW
         MVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uucvDhQU54rvdSGYVFVAXcb4PeRvpWkxMM335asLR68=;
        b=speMqtWHP3+Aoxwc7mnkinIwF0lQrEh6xb5fjyNBxbMMlf+kiX/zktUQQgaRAbyZ7x
         70owGS6R7hTEGcELzjvgU2xIVNCnKAS0lVvxh6IB0nGEfTnL2dadkoPp1Xn+8Qt+R+2e
         J2WFVJbFullgh9xgyPv4pxMy6Fwq+o/ApmXH2T25fK+s+7jjg6I6PWIn5xZ17MTE/fX+
         pBK+myu/1V1Cw8I27tUBX79Wfv3Ib7bGtXSmh00+ckM6lSLqWwDvYhwJm579D416BShe
         jyMT+IFy1G9g97yXmSa1moAKSn3PYqSkBy3yRUtpnsldgOAmlKdWxqLxbAy1cJY5IiAE
         8eog==
X-Gm-Message-State: ACgBeo0erWVV4IwO6IFyDFjWnp4xPyAjuUPZMNI7BmSI1v7Jbkp8J8SL
        A0z+EDVkAnjd0abaxLkUDthEzZlceSxNfqKXuh8=
X-Google-Smtp-Source: AA6agR6k97bbHwDeE2wqTssoTPNRjEdW6g6Q3+O8YUy2+JFcdLu1p7CdBk53BYkT8E+U0OonChqL9aKh+ECWnEiPdZQ=
X-Received: by 2002:ab0:1c56:0:b0:384:cbd7:4329 with SMTP id
 o22-20020ab01c56000000b00384cbd74329mr1740457uaj.9.1659113297874; Fri, 29 Jul
 2022 09:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220711044711.466822-1-yury.norov@gmail.com> <20220711044711.466822-6-yury.norov@gmail.com>
 <20220729034638.GA2276915@roeck-us.net>
In-Reply-To: <20220729034638.GA2276915@roeck-us.net>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Fri, 29 Jul 2022 09:48:06 -0700
Message-ID: <CAAH8bW_fRmfNnCo2XZdQxe6_W8KS=bkgv+Jrn8KA_c4rmNVCzw@mail.gmail.com>
Subject: Re: [PATCH 5/5] lib/nodemask: inline next_node_in() and node_random()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 8:46 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Sun, Jul 10, 2022 at 09:47:11PM -0700, Yury Norov wrote:
> > The functions are pretty thin wrappers around find_bit engine, and
> > keeping them in c-file prevents compiler from small_const_nbits()
> > optimization, which must take place for all systems with MAX_NUMNODES
> > less than BITS_PER_LONG (default is 16 for me).
> >
> > Moving them in header file doesn't blow up the kernel size:
> > add/remove: 1/2 grow/shrink: 9/5 up/down: 968/-88 (880)
> >
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
>
> This patch results in
>
> Building powerpc:allmodconfig ... failed
> --------------
> Error log:
> In file included from include/linux/nodemask.h:97,
>                  from include/linux/sched.h:22,
>                  from include/linux/sched/mm.h:7,
>                  from arch/powerpc/lib/feature-fixups.c:16:
> include/linux/random.h: In function 'add_latent_entropy':
> include/linux/random.h:25:46: error: 'latent_entropy' undeclared
>
> and many more similar errors when trying to compile ppc:allmodconfig.
>
> Guenter

Hi Guenter,

Thanks for testing. The fix is:

diff --git a/arch/powerpc/kernel/setup-common.c
b/arch/powerpc/kernel/setup-common.c
index eadaddccfe89..18c5fa5918bf 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -179,6 +179,7 @@ bool __must_check
arch_get_random_seed_long(unsigned long *v)

        return false;
 }
+EXPORT_SYMBOL(arch_get_random_seed_long);
 #endif

I moved this export in and out while discussing the patch, and finally left the
branch in a broken state. Sorry that. Now fixed.

Thanks,
Yury
