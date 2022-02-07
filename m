Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2F94ABCCF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 12:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387134AbiBGLj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 06:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384386AbiBGL2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:28:02 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6049C03E947
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 03:26:09 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id q22so19047649ljh.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 03:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77jDirKALASyuRe4H7SNos8+ceiZ5NwhVHAmzpu0zXA=;
        b=YPG3HSxJDHKgSkLNtEZkTejuMRlS5t3d0YDL/GSegkBzscg/AzU0bbVAoAAIj2jYRj
         aESr+4jgMaypMMIwM0Ho5vk5lfe7AUCINgESqbh1fjUuJHPGg3TszyV9MJG6Lsx9dlG3
         lCaRevSAg68VQeJAGT8TYNZOWHv6gIYm98eYHsENIigae8mIHGqX3XT+TvMmFQm0D9fW
         /EE7CB+EcTk3UXcfQR7OYRRuguM8pdwxYbFoHj/sP2ROwqrJ3r8MCdyqv+9f9NO1uHKL
         /AqLLS18OjZzcg8UtTf+WhTvI7hSJ77JkNZ/92/dzIGYzYoMqlbKlUrJU0TXu15+UwRl
         zg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77jDirKALASyuRe4H7SNos8+ceiZ5NwhVHAmzpu0zXA=;
        b=W6eU0CxEMDK29JZtjz2ByK5pLwaCSPatD3U89Xh3Qc5kG9dKow57RyWpY0h7mx0jIC
         SWrBYPA2teX2XKJ1L24yp8MyeCDbjUiIMKscNPZO1X19KxkE4AHKTJnk/aLRh/40aRfL
         fOjqRdsorQpF0fUd+RbQDk4iYaU2Ho2JmCD19ygo/1h5uZuiz32EFdIZHUsoIR8XJTsr
         yz+hhzpE1nEXErXYzrmVZfOauZktzDaaAAlVJ3NGMF0k/SoC4ap6+QqAMeXy4vWR2c27
         iYbfzxkDrnsq7eJHDR1QEc0k07CiUpl3fcbp0lH+eHRh7oFBd3FQqHz/FxbzeRE/N2Sx
         sHCg==
X-Gm-Message-State: AOAM532F5NrEsuIGbussgzPkXlkkKgfEZ75QbS7cOVubGniWNgB7eAHm
        EDvgXzQycGz1kvnhRWTN4ssYRQ==
X-Google-Smtp-Source: ABdhPJx1YHEx8hiT2J0YS7cHvuzQ34b5CoCNxheFV1HDcYv0oDChcf6LpLrWcy+v2YVfAhzHSCjOWg==
X-Received: by 2002:a05:651c:d4:: with SMTP id 20mr8530119ljr.132.1644233168232;
        Mon, 07 Feb 2022 03:26:08 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-21.NA.cust.bahnhof.se. [155.4.129.21])
        by smtp.gmail.com with ESMTPSA id z20sm1530066ljj.103.2022.02.07.03.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 03:26:07 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.17-rc4
Date:   Mon,  7 Feb 2022 12:26:05 +0100
Message-Id: <20220207112605.246647-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.17-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.17-rc1

for you to fetch changes up to bd2db32e7c3e35bd4d9b8bbff689434a50893546:

  moxart: fix potential use-after-free on remove path (2022-01-31 15:36:34 +0100)

----------------------------------------------------------------
MMC core:
 - Fix support for SD Power off notification

MMC host:
 - moxart: Fix potential use-after-free on remove path
 - sdhci-of-esdhc: Fix error path when setting dma mask
 - sh_mmcif: Fix potential NULL pointer dereference

----------------------------------------------------------------
Andrey Skvortsov (1):
      mmc: core: Wait for command setting 'Power Off Notification' bit to complete

Greg Kroah-Hartman (1):
      moxart: fix potential use-after-free on remove path

Jiasheng Jiang (2):
      mmc: sdhci-of-esdhc: Check for error num after setting mask
      mmc: sh_mmcif: Check for null res pointer

 drivers/mmc/core/sd.c             | 8 +++++++-
 drivers/mmc/host/moxart-mmc.c     | 2 +-
 drivers/mmc/host/sdhci-of-esdhc.c | 8 ++++++--
 drivers/mmc/host/sh_mmcif.c       | 3 +++
 4 files changed, 17 insertions(+), 4 deletions(-)
