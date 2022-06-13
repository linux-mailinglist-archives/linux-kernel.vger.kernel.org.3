Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182985483FE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbiFMJyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241097AbiFMJyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:54:04 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1348418B3F;
        Mon, 13 Jun 2022 02:54:03 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u18so4677787plb.3;
        Mon, 13 Jun 2022 02:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YNhd/FL425kRzxrVXJkEkRoau5KOg53TFkVnNDFPTbE=;
        b=Z7e+Rur4inXUcXgthnaZ2pFOzXXfJ4X9KNFxNHhLbA5Qgu72efS6R7e+aLk46rVlvU
         LzIIcs0bLiuAz75WUXtqcngkZtE35Yi+nB3KDs/BczEiMc0P2S1XEFu8LxmXJa4QH/DX
         i/yv0BZL9zlbn+i0dsx/u9YGmKY0I75MmH2TWYrbU4VdlxWIbpuWfQghvNTe3SYgD217
         eCOQ+F+7nfqe5tDizUYOyZVEdNBeT75E6/TpI/XSKM3m+TG/11YpBoxmNonTeXmgRTzx
         +KcySB4bijDlaHEBcS+qRXOrxsArCUoW9dvnRtJV3SVJ5YiiNqIYfD7Fz+6hPHDnP8DA
         JKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YNhd/FL425kRzxrVXJkEkRoau5KOg53TFkVnNDFPTbE=;
        b=IAvy+CLyyx903ut3alyGUrbSpM9pw1GWtMzZURMVT1Tz02aE4P+WeS2NMjeekLTewH
         6fEBQLbOeeF68pa2jeDyjFQPubqGb7f1SOxBzPQfH9zkBVcCN43bxd8llquKqiLMxNF3
         WDEb2UyyxmpbpwBQ6GNuedRUQZtbZWOVhtEz/mFzo5uJKM/Vq35/52z7Dh9n0V7WIc8X
         mNYlN2td3iA+SxWNNCE5WTESKgfyTZ1aMs7Ho7JbVcUp2MaY5sDLHiV/+6csXDmWV4QZ
         6bfgU3fJOggZhdHCqvcU5FUeoPRtO5aiSNxZ+4tIG33PdAqodEqkHWWw1MCyrVJVYCwq
         gEsw==
X-Gm-Message-State: AOAM5304DKgUyYsQzVUdrQxWBunwXsQEybJqO1EuOuaXHyx+3xPvIeli
        YDxzAs83D8CcB+ewJ0eahFY=
X-Google-Smtp-Source: ABdhPJznuSGMGqWN1zmUDGm+Kr7nnDXOF2Q4rVuh1OdEp2S2Y4/rSDjXL8ek0riyUPHc6euHt2GqeQ==
X-Received: by 2002:a17:902:d481:b0:167:770b:67c with SMTP id c1-20020a170902d48100b00167770b067cmr40584528plg.77.1655114042596;
        Mon, 13 Jun 2022 02:54:02 -0700 (PDT)
Received: from potin-quanta.dhcpserver.local (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902e9d300b001639f038250sm4639754plk.220.2022.06.13.02.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 02:54:02 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 2/4] ARM: dts: aspeed: bletchley: disable GPIOV2 pull-down
Date:   Mon, 13 Jun 2022 17:51:48 +0800
Message-Id: <20220613095150.21917-3-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613095150.21917-1-potin.lai.pt@gmail.com>
References: <20220613095150.21917-1-potin.lai.pt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The external pull-up cannot drive GPIOV2, so disable GPIOV2 internal
pull-down resistor by the request form HW team.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index d34bfa50620e..ee33cc3efae4 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -860,6 +860,9 @@
 };
 
 &gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpiov2_unbiased_default>;
+
 	gpio-line-names =
 	/*A0-A7*/	"","","","","","","","",
 	/*B0-B7*/	"FUSB302_SLED1_INT_N","FUSB302_SLED2_INT_N",
@@ -950,3 +953,10 @@
 &ehci0 {
 	status = "okay";
 };
+
+&pinctrl {
+	pinctrl_gpiov2_unbiased_default: gpiov2 {
+		pins = "AD14";
+		bias-disable;
+	};
+};
-- 
2.17.1

