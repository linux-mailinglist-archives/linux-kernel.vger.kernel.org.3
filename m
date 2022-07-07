Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9396D569BAA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiGGHbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbiGGHbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:31:09 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6823B31235;
        Thu,  7 Jul 2022 00:31:08 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 145so16952208pga.12;
        Thu, 07 Jul 2022 00:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=05adq9e2iMCT+akFGqC1jijiEVT2oaWGy/uJ53ipCKA=;
        b=KV53tV/98wkSolJXfUehSfTQuITfMrpPzM167JsrIh2+CGqgIlvjkJhfbO5doHx8Sg
         zwH9AIH/KDkay0vEnoML/BK6AsQgGSi2TkYhNamO1zNmI1W3H6TFLUphIw0Ub3HyZ6S4
         eU78MyHmDj/ZIFFdPJM6Omt389tajXE2+raSiQRBqAZcF0I2XXIjZ6AApEEP9LGlvpvu
         5hqrFjTaGL82z2tKhQG8HrEhCYHNTMHYVYvdsyDzLWpYj8DFTCHC+348eXA6LWi4ZYR5
         dpEXd5nToj1JsJWH3yeFGONhGWplfLu3LVMtoLRJsh1rgVJketY3zXI2bkDq6hfcCMpi
         0/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=05adq9e2iMCT+akFGqC1jijiEVT2oaWGy/uJ53ipCKA=;
        b=NJTt8LxT0Yg7XIdEZ7Dj13ehLJPkx920VPtQi05BQ6KadjLIK/K7XbmI+YwiwAII20
         kDnAkcOhaFDqc9Ibc5uZphT7pE+cIbc01+fcqcph6NDZZxZytyA/6cC5fEWsDkJdpxqw
         VaXbdfkwMHSywIOFk2RUB/PhFOEiUeXischq0Ap25Z5+gi5+t9xSszEcE1IcLbD+oryx
         tzh2Quze391INtu6r/dyGl3Hxwp8YeXlfcQy6z1P+NAep6waMmCUDXfUl3KWezeuYdFH
         wnAf09y651xaIAARIfwdtR/CjLPWhlfnNh+st2NqwDSWUfaaPHdFCHpdjNskUovamj4G
         1KvA==
X-Gm-Message-State: AJIora/fncFvM5RRrHqQ/r7Frr3Do9FfNVDu/HzHU+/SlF57RSKPCbpW
        bIstbFcXlRj/GDibLzoZU/Q=
X-Google-Smtp-Source: AGRyM1sCeA4QOM2dMj/QF5wCKZJBH0qADixd73Ldb2BT2BoYNhGsbOitMHVKaDElj/evCtcFantZbg==
X-Received: by 2002:a05:6a00:15c1:b0:525:2db4:2a2c with SMTP id o1-20020a056a0015c100b005252db42a2cmr49723557pfu.30.1657179067746;
        Thu, 07 Jul 2022 00:31:07 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s1-20020aa78bc1000000b00528c70c34c2sm928481pfd.115.2022.07.07.00.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 00:31:07 -0700 (PDT)
From:   Mia Lin <mimi05633@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        ctcchien@nuvoton.com, mimi05633@gmail.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, KFTING@nuvoton.com, JJLIU0@nuvoton.com,
        mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] ARM: dts: nuvoton: Add nuvoton RTC3018Y node
Date:   Thu,  7 Jul 2022 15:30:53 +0800
Message-Id: <20220707073054.3954-3-mimi05633@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220707073054.3954-1-mimi05633@gmail.com>
References: <20220707073054.3954-1-mimi05633@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nuvoton real time clock RTC3018Y in I2C node

Signed-off-by: Mia Lin <mimi05633@gmail.com>
---
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
index 3dad32834e5e..589aadb67688 100644
--- a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
@@ -202,6 +202,10 @@
 		reg = <0x48>;
 		status = "okay";
 	};
+	rtc0: rtc@6f {
+		compatible = "nuvoton,nct3018y";
+		reg = <0x6f>;
+	};
 };
 
 /* lm75 on EB */
-- 
2.17.1

