Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1A950AAD7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442120AbiDUVju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiDUVjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:39:48 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264424A3FB;
        Thu, 21 Apr 2022 14:36:58 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id q129so7022806oif.4;
        Thu, 21 Apr 2022 14:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUgxKgMIon74FgS8ThsTztXtidaROyVyoTKM0lJdMBY=;
        b=IovDd6Zh7okx91S098LpEDbfV6osBUmc1Ups40tC7h4CV5p3aM5KTusoEj8Ua0RueS
         NfY3lavbNz6esYDw1RY48nAFFogBFVDKzhpjktv/dioK7sZjpqvFd5jhD9nVGl8ns65t
         l4VHCNfb/4yuUBzqTvB8Gt8NNx0pXZBogEZQtUWTDFC7yvFqqTfHwQiadZ1te0+u/6m1
         pj2LhB/Cm5WW/UaeYEKYuHqy6T5XuLtTPPp+0jmiozT2tmmtiEUbcpMzEykbtDWsE3WE
         7a4nL5ZO2FsVkZDEb5nHxCZtM4v6ngZbNKCUEWKwQ6tpg/dsAjx/zXwHbMwuTt/mf3pY
         TRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUgxKgMIon74FgS8ThsTztXtidaROyVyoTKM0lJdMBY=;
        b=kYy2ueEM+FhRFA5hiNrtQd5DJ+I0mv3DyBp9vElJSVo8bKbNbb/XXkLjb8eMD/T/d5
         g6ub5vPKfX2lvgMHF/LLwr0Z/uThfpap4dj01xFBrOYF4WgzqUYm8G2cxzLIopRk29+y
         mIaAhKu8osEzyO9h8IaMC3VxDfj+KHGyFoYJVNLMKE/DzD7tpFqmZK6sgfkQZE0tL6gF
         Cq+cLcPrbdp7Hl8eeT8J/PC8HarH+EqDRZ0+S+588/8WSCluPMaaAht5saRHn9vQzYvt
         fG7kwMd1BURdN/eSeGsIa5CxjeiOZFhyh/y/DVjQWMpw+YTuk5eEIkCX6JY2YYCbkEYB
         xF4A==
X-Gm-Message-State: AOAM5310UYrPvCb7IAzZHx7bIXDxZSIyJGt3tgWcykF4kmQRzwxvvyAB
        /S25vqLo9dbBny3OyyeLzCs=
X-Google-Smtp-Source: ABdhPJwL3mC33NuySTThTtMCGd0apoCnU6B//AN7X5pzrxPCBrNbgGaGZM/UCOe9BiFvtr9noplFiw==
X-Received: by 2002:aca:b505:0:b0:322:a524:8859 with SMTP id e5-20020acab505000000b00322a5248859mr4963479oif.2.1650577017387;
        Thu, 21 Apr 2022 14:36:57 -0700 (PDT)
Received: from fstone04p1.aus.stglabs.ibm.com ([129.41.86.7])
        by smtp.gmail.com with ESMTPSA id s14-20020a0568302a8e00b006054e841915sm51010otu.73.2022.04.21.14.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 14:36:56 -0700 (PDT)
From:   Brandon Wyman <bjwyman@gmail.com>
To:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        Eddie James <eajames@linux.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Brandon Wyman <bjwyman@gmail.com>
Subject: [PATCH] ARM: dts: aspeed: Everest and Rainier: Add power-ffs-sync-history GPIO
Date:   Thu, 21 Apr 2022 21:36:38 +0000
Message-Id: <20220421213638.1151193-1-bjwyman@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IBM Everest and Rainier systems have a GPIO line that goes to the
power supplies. It has a dual function: 1) Fans Full Speed, and 2) Sync
input history.

Signed-off-by: Brandon Wyman <bjwyman@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 2 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index 578f9e2fc7ed..382da7934eaa 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -283,7 +283,7 @@ &gpio0 {
 	/*P0-P7*/	"","","","","led-pcieslot-power","","","",
 	/*Q0-Q7*/	"","","regulator-standby-faulted","","","","","",
 	/*R0-R7*/	"bmc-tpm-reset","power-chassis-control","power-chassis-good","","","I2C_FLASH_MICRO_N","","",
-	/*S0-S7*/	"","","","","","","","",
+	/*S0-S7*/	"","","","","power-ffs-sync-history","","","",
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","","",
 	/*V0-V7*/	"","BMC_3RESTART_ATTEMPT_P","","","","","","",
diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 528b49e2c0f8..7213434695bf 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -265,7 +265,7 @@ &gpio0 {
 	/*Q0-Q7*/	"cfam-reset","","regulator-standby-faulted","","","","","",
 	/*R0-R7*/	"bmc-tpm-reset","power-chassis-control","power-chassis-good","","","","","",
 	/*S0-S7*/	"presence-ps0","presence-ps1","presence-ps2","presence-ps3",
-				"","","","",
+	"power-ffs-sync-history","","","",
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","","",
 	/*V0-V7*/	"","","","","","","","",
-- 
2.25.1

