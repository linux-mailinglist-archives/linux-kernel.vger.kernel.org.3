Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5007D4BCF58
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244196AbiBTPQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:16:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244144AbiBTPQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:16:17 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71B234BB3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:15:55 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id o24so22874445wro.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BNiRHWO4HLFv+UVov8z2shlE8WSMm7D0PfvatmCO+8U=;
        b=N7V/I4j8PzHey8p1AFUCuSEr7LELjsKsOjoLstg9JmC3mbmQZBvRF2HsdcsZ44Uk28
         PiWJ1AT3fVDAzuZQDGRHBM6Ygya52JFzQTgts4HiXfkOYd0Rh29bYWOESrgFeAv5Lwqq
         KyZ2WYfkZrcbjSVyCeXeCPSAHL7XpukcGr8r/MsB6lGelZ19Ff3OE8/LokJ1xlwwNzGL
         tbOQtM1WMusfMwgleCOG6gEwcpFTJcI9brqYbHknliwvuus1kvY6sQ8kJZjkd/JEMRkV
         TDi+6leGWaWkSdimIsx+ko5oF7R0k6FzRvcxsPhDSshJql+am3HBoevr4aqgNBCVjTdb
         CRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BNiRHWO4HLFv+UVov8z2shlE8WSMm7D0PfvatmCO+8U=;
        b=22y9lE0zI8DKNUh3FhnsgRnuBA71G188bHDvftutd7vPQLH+5oo33ORF91kp7KaLLS
         C0I25BlQRn4RWn6OtBZySqyhK6v+RAhqXQLcJjOaE+WepwrbrfslaB4+YmE1TMnoLtjg
         +C5LqoztmWrozMVdbeVxIKIK80308S5iwv233Ch1riDqnTPcujvzTaqwfPQllhexRERd
         DgT716bGHp6D3KhI4k9eSmVGiHOyYgLzrkL1DpMyuAfzjGmFGOUiXCvted5BvTthZNks
         S2LWG2QQxUHRPPc7H8Cg39ABUZCtski+92Q1q+P0vfp/IrwqhZwf9HFwiD08Pa7M2M7L
         elOQ==
X-Gm-Message-State: AOAM533c6L634JIUTH7aYGunbTMmc4KhigHiNkhJ71g+NbAR+NKI63/h
        DmJLcoKQqXDP0LNhRQMyXYFCjtkg7XSVPw==
X-Google-Smtp-Source: ABdhPJyakR4a/iE02zTmqIAPt2wTWDG+ZbxmeT8aPIAwTrqaIBHT0QewXJ0HBLy6kQ7DYlM0sbtgqg==
X-Received: by 2002:adf:eace:0:b0:1e7:6884:45a5 with SMTP id o14-20020adfeace000000b001e7688445a5mr12733333wrn.197.1645370154500;
        Sun, 20 Feb 2022 07:15:54 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id h7sm28687749wru.41.2022.02.20.07.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 07:15:54 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/13] nvmem: sunxi_sid: Add support for D1 variant
Date:   Sun, 20 Feb 2022 15:15:20 +0000
Message-Id: <20220220151527.17216-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
References: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Holland <samuel@sholland.org>

D1 has a smaller eFuse block than some other recent SoCs, and it no
longer requires a workaround to read the eFuse data.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunxi_sid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 275b9155e473..5750e1f4bcdb 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -184,6 +184,11 @@ static const struct sunxi_sid_cfg sun8i_h3_cfg = {
 	.need_register_readout = true,
 };
 
+static const struct sunxi_sid_cfg sun20i_d1_cfg = {
+	.value_offset = 0x200,
+	.size = 0x100,
+};
+
 static const struct sunxi_sid_cfg sun50i_a64_cfg = {
 	.value_offset = 0x200,
 	.size = 0x100,
@@ -200,6 +205,7 @@ static const struct of_device_id sunxi_sid_of_match[] = {
 	{ .compatible = "allwinner,sun7i-a20-sid", .data = &sun7i_a20_cfg },
 	{ .compatible = "allwinner,sun8i-a83t-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun8i-h3-sid", .data = &sun8i_h3_cfg },
+	{ .compatible = "allwinner,sun20i-d1-sid", .data = &sun20i_d1_cfg },
 	{ .compatible = "allwinner,sun50i-a64-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-h5-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-h6-sid", .data = &sun50i_h6_cfg },
-- 
2.21.0

