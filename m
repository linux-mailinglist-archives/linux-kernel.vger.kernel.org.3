Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1E34CFC62
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242255AbiCGLNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241808AbiCGLMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:12:37 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E04D996B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 02:34:42 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hw13so30751427ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 02:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M1rR/eY80n5vDuYqXPNSE6u83mcd2WVzC9/2TTt/Eo0=;
        b=Gj9/fnWrwc6IHetIWpmkFgWwMuti9SnpBTZQI4+fpBSdSMDh78T9YTel1Ks7RaIY3f
         zt5OncxwWYqxHOdhY9xn8K+MSHrrreD3qDrY/f9jhrpwKbCGBjunGgzzLDt1VLWVdZLc
         VRRHaUu3KNRRT/eYvRBUHb9BxA8vk/e/bVT+31IvTkAPDpn6LOk6C+RyKZRq0ydfmFQb
         E5RL6qF1WR/VI2wp4CZMK7TjH0h54ml3dEIiDwdC9JzDHKn5m7XO4frn1CD5GKKzfGp+
         m6+cIe+wGQCr9BM1Hl3mg8089U0CYQPLnBvjkO7tnG2qferM0ANsSrtdVHqhBdUJ+Z3X
         N56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M1rR/eY80n5vDuYqXPNSE6u83mcd2WVzC9/2TTt/Eo0=;
        b=n/nFanOL0uH0IFWjlskBRBHLdF5djvpr4zZdNWH6QPgqrPpm85S7Gc0JA6z2Jus5UT
         0Jmtt8l9G2f5VfQLv3D5bIPGLvqkkVwZUvRqFRWUnBFVn6FCzQuirAinH22qf3HNS9+P
         AkJ403Vqq7ksfFCmI+FGELbLp20GCg0OqScFZp3tlOSaL9b8rLpA32WETpctDrTwtvYR
         zkgwiEnsk1x71QayUFtS1Ygkvx6fICNGkspX7pyQNhYMnNutfbDTEBWXq66Ajqi9jDe/
         097qEFBQDUIcBJZE5996Pt51rXIzkqjt+q0fMvhbP61C8qIqUW/QHw74fp+MaKg90dKO
         DsCA==
X-Gm-Message-State: AOAM532Zf04uhuicasx4HKe9K5HgHBWIJxxKoe86DRRF5cUnQdlyU34b
        orhrvRvJghJIXD1rlNC3l/yZ071SmjzAI75giOqiEvEJU3c=
X-Google-Smtp-Source: ABdhPJyZ9XFlNCbQVulJPua3Jfgj9sQ1cpljwcF6zb22A8M+mwlVxG4zEsvsO1xYx7ek52amuGOhL0m4PYqKpZyjTr4=
X-Received: by 2002:a17:906:cc12:b0:6b5:ec8f:fdf2 with SMTP id
 ml18-20020a170906cc1200b006b5ec8ffdf2mr8297004ejb.579.1646649280273; Mon, 07
 Mar 2022 02:34:40 -0800 (PST)
MIME-Version: 1.0
References: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr>
 <CAHp75VeT3LbdbSaiwcC2YW40LnA2h8ADtGva-CKU_xh8Edi0nw@mail.gmail.com>
 <CAMZ6RqJL2G=i-x3wwBD92devAxdNcnmwfDqz30+GFGobp21s+Q@mail.gmail.com>
 <CAHp75VdTzjW_YONcFy0qQGvT-xMDQOXTYsAun40106Spzgx_2Q@mail.gmail.com> <CAMZ6RqJAxqbbkMP=r7h0b2nvobYu8tcSm8PLaPNbXb0NV+gzaw@mail.gmail.com>
In-Reply-To: <CAMZ6RqJAxqbbkMP=r7h0b2nvobYu8tcSm8PLaPNbXb0NV+gzaw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Mar 2022 12:33:22 +0200
Message-ID: <CAHp75VcO+4jD_KVDjmOYCRKy31sdC3BwgcfcEOL=RtTjvzmzHQ@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: fix -Wtype-limits warnings in GENMASK_INPUT_CHECK()
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 6, 2022 at 7:35 AM Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:
> On Sun. 6 Mar 2022 at 06:33, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Sat, Mar 5, 2022 at 2:43 PM Vincent MAILHOL
> > <mailhol.vincent@wanadoo.fr> wrote:
> > > On Tue. 5 Mar 2022 at 03:46, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > On Fri, Mar 4, 2022 at 7:36 PM Vincent Mailhol
> > > > <mailhol.vincent@wanadoo.fr> wrote:
> >
> > ...
> >
> > > > NAK.
> > >
> > > Are you willing to change your decision following my comments?
> >
> > Have you read this discussion (read the thread in full)
> > https://lore.kernel.org/lkml/cover.1590017578.git.syednwaris@gmail.com/
>
> Thank you, this was an instructive read.
>
> For what I understand, there was an effort to fix this when
> -Wtype-limits was still a W=1 warning but the effort was stopped
> after -Wtype-limits was moved to W=2 despite a v4 patch being very
> close to the goal.

My understanding of that discussion is that Wtype-limits is broken,
and Linus pointed out many times that compiler warning on

    if ((unsigned int)foo < 0)

is bogus. I.o.w. there is no issue with the code and hence nothing to fix.

> Back to my patch, it successfully passes the lib/test_bits.c
> build test (including the TEST_GENMASK_FAILURES) and it also
> fixes the last open warning from the thread you pointed me to (on
> drivers/crypto/inside-secure/safexcel.o):
> https://lore.kernel.org/lkml/20200709123011.GA18734@gondor.apana.org.au/
>
> So, I am still not sure to understand what issue you see with my
> patch. Is it that we should just not care about fixing W=2? Or
> do you still see some issues which are not being addressed (if
> so, sorry for not understanding)?

See above. You may Cc Linus himself to reignite the discussion.

> I do agree that fixing a W=2 has small value for all the files
> which are still emitting some W=1. However, I think it is
> beneficial to remove this W=2 spam for all the developers who
> produced W=1 clean files and would like to tackle the W=2
> warnings.

-- 
With Best Regards,
Andy Shevchenko
