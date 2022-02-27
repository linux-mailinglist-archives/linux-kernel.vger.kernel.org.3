Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE2E4C58DE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 02:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiB0BMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 20:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiB0BMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 20:12:14 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06902229498
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 17:11:39 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id f38so1508725ybi.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 17:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5A0m1bN6aUhIMIsLQ8DmMr2K7rDr/v9MtDeLLhXW6As=;
        b=pkWgcULyMIqrcvNgtJCNJBdIuGraEqRQy8lawxb/MeMtDXh7YqJq4N53zV3jgobs7R
         lJQfB0SdqtFRUn6ACmJf1gbeGw6GfbpCL7/wnoVWuVkqw+NoOR8QJvp3ewWRBqT+RkRl
         PZdo2ap/+mlS212h5HVP1UsXOD8JsOE2KCfponeIoOYShwkER9HG0BokejVZEC+s6Bug
         iKClbP41Q18dGi++ykUO2LLePrZE6AdHGSz+zqK9EOOBnKWdghXq2zXpVyafNfPCMEC8
         UMCQABtNj+epjCWFZBHiEUdzaBYXS270Z8OPJlQCd7nlHt0+o7xVHVxYt2MP69/VtZ79
         WicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5A0m1bN6aUhIMIsLQ8DmMr2K7rDr/v9MtDeLLhXW6As=;
        b=3pyz/weTGmpP0iR9Sg4Ez7LzTytGiR3nGVUYbKI2tgV6qYXIYK2zGh1CI0K0kzhlEV
         RlNGLEt79oUicigq0Qv/p31Lsz1+tDRLQref4mIRfwDbUzjj1PQ2nHEJPf+C8d4VvxiM
         VPmRALQBGvhZML9X+q57AFHH+ke68NuNFFjKpEQzJEnVpD3r9QR6lid4/X4S+mmokuEV
         F1ZrNRomPfBdoOm/X7d1kYVKis0gbD3zb6Yui6oE8/7PkYfrSGNSJ44RCBS2+FJaKR3e
         a2a2leEjR1hnMEJKTZFNO7A8ZbqDjDB8YtArUzk7ZEUsWFBL8sBSXUGMSg7zJDERI0cb
         s7lQ==
X-Gm-Message-State: AOAM531ONaElSjsy6mcQ4JOIwsNGATc2u5fZ9lvsw7njfu4vJl0lgTxq
        yiM9zGi03rDYe6TnWyrjQH2DTLT4W2rJp1fPt7bhfg==
X-Google-Smtp-Source: ABdhPJx6fFzZX60QgOiP2+ukdiVHdD4rV+h48XcCnCeVioSNPfrisfj88O5sTvqZf1tl8i+dFMYwvR3h9AHEuj9+Rzw=
X-Received: by 2002:a25:aac3:0:b0:624:ab10:49dc with SMTP id
 t61-20020a25aac3000000b00624ab1049dcmr13631037ybi.291.1645924298247; Sat, 26
 Feb 2022 17:11:38 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 27 Feb 2022 02:11:27 +0100
Message-ID: <CACRpkdYM21hcH5d9rXyvjMPHQp429OZ1Zcy7uLU2tndoJcOmUQ@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for the v5.17 series
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
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

some more pin control fixes that trickled in the last week or
two.

Please pull it in, some details are in the signed tag!

Yours,
Linus Walleij

The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5-17-3

for you to fetch changes up to 486c2d15aa812d669bb27f8241aa5d5dafbac5b9:

  Merge tag 'intel-pinctrl-v5.17-5' of
gitolite.kernel.org:pub/scm/linux/kernel/git/pinctrl/intel into fixes
(2022-02-19 02:03:58 +0100)

----------------------------------------------------------------
Pin control fixes for the v5.17 series:

- Fix some drive strength and pull-up code in the K210 driver.

- Add the Alder Lake-M ACPI ID so it starts to work properly.

- Use a static name for the StarFive GPIO irq_chip, forestalling
  an upcoming fixes series from Marc Zyngier.

- Fix an ages old bug in the Tegra 186 driver where we were
  indexing at random into struct and being lucky getting the
  right member.

----------------------------------------------------------------
Andy Shevchenko (1):
      pinctrl: tigerlake: Revert "Add Alder Lake-M ACPI ID"

Dan Carpenter (1):
      pinctrl: fix loop in k210_pinconf_get_drive()

Linus Walleij (1):
      Merge tag 'intel-pinctrl-v5.17-5' of
gitolite.kernel.org:pub/scm/linux/kernel/git/pinctrl/intel into fixes

Marc Zyngier (2):
      pinctrl: starfive: Use a static name for the GPIO irq_chip
      gpio: tegra186: Fix chip_data type confusion

Sean Anderson (1):
      pinctrl: k210: Fix bias-pull-up

 drivers/gpio/gpio-tegra186.c              | 14 ++++++++++----
 drivers/pinctrl/intel/pinctrl-tigerlake.c |  1 -
 drivers/pinctrl/pinctrl-k210.c            |  4 ++--
 drivers/pinctrl/pinctrl-starfive.c        |  2 +-
 4 files changed, 13 insertions(+), 8 deletions(-)
