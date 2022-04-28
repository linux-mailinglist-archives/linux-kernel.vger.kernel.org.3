Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA563513875
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349240AbiD1PhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347399AbiD1PhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:37:17 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34AF56C3B;
        Thu, 28 Apr 2022 08:34:02 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id w17so9668063ybh.9;
        Thu, 28 Apr 2022 08:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xOJ+jxKKRQoro4qMUrRkofG7Mr8u768GVI3+/N34XWk=;
        b=GYOjFT/vAmx7PvhaRga3ovDZsNeojxYbQ0iSvT+oqtaHn4b2teyfxcKeZyJXNxPQi3
         shI+sDU9CITbf00TYgDVTrifjx6wnDGjUTd7zGLKX7ZX1Bgp58g1Bambq1OadLCF2ch2
         4CQBvG+iiiYWq6ET1rpsNrmRjcP8SA0GFMX6PiTNJtu5BMvqEefWBK/waHe6ch76q9kY
         2epyO4GNqapOrNmnTgJhRB0ON9DqYAPfcY/ADiZS5L+OhKo0JcEwxHk/HbWyRSkw2y7V
         nZh3iyKhhercN5k40muMzGaM/1pe++1tnKRy1y8WEot+rCIsf4igbS0EJAYIJw/1t4FB
         gX/Q==
X-Gm-Message-State: AOAM532XVJcJUUu7DXhraPZ2guRdngnLUDVmY3Tk0s9QCR2v1DWwtpWu
        +HNKKqrjxYwqkW1Bbs3vQjpnthsLw3Bt4hzW7W5xwCxPkv0=
X-Google-Smtp-Source: ABdhPJwwDj90K/MEJaGFQ0QrJmeM2enDiidLNZP8/7R7cwWwevQPomW0hnGZ/bgvxa6ehowEzWss9rICeAMxm1Cg+5I=
X-Received: by 2002:a25:e792:0:b0:645:7ddb:b5eb with SMTP id
 e140-20020a25e792000000b006457ddbb5ebmr31503488ybh.482.1651160042121; Thu, 28
 Apr 2022 08:34:02 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Apr 2022 17:33:51 +0200
Message-ID: <CAJZ5v0gbBq=UJLyXPcKYN6_LEUoagwUSt61i-ttPLHXvLVzaNA@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v5.18-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-5.18-rc5

with top-most commit a12475f91b69cce067e5de905fafa893ae12c3ae

 Merge branch 'thermal-int340x'

on top of commit b2d229d4ddb17db541098b83524d901257e93845

 Linux 5.18-rc3

to receive thermal control fixes for 5.18-rc5.

These take back recent chages that started to confuse users and
fix up an attr.show callback prototype in a driver.

Specifics:

 - Stop warning about deprecation of the userspace thermal governor
   and cooling device status interface, because there are cases in
   which user space has to drive thermal management with the help
   of them (Daniel Lezcano).

 - Fix attr.show callback prototype in the int340x thermal driver (Kees
   Cook).

Thanks!


---------------

Daniel Lezcano (2):
      Revert "thermal/core: Deprecate changing cooling device state
from userspace"
      thermal/governor: Remove deprecated information

Kees Cook (1):
      thermal: int340x: Fix attr.show callback prototype

---------------

 drivers/thermal/Kconfig                                 | 6 ++++--
 drivers/thermal/gov_user_space.c                        | 3 +--
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 4 ++--
 drivers/thermal/thermal_sysfs.c                         | 3 ---
 4 files changed, 7 insertions(+), 9 deletions(-)
