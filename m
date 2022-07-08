Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892D156C2CC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239108AbiGHTTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGHTTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:19:01 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA48167EA;
        Fri,  8 Jul 2022 12:19:00 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id n74so9697811yba.3;
        Fri, 08 Jul 2022 12:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zBVfIjIBKAVbQPvcPRZtKlChTb3SHo0Kz1tsaYTp44M=;
        b=wTQnrUI9pxmGj/BJOTk0keUjHkAVFB6zc3TvpPSUBDubjNyXkKIf492IWZmsugNjBg
         pGrchE4uPsDzxCrYqcWjQMfGUpUPg/hf1sGTuINcppu+Ew2m4oy1CsZcrQtSdrGqpuHW
         F6GwVhpX0ARD4+c/HZu8OtyHRAunwVPfqmr3xG7wL4mOWxPSOe3BAP3DxOAz7jyg9V13
         jU5939pwVbVqYkUqbdJ8/NEKqIbIYOICgyOId6uQY54/DlqssJCHZ/z07RdYjD0c0V4G
         DarydBQcld7+NJiYtNqkHE0cSbE2BsY36FueJeGQ4ppMt3P9HDyO0DwyiLxsscYk5x06
         Hxzw==
X-Gm-Message-State: AJIora+qFGfInxcxy/8/xqsuWpAS1GP8hiS2gunmgN5MAUxuvHTmf3/A
        0ilcnv+6VHHLgSHknuUHXASK1qKxsKyDHtmDIfXeRBTTGbY=
X-Google-Smtp-Source: AGRyM1uC7ssN4Z6DkbXmmBEQCdYHH0N0jmNNwvf4HB/XDrBGhxDwduhwwAICzC9XS7DgYaC1J3t57m7fW9eQaj0/4o0=
X-Received: by 2002:a05:6902:154f:b0:66e:e2d3:ce1 with SMTP id
 r15-20020a056902154f00b0066ee2d30ce1mr1440802ybu.365.1657307940019; Fri, 08
 Jul 2022 12:19:00 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Jul 2022 21:18:47 +0200
Message-ID: <CAJZ5v0hEZmJ4PJZs43m4tbrEVX4Hx3Jd1jvSsTzU09uaqbm7TQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.19-rc6
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
 pm-5.19-rc6

with top-most commit fe7c758c07c4729a16f940eb1d77027ad032ab29

 Merge branch 'pm-core'

on top of commit 88084a3df1672e131ddc1b4e39eeacfd39864acf

 Linux 5.19-rc5

to receive power management fixes for 5.19-rc6.

These fix a NULL pointer dereference in a devfreq driver and
a runtime PM framework issue that may cause a supplier device
to be suspended before its consumer.

Specifics:

 - Fix NULL pointer dereference related to printing a diagnostic
   message in the exynos-bus devfreq driver (Christian Marangi).

 - Fix race condition in the runtime PM framework which in some
   cases may cause a supplier device to be suspended when its
   consumer is still active (Rafael Wysocki).

Thanks!


---------------

Christian Marangi (1):
      PM / devfreq: exynos-bus: Fix NULL pointer dereference

Rafael J. Wysocki (2):
      PM: runtime: Redefine pm_runtime_release_supplier()
      PM: runtime: Fix supplier device management during consumer probe

---------------

 drivers/base/core.c          | 13 ++++++++++++-
 drivers/base/power/runtime.c | 34 ++++++++++------------------------
 drivers/devfreq/exynos-bus.c |  6 +++---
 include/linux/pm_runtime.h   |  5 ++---
 4 files changed, 27 insertions(+), 31 deletions(-)
