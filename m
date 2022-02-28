Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4704C6CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiB1Mou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236579AbiB1Moi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:44:38 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256354755A;
        Mon, 28 Feb 2022 04:44:00 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id e6so9866720pgn.2;
        Mon, 28 Feb 2022 04:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qP6HrvQPRvcyooG75RH7rCRDnFKMKhHlpTnOTmKWJ5E=;
        b=TKQpbKejpJRp4QDPKI8yohmG5/EW4zPfAu2U/DpBuHKDZSxLIHAkqKLxAr+u4lWR4x
         IMWlw2biisuqVqpmict5mhC7vd8xAtUurrB1EgIMmfVhLPDMymqDekJkytiIFz6cjyk4
         xCSbLXVbgaU3vnM2FBJLZIfER7uDRbLnYoUdu8cAZeeeqrx44fSIvOWqC8AR4zht9nBN
         eV27wl40nRq9lcd4TkDSv7tjMFodI7tSY8FMoAGdBe37vkoqR/kW5QZcnvLVSbjW4ALZ
         PYp9kW6Ky5wTWYH8K8/NGb+w/PAMRaEG6mjNshefOq/kYBrCn9NaCktL05l8PMpo76Vw
         uvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qP6HrvQPRvcyooG75RH7rCRDnFKMKhHlpTnOTmKWJ5E=;
        b=btENuZn6I+1TSv5A/IPQkcaf9T0hI2dVXlSTrjSwOslvHqH4Dps5Twgg96e6HYpp1+
         T9NCRpvqFFRiR/fUJ4Es+ay7hvP8XMCWijpKcetBCPNrs5WIPNYtMvp8XjpbtqMk4wEW
         N4NVGa8zJzGnXm8ziuIzEyS/Hi4n1mKQYC5uO2gy6T92Ww6ZlfHrLZrVFFTAm002gJW3
         2PV78sGslYnAmOnJv/liylyC36OOD37xfT0sNpx/oMzhtRCUpR3NupO4BVkNsKe06iW+
         IIM9izstVDNyJsZbkDMGQ6JJN8thpRcJs0RHYcR8BgyHXLNZx0IJJi05TLyJsJBgjbSx
         gAFQ==
X-Gm-Message-State: AOAM530s+3woFz9qE3ay9UlsgmD6RpYyVcLRkXTpuqfuv8ZIOn/wTWiI
        5G12Bss4f/O6IvenFxMbSUkjMmobUFoJ3A==
X-Google-Smtp-Source: ABdhPJzp96y/zE/eVlnUwluVho7ei6LG8OeQKtPLlwooDFfhvzVyToNALwKYpnUo1Q/PPW0Czl58Yg==
X-Received: by 2002:a62:3085:0:b0:4e0:1218:6d03 with SMTP id w127-20020a623085000000b004e012186d03mr21101080pfw.19.1646052239644;
        Mon, 28 Feb 2022 04:43:59 -0800 (PST)
Received: from localhost.localdomain ([122.161.51.77])
        by smtp.gmail.com with ESMTPSA id z23-20020aa79597000000b004e1bf2f5818sm14129214pfj.87.2022.02.28.04.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:43:59 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/3] dt-bindings: spi: Add spiclk to clock-names property in pl022
Date:   Mon, 28 Feb 2022 18:13:45 +0530
Message-Id: <20220228124345.99474-4-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228124345.99474-1-singh.kuldeep87k@gmail.com>
References: <20220228124345.99474-1-singh.kuldeep87k@gmail.com>
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

Fix below dtc warning by making necessary addition of "spiclk" in
clock-names property.

arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dt.yaml: spi@190000:
clock-names:0: 'spiclk' is not one of ['SSPCLK', 'sspclk']
    From schema: Documentation/devicetree/bindings/spi/spi-pl022.yaml
arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dt.yaml: spi@66190000:
clock-names:0: 'spiclk' is not one of ['SSPCLK', 'sspclk']
    From schema: Documentation/devicetree/bindings/spi/spi-pl022.yaml

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-pl022.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
index 5f6926a58b15..fb3075a0c7fd 100644
--- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
@@ -45,6 +45,7 @@ properties:
           - enum:
               - sspclk
               - SSPCLK
+              - spiclk
           - const: apb_pclk
 
   pl022,autosuspend-delay:
-- 
2.25.1

