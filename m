Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77F14D8DFF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244842AbiCNUPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242151AbiCNUPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:15:35 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994511EAD1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:14:23 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 17so21484900lji.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VKmL8N0MGUKpjg1aebJTq4IQfdUqqRnSzv3Tmq9qgdk=;
        b=ObJVnTZXyeW/s7wGtaP9fKZR7mREfI6BR1X/Yg28I+eGnVwt2Z1JiRjzILenldH9Cd
         Ce7VcSAUnYj/8zAFqRBfcAHwW7TpQNI1fb2kEmEqT6Y4GyAk7vgmEqBB3GtrxP4Nfb7U
         N1eLsE6DoaxBy7NQEemmEpAEJ1imM1tkPetn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VKmL8N0MGUKpjg1aebJTq4IQfdUqqRnSzv3Tmq9qgdk=;
        b=kPTyBd63Ts4PCyZuOnvNc8I6ti6Jm5a2AgLoNXOyMcrpJnmk1ZZoWQDZRAay2mpu9v
         aRa4Unw3YiAI5yl9EvO/vJH6MHEA2Q4Kua51iQqC7K+SrXSWP8WlxaMEq00YXbEia4Q2
         +n32j/1mpp+drX5VfYxwlRVUKTKyac55FkgpjmgfAYpNKOA/O0Aa9QBoWsimQKCulUS9
         Eif6LOPWvDO0iS5FFnKxqzixhNgd8OudPbTrmHCihSb3APc/+ySG+7oV0pInfLBQDIjh
         iMfAtlCnd7PDgdW4nGGQKeeiH8UT64rUSNErigc8EDDRjXWWawfXah8qKq8n9Tjqh7Rm
         XgIA==
X-Gm-Message-State: AOAM532b58N7acy+CbfUQwuFSEI5Fa2TlqhL7qNBT8ewBPRrf7CwZCX2
        kLxL8qPJiQFADRuzx0Uzkr1gTPrT4Yuj5q6p
X-Google-Smtp-Source: ABdhPJy2k5XayKMoJ4a2Eby6Pc8rZnqNtgCXgsSni+79yczi4Tm2c+hppfa5SSlXbUQpRCjs114iPA==
X-Received: by 2002:a2e:8ecc:0:b0:249:3a3b:fe70 with SMTP id e12-20020a2e8ecc000000b002493a3bfe70mr2995867ljl.230.1647288858387;
        Mon, 14 Mar 2022 13:14:18 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id m10-20020a2e97ca000000b00247e2d9a22esm4150096ljj.32.2022.03.14.13.14.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 13:14:16 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 17so21484664lji.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:14:15 -0700 (PDT)
X-Received: by 2002:a2e:6f17:0:b0:248:124:9c08 with SMTP id
 k23-20020a2e6f17000000b0024801249c08mr14988725ljc.506.1647288855508; Mon, 14
 Mar 2022 13:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiHa0vsZseZES=1T0rJ4Z_bC5cwHMUJfqFL9hVpvB283g@mail.gmail.com>
 <20220314192522.GA3031157@roeck-us.net>
In-Reply-To: <20220314192522.GA3031157@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Mar 2022 13:13:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiEhs+4P1TNh2sNnk04D1FFdNThk6XLOMxzkRL72PEXFw@mail.gmail.com>
Message-ID: <CAHk-=wiEhs+4P1TNh2sNnk04D1FFdNThk6XLOMxzkRL72PEXFw@mail.gmail.com>
Subject: Re: Linux 5.17-rc8
To:     Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Edmond Chung <edmondchung@google.com>,
        Andrew Chant <achant@google.com>,
        Will McVicker <willmcvicker@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Adding more people to the cc, since this last change was triggered
by earlier changes.

On Mon, Mar 14, 2022 at 12:25 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Build results:
>         total: 155 pass: 155 fail: 0
> Qemu test results:
>         total: 488 pass: 484 fail: 4

Uhhuh. We got all the previous problems sorted out, but a new one instead.

> This is a new problem. It bisects to commit fc328a7d1fcc ("gpio: Revert
> regression in sysfs-gpio (gpiolib.c)"). The network connection fails
> in the affected tests. Reverting the offending commit (ie reverting the
> revert) fixes the problem.

Hmm. Looking at the changes since 5.16, that commit fc328a7d1fcc looks
somewhat suspicious.

It claims to "revert" things, but the behavior it reverts goes
basically all the way back to v5.7 (with one of the patches going into
5.10).

And it clearly breaks things that used to work much more recently (ie
this worked in rc7, but it was also the state in every release since
5.10).

So unless somebody can find the _real_ issue here, I suspect very
strongly that that "fix" that came in last week was just wrong.

It is also very non-specific "Some GPIO lines have stopped working"
with no pointer to actual reports.

LinusW? Thierry? Bartoz? Anybody?

Yes, there;s something bad going on here, but we can't randomly "fix"
things in an rc8 that have worked for several releases by now.

               Linus
