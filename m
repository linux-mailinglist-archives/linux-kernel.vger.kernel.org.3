Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D944654BF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352007AbhLASKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244633AbhLASKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:10:20 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321CEC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 10:06:59 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r138so24392771pgr.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 10:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=F0ZMo0dwIdPkRsr3GBQ6j+qx8/KuZB2bBWo3J0kOkKE=;
        b=G0HqefTxKBbuIn0vUfWU50dJwSnBsFJuTDVAWezwjsANGQ+wEIOfS069+VnpiEy2k5
         3SJ7j7lUH+t/PFgongKyqgvfIX6OVV7PGPykdKS/6wKRlvgjR+MjF/x8UJ3UI7RYaIxj
         HkgeA3rT4VycRgSyNt/jsKSuY/MBmOw8IpEGlAq5p4SOIbIG6pNNV9HPtiVD0z6Xmv8z
         NpVWLYVeCUmOW7HXEjHcnT1kKCTHuXPrGWDl9Zhf2hPQS6OKkfUDN1Hdtn/Rmodnhbd+
         0wuGzmWIQblHuz7Un/blgaV+W5tP0u3yDfXGCl/QH9G7RcZKRe1IAKwM08xp1WLSdbMl
         PH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F0ZMo0dwIdPkRsr3GBQ6j+qx8/KuZB2bBWo3J0kOkKE=;
        b=ynAKV30p7V+HLOnkzd1HH4k92EYWse/XQP337o+F3N21go5GP9T6k478phvRJ8Q/ja
         zD1gKLAyx1onUZINW2cK4d2OuvcraamWF4tBAx7UlFdtzHXcmER8K1dVtW51f0QK/4Ze
         96bzKmp4G4kFvv214VvRRiQ85FD+jrWkEP08tGrEHa3up+/EHqdu0fuD5eEXv4GFKrB8
         qrUYc60ow1AxKB9sZwkW6HkP/utl08Q3SaJ4P/yxxtJ4lDM6UYPDjxvrWuQAnTuBEmfv
         /zH10ooxTpkBO+379FOyy4CRb9eP0hFc3qmVYMC6eAtL6AdVQIdShpuvNrrzfctbkfAJ
         C3Mg==
X-Gm-Message-State: AOAM530uXGOaoTzMxOkcDm+mj+GR46oOA32Js6qeCiH+WT09UmLmzHwo
        dT1fhypYkVpYa2SBbNsVndI2YCOibUuJVg==
X-Google-Smtp-Source: ABdhPJysyRcHb/Oal4MwJqbyJWtlBGgxu/ur+mvTEi8xOkEQ4D1BIatg5R4HnOOTHwQDLbH5aBDC2A==
X-Received: by 2002:aa7:9438:0:b0:4a2:c941:9ac4 with SMTP id y24-20020aa79438000000b004a2c9419ac4mr7518539pfo.12.1638382018553;
        Wed, 01 Dec 2021 10:06:58 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id w142sm462582pfc.115.2021.12.01.10.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:06:57 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 0/3] phy: phy-brcm-usb: Fixes for phy-brcm-usb driver
Date:   Wed,  1 Dec 2021 13:06:50 -0500
Message-Id: <20211201180653.35097-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few fixes for the phy-brcm-usb driver.

Al Cooper (3):
  phy: usb: Leave some clocks running during suspend
  usb: Add "wake on" functionality for newer Synopsis XHCI controllers
  phy: broadcom: Kconfig: Fix PHY_BRCM_USB config option

 drivers/phy/broadcom/Kconfig                  |  3 +-
 .../phy/broadcom/phy-brcm-usb-init-synopsys.c | 46 +++++++++++++++----
 drivers/phy/broadcom/phy-brcm-usb.c           | 38 +++++++++++++++
 3 files changed, 77 insertions(+), 10 deletions(-)


base-commit: f080815fdb3e3cff5a004ca83b3815ac17ef71b1
-- 
2.17.1

