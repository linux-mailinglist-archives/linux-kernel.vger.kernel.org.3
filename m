Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C345777B8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 20:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbiGQSKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 14:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiGQSK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 14:10:26 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF1B13F48;
        Sun, 17 Jul 2022 11:10:25 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id r4so851175ilb.10;
        Sun, 17 Jul 2022 11:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4anNrS+LFYxOaQ+dCh0pkcVaONbH2FluAqjsIfQnn04=;
        b=Y7xVPb/0ALshBut6fU+YLkpBoCSyRlpduC09iIAtNp542FLG8hGdzScI4AtsFjs1l3
         jx+KAd5h70NsRVUcGdu1hEGFrebz0dNHBj/EA38X9zftKTz1txfNH3+/aA5W20rGnoNI
         VFJVer7KTsFd3LMHwNxdwZhFdzQxp21mcg0fxdOSR8YQBXmi/6BeUtAf50ineHgoKoVl
         aCX/HkF5MLJgqEc0uMRVeKon8k//PtEhxRMoXKm3b7nA+dHww0bMsZIIiT+RmZTSadc8
         +SDwXZ73esyPLkLi6wkMKm4pw87L34ZOrVXPD2zI2rgb+AWroHipqtMActFXSaWyrJ2n
         Ogdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4anNrS+LFYxOaQ+dCh0pkcVaONbH2FluAqjsIfQnn04=;
        b=oKVn178xJkBYbMISlWs6MDTV93gYB30Fv+X4Tb9gyJRMF1xOKUeiA57yGEET/RjFKY
         /N/HY5stUEBv2PGo923CkAebOEBOjc0lBIytaoWTn+BGqyjRkmbauwrq59Zz7N4Kv9/Q
         eaTDz6MXh3yV40Wbte+wa7PyI35cmRUVFevdjK93jgBlhvzP1GnMQeGv71qHssfvLJVt
         WgaW3kGZW3nxbGqQtdt1e9hSMDfnIFRa2QynBaHfk+PiMMYnJASDXWNCTlsN0yxSAiwZ
         ydzM+4dbqlO9FFrj2e1zOfmvY3K7hhYf8LKkIUznGymyJqw7YblOLvrnVWzWPR/LDDQN
         DpXA==
X-Gm-Message-State: AJIora+OOuLWYmbYDn5Vt++1gLSwh38FqcgDiY269nlK71sDBImHATJi
        5EjfefGuLZ5xOcbFAzFfGavFv/6G8Gw=
X-Google-Smtp-Source: AGRyM1s3f5gCi8OEjCiAiuBUAWILV01AE0BM7ZDfQs4dxVGFw/UMmpoMEEpkPP1Vy0QH25DOTOVDqQ==
X-Received: by 2002:a05:6e02:17c6:b0:2dc:1d37:5133 with SMTP id z6-20020a056e0217c600b002dc1d375133mr12575949ilu.297.1658081424761;
        Sun, 17 Jul 2022 11:10:24 -0700 (PDT)
Received: from AIO.lan ([2601:448:8400:9e8:8e1b:7df0:7e10:ddb0])
        by smtp.gmail.com with ESMTPSA id f4-20020a056e0204c400b002dc1ea52967sm3869136ils.34.2022.07.17.11.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 11:10:24 -0700 (PDT)
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
Subject: [PATCH 6/6] arm64: defconfig: Enable imx-audio-card
Date:   Sun, 17 Jul 2022 13:10:00 -0500
Message-Id: <20220717181000.1186373-7-aford173@gmail.com>
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

Both the imx8mm-beacon and imx8mn-beacon kits have a PDM microphone
port. The PDM is used with micfil driver, and that is associated to
imx-audio-card, but that is not currently enabled by default.  Enable it
as a module.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d3ad1cb2f5eb..2a824590811b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -792,6 +792,7 @@ CONFIG_SND_SOC_IMX_SGTL5000=m
 CONFIG_SND_SOC_IMX_SPDIF=m
 CONFIG_SND_SOC_FSL_ASOC_CARD=m
 CONFIG_SND_SOC_IMX_AUDMIX=m
+CONFIG_SND_SOC_IMX_CARD=m
 CONFIG_SND_MESON_AXG_SOUND_CARD=m
 CONFIG_SND_MESON_GX_SOUND_CARD=m
 CONFIG_SND_SOC_QCOM=m
-- 
2.34.1

