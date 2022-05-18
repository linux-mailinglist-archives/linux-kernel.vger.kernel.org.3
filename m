Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9D052C602
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiERWLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiERWLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:11:51 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D9A66691
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:11:50 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h29so5984473lfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=np9qQNRe/434uUffTp5fkNq//+6BgIG1Jqjo8T2tQq4=;
        b=mVXnIcfDowm0H9W6YJlJel6lMFCikH4arwUrKuuRIFQ8GsrMRKn8vO7Utj9nZZj0tw
         TrO4FkvAxS9v1u2dxjdX4iDxqjM0MY7Sjif/BiSYGOvVmV9p1jMqgHTkxt1JiaLn6QfJ
         u559aOYqgsjSAiTFHJ8E9/cAb5nQIsGwYYaJuX79GkleImiovIqjuuDBvBheReQimeRv
         t/0WMxJ88K0b94eBFgMMKxSNm9GsRG4eMBjUhhdR3pP5sP4UiU1c+2YnP8UPeiUKxNcB
         Rue2SSQ64bFEEi3WNcbu4a3lw6FY/EjWCt8s2w2y4v/BqdXLZbX4pfnzTH5NecD/knzh
         wwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=np9qQNRe/434uUffTp5fkNq//+6BgIG1Jqjo8T2tQq4=;
        b=VJ47L9t1yx+rKVGVl95GchEu2pWSOcvTT9CMTZtv/gm58YAHiCbaKg/Gd2+uGtdMFu
         TGno10fJNm2x+M/y+fYDesF9MiXxKVu5aCRKzhpovc34I0JuZLwx4sy2tivr8BX7G6tl
         IhW/BTCUCBBMXxf6rbish4mdygtIhuRZpxKkK7cIjHeVx7GpnLwp+xmNWeasLU311Q8f
         eUy9drdFAMrxa0pEhG7WtCVktFt8HlPrWfMHu0nNjfVCQhogM2jaykRs3vaHfLGPear7
         G/NENH4e7Y5rKwaXQP/E3dE5iN6pMtzloARtcOp8sGCD7zrnEVDCcHzbbuep0dO2zk0O
         Zung==
X-Gm-Message-State: AOAM530khZ7K63X0nevFrJRdfFi6Rh70G9Ua/nFlFegMDhmQdwWDAW+X
        jXw0dLvBi7Lz8G2PKKvgsxA=
X-Google-Smtp-Source: ABdhPJySSMcW9Cf36RqzFKxgy2nAY+ds7Cn6Au7dGczI6ytJbTCgPr59yAnHTD3DkEgvGCHe3pFq1w==
X-Received: by 2002:a05:6512:3341:b0:44a:eb29:c59c with SMTP id y1-20020a056512334100b0044aeb29c59cmr1056155lfd.596.1652911908406;
        Wed, 18 May 2022 15:11:48 -0700 (PDT)
Received: from localhost.localdomain ([46.235.67.4])
        by smtp.gmail.com with ESMTPSA id v21-20020a197415000000b004742009e038sm67500lfe.126.2022.05.18.15.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 15:11:47 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        dan.carpenter@oracle.com, fmdefrancesco@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH 0/4] staging: r8188eu: add error handling of usb read errors
Date:   Thu, 19 May 2022 01:11:43 +0300
Message-Id: <cover.1652911343.git.paskripkin@gmail.com>
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

Series is based on top of staging-testing branch

Pavel Skripkin (4):
  staging: r8188eu: add error handling of rtw_read8
  staging: r8188eu: add error handling of rtw_read16
  staging: r8188eu: add error handling of rtw_read32
  MAINTAINERS: add myself as r8188eu reviewer

 MAINTAINERS                                   |   1 +
 drivers/staging/r8188eu/core/rtw_cmd.c        |  15 +-
 drivers/staging/r8188eu/core/rtw_efuse.c      |  32 ++-
 drivers/staging/r8188eu/core/rtw_fw.c         |  62 ++++-
 drivers/staging/r8188eu/core/rtw_led.c        |  20 +-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  62 ++++-
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    |   9 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c  |  20 +-
 .../r8188eu/hal/Hal8188ERateAdaptive.c        |  21 +-
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |  20 +-
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |   9 +-
 drivers/staging/r8188eu/hal/hal_com.c         |  24 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  37 ++-
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     |   6 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 117 +++++++--
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  30 ++-
 drivers/staging/r8188eu/hal/usb_halinit.c     | 239 +++++++++++++++---
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  33 ++-
 drivers/staging/r8188eu/include/rtw_io.h      |   6 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  61 ++++-
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  19 +-
 21 files changed, 681 insertions(+), 162 deletions(-)

-- 
2.36.1

