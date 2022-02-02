Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14A54A793E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345978AbiBBUOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236790AbiBBUOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:14:01 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5DCC061714;
        Wed,  2 Feb 2022 12:14:01 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id 9so539245iou.2;
        Wed, 02 Feb 2022 12:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+joIfLcwi0AHT9CfmeRWcZipKd8v5eWFKJZkkqDlqIo=;
        b=Cpz+g9imX/K+prVNM2ef9ZNuDEmBDl87wa3qhiO7PkJtVw6JxD2J/yzwqCfExLFDul
         dInhS/EKoCg1Lp5yPwLbPoZHc7QK0wTCVUS5bhgOUvf+JwIvBqNbPZFGwRwr+PXr0j2O
         6jDlo0h+iWkjd09guUmisZ4JUnZYOgipwJCIt7+3cHXmECHOvGFEsaTMoW/N+9f1nnNO
         hYuvJidRQqB0TgWayFIZUaDfRQAcbFMOw+7VHPasyP6P5MxEcEf8hGyfKXUZHWV6EiPB
         IqeB3TwpL+TkB4+tIvXcck3FalTnKYvGqxMcA++WknXE94iDDm2OKGSBwf1CRy0XUE99
         2e8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+joIfLcwi0AHT9CfmeRWcZipKd8v5eWFKJZkkqDlqIo=;
        b=g3FOJd+Vs135wja3+019HM85rkAIPLOGM4UTqAub1+iiOq2sCjNbAJ3/wrGBGyRUuq
         XzM3j81bhC1cwaCgp69glmS26tm4FPRaZG31iYDyoBpBkgnugDh/K8s1dgfNGJn+VW7O
         rZoF4iwmN/yQm0ehwSinL6RsLSV6HiNqjT0cPH+DnDP9lw600PzfjaxqOxPGxITVqkw5
         wuaFEpCprj15jt4uvKAuIUutoSy9cVyc63emcBBrgfrNqyTKt1PLJkAWodocdiD8AbdT
         7iE/ej6RQsUCtDUhoHuUd1c61Y52357YDJI+zonlXChW8e2tjjbvmtt/VoJhoF7y6XRK
         i7Sg==
X-Gm-Message-State: AOAM530mLPx6yeW0CyS395r5xErFBYQUAjDGz0MKBNDwK/pwlGFUH1gD
        R2lGaXZT4KmhIwGuY5eGe7B5YKqMuxHALFY290Y=
X-Google-Smtp-Source: ABdhPJxh+izLGYhkARHCk/mSFpCvcaaRvL3BTV5Owj0Aeywjheb39Iyl2IvHfd+OqyK7P1oLNmlV0YHlb0JkaXx18sQ=
X-Received: by 2002:a6b:ea08:: with SMTP id m8mr17027283ioc.172.1643832840579;
 Wed, 02 Feb 2022 12:14:00 -0800 (PST)
MIME-Version: 1.0
References: <20220131204357.1133674-1-keescook@chromium.org> <6641e01b86374ce197020d57c65ae3b3@AcuMS.aculab.com>
In-Reply-To: <6641e01b86374ce197020d57c65ae3b3@AcuMS.aculab.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 2 Feb 2022 21:13:49 +0100
Message-ID: <CANiq72neVsdLRyLn24avMhLCaHxMEiG0bD-ZkG46O7J29FanYA@mail.gmail.com>
Subject: Re: [PATCH] linux/const.h: Explain how __is_constexpr() works
To:     David Laight <David.Laight@aculab.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 5:19 PM David Laight <David.Laight@aculab.com> wrote:
>
> - The conditional operator (?:) requires that both expressions have the
>   the same type (after numeric promotions).

I think you are referring to the arithmetic types case, but that one
does not apply here.

> - If the expressions have distinct non-NULL pointer types then they are both
>   cast to (void *) and the result has type 'void *'.

GCC and Clang give `void *` for this, but something like `float *` and
`int *` do not fit the constrains of the operator.

Cheers,
Miguel
