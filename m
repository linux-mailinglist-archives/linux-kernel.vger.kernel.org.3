Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F8B539115
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344360AbiEaMuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiEaMuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:50:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383366EC4D
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:50:18 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d26so12940253wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G2o8rrRm/rSsYSXsi2pnvW4ZzfymkwbyFEWUK4Ia2ho=;
        b=mmybuscfa6Ot10NSXfgRNyJEo6QmiYe16/7mTMCQ4IfVJWm3g7EGt/bYQb8nzEUqti
         fdhvuCvcwURHCsxHPuq5RG3n1v396Nw8/PEiKKM2PdzHY1jjMcpf55i/VxKgCRxzQ/ok
         YjRBxW+pcBFayrVibnBNK29pmegCFP9i1kcIgP1duq46kPJFaw/qpxhT2VT9N+zzF0dh
         HAmoE9EL5oC/lszYQPF1VZymU+WiPtilgcZx+DcjP183TX78bCYig8yUma0eEiUWWNSA
         zcRw2ZRmOS79kQVLk2gKgBJAr5jn4m/opji5Ahe471OVPf4ZO9Vuno+pWUUqf0R9s+yS
         iywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G2o8rrRm/rSsYSXsi2pnvW4ZzfymkwbyFEWUK4Ia2ho=;
        b=pVtNuG6DAgqIZXjOGRY4bNM0HkG0n/Q6ZA1/cfDoERz5d19ozRRFbGDCWZYryr3s3C
         rcTUcBK8URquGzQ12DXf2EkLwcnlUDOFVYGL3c6SQG7tyZ/B57KmCoWstQHpHSlgi+n3
         mxXFLwFXHy3/kgNm5zDCAhpTfQpgNLMJsOsRHNTKldB9dA2WmO0KATqi+488zmDI4sEy
         xcdbjZtffnE6aLkSRGsuUBrf/GEupe4LK82WfxqLHFHGAC3oGRjdeo18ng25Kw6gQvP+
         nOSUZmWm+xv2tQYdT/ZOhaTkgf+PI3kjk5k3+BhEGqhTqIjMYaWI38Pu+AfNZWAjxwCN
         Y3Fw==
X-Gm-Message-State: AOAM531M6dNct7yMY9x3C1CZtPkeJojthD8rqos8qJMDUsBylq3s9WBl
        s2ufJLGOetC+v3uRUrrw+5s2lA==
X-Google-Smtp-Source: ABdhPJxFrBY6CrE1EfSvbOblSOMd54KwCAB1UviagiC4WZn0SyFrkBQviZ7o1RhhD0SrbR5KG4VhEQ==
X-Received: by 2002:a05:6000:2aa:b0:20f:c5da:d4e3 with SMTP id l10-20020a05600002aa00b0020fc5dad4e3mr41519505wry.510.1654001416707;
        Tue, 31 May 2022 05:50:16 -0700 (PDT)
Received: from helium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id i13-20020adfaacd000000b0020fc40d006bsm11475019wrc.17.2022.05.31.05.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 05:50:16 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] dt-bindings: mfd: mt6397: add binding for MT6357
Date:   Tue, 31 May 2022 14:49:53 +0200
Message-Id: <20220531124959.202787-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531124959.202787-1-fparent@baylibre.com>
References: <20220531124959.202787-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the MT6357 PMIC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/mfd/mt6397.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index 293db2a71ef2..31f2c6d253ca 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -20,6 +20,7 @@ This document describes the binding for MFD device and its sub module.
 Required properties:
 compatible:
 	"mediatek,mt6323" for PMIC MT6323
+	"mediatek,mt6357" for PMIC MT6357
 	"mediatek,mt6358" for PMIC MT6358 and MT6366
 	"mediatek,mt6359" for PMIC MT6359
 	"mediatek,mt6397" for PMIC MT6397
-- 
2.36.1

