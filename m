Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A1D4DBB42
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350039AbiCPXn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352178AbiCPXnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:43:25 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7EF1B7B7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 16:42:06 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id f38so7318718ybi.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 16:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IE2Ea1Cz8v1eLhlB/b4Le+DL8OUHmAt2PXNs7TNdYyo=;
        b=ER72S7HFC008I9si0CLcY2Yjgn92FTTnxYAWgV/xZsbR8TntqsInYe5JWzjOPXFo8S
         m1FjJ/EF+HY952bZaCaPh6p/vag21pmK9zMwEM+jBa2CTu6G52PYVMMj+od2uod0M+R/
         YhABNZVBsE/YqUzLiwiEGMl7x0R/msYx+IuMQAK2a7JVXcH0cVN/5jt4WdOATvY/YFme
         /6Cx+6b5tQtNjvt4453yzJ4MNSqqs2iUY/x5gOyWApD4VJWZRBKMmIt+c8T4IqMriJMB
         R5awjV8maBUntFQxzaA/QoQ3vdaT4wX8TFpaLk2oGE6PZo2KBxFwVArNra11iAajEAvp
         jylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IE2Ea1Cz8v1eLhlB/b4Le+DL8OUHmAt2PXNs7TNdYyo=;
        b=ovS4T6+/ZO0qogBj8Mrnj7OJaI0H3vzkALH8fWsrS8wKGDdDQ0TdwzV5F+SlXqEp3a
         Krv6m+T0YIi1HTDjsULq0UiK7uUk0luynxurtS5ba6UkPwNCenE2MUwfaCEapMwquLqo
         Mb9WHrj8qQOGvV69AyIR3P0tn8dDzsxfWh41iz2Fy+66OsgHbGGizZJqCKH6OTtNGY69
         lP0AIka3ds1PZ5bCSCa6CyKaR+zGyAfunnZAg0xa9lCz/pKuz3z/YAxSFomJWpiBe9K7
         0dFQK5stMVFqbo2C5y/g8Xlb5wLbLSFvDCc2LHB/zEGdL/1QYuk3uqwiqN3JFlbxkDtD
         QemA==
X-Gm-Message-State: AOAM532BAmuXAk86ySXUX1wl2Mj4fMNzsVMqZiaXqFfnuLMV34fiAJNj
        rrYGkyBvgjVMCiBv5zLvNeWUVQHKFNQi+OrLVWRql/x5unkGRA==
X-Google-Smtp-Source: ABdhPJzqz46JGmqxBDLRnCpVdoH9nYY9SgLKyI8nxa65ZhXp3xjQz+PNbeXq6UT9EcgDZkdJ6rRORP/8KhCR/rDTue8=
X-Received: by 2002:a25:2308:0:b0:628:9a66:7327 with SMTP id
 j8-20020a252308000000b006289a667327mr2490701ybj.626.1647474125953; Wed, 16
 Mar 2022 16:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220316141636.248324-1-sashal@kernel.org> <20220316141636.248324-10-sashal@kernel.org>
 <CACRpkdZU_wv74MeRiO_bMV03Gwp=8LamsPOGMEpY8Rm-X2Aq8w@mail.gmail.com> <YjIS9KENmMgXQejZ@sashalap>
In-Reply-To: <YjIS9KENmMgXQejZ@sashalap>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Mar 2022 00:41:54 +0100
Message-ID: <CACRpkdbQtP8G975s46t9-94BsvtLO3Vys99ap2=9ZR1ykLyhKw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.10 10/12] gpio: Revert regression in sysfs-gpio (gpiolib.c)
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 5:40 PM Sasha Levin <sashal@kernel.org> wrote:
> On Wed, Mar 16, 2022 at 05:06:47PM +0100, Linus Walleij wrote:
> >On Wed, Mar 16, 2022 at 3:17 PM Sasha Levin <sashal@kernel.org> wrote:
> >
> >> From: Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com>
> >>
> >> [ Upstream commit fc328a7d1fcce263db0b046917a66f3aa6e68719 ]
> >>
> >> Some GPIO lines have stopped working after the patch
> >> commit 2ab73c6d8323f ("gpio: Support GPIO controllers without pin-ranges")
> >>
> >> And this has supposedly been fixed in the following patches
> >> commit 89ad556b7f96a ("gpio: Avoid using pin ranges with !PINCTRL")
> >> commit 6dbbf84603961 ("gpiolib: Don't free if pin ranges are not defined")
> >>
> >> But an erratic behavior where some GPIO lines work while others do not work
> >> has been introduced.
> >>
> >> This patch reverts those changes so that the sysfs-gpio interface works
> >> properly again.
> >>
> >> Signed-off-by: Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com>
> >> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> >
> >I think you should not apply this for stable, because we will revert the revert.
>
> Okay, I'll give it a week to soak and if the revert is in by then I can
> just pick it too for the sake of completeness.

The revert of the revert is already in Linus' tree:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=56e337f2cf1326323844927a04e9dbce9a244835

Yours,
Linus Walleij
