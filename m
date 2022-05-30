Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190DE538655
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 18:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240093AbiE3Qt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 12:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbiE3Qtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 12:49:55 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40445A167;
        Mon, 30 May 2022 09:49:54 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id h75so13886523ybg.4;
        Mon, 30 May 2022 09:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=O0qtKGbgqamTRlfvEaAawcHUxUuFNdQZ++whauvuoLA=;
        b=ZD3zzJc9p6hTmAz6WUvH/aylhgRUx6VzDQWFX0fwggdpAId6wYwbi1lBU+n64bnuuV
         nfV/P3X9bD4aA4a73JKM7iHdu3ZdxDz836vlznRdS0l1pOqvPPi1/AsV8a7GJw7+jDfm
         dBfgqcgV39YmMZ7dqdFw7hKqfl+JRvFp12NSSKG2GBf5Vb3RF60Ql2EAtc8EEVD+ecIs
         tUkYKYzlmJC2j86VH0T09Cx1Ex9jvHqHZVf52u+3bStZtJU4S2zbbwSQVH4sts6EdpoS
         1qB1bF8pP2hB1J6/HlMQ3ntXqTPSS3mTVtRlfOQvcKgkMQqH1cE1B6EZNbb9ExxxRXhO
         U/nQ==
X-Gm-Message-State: AOAM530+Y+A13GM1s4Qh8yBeqnM1M10V+uFotspRddmTanKGovc0Ep+2
        T7rOXI89XW4xh8yh5Ea8Bum8kPvUydmTDkuvZ2CEYNQ7ONo=
X-Google-Smtp-Source: ABdhPJy7e7HF/Lq0ogGvxIH3ZcJw+HDgPFMGLhTsGppoAggsbtDoqSG9hJd2netQthg/GvkO0P7Tg7WcMkxi7D93uzM=
X-Received: by 2002:a25:84ca:0:b0:65c:b5a4:3d0a with SMTP id
 x10-20020a2584ca000000b0065cb5a43d0amr9644306ybm.137.1653929394225; Mon, 30
 May 2022 09:49:54 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 May 2022 18:49:43 +0200
Message-ID: <CAJZ5v0gJ-06Zt_p9SS+wCZW60Z9TmvUF8zgL3g=iw3y_VGM71Q@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v5.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
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
 acpi-5.19-rc1-2

with top-most commit 4a577fca503a63442928ff4cec06c1136ea9b53e

 Merge branches 'acpi-battery', 'acpi-video' and 'acpi-misc'

on top of commit f4fb8596657c998ca4cdb833bc0f509533a38ddd

 Merge tag 'thermal-5.19-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI updates for 5.19-rc1.

These add some new device IDs, update a few drivers (processor,
battery, backlight) and clean up code in a few places.

Specifics:

 - Add Meteor Lake ACPI IDs for DPTF devices (Sumeet Pawnikar).

 - Rearrange find_child_checks() to simplify code (Rafael Wysocki).

 - Use memremap() to map the UCSI mailbox that is always in main memory
   and drop acpi_release_memory() that has no more users (Heikki
   Krogerus, Dan Carpenter).

 - Make max_cstate/nocst/bm_check_disable processor module parameters
   visible in sysfs (Yajun Deng).

 - Fix typo in the CPPC driver (Julia Lawall).

 - Make the ACPI battery driver show the "not-charging" status by
   default unless "charging" or "full" is directly indicated (Werner
   Sembach).

 - Improve the PM notifier in the ACPI backlight driver (Zhang Rui).

 - Clean up some white space in the ACPI code (Ian Cowan).

Thanks!


---------------

Dan Carpenter (1):
      usb: typec: ucsi: acpi: fix a NULL vs IS_ERR() check in probe

Heikki Krogerus (2):
      usb: typec: ucsi: acpi: Map the mailbox with memremap()
      ACPI: OSL: Remove the helper for deactivating memory region

Ian Cowan (1):
      ACPI: clean up white space in a few places for consistency

Julia Lawall (1):
      ACPI: CPPC: fix typo in comment

Rafael J. Wysocki (1):
      ACPI: glue: Rearrange find_child_checks()

Sumeet Pawnikar (1):
      ACPI: DPTF: Support Meteor Lake

Werner Sembach (1):
      ACPI: battery: Make "not-charging" the default on no charging or full info

Yajun Deng (1):
      ACPI: processor: idle: Expose max_cstate/nocst/bm_check_disable
read-only in sysfs

Zhang Rui (1):
      ACPI: video: improve PM notifer callback

---------------

 drivers/acpi/ac.c                                  |  4 +-
 drivers/acpi/acpi_video.c                          | 31 ++++----
 drivers/acpi/battery.c                             | 24 +-----
 drivers/acpi/cppc_acpi.c                           |  2 +-
 drivers/acpi/dptf/dptf_pch_fivr.c                  |  1 +
 drivers/acpi/dptf/dptf_power.c                     |  2 +
 drivers/acpi/dptf/int340x_thermal.c                |  6 ++
 drivers/acpi/fan.h                                 |  1 +
 drivers/acpi/glue.c                                | 16 ++--
 drivers/acpi/osl.c                                 | 86 ----------------------
 drivers/acpi/processor_idle.c                      | 10 +--
 .../intel/int340x_thermal/int3400_thermal.c        |  1 +
 .../intel/int340x_thermal/int3403_thermal.c        |  1 +
 drivers/usb/typec/ucsi/ucsi_acpi.c                 | 23 ++----
 include/linux/acpi.h                               |  3 -
 15 files changed, 51 insertions(+), 160 deletions(-)
