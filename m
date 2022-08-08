Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C74558CD67
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244048AbiHHSMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiHHSMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:12:13 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2779E12AB3;
        Mon,  8 Aug 2022 11:12:12 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 21so14908257ybf.4;
        Mon, 08 Aug 2022 11:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=/XHnQoPocPD1a+UnGHJ/9LJiW0L14KZ4B77UdMr6VZw=;
        b=sP+bxYE0OzPRL5B3OGUYDf3qKflzLSyRBedXSPhMvreUbU699YeMKCURPfFRuyfweD
         bdTmPQ0r3LcnnYD9wYgT/gpu7O4LYHco1wu3ze42WB9CJJhF9GxBRE8Kfz9i2yokei8e
         JeNNvAWWOX73/OPvEPl4TobBhqld6VoEGONBen0SFHjMmiZ2pByl7PIVMzvtkvi+JNto
         BgB2wgM1hl847wnaeYg70Uz3PvCM5tDwdcFEtK3dBk7I++P2S7AW2hy7lYsVgPr0JF8Y
         NBjAS/mITufdDIKCjqgWb/s7DYbYd/Mr5k4RSBLg5KGxZ0sXc8gS8CvFGVAn5jXXi4fg
         gGww==
X-Gm-Message-State: ACgBeo1qrhDtObB+dtZt/Ph11Yx5InEOb5e2O8UqHniIzUpJwsms8/Gs
        +LcMtDNQ3z5mLYBWCIRtBbeeML9a84Bk/uo9078=
X-Google-Smtp-Source: AA6agR4H1H7WBo4EV9Tg7G3C9OGsDnETofLMg/OU7ZpAttHQ9aGjHDaj1q03AN3BQxR3GOdd60H1sGvdcIpQwUiymko=
X-Received: by 2002:a5b:202:0:b0:66f:aab4:9c95 with SMTP id
 z2-20020a5b0202000000b0066faab49c95mr17629644ybl.81.1659982331328; Mon, 08
 Aug 2022 11:12:11 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Aug 2022 20:11:59 +0200
Message-ID: <CAJZ5v0iTeVEHGZZeo+qBSgKENY7E-jp0MEu30Barm=yYjnYMxA@mail.gmail.com>
Subject: [GIT PULL] More thermal control updates for v5.20-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-5.20-rc1-2

with top-most commit 7f0169cde0ced2e2b7bdf3dcedcf8c71efc6afc0

 Merge branches 'thermal-core' and 'thermal-tools'

on top of commit c1dbe9a1c86da098a29dcdca1a67b65e2de7ec3a

 Merge tag 'thermal-5.20-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more thermal control updates for 5.20-rc1.

These fix an error code path issue leading to a NULL pointer
dereference going forward, drop Kconfig dependencies that are
not needed any more after recent changes, add CPU IDs for new
chips to a driver and fix up the tmon utility.

Specifics:

 - Fix NULL pointer dereference in the thermal sysfs interface that
   results from an error code path mishandling (Rafael Wysocki).

 - Drop COMPILE_TEST dependency that's not needed any more from two
   thermal Kconfig entries (Jean Delvare).

 - Make the Intel TCC cooling driver support Alder Lake-N and Raptor
   Lake-P (Sumeet Pawnikar).

 - Fix possible path truncations in the tmon utility (Florian Fainelli).

Thanks!


---------------

Florian Fainelli (1):
      tools/thermal: Fix possible path truncations

Jean Delvare (1):
      thermal: Drop obsolete dependency on COMPILE_TEST

Rafael J. Wysocki (1):
      thermal: sysfs: Fix cooling_device_stats_setup() error code path

Sumeet Pawnikar (1):
      thermal: intel: Add TCC cooling support for Alder Lake-N and Raptor Lake-P

---------------

 drivers/thermal/Kconfig                   |  4 ++--
 drivers/thermal/intel/intel_tcc_cooling.c |  2 ++
 drivers/thermal/thermal_sysfs.c           | 10 +++++++---
 tools/thermal/tmon/sysfs.c                | 24 +++++++++++++-----------
 4 files changed, 24 insertions(+), 16 deletions(-)
