Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD00A52DEF5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240850AbiESVJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbiESVJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:09:48 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E9AEC330
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:09:44 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 27so2677361ljw.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8gYyU3h5xXcUaprA3xNu8bw+7vAf51vN7b/Y2uG8LlE=;
        b=khHNK76O0MdKU5YuZTbfKkZWnkhL8wePXdC+Omz4MZ4jZpm+24Jjk/mEpkAI3cNrNh
         MY1UHKQnguqv2Eho3hH/m/tXxmHU2cMVuNILfsdCMMwfn757BCJOZeNuW1Ms37LTMNpt
         +8YxXL7tjVCIHzqFpSc5obOVQxgQba2Icf8pcICCW/xeIZInC4URJsR26wPf8tJH3uzA
         ahqWMlA2fU7TH2/UHJ8n/7GRptTNi3t4tKY2g5nj79bo43ACTXSL6aVOvRaOuLr5dSu1
         mwLkwyTEetNkPWxTktS5BOXyOATL3H7hS0rnlg/rh+SiRUwxShN+5xF5bIF3TBWwazpE
         22Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8gYyU3h5xXcUaprA3xNu8bw+7vAf51vN7b/Y2uG8LlE=;
        b=c4uadzCxbfR660J9Ysm7AqnhoVu7WKGzPjQYbdWAVnDA7IJjrWdcU4pS2Z9bG3gpMT
         bW4oy/zrrRfTb5ZoUe52LIl7wh7vRGkOOzQwimZuNMNrL2FRNPh+q8xJnpv74R5c1MiI
         VE9/wzelUYRpAvZ4Fo92dGY+T2URGetkq4DCQTinNyK42imHqOx95AmThpmom8pCP4iJ
         wfHOoRoZRx1YfXkcL8TkOrPi0aIyudSeO/nJmvNctJFbT7RPG3UbCzzL8lsv3t6sDnsr
         orcWO/91uJKSeu6skDThI64QvevEzWIb/v4WZkIXnIEVWoYZx9wTiRt7GIDwQo1uIE+J
         3xxg==
X-Gm-Message-State: AOAM530jAvz1uNOe49cSWA+HIqta6zXymkS2DLRcThRU1HYAm/fPCG0W
        h5qA7ZOyhVCWCGkKzh/YjYM=
X-Google-Smtp-Source: ABdhPJzUeqRfvm32FniVrCo648fPtw5Ofc0h8BH9vqxORMMSDDWPSrcRbfEQG93iSjjd5VJhtT1Pvw==
X-Received: by 2002:a2e:b0ef:0:b0:24f:ddc:cfd1 with SMTP id h15-20020a2eb0ef000000b0024f0ddccfd1mr3651354ljl.519.1652994583038;
        Thu, 19 May 2022 14:09:43 -0700 (PDT)
Received: from localhost.localdomain ([46.235.67.4])
        by smtp.gmail.com with ESMTPSA id y5-20020a197505000000b0047255d21202sm396875lfe.305.2022.05.19.14.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 14:09:42 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        dan.carpenter@oracle.com, fmdefrancesco@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v2 0/4] staging: r8188eu: add error handling of usb read errors
Date:   Fri, 20 May 2022 00:09:38 +0300
Message-Id: <cover.1652994483.git.paskripkin@gmail.com>
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
Series is based on top of staging-testing branch and should be
applied after Dan's patch https://lore.kernel.org/linux-staging/YoXS4OaD1oauPvmj@kili/


Changes since v1:
    addresses issues found by Dan and self review. Mostly related to returning
    _FAIL instead of -errno, since callers expect _FAIL/_SUCCESS

v1: https://lore.kernel.org/linux-staging/cover.1652911343.git.paskripkin@gmail.com/


Pavel Skripkin (4):
  staging: r8188eu: add error handling of rtw_read8
  staging: r8188eu: add error handling of rtw_read16
  staging: r8188eu: add error handling of rtw_read32
  MAINTAINERS: add myself as r8188eu reviewer

 MAINTAINERS                                   |   1 +
 drivers/staging/r8188eu/core/rtw_cmd.c        |  15 +-
 drivers/staging/r8188eu/core/rtw_efuse.c      |  33 ++-
 drivers/staging/r8188eu/core/rtw_fw.c         |  72 ++++--
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
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 130 +++++++---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  30 ++-
 drivers/staging/r8188eu/hal/usb_halinit.c     | 240 +++++++++++++++---
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  33 ++-
 drivers/staging/r8188eu/include/rtw_io.h      |   6 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  47 +++-
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  19 +-
 21 files changed, 679 insertions(+), 175 deletions(-)

-- 
2.36.1

