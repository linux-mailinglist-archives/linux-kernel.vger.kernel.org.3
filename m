Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CF55777B2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 20:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbiGQSKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 14:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiGQSKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 14:10:21 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFB513EBB;
        Sun, 17 Jul 2022 11:10:20 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id o2so3592389ill.6;
        Sun, 17 Jul 2022 11:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wtwfkquDg1r5vx4gIVS0dR2M8BGP6VTaWqG2dB/VTZc=;
        b=gQbk/Rb3nWBPcigsxdVmVjnJ83Ov5Wrglac4iNyPJgruDFJooC4XZEAp1yWQ4yF0Hk
         Q8ckG8BVKgsBo5qNxS81ar4R2LQN6eneRAdjxnR5VZjE+F6UWISTCVp+xKMFmV55ujlz
         fST5cIUK5p41c22jNYgS8+/eUIfGc+2MKiDg3f+/DG5FCOPOWl5NuGJvIhZT4HEMYreo
         93b+S3Xc3+TcfCnqPcnhiQZQrNRegMiMy2cypnasOnjrWhy+aJs2Lj2cJkaYznvWo5hp
         eJnhXzS+5ERU4Quqk09TBgpLT/IoB3Dm8weLmCheiYBju6WhyBS8TAGXQ2gr4CGzaoM+
         l9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wtwfkquDg1r5vx4gIVS0dR2M8BGP6VTaWqG2dB/VTZc=;
        b=W4edrC46in8aMs1//51tCjQ6FmCosBQi1PPtwbkYzJEzEWG66d0YfCSRT2KVvl2WoY
         r3gtVZNva4wp8bqzB16jVC9HulW0taTEmNqXqZS4PxfTIkWq0qyyB0+UUwz6i9HtGgtz
         aLmh693e4DgX82zowyoSanYD8E4v5E9BDrxuLORWg2LrlDbB2BC4D/gslBaW5MLhKNiv
         KaKZXSw9W7lbhUItC4ddLNohgCwFe/qZbgfCIOjrB+2HdwnHv3kjumt9TPJbqc6BbUKh
         3jKkU3ePsLDfCs9W6qllQm1vvosD+hrFYgXpQ7hS6Z7Dsv2ps3JqGrQulYMnsq0J7MLr
         COoQ==
X-Gm-Message-State: AJIora+5jmoJLWLnngqJp1yIpynRbwXDD6ftz1w2wdi3M6UHObd8tep8
        sPbFfGnzXgwgTw7Jn9rAV8c=
X-Google-Smtp-Source: AGRyM1vYz9kkcXloxtJU7uAFnxYuVk8zW796PbIZvMMCgcK8ABNLLO7mmOIQKDGb1y6et13z1a+b8Q==
X-Received: by 2002:a92:b106:0:b0:2dc:eebb:e6f6 with SMTP id t6-20020a92b106000000b002dceebbe6f6mr372194ilh.54.1658081419590;
        Sun, 17 Jul 2022 11:10:19 -0700 (PDT)
Received: from AIO.lan ([2601:448:8400:9e8:8e1b:7df0:7e10:ddb0])
        by smtp.gmail.com with ESMTPSA id f4-20020a056e0204c400b002dc1ea52967sm3869136ils.34.2022.07.17.11.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 11:10:19 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] arm64: dts: Associate easrc to the audio CODEC
Date:   Sun, 17 Jul 2022 13:09:57 -0500
Message-Id: <20220717181000.1186373-4-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220717181000.1186373-1-aford173@gmail.com>
References: <20220717181000.1186373-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a wm8962 Audio codec already enabled, and the
EASRC is also enabled, but there is nothing connecting them to each
other. Set audio-asrc to point to easrc.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
index 224845d24b64..f31ba1101a1d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
@@ -67,6 +67,7 @@ sound-codec {
 		compatible = "fsl,imx-audio-wm8962";
 		model = "wm8962-audio";
 		audio-cpu = <&sai3>;
+		audio-asrc = <&easrc>;
 		audio-codec = <&wm8962>;
 		audio-routing =
 			"Headphone Jack", "HPOUTL",
-- 
2.34.1

