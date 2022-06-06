Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B1E53EEB4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiFFTg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiFFTgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:36:55 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100CA84A22
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:36:52 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id w20so3263893lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 12:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ocE4xdI2Ps5J5GJU8d4YixiKjR69pIIldx4ffv9ni2c=;
        b=dSgm0J+kU8mOPlOycUV4NGLJBqwoFt1vRSHeQmhgpBNK2dFapFO7pjvXtv3708T7zn
         0dx8XJFjcHy2H8tYq0aB/f49XzmWbEkCABFK4GqxnSxs4fRx3NRufQiU5VW1YIOKiX/H
         9imtXgzpzHAGMm6+n3uhhWvFDDAVfRJfpVzubECh8u1BIg2KayMX8SWrTtqaEJOviJy4
         XkmOl7bJ24r7OmrisaRblYC+PHBgPgPgqmrCq8yp41mze3qLSu6kDQyVSCWLSU2eXpl2
         JKhZaKJ7T993IKlQ2ryNqGxSU05rG4V56rW8SmkFHc+ai/AtsJv3Tz0aaWN8dRbl4/zk
         UpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ocE4xdI2Ps5J5GJU8d4YixiKjR69pIIldx4ffv9ni2c=;
        b=Eu+lezMbErhe9qEPgcmc/m1aIK2lR3DqNjQlf/ia0p2wWEZA9i4EkHaZcr/yJX6jJj
         bJ5CwOw6k5AQKmUDVYBEX6xd6NgXtwqTqPVcpv+t9ZDspq5AQjGJvJ+/l3UsyGvUPk4l
         qdyTMucEU/EAwWP6at4OZFXOoxc6ze5XfjMRHHYppaGUtVv96rWUQ+lHCttU1QEeKSxZ
         nI+49pE81fhfDp7wuVi9w/hd7koH/d/XKtp+yHSmOhfeGoDVP4wg0/qNCXOaesAJXmMf
         T3or/Qgz2Nnyq3PlRde6/PqBfJ+DhLkVqSodmW9WEQY8uls+lsYV2Y8n3vi9zOj1bjzR
         hGnQ==
X-Gm-Message-State: AOAM531ln+vdpCXpCImrAjDTStTXFpOMHmcV0yOWjUZ2Tvt3xRETVTgH
        wYmUTNnqx8Ymfo9l//0ynBk=
X-Google-Smtp-Source: ABdhPJxCSp/6uMa99wsCN0iUq6WWebYMaS87eW+3AfWRWIRd4tPDAvfHnLN4enGA4KhzlO/FAFt/KA==
X-Received: by 2002:a05:6512:c07:b0:479:2e0f:9a06 with SMTP id z7-20020a0565120c0700b004792e0f9a06mr7626550lfu.687.1654544210301;
        Mon, 06 Jun 2022 12:36:50 -0700 (PDT)
Received: from localhost.localdomain ([94.103.229.27])
        by smtp.gmail.com with ESMTPSA id l10-20020a056512110a00b004791c4858e0sm1656662lfg.114.2022.06.06.12.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 12:36:49 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        dan.carpenter@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v3 0/4] staging: r8188eu: add error handling of usb read errors
Date:   Mon,  6 Jun 2022 22:36:46 +0300
Message-Id: <cover.1654543286.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it's reincarnation of my old series for adding sane error handling in
r8818eu.

*Problem*

Old code was returning just stack variable in case of read error. It's
not the best approach, since passing around stack data might cause
device misconfiguration or even kernel data leakage

To solve this I've changed rtw_read{8,16,32} prototypes to return an error via
return value and data via passed pointer. Some work should be done to
propogate an error down to calltrace, but it's good way to at least
start doing sane I/O error handling

Tested locally on qemu with TP-Link TL-WN722N v2/v3 [Realtek RTL8188EUS]
device. More testing is welcomed, of course :)

_NOTE_
Series is based on top of staging-testing branch.

Changes since v2:
    get rid of `(void)res` and return an error from function instead of
    hiding it

Changes since v1:
    addresses issues found by Dan and self review. Mostly related to returning
    _FAIL instead of -errno, since callers expect _FAIL/_SUCCESS

v1: https://lore.kernel.org/linux-staging/cover.1652911343.git.paskripkin@gmail.com/
v2: https://lore.kernel.org/linux-staging/cover.1652994483.git.paskripkin@gmail.com/

Pavel Skripkin (4):
  staging: r8188eu: add error handling of rtw_read8
  staging: r8188eu: add error handling of rtw_read16
  staging: r8188eu: add error handling of rtw_read32
  MAINTAINERS: add myself as r8188eu reviewer

 MAINTAINERS                                   |   1 +
 drivers/staging/r8188eu/core/rtw_cmd.c        |  15 +-
 drivers/staging/r8188eu/core/rtw_efuse.c      |  33 ++-
 drivers/staging/r8188eu/core/rtw_fw.c         |  72 +++--
 drivers/staging/r8188eu/core/rtw_led.c        |  16 +-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  62 ++++-
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    |   9 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c  |  20 +-
 .../r8188eu/hal/Hal8188ERateAdaptive.c        |  21 +-
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |  21 +-
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |   9 +-
 drivers/staging/r8188eu/hal/hal_com.c         |  27 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  37 ++-
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     |   6 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 136 +++++++---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  30 ++-
 drivers/staging/r8188eu/hal/usb_halinit.c     | 251 +++++++++++++++---
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  33 ++-
 drivers/staging/r8188eu/include/rtw_io.h      |   6 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  47 +++-
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  19 +-
 21 files changed, 693 insertions(+), 178 deletions(-)

-- 
2.36.1

