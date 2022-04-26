Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B58350FFAD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351268AbiDZN5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349923AbiDZN4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:56:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A7D15CEC6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:53:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d5so10385062wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6PPGdjzLBRfmjyoYZPbtheYxkUOxVcg2XjuwyGNEy84=;
        b=HYqHeXHh2jVFDzdmAAsOgALRoHWL3lylNXPL38qJKWgAhYHnpOcKvTgqc0S8MKTa1D
         KmiiqFzIT5/QBQVrAK+sjKMobtjDgyeim9RfZOHg46y/OlCh3osuBTszhmtAka/UQ2Gi
         /heJA9jcE+HxOs5yED5UC9WG32WsOgl11Ujh3pc/eLL+H2JU4Ky5ypWEEKOyEGqy1WKW
         Wj1m8C/Dyutxj3dogPfQlPCsD462xfyBYhPV7Z2sCQiO2hAFYEV1xQYsfGpr5NNQuJKx
         EJPIZnu1GBhAPjARnX3ityHRgQAeGIovnvXJlQxpSyJ0g3U0cSCeEq970+ij1X+3SB+0
         5eWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6PPGdjzLBRfmjyoYZPbtheYxkUOxVcg2XjuwyGNEy84=;
        b=QnTQii0rcrnR8eKq18zsQpSAUys+KiZVmFCrGLVMRNLQd/irofLrL3Y8qcDB0sKQ4X
         LhZ1cgBbfu3rC6sSJM/pBY0WesZY16bdbxFCsZfW+uuyCbCOPBXnm3ozzBMV93cpNTIU
         qPmO7ooH8OIMUcSrETPPpc9kP6KXCUBYMtk8/SIFoQ0Rb66m2zb+GUXKyjCrk2lo6/ch
         RJUSoUTmLmkU0Ki6iB0ik6Bs/SxwQygYLmgE6OP4UoKRdEOQ1i6uYef8RAFEg52+ooPw
         E8qGb3cHUa85SUrG48VNpd20GXXLPIdtUGAF9eDUFjRZKW9iKoLgIqX2lWV2AHT/oa++
         uL8Q==
X-Gm-Message-State: AOAM530HvuEGlCEnr+/sWw7KR4hWbgCsPojWLvnv3jHPiQLqg6hvi64Q
        HHVczpPeUV213ozrGOP5jo6GSw==
X-Google-Smtp-Source: ABdhPJxv5zp1uTq4FHJtwaeINExGGDRpzDODK6frUqUyafJ3hBir6qwv2I4zIElowuN410a68r3QwA==
X-Received: by 2002:adf:ef46:0:b0:20a:e153:1f4e with SMTP id c6-20020adfef46000000b0020ae1531f4emr4710059wrp.352.1650981217679;
        Tue, 26 Apr 2022 06:53:37 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id m35-20020a05600c3b2300b00393ebe201a6sm5504775wms.44.2022.04.26.06.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:53:37 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] arm64: dts: mediatek: mt6359: add node for PMIC keys support
Date:   Tue, 26 Apr 2022 15:53:12 +0200
Message-Id: <20220426135313.245466-8-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426135313.245466-1-fparent@baylibre.com>
References: <20220426135313.245466-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for the MT6359 PMIC keyboard in mt6359.dtsi.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
v2: remove key definitions from dtsi

 arch/arm64/boot/dts/mediatek/mt6359.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6359.dtsi b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
index df3e822232d3..c09cbd8e81ce 100644
--- a/arch/arm64/boot/dts/mediatek/mt6359.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
@@ -294,5 +294,9 @@ mt6359_vsram_others_sshub_ldo: ldo_vsram_others_sshub {
 		mt6359rtc: mt6359rtc {
 			compatible = "mediatek,mt6358-rtc";
 		};
+
+		mt6359keys: keyboard {
+			compatible = "mediatek,mt6359-keys";
+		};
 	};
 };
-- 
2.36.0

