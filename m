Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8F14D39D9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbiCITRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbiCITQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:16:37 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2E5111DD0;
        Wed,  9 Mar 2022 11:15:36 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id r65so1959617wma.2;
        Wed, 09 Mar 2022 11:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xSQ2yhNDi95jlyBXKH2xZQZRaUq6VTuSLNcrSv00FfA=;
        b=gMpSAaf3upVy7urydsBI7KTY9clFAUEKHMkO+RSCE/wRDAWxRspV69F83+h593JPjQ
         z1frbqEU8Vkk1j6RibPw/WiO+EljXrIM5MfamYXmRhOQfvG5+vm+oOt1yNb4/AXpX5h0
         SvAySmCphPmmsHK7S5DgBM7XlYnMC/gqa8FuExlfH4VQ2Qhqh64lQniD2Wc1KSYe42vf
         b6Ai67FgPfRCJw8uEQrm9ViUWv4Fao1FpbfEzuHmZzWU8VzCft77RrknVYOQ1wOYObTo
         JRUFauIHZGZizga0SHHPYfyETH7MRe6RiFc8dhD0E0wF8NMXL6fuAKDw1XqFISi2A75h
         RCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xSQ2yhNDi95jlyBXKH2xZQZRaUq6VTuSLNcrSv00FfA=;
        b=HF573qcA3r5OwnIXIfcNzIWK1zExwJzQv2SGxt7MyKIdUYx/6/VUWD5Fs512UzBDOP
         zV3hVfjkq5Gd5D+HQCCJ+CKpZTqSBYxX5ihm1pv+SbRBbTfFzGAy7D6MQDuUzbxNvhZZ
         zonRWjL2vT5bvBGzUicB/ioQmuHLkU4lKzicxZ5tWt3SpSvJGN9BzOWVsFhFlNgPyHfF
         touZ+oIUz/IbFDPArxv6HTPnYoKr38ev3ZCLQyWaPIC9mxwo3pmGRFniIRXInxxsS1IB
         FsbUacncnxBQra/YESB+ZYyKEIWY6UN+cT2mUqUZ44tc7bUCRzl5nEZCvATfRnnwJIsS
         CFCQ==
X-Gm-Message-State: AOAM5306BWsza7JJPZ9k0Ux+pWbRK6STkIxTpWmDGg2PDBiLNgbrXeyI
        lcZwCi+ToLwwTlr3dZShSXw=
X-Google-Smtp-Source: ABdhPJxHBaTboBS3HQV0v9ypyuSzuHKdivriCsVrP56AU4fZFf/wY/DB3vKfk3joObxzGtxTRXXGHw==
X-Received: by 2002:a7b:c8d7:0:b0:389:c84c:55be with SMTP id f23-20020a7bc8d7000000b00389c84c55bemr7028198wml.135.1646853334841;
        Wed, 09 Mar 2022 11:15:34 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-79-47-249-147.retail.telecomitalia.it. [79.47.249.147])
        by smtp.googlemail.com with ESMTPSA id w6-20020a5d6806000000b002036515dda7sm2396699wru.33.2022.03.09.11.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:15:34 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v3 14/18] ARM: dts: qcom: add speedbin efuse nvmem binding
Date:   Wed,  9 Mar 2022 20:01:48 +0100
Message-Id: <20220309190152.7998-15-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309190152.7998-1-ansuelsmth@gmail.com>
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
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
Tested-by: Jonathan McDowell <noodles@earth.li>
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

