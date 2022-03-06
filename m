Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B283B4CE921
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 06:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiCFFgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 00:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiCFFgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 00:36:10 -0500
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D49670F7C
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 21:35:19 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id u3so24931949ybh.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 21:35:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=slqIUnaaim/Zcjf+c7IWsC5j1SzZDBhUp+PgfUoBld8=;
        b=yUCnr6cVrswC5Zjv7eDb+8v/VMzk90XUF5w+hlhCG2gZp+8zqOTGVAIth7SvL7qDoj
         gBISxlFAiou+G3jkX7U9PIQSjz0RVidHv/k8xrcrLEpwaWoExp4LCYkaQbr7XQZxO01D
         lJupq7SpkhnD6Xqr6ZbD1FK7k/Jhi7T76329jl6TbU59tDSkTC6jFWsYHvBb7lcZv6R8
         5o97Egs7fixQU7prjsiwO8NqMPatFN/YgDbZXnNlzSZrrhoobqyfhPiUi6pvvkKJvRfm
         K/F36voNg+VZA+rvAqoRDqdIBgkl6WugG5wQpSGbP3Onk4AJyvk8m28QM1poBtgh8nKE
         pDDg==
X-Gm-Message-State: AOAM533JO1yJFqgj1YhDjicafpuX3cRFlBClIRePDxVry+jkhF2arZ46
        xMHEXdOIEhvMc/ubDfrG+4iMr9A27VO9r0pDGQo=
X-Google-Smtp-Source: ABdhPJylYsvZMKOiM8jj1gW+qtyMFrOIfVgOOzq4IJ1ob3Pv0oHImP5Q8GspS17DIFDZx6swlK1Xf8/unPvySqf8PPY=
X-Received: by 2002:a25:2685:0:b0:629:1eee:81e1 with SMTP id
 m127-20020a252685000000b006291eee81e1mr2644568ybm.20.1646544918376; Sat, 05
 Mar 2022 21:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr>
 <CAHp75VeT3LbdbSaiwcC2YW40LnA2h8ADtGva-CKU_xh8Edi0nw@mail.gmail.com>
 <CAMZ6RqJL2G=i-x3wwBD92devAxdNcnmwfDqz30+GFGobp21s+Q@mail.gmail.com> <CAHp75VdTzjW_YONcFy0qQGvT-xMDQOXTYsAun40106Spzgx_2Q@mail.gmail.com>
In-Reply-To: <CAHp75VdTzjW_YONcFy0qQGvT-xMDQOXTYsAun40106Spzgx_2Q@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 6 Mar 2022 14:35:07 +0900
Message-ID: <CAMZ6RqJAxqbbkMP=r7h0b2nvobYu8tcSm8PLaPNbXb0NV+gzaw@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: fix -Wtype-limits warnings in GENMASK_INPUT_CHECK()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun. 6 Mar 2022 at 06:33, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Sat, Mar 5, 2022 at 2:43 PM Vincent MAILHOL
> <mailhol.vincent@wanadoo.fr> wrote:
> > On Tue. 5 Mar 2022 at 03:46, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Fri, Mar 4, 2022 at 7:36 PM Vincent Mailhol
> > > <mailhol.vincent@wanadoo.fr> wrote:
>
> ...
>
> > > NAK.
> >
> > Are you willing to change your decision following my comments?
>
> Have you read this discussion (read the thread in full)
> https://lore.kernel.org/lkml/cover.1590017578.git.syednwaris@gmail.com/

Thank you, this was an instructive read.

For what I understand, there was an effort to fix this when
-Wtype-limits was still a W=1 warning but the effort was stopped
after -Wtype-limits was moved to W=2 despite a v4 patch being very
close to the goal.

Back to my patch, it successfully passes the lib/test_bits.c
build test (including the TEST_GENMASK_FAILURES) and it also
fixes the last open warning from the thread you pointed me to (on
drivers/crypto/inside-secure/safexcel.o):
https://lore.kernel.org/lkml/20200709123011.GA18734@gondor.apana.org.au/

So, I am still not sure to understand what issue you see with my
patch. Is it that we should just not care about fixing W=2? Or
do you still see some issues which are not being addressed (if
so, sorry for not understanding)?

I do agree that fixing a W=2 has small value for all the files
which are still emitting some W=1. However, I think it is
beneficial to remove this W=2 spam for all the developers who
produced W=1 clean files and would like to tackle the W=2
warnings.


Yours sincerely,
Vincent Mailhol
