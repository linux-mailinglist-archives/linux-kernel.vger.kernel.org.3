Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5184BAE87
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiBRAbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:31:11 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiBRAa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:30:59 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E601F6EF09;
        Thu, 17 Feb 2022 16:30:38 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n8so4164904wms.3;
        Thu, 17 Feb 2022 16:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kai4mO4cn4KI+lgyIwdOV2Qv4GKeCuW030s+6PxSDI0=;
        b=TElzVa/ZubwdPudTtIwHc6IG4r/KNEbRRDqhjbbXb7/kvlf9yaVhelor30LZ51+/Ko
         8wXqGAxOhPmloNiQF44PPOPtyDqhvzQgS2a5IfWjga4PUerDecxI70KMp1tISpajBISO
         UUz6RaTCDCARBgumvG0CpLTcGj6k/KAVFd3sK8DERDSeJWvtyChNmOR4q0+LyZSivZj3
         qyp3/QVSQwbSVJs/37/Ez4AkLDgPLjOSLNGclEutYAkfYdq+HGTGutGLqF4zV2HfYc3m
         VmnOgG04wfYR7KwTIyGKLsX/f8KwAB7WZEnxrgFjSjs9Q6i0kxa2wo9q7WliA1suxRBO
         AggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kai4mO4cn4KI+lgyIwdOV2Qv4GKeCuW030s+6PxSDI0=;
        b=SyflEwj7EaUR53Eod3LtmQ1w58mawREqjnnto6paZY3vFirTOtEmEqo72JhtvYbrGP
         w9JnZeL9ndxW1Rk9QxDqtGiq4f63U9nPxdc3m2R3770yqeKCq7od2xDhYfkHGJjVc5n6
         V3xZs4id3cFXBtBZNQwkqmBw6nVhTOInVmoR74Lze3NN3Y+OhFLzLhkMXVRTCK8BnBUB
         YMxJGvZhi5Gj8iD3Ap8SlxYdVSXUuNsiXG/cWMbdDBwDNsKWqButzBkykeP9/5LXsGIk
         GLTKJqvEQAPDkw7F9E3gsLiCbqRP7/7F0/ZH68R7nDxzAAiPshUziAhzOzrw+td8/Yqt
         Z80A==
X-Gm-Message-State: AOAM530+zDortzcglRcr958jRSAIoA5c3kE9/s7OEKddUOOk3l/bJtLG
        sIvHb7r3YqDrgUf4WA6hyPyOcGf8eps=
X-Google-Smtp-Source: ABdhPJyJ75DFYwlDkoleOzvSxzqgmeHPVxBTEUM2sz/lF9Gw0F/TbBckvFudw2j9J6+DQwMAwKMJfQ==
X-Received: by 2002:a05:600c:4e12:b0:37b:ebf6:3d17 with SMTP id b18-20020a05600c4e1200b0037bebf63d17mr4782465wmq.44.1645144208920;
        Thu, 17 Feb 2022 16:30:08 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d29sm3640406wra.63.2022.02.17.16.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:30:08 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 14/18] ARM: dts: qcom: add speedbin efuse nvmem binding
Date:   Fri, 18 Feb 2022 01:29:52 +0100
Message-Id: <20220218002956.6590-15-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218002956.6590-1-ansuelsmth@gmail.com>
References: <20220218002956.6590-1-ansuelsmth@gmail.com>
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

Add speedbin efuse nvmem binding needed for the opp table for the CPU
freqs.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index a1079583def9..629e22236f5b 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -981,6 +981,9 @@ tsens_calib: calib@400 {
 			tsens_calib_backup: calib_backup@410 {
 				reg = <0x410 0xb>;
 			};
+			speedbin_efuse: speedbin@0c0 {
+				reg = <0x0c0 0x4>;
+			};
 		};
 
 		gcc: clock-controller@900000 {
-- 
2.34.1

