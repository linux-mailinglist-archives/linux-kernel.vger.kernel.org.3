Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B29544A8F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243047AbiFILks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243983AbiFILkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:40:22 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACF61DF116
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:39:56 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kq6so33863079ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4nap20TqgB0A/v+P7vQ2P8UpGK04XbIqt1wfub5uXnA=;
        b=Ueg1vJJtA8mzpsxH0nEFiaIWtuWV7p1LHMzOZutphyHV3yLNgABv3dLC3ekrynBmwn
         A/r+kMTyQaEVwCSXfT8V7XJ7862EeGQ/QmFFFCuYQY/z7H9oSYIIAYN2VD1mfiHEJahL
         I9d9ol2tBYkYfdlqvyOl8A3FYWHVy9LkBc8s8/A2936OS0dlpyGAC4pX0RkletzxOvfy
         cBJe9jXO2rjn34k591hPOiNOuATn92Q7pk81D/u+v+tbYmzGuHCrsHuayEZrMmZYjuj6
         D3obDZLP6s59w9spooYZTHq3H5UCsViIrUCXGqbofhtSH7UBNMSsJRX7Vps4kEGQuZkU
         h1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4nap20TqgB0A/v+P7vQ2P8UpGK04XbIqt1wfub5uXnA=;
        b=Eup7gKAlPrNnElI0h8UpCx+8yZCNtSPgcb3C6L91i68N4OIZqlQU6GwmVBu3wff5Nq
         82O9zjUCqQF00nf46+6cnyRZ6vjl2SmfssbxhqkM1uGLbhDzoUBY7xU96u9ZSZ5q+Azk
         m/gpkOIgyGZj1Zky5pdpZa/ak2fqY+LF1SrUmTP0cbOn52pg0ghM3u6L1MnCcF12JhB4
         ZtcTYZCMAuyfkaUXHZGinrBv39NdHSAFGi3EZUzabL4GXyu5sxgcoO5QEgQAOGXSYF4S
         axbX5yBCSrCfGJ+/YiL7zsqZUdosFPqARSh5Upqtdp+lv24lFPrK/E0+9uTOclb0Hijb
         b1BQ==
X-Gm-Message-State: AOAM531srAQWysWOpaLMle7mgPptqMW0aWndZwDKEzFv3C4195VlmPAW
        CGbtUPBHKmo3brzl9TCkY4FZVQ==
X-Google-Smtp-Source: ABdhPJwT53YScCHkgOGSRt+XjDo4cxp8wW6m7k79ds1Jt/noDk4zfP87CzIo6MdnULITXiZ97ROXQA==
X-Received: by 2002:a17:906:99c1:b0:6fe:b01d:134 with SMTP id s1-20020a17090699c100b006feb01d0134mr35617094ejn.598.1654774794528;
        Thu, 09 Jun 2022 04:39:54 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c10-20020a170906528a00b0070a80f03a44sm9460415ejm.119.2022.06.09.04.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:39:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 18/48] arm64: dts: marvell: armada-3720: align lednode names with dtschema
Date:   Thu,  9 Jun 2022 13:39:37 +0200
Message-Id: <20220609113938.380466-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and DT schema expects certain pattern
with 'led'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 6721b9b4cf5c..de8d0cfa4cb4 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -35,7 +35,7 @@ memory@0 {
 
 	leds {
 		compatible = "gpio-leds";
-		red {
+		led {
 			label = "mox:red:activity";
 			gpios = <&gpiosb 21 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
-- 
2.34.1

