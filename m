Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7952647AA77
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhLTNko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhLTNkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:40:43 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6F6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 05:40:42 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so5202613wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 05:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lOKHr4M8GH4POVA6wGDp/sQJEDhJB1D5YusNPIcTnV8=;
        b=TRdshk0Ls9G3yxCdXzlyAYBiAIwi/glzUAHy1zkBYWOTGG47hOWM6R9g1/cO8RdrWa
         8b447PoK+3ObAZ2tIFsSmAnDdY9kkCG79AvTOmE/XQX28g87k7xtJpcSsJj8fjVRIq9e
         2WmGvMYbawhHWS6VA9j2hlsaOWo8SAMYcRLnZCzpvWjYMEvs8DnEZ7L4rfNVMXH2K3sl
         uxu/0ZVHz4C46hmlXU9KP2ywWksP2TLy6R2KeaaJ8VQqIqOaIux5Jo1zzB8+viSOrRty
         E/O81psfbUH+IpeLEMQBp4rHXT0r/l+jaxY/O49HEzlZY+RuWOHf1tofNGAFj14GKa0z
         9DoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lOKHr4M8GH4POVA6wGDp/sQJEDhJB1D5YusNPIcTnV8=;
        b=D45hOgPFjVEMIBXWNn/zXR6JvsAgdBP1/C3Hmacsl/t/e1CZQDch8AKdQCS2Qq9/cT
         w00GSwtoSls0l6os2/iv8hXSDjKnKRyBdOmcdC4KxAMofYWcBnj/phOXENOwaRieVmX6
         YViGs5dFBBknLPL2/pOhMup2+HLtG5cVGC2D0j3jeMJGy0zHN9QL0MvZx25RJlrJ2lGI
         ly7/96gXl+0ubLLHkLWm8Qrlo9Pw+/IDrmj3skZMRLyf+j3S6Pcs5O9NTqlu7k0fQUnK
         dbpE7HBstrBx0Fp79FLiMtf9lXTghY0pN7qhIIUSD1FyECABC/JdSzqkCPruX+T6U/yJ
         yd4w==
X-Gm-Message-State: AOAM532kDXNFm1Q0fh9ygsNrm4Ui+BxhM7Ag+8Ci1wvTkU9b/+H/grYE
        +F41pjee7x+uTWrWBdgRra0UWYDAv+m67A==
X-Google-Smtp-Source: ABdhPJxSixlSyXgyg5g6e+BZWTVcP9HEpU2UqeXtQzwQ1r5GbXolyNkJHBhLSN6pz/LJ6C/nT7pM5w==
X-Received: by 2002:a05:600c:1987:: with SMTP id t7mr13976740wmq.24.1640007641300;
        Mon, 20 Dec 2021 05:40:41 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id m6sm19327640wrp.34.2021.12.20.05.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 05:40:40 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: dts: Fix some I2C unit addresses
Date:   Mon, 20 Dec 2021 14:40:36 +0100
Message-Id: <20211220134036.683309-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The unit-address for the Maxim MAX1237 ADCs on XPedite5200 boards don't
match the value in the "reg" property and cause a DTC warning.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/powerpc/boot/dts/xpedite5200.dts      | 2 +-
 arch/powerpc/boot/dts/xpedite5200_xmon.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/xpedite5200.dts b/arch/powerpc/boot/dts/xpedite5200.dts
index 840ea84bbb59..74b346f2d43c 100644
--- a/arch/powerpc/boot/dts/xpedite5200.dts
+++ b/arch/powerpc/boot/dts/xpedite5200.dts
@@ -132,7 +132,7 @@ rtc@68 {
 				reg = <0x68>;
 			};
 
-			dtt@48 {
+			dtt@34 {
 				compatible = "maxim,max1237";
 				reg = <0x34>;
 			};
diff --git a/arch/powerpc/boot/dts/xpedite5200_xmon.dts b/arch/powerpc/boot/dts/xpedite5200_xmon.dts
index 449fc1b5dc23..d491c7a8f979 100644
--- a/arch/powerpc/boot/dts/xpedite5200_xmon.dts
+++ b/arch/powerpc/boot/dts/xpedite5200_xmon.dts
@@ -136,7 +136,7 @@ rtc@68 {
 				reg = <0x68>;
 			};
 
-			dtt@48 {
+			dtt@34 {
 				compatible = "maxim,max1237";
 				reg = <0x34>;
 			};
-- 
2.34.1

