Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435974B00FF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbiBIXLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:11:37 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbiBIXL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:11:26 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D255C1038D3;
        Wed,  9 Feb 2022 15:11:28 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id u18so8016918edt.6;
        Wed, 09 Feb 2022 15:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XbH8L4Q6Vj1o9WBb8a2Uehm4Ig7OmB/+4uNvF8Kf+Yg=;
        b=XbizGjekE8x2jEMOJq0Upy9jUGelbiA0rVMbBHS2euzx34r9q7fjc0S/3RR7o+jAgN
         QjV8RDbAKVdebVumYh7IPddZGhfQPSf57vudvQjToZ6H0p+5xLQedVq5DyTh+oG9Bsj7
         FGpFJYwWFt7CEsIiWqZIuMeWORLUD8ULH1725jPHRt8POI+bd0qukYXEWmYp/+Oo9G/K
         pPj2fRE8fVurOu1sX2AhKCVm6C3ZE/Si3JP+1zm3QL7HUBMojTHYOv0uynzGGgIZJ/0C
         XceWeqFpVUsrMt7W7Yer6JfyK0QsFv+ATtZvTqaVD+piWXYVZrz1S14uc86aGdrR1kAb
         hxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XbH8L4Q6Vj1o9WBb8a2Uehm4Ig7OmB/+4uNvF8Kf+Yg=;
        b=uBqfraUo4osHakP9n30Lckqnk363wv1q0xp3rpYvGAUU3EajcN++PP6FbbPUHyeQ+9
         mYlkbaMLVYglYwcdednhiCjuVRJha2mxYsjpEaZ/RifpFJxFtw0FLJgCBpqj8CoYktUw
         CG12v0ZGOJyzs/ZwfTDRWdf3kV7rVaWd2SWYp87i/NolYCWK33XqPT3x/KS9zJgBw0ZA
         uKEEplWZAba6HhCW3LLlpb5AIZ+zv3bbz3WRDu7SQhryC99598CUbK+GYRznjjW8qIuy
         9f++SmBtxwyx8u/HxYY3ieSAR0T2u6ElsVb3TpXtCVw/x6e1Sbob/Q7t8ncYDyx5jehM
         bhWg==
X-Gm-Message-State: AOAM533ByQogyQEqzWftt3u/eznMUZv0sZ9hWB7REyRa92VqoOZsc7+1
        H5YhDdG64YZyzu7PNONUOeo=
X-Google-Smtp-Source: ABdhPJz9TkZEN3ueIO9dN1VAWo7WXTGe/PIPAiVsF2V/IBJhqXStNLVyjN5uKWSMfPH3yNjxtKS3tQ==
X-Received: by 2002:a05:6402:4304:: with SMTP id m4mr5343473edc.67.1644448287284;
        Wed, 09 Feb 2022 15:11:27 -0800 (PST)
Received: from localhost (92.40.202.147.threembb.co.uk. [92.40.202.147])
        by smtp.gmail.com with ESMTPSA id qw28sm5268188ejb.0.2022.02.09.15.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 15:11:26 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, robh+dt@kernel.org
Cc:     linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pwm: jz4740: Add support for X1000 SoC
Date:   Wed,  9 Feb 2022 23:11:42 +0000
Message-Id: <20220209231141.20184-2-aidanmacdonald.0x0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209231141.20184-1-aidanmacdonald.0x0@gmail.com>
References: <20220209231141.20184-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X1000 has the same TCU / PWM hardware as other Ingenic SoCs,
but it has only 5 channels.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 arch/mips/boot/dts/ingenic/x1000.dtsi | 13 +++++++++++++
 drivers/pwm/pwm-jz4740.c              |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
index 8bd27edef216..0dcf37527c8e 100644
--- a/arch/mips/boot/dts/ingenic/x1000.dtsi
+++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
@@ -127,6 +127,19 @@ wdt: watchdog@0 {
 			clocks = <&tcu TCU_CLK_WDT>;
 			clock-names = "wdt";
 		};
+
+		pwm: pwm@40 {
+			compatible = "ingenic,x1000-pwm";
+			reg = <0x40 0x80>;
+
+			#pwm-cells = <3>;
+
+			clocks = <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER1>,
+				 <&tcu TCU_CLK_TIMER2>, <&tcu TCU_CLK_TIMER3>,
+				 <&tcu TCU_CLK_TIMER4>;
+			clock-names = "timer0", "timer1", "timer2",
+				      "timer3", "timer4";
+		};
 	};
 
 	rtc: rtc@10003000 {
diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 23dc1fb770e2..a5fdf97c0d2e 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -256,10 +256,15 @@ static const struct soc_info __maybe_unused jz4725b_soc_info = {
 	.num_pwms = 6,
 };
 
+static const struct soc_info __maybe_unused x1000_soc_info = {
+	.num_pwms = 5,
+};
+
 #ifdef CONFIG_OF
 static const struct of_device_id jz4740_pwm_dt_ids[] = {
 	{ .compatible = "ingenic,jz4740-pwm", .data = &jz4740_soc_info },
 	{ .compatible = "ingenic,jz4725b-pwm", .data = &jz4725b_soc_info },
+	{ .compatible = "ingenic,x1000-pwm", .data = &x1000_soc_info },
 	{},
 };
 MODULE_DEVICE_TABLE(of, jz4740_pwm_dt_ids);
-- 
2.34.1

