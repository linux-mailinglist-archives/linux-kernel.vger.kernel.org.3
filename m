Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E564CCA2D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 00:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbiCCXmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 18:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiCCXmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 18:42:08 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F60175841
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 15:41:22 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2d07ae0b1c0so73833347b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 15:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rSqQP18Wd5NjhlnE4AqOcj5HhSDR0at9tMDx/gdLLlo=;
        b=yRmMVk1t4YVHVWSGbfOVyeRazJTFv7gUI8AQpl8PJ0Lc6YZ/2i11q5FFuGAp+h1W5d
         da41qXCZKxNC5tC/aSkNNNRk1p1Hj9Rb54nxLmZs+jghB0FhkWq8uEAXaWDd4ecHLuEg
         4zs54BYBdf6j2tG6Bk+TQW0yogAxZp1vQbdKcZ9HQiwev2x9ZpMOvXOEtJCv153M9d7e
         fzwuxcSy7+ax7dmy8rJ7nxBKGdtSBTBut8aXsaVoRm8Ci19A/RjIb2vDBTaE4pHms68C
         hgJPIu6dyqz9TSMbuwcS9Y1FId8Cu7QYJU3mNTBN2L6XjSPjV8fE2H1BNHHNkJdVv3/g
         0sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rSqQP18Wd5NjhlnE4AqOcj5HhSDR0at9tMDx/gdLLlo=;
        b=uZ8SV7k/i7j6z3CkDJexf6ucpUgG2F8vgYQRsJ5QMlyeWBRl/oq15PuYVKceYr7Let
         KqE8YDRQGoabSKjUMim+VzegpylmSQKWNuBc1xE4/AIjyMZgdJCBhgETFc7hdy3SFj+a
         6ihnjr6nfzgtmOBZSuh8/XNfQvrPxmT5XQrqM3gmryq+w13247dB12CAYlNaZX6KLoZp
         JYiN+IwGUbTFTt7ogcNo4O64zxfUbvzvMksvbAZF92dqybA3jyBSDMqTQ6NoYy8xOy9E
         ual1kSDUjZ4SHgSqffdpjghqGhCnbZvs1rcQKKrXY+EPuRvhoS+F/MIB9CzW/QYCeurW
         5aIA==
X-Gm-Message-State: AOAM532nktjK+HeV+abrr10u4QOU00qE1Kn1J+r7rbf/h24rf/0Y/wxQ
        jcYnYAaiHw6z/0kvtQktfIuC+nIfyO8lwOjCDnlPIA==
X-Google-Smtp-Source: ABdhPJwtC1jhKWkPjadvpjvVogW8B+4VLWiojzRsvx+jKaozVAbWCq1Wrf4pA84QhGsjYIdSfK9xZ4qqGOZqWIuNV60=
X-Received: by 2002:a81:1182:0:b0:2dc:4e58:da41 with SMTP id
 124-20020a811182000000b002dc4e58da41mr3555190ywr.268.1646350881491; Thu, 03
 Mar 2022 15:41:21 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Mar 2022 00:41:10 +0100
Message-ID: <CACRpkda0eFMzvfCjtXYiRoe=Wa5XqacL1Lhy4mBBOo6pu_Wi5w@mail.gmail.com>
Subject: [GIT PULL] late pin control fixes for v5.17
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

as promised, here are the fixes for the issues seen by Guenther
on the OrangePi, details in the signed tag.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:

  Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.17-3

for you to fetch changes up to bac129dbc6560dfeb634c03f0c08b78024e71915:

  pinctrl: sunxi: Use unique lockdep classes for IRQs (2022-02-28
23:53:19 +0100)

----------------------------------------------------------------
Pin control fixes for the v5.17 series

These two fixes should fix the issues seen on the OrangePi,
first we needed the correct offset when calling
pinctrl_gpio_direction(), and fixing that made a lockdep
issue explode in our face. Both now fixed.

----------------------------------------------------------------
Hans Verkuil (1):
      pinctrl-sunxi: sunxi_pinctrl_gpio_direction_in/output: use correct offset

Samuel Holland (1):
      pinctrl: sunxi: Use unique lockdep classes for IRQs

 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)
