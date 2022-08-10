Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE7B58E46F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiHJBVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiHJBUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:20:55 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF5F1114D;
        Tue,  9 Aug 2022 18:20:54 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b4so13314956pji.4;
        Tue, 09 Aug 2022 18:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=khqf1k3+MfYNkalxMZpYKoE5do6tLfZ/fJm+K3skWls=;
        b=qJkU4UQ+AFW9nIaysvnQnXgf/SNabIxuyEJTYq7zhTekZHYl5pahldNS9q3QWmL6gz
         r/IuRKu+nE2bY1P/mFE4IRL0rai9vBErmrZMEen++AZkhEMZUEHWfu8vYkxH2j2aR5aO
         JnUlMyVPVX9p2gS2Cy5VuPXxnIy45IYpFphw2BdqZqVFvsP3+t5nAl2aLAAobBqz3buJ
         3a5ubFPVrqVNl/+MgnZhNzOOa0eiTGvpigkW4QxN5Vwg0ZsMkbuwwB52ubxERYorSl/n
         QzMMWTlItehEiFhlXvTPkYHnjkTpQWLLrzcewPp7Bw4PtnKxcbYJA42rEhcI2IXk2GGM
         y0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=khqf1k3+MfYNkalxMZpYKoE5do6tLfZ/fJm+K3skWls=;
        b=PDHgTuaGGBXwVtHtNn9koFzES5wJCgyYSQnVM5m1FiSHrgxCXui2lr+WnhqvBHPA7X
         F3Ye7b4lpcIg0Hnyde9/w6HMWSJIeVUSNShQc3oBkzT+Meu1ckEbV3cvLmxpPKz3EPQu
         ZoV6TURxWntY1sgwsP/PZ9xH1Gx4pZgTJBzypMrReTfSQ9scjLUSKfIuLTEuzh8/z9U1
         KHeyw0kazNr3XtV9y68C7+RFEYGOCUX/G9bOMOIiOdtdbsilSGBdEzOYXVDMxnvYZxyM
         Q3WpeIBILUcSfpXt7G4uJCkBDG/YnpMJz6LlqPBypV/xhUi+zQNqqwZU3RLVylmVtYez
         V2NQ==
X-Gm-Message-State: ACgBeo08C1hYzNKE0NpRsBfHVqK0KegFclYLqebZELMa2rs/3jClr6EC
        AGRF1e7kLZw/QKHup+GSprM=
X-Google-Smtp-Source: AA6agR51LnBaxgTx2WgJTcm+BjiH3Xg6ee3Zo6ptWf7bD0MQA3eWreverFGPZFili+oDVkT6ma17GQ==
X-Received: by 2002:a17:902:a586:b0:170:f3ae:bd06 with SMTP id az6-20020a170902a58600b00170f3aebd06mr5791490plb.104.1660094453559;
        Tue, 09 Aug 2022 18:20:53 -0700 (PDT)
Received: from localhost.localdomain (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id s18-20020a170903215200b0016c3affe60esm11356754ple.46.2022.08.09.18.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 18:20:52 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 1/2] ARM: dts: aspeed: bletchley: add USB debug card IPMB node
Date:   Wed, 10 Aug 2022 00:43:37 +0000
Message-Id: <20220810004338.329832-2-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220810004338.329832-1-potin.lai.pt@gmail.com>
References: <20220810004338.329832-1-potin.lai.pt@gmail.com>
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

Add an IPMB node for USB debug card (13-0010) to support IPMI comnunication

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 9fdb3d17596b9..54c9f182f6a5c 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -7,6 +7,7 @@
 #include <dt-bindings/usb/pd.h>
 #include <dt-bindings/leds/leds-pca955x.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/i2c/i2c.h>
 
 / {
 	model = "Facebook Bletchley BMC";
@@ -946,6 +947,13 @@ &i2c13 {
 	multi-master;
 	aspeed,hw-timeout-ms = <1000>;
 	status = "okay";
+
+	//USB Debug Connector
+	ipmb13@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
 };
 
 &gpio0 {
-- 
2.31.1

