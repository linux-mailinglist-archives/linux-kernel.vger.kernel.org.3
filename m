Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D46047EBEE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 07:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351453AbhLXGFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 01:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245640AbhLXGFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:05:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539D7C061401;
        Thu, 23 Dec 2021 22:05:32 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gj24so6901381pjb.0;
        Thu, 23 Dec 2021 22:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Pgij6bvbOy5I0W9pKQtp9mNH6BcgfIX0vw3kfjJYoYE=;
        b=cOAlMQ/9Q9SOul+vQAF9kNQTFVTW2tTh7fv7V7C659InBAGcdyS5yOZ9W7sdBrbIG3
         KuD+M8sPbO3yfhScppAPW8Y4WfYnPOa1LhQAr90Y0RC1Ul9yAKWJWgIv8Z2MyL6U7aMQ
         b1ltFzPDiNBoFrRuh6ad04EtSyvm1Zpr3/ozhCqZwGXf+7ORsiAcHqSohNHiDnI834qC
         TMqdFfxW2/7Ag6ofVeszWiXarVSZlthR29JuDxv5KDRZuehMIJIyW/Mj4E3K+G5rjcEw
         VdXqRvCax/fJxCd1Fi/jiKvEMnMMMjKOM+oGgWAsckzxtbJT8FBn/zoDFhyayNXOnO9X
         XNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Pgij6bvbOy5I0W9pKQtp9mNH6BcgfIX0vw3kfjJYoYE=;
        b=0tfAbdaI/6m4JesY7gIKf8hjhXLQyhpIQ+phMwVfhygzgMUiDFKTgQfTyE8Hwkyt0J
         rUg2sKBEE8mD0wWKcQ7FdNzVPonTgClmQkCL+fWPy8+uHkhBLcT+9B3dXLWgz2OERavc
         +6v+ZJtdTDpca5sRcdApoReq9FbBfgwnOdgqo48hjLVxz65pE6JoaSNHkfH3g6DXMv54
         NsVsoHEcQzCfN75WqjHW0W7YcCQYvwGqvCqU7cMXIPDTgacrfzuiCNBMyE7DCtYIYjRL
         bPNYOgIeRD73L+wIfBPIbIKgSeTAwE9OacusCrVdasU0cedfAgRrtyie5Om/4jcOsTRP
         JADw==
X-Gm-Message-State: AOAM530tmsc03ICuSu+ucDn+RaW4TK3gCS0IBszObnFl0WUdek4ULYAB
        rHnZvmOYv6MIIjXMtH088s7ALNQ6a2ZOJA==
X-Google-Smtp-Source: ABdhPJz2UWxL8nfb+Vphoy1XFn9Txc4/TbH99YWi75ruxi8wyID2L/hChofBkuK/FEliGBcZX38hMg==
X-Received: by 2002:a17:90a:5d13:: with SMTP id s19mr6594790pji.117.1640325931726;
        Thu, 23 Dec 2021 22:05:31 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id y128sm8234736pfb.24.2021.12.23.22.05.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Dec 2021 22:05:31 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     p.zabel@pengutronix.de, daniel.thompson@linaro.org,
        lee.jones@linaro.org, u.kleine-koenig@pengutronix.de,
        ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lh.kuo@sunplus.com, wells.lu@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v3 0/2] Add SD/SDIO control driver for Sunplus SP7021 SoC       
Date:   Fri, 24 Dec 2021 14:05:37 +0800
Message-Id: <cover.1640325539.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	This is a patch series for SD/SDIO driver for Sunplus SP7021 SoC.										
											
	Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates										
	many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and										
	etc.) into a single chip. It is designed for industrial control.										
											
	Refer to:										
	https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview										
	https://tibbo.com/store/plus1.html	

Li-hao Kuo (2):
  mmc: Add SD/SDIO driver for Sunplus SP7021
  devicetree bindings mmc Add bindings doc for Sunplus SP7021

 .../devicetree/bindings/mmc/sunplus-sd2.yaml       |   73 ++
 MAINTAINERS                                        |    7 +
 drivers/mmc/host/Kconfig                           |   12 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/sunplus_sd2.c                     | 1107 ++++++++++++++++++++
 5 files changed, 1200 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml
 create mode 100644 drivers/mmc/host/sunplus_sd2.c

-- 
2.7.4

