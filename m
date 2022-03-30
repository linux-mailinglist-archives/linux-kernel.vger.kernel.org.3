Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AB34EB859
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 04:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242013AbiC3Cib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 22:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237060AbiC3Ci3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:38:29 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A7D227C56
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:36:44 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id w17-20020a056830111100b005b22c584b93so14048693otq.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DHEZxSjzJlAPP2uqRqoKSVFTqS9GuHL/yTxHB4u0XZ8=;
        b=deFHZEmJxRWJscAbTS7+14TIUG1p6cMQHdj7ZGHJ4PaVtO5K8L09p7k69yoG/405N7
         37WH0U7LaCMTM+sQp/yb/ETrRwwvORNrZZPFtvsiZRpoi44RRZnu+INkK7tHLFuitYzN
         E3U868ePSbdsHP5H5axaka1tO5sYb1ErrJzCLiJEMuQiPboQRemlpKDYkjBcvltLyJXA
         8GqVwlC57PMQKicBKnOgwEMOjiJ2HF3cjTfmYUQOPsNf8/7y/vfuAxBiSI6MAMoDIucV
         k5pvfxSZzVw5FHaZKbLebwK6sOtrRbWlFWy3gGc0oZyUTfIBmAnd1VH35oHCHiaeCE6e
         hgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DHEZxSjzJlAPP2uqRqoKSVFTqS9GuHL/yTxHB4u0XZ8=;
        b=bCrIoAF6tYiZl1i2sQap7NQ8kmqr95nAZxLUzCnvc0uIkMWPqT29+8XXTtUfSTxoEC
         +7ZCSmJukvgwRtX4v72QyUu3FRz8N1r0+C+FuLgOdQkJcAu5m14s1Yk+mhslGXqrTDvU
         iQOHa3CDtHgq2BpCKi8wj1uFg6ITII94P09iP6cE39ZQvGmty8AC0m2COHc2xvLW6Mfu
         WFiMfletCAera95Q9hMX0CzqtnXaQO2pSM9F84rriQDf+n3T5CB1yaaD4wnCeGoTGIz2
         4TSeR+LsVgaZBjdNu8juHLY+ItyQ8WDuaWlLBDM6UbdaUgBc0UN4jDroJ9xzVfaH586j
         BppA==
X-Gm-Message-State: AOAM532AKfP5I8WfPOJrD2C9w6v/SB7MezuAeZO5giPUW5WxNYQ7XZkz
        gVb2cdzMTV9SoSB7utNmauLqXg==
X-Google-Smtp-Source: ABdhPJyX7nFTb5fNtNKAkBvNdRMgmjcVXyBvRPthDL9QsoLtpEcBDKHG3ePy6i/5GKwyn13gvdCwmw==
X-Received: by 2002:a9d:77d7:0:b0:5b2:29b0:70cb with SMTP id w23-20020a9d77d7000000b005b229b070cbmr2366290otl.276.1648607804090;
        Tue, 29 Mar 2022 19:36:44 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id f8-20020a4a8908000000b0032472938f95sm8411542ooi.17.2022.03.29.19.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 19:36:43 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Tim Blechmann <tim@klingt.org>
Subject: [GIT PULL] rpmsg updates for v5.18
Date:   Tue, 29 Mar 2022 21:36:42 -0500
Message-Id: <20220330023642.187977-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v5.18

for you to fetch changes up to 8109517b394e6deab5fd21cc5460e82ffed229c6:

  rpmsg: ctrl: Introduce new RPMSG_CREATE/RELEASE_DEV_IOCTL controls (2022-03-13 11:49:53 -0500)

----------------------------------------------------------------
rpmsg updates for v5.18

The major part of the rpmsg changes for v5.18 relates to improvements in
the rpmsg char driver, which now allow automatically attaching to rpmsg
channels as well as initiating new communication channels from the Linux
side.

The SMD driver is moved to arch_initcall with the purpose of registering
root clocks earlier during boot. Also in the SMD driver, a workaround
for the resource power management (RPM) channel is introduced to resolve
an issue where both the RPM and Linux side waits for the other to close
the communication established by the bootloader - this unblocks support
for clocks and regulators on some older Qualcomm platforms.

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      rpmsg: qcom_smd: Fix redundant channel->registered assignment

Arnaud Pouliquen (8):
      rpmsg: char: Export eptdev create and destroy functions
      rpmsg: Create the rpmsg class in core instead of in rpmsg char
      rpmsg: Move the rpmsg control device from rpmsg_char to rpmsg_ctrl
      rpmsg: Update rpmsg_chrdev_register_device function
      rpmsg: char: Refactor rpmsg_chrdev_eptdev_create function
      rpmsg: char: Add possibility to use default endpoint of the rpmsg device
      rpmsg: char: Introduce the "rpmsg-raw" channel
      rpmsg: ctrl: Introduce new RPMSG_CREATE/RELEASE_DEV_IOCTL controls

Konrad Dybcio (1):
      rpmsg: qcom_smd: Promote to arch_initcall

Luca Weiss (1):
      rpmsg: smd: allow opening rpm_requests even if already opened

Minghao Chi (CGEL ZTE) (1):
      rpmsg: use struct_size over open coded arithmetic

Tim Blechmann (1):
      rpmsg: char: treat rpmsg_trysend() ENOMEM as EAGAIN

 drivers/rpmsg/Kconfig             |   8 ++
 drivers/rpmsg/Makefile            |   1 +
 drivers/rpmsg/qcom_glink_native.c |   4 +-
 drivers/rpmsg/qcom_smd.c          |  13 +-
 drivers/rpmsg/rpmsg_char.c        | 238 ++++++++++++++-----------------------
 drivers/rpmsg/rpmsg_char.h        |  46 ++++++++
 drivers/rpmsg/rpmsg_core.c        |  15 ++-
 drivers/rpmsg/rpmsg_ctrl.c        | 243 ++++++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_internal.h    |  10 +-
 drivers/rpmsg/virtio_rpmsg_bus.c  |   2 +-
 include/uapi/linux/rpmsg.h        |  10 ++
 11 files changed, 428 insertions(+), 162 deletions(-)
 create mode 100644 drivers/rpmsg/rpmsg_char.h
 create mode 100644 drivers/rpmsg/rpmsg_ctrl.c
