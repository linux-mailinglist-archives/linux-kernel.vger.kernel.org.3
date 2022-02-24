Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A61F4C39CD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbiBXXmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiBXXmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:42:10 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B2C17073;
        Thu, 24 Feb 2022 15:41:39 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so708517wmq.3;
        Thu, 24 Feb 2022 15:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QTChzNNqL4uRVDzov86uRnkW7Fd6lCMAisa40B88GGw=;
        b=OC0+6RPn7XcJnvTD2dtq0hOk9xgm78TGpPofdyyTQEYcc4ZzozQK5e9SKRr3Y3SoLB
         AF/3eABSxVGAEA2KkZO9aI5+gkdsDI4fr7A9xD70ZwIZjk3zlkRb6C39Sb0D5oDalQ6H
         rKRKiE+cIG0KYfzK4VdZhUGGxQA2AOXidkjoC0Uv8Wu4gk15qNkdEK+XUZmCwdtJ6fg2
         LmWtS+4lDWtb3La6QmnJ3o/tEs7jice3nHxuFJ1VfOJoETe2FwsPKWRKyuLhAEDMPUXe
         OzhPzaVJ2dSGF1j0acOF/U5b06x5WKdddu+LR7+tMpxW+4Ssg8XlN86RuiFzJC3yQws8
         sOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QTChzNNqL4uRVDzov86uRnkW7Fd6lCMAisa40B88GGw=;
        b=P2kJeuIazFJn7ivEb18S1kcLwcerEgcXCOrp2/H9O5oILi1iUXnC8A4TC5xiw/0ys5
         BjRYRzsaDejrU6gMmdmCFj87Fg5E/4q986jJgo40NepDW/aq3OGWGXLtjdQy/dm9xJBO
         H1azKvhJnrPTjTO1YRjCOm7Ux34lLbhFx2tJbO/VaYGi2Gkf4Wmu8N1N5O7jbNierDbN
         uemjEuFScSuGnuhG/9heCEpD8hdGeonUqYwCw0OUKmo1ny7J9JkC8TIoSYpVBJRzP7nI
         Mb2AZQ98xvufXgJTGCqWXOkVS3JjK75J/cbQLrCw8INYzPfEerYEJ84AMh/nvlPQsp4u
         f3xw==
X-Gm-Message-State: AOAM5336rSSSTF9pPxipzE60aSS6XVsiOvFD6H7Yb899UFTyHCa+7ayQ
        z3AMacopppLOP/6gaEsDOrk=
X-Google-Smtp-Source: ABdhPJwrR1PqavO0VHuT9iXf9a5hWRGVZvMgpzkI2aobHKq3hn3cSJVR2iGfqR1fg14WZTkkidVFVQ==
X-Received: by 2002:a05:600c:4ed0:b0:37b:e983:287b with SMTP id g16-20020a05600c4ed000b0037be983287bmr340240wmq.156.1645746097962;
        Thu, 24 Feb 2022 15:41:37 -0800 (PST)
Received: from localhost (92.40.202.225.threembb.co.uk. [92.40.202.225])
        by smtp.gmail.com with ESMTPSA id a11-20020adffb8b000000b001e4b2617e5asm663422wrr.29.2022.02.24.15.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 15:41:37 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, robh+dt@kernel.org, thierry.reding@gmail.com
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mips: dts: ingenic: x1000: Add PWM device tree node
Date:   Thu, 24 Feb 2022 23:41:34 +0000
Message-Id: <20220224234133.15708-2-aidanmacdonald.0x0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224234133.15708-1-aidanmacdonald.0x0@gmail.com>
References: <20220224234133.15708-1-aidanmacdonald.0x0@gmail.com>
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

Copied from the jz4740 devicetree and trimmed to 5 timers, which
is what the hardware supports.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 arch/mips/boot/dts/ingenic/x1000.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

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
-- 
2.34.1

