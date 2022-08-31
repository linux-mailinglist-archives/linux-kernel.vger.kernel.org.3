Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E2C5A87A0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiHaUkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiHaUkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:40:31 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0946844EE;
        Wed, 31 Aug 2022 13:40:28 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q7so21563722lfu.5;
        Wed, 31 Aug 2022 13:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=6r7qNJQ9qhEl++Kww/F8hltPupbf7ISSLDOC2iciXcw=;
        b=ezCb/Lqr8CabV5aQeawj6AuanSM1hkM/RPKw9RIKeJEKHBJtK5BxlVy2sZJDnNTTBS
         wDViDDZEZX1E70OeL2HJ7xhSr1r9cj5AaWH228Di0f7sEgrVScxjrRIPTGZ6YjWmvT0y
         bfhZA7CFgfufWKms0ORjgP+BkII3DzQCJ6ah6VJoPwL9tZFZ30iN+5ae+1LUosNZgvFx
         VIJGCxvazX/4YrOJd6vpZJJtLtsWifVFUR5fIR+Vinti3S2X8sxrHVFiGKZDMLsC7jUS
         gPF0Psiyr18UW2AUYGxP4CZt1MhtEiQiioylO14Zs3PuJDmoQNwAzxXM8e8jf0WbTFn4
         jN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=6r7qNJQ9qhEl++Kww/F8hltPupbf7ISSLDOC2iciXcw=;
        b=pNRoVBhxcyPvutNDTBNdPnStrRNHsP48ytGX80wKvKyr60dfNA8Z5RzuoPlNMEtpvx
         Ps3V/0EK3E8PWiL//TZ7R7k9ve/kXktHjWmiysxVMQY7aL1jyZSZ2XIAH0/RDyffhQto
         6UQPxdVpmZzssybIX59GZLgcyAURVTkJfTYIUMTi6oeE6UTXr56XBpRrGKKnWtk9sDdc
         PNZB0HKAIX6N+C+BzczVN+COOSCR08W8WvpbZmp0bJZ+x+7r/mTDR1jiHWQ3SBRcTdB7
         IVatzDozGUHnf1oX8sCwWf8uriCxXBvvQcov1YgVdnlfJP2AmLiFWI1PleO7pxxiqFOL
         gxdg==
X-Gm-Message-State: ACgBeo3zMyYmnlivw0roLOYXQtsOe4+mvoOP5t4i8p3Qp+WKMt5huHoH
        nZM5/oVNJc3EU27aiSEn7pT0QqqHSZC/+g==
X-Google-Smtp-Source: AA6agR6oonOsgUC++bzNhhDhebFY1lavC6Y0gvQCkfsPEzbfHSRQSGSLieabrd4fvAh0tpi1Z6uKmw==
X-Received: by 2002:ac2:5d6e:0:b0:494:99aa:6548 with SMTP id h14-20020ac25d6e000000b0049499aa6548mr240660lft.508.1661978427095;
        Wed, 31 Aug 2022 13:40:27 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id w18-20020a05651234d200b0048acfdc8b70sm198431lfr.184.2022.08.31.13.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:40:25 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Brian Masney <bmasney@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: qcom_defconfig: Enable MSM8226 pinctrl driver
Date:   Wed, 31 Aug 2022 23:30:33 +0300
Message-Id: <20220831203033.250237-1-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This config is required for QCOM APQ8026/MSM8226 based devices.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 8a59441701a8..91572f6d0a89 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -131,6 +131,7 @@ CONFIG_PINCTRL_APQ8064=y
 CONFIG_PINCTRL_APQ8084=y
 CONFIG_PINCTRL_IPQ4019=y
 CONFIG_PINCTRL_IPQ8064=y
+CONFIG_PINCTRL_MSM8226=y
 CONFIG_PINCTRL_MSM8660=y
 CONFIG_PINCTRL_MSM8960=y
 CONFIG_PINCTRL_MDM9615=y
-- 
2.34.1

