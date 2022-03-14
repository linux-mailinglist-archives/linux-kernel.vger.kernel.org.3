Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195FF4D8933
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243132AbiCNQcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243068AbiCNQbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:31:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2E62CCA3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 09:30:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b19so2546558wrh.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 09:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e/dTVZpcytovUeoSa6wHFl7UXWNee7c+A/oVC25NTBw=;
        b=T5P6P5Vw0Bw5LmWAe9WHyMV6dZ+v6BQwoNaKdGtdW/xxIHkV6gsd6eJuxazQlxtf8N
         9uwF8epOuD6eaVjrldHMAbbuwFoMIqBCE8jEcwUfI6xo4NhAVRAvfxrBTAkpAhemf4I+
         dtTGOiE7KoBUaADz5WA74rxQBFb8y8ezRdjb39hHQIaHrlO7AwrN+iSPW6miR0Sombkj
         XpU1zpTbcziXqJXa9hdGla+5kSWAnUsyBBkaQZIhkSslJ3Pq8jId6giii03STIOf0t5z
         HODZqkMdcpYiOMo9cVA9W5gwZQMxePowbY/Pve8TVjldbqhJp/NLaqvCjO6i48FRZgqG
         HdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/dTVZpcytovUeoSa6wHFl7UXWNee7c+A/oVC25NTBw=;
        b=pmi2khGZKfkBlfHDFR8Wtxy2acP6sXx6BoZlQhTZL4pUacczHn6v2nnNGaGoFzmjuD
         qBj43m8ybRXoCT4I0/92M8QzH82NOS0f4ck8YaNGxV9FEiXm2fygiqszex5Q7VwC847h
         UsfYby24fnJ+2vUed5EquIXkZXaoSMYDhOA7bO+ATOlvjAABZlfwOQrl9VkynmlETGwL
         RTmX7M9WUnmcso7Cg8OOJjSBRngVXBSK7AJn0SOQPGOKLojFYC3Pf/WxHak0X6Y0AJnx
         52NBeuQQNibgRqXdvm/iR+DAOvuOpSBdp0m8dyYWbZMRd8toUNYyZ9gSnGK2KLEnzZof
         NYIw==
X-Gm-Message-State: AOAM532GHCNeZk0dCA+WGJvvytC0FtF6IP8UrCeSrTjezyQBGZOM4ank
        EAgk/oyij/dfkIIYq+IyeJ4=
X-Google-Smtp-Source: ABdhPJwNTOIpKmGOIMFQ8qTfPkPnfzmysvOszCMtCfH7tHiFLKyUSnGdlaLoSdoJnVsoY/p+cvQ/6w==
X-Received: by 2002:adf:fa8c:0:b0:1f0:47ef:a04 with SMTP id h12-20020adffa8c000000b001f047ef0a04mr16904304wrr.398.1647275428099;
        Mon, 14 Mar 2022 09:30:28 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d680a000000b001f1dabec837sm13476817wru.113.2022.03.14.09.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:30:27 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     max.krummenacher@toradex.com
Cc:     Alistair Francis <alistair@alistair23.me>,
        Douglas Anderson <dianders@chromium.org>,
        Fabio Estevam <festevam@gmail.com>,
        Johann Neuhauser <jneuhauser@dh-electronics.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pascal Zimmermann <pzimmermann@dh-electronics.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 14/14] ARM: imx_v6_v7_defconfig: Enable the ADC part of the STMPE MFD
Date:   Mon, 14 Mar 2022 17:29:58 +0100
Message-Id: <20220314162958.40361-15-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220314162958.40361-1-max.krummenacher@toradex.com>
References: <20220314162958.40361-1-max.krummenacher@toradex.com>
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

The SoM Apalis/Colibri iMX6 use the ADC of a STMPE 811. Enable
its driver.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index f7498df08dfe..88a3602c4e58 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -402,6 +402,7 @@ CONFIG_IIO=y
 CONFIG_MMA8452=y
 CONFIG_IMX7D_ADC=y
 CONFIG_RN5T618_ADC=y
+CONFIG_STMPE_ADC=y
 CONFIG_VF610_ADC=y
 CONFIG_SENSORS_ISL29018=y
 CONFIG_MAG3110=y
-- 
2.20.1

