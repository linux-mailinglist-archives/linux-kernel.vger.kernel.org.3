Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EBF5111D1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358496AbiD0HB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358388AbiD0HBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:01:20 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B376117E36
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:58:07 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id a1so835385edt.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ocARHRASAyy5ekahF2LGjwlLKqc2XinQEkZtryZtbDg=;
        b=qdEAEjgJNuV9dtRj9apfVr6pewWgkwnSa880J5qM7FtcNLOWg+qr6CKXP1OKgi1NlH
         xHRnwe4EWAjW4wcd517OohN6aqWy8DL3GqFmJVZqzC/SNR5KbSP9DDLxx54fFbcVRAgF
         qwOVy8xv0LFKkl2NUQpgn5iSiippkxiBWSm9RBJABML8MvUn/xECJ6g7BQGlAvl/HifN
         A5+AqGfnx3bd3gizs+4HGtnkb0CaECJTZrnhEaRNO5a0UGUB+NRnrgbHTv7HN6hYu4r/
         t8ezU+0BgVAtm8aoHn7xZ9RBveUGzy0IydKBl2kiJYmhgbxxEp9YovyVL6nKRsu9Eqe2
         9tVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ocARHRASAyy5ekahF2LGjwlLKqc2XinQEkZtryZtbDg=;
        b=fQoabu/Oah1m6s9jUp7zE1xUfM0k2sIAxlqY3UGoBoPIsq6q7L/BE5n1WzJbTjYAHe
         ors1zGwQi6z3SouCRLSvTu9iGdtMt0wTybgWNGAdDralzOkDmwIDfiyIMVpsmbfUzoh6
         UO5jreB/stKIKjX3ukJNs7t04930AxxzR4WSp45rnqy67gLuXsvdPn76F5/BRS2Yw6TG
         W+MENpTgHpQ/Uohdw3sEUniKMDqNZ5xU2JcIE2R+obUzaG2N5NgvOnISTl331WYSyX64
         WzMjGBpiu9aeRVtrcOctho780Bm2ZdYyNEjVBcnBdPTdQLDpQELM2nohoM9KLUzz5UC9
         9OcA==
X-Gm-Message-State: AOAM530BXajV7l/K5QWxy+HZdsWn1/562zSafeokxwfTeTH8Ql13GrCD
        9ZCdR0RAS3dO9NlLY4CkKeJ0Og==
X-Google-Smtp-Source: ABdhPJy5D5/RNHf18wBa0Eg+t5e86Md66zOvKYCYi1Q/E6sb0yZTNAjy6T3W8kbfcazX8IhaNqcHHA==
X-Received: by 2002:a50:99c7:0:b0:419:225:80b6 with SMTP id n7-20020a5099c7000000b00419022580b6mr28917945edb.240.1651042686278;
        Tue, 26 Apr 2022 23:58:06 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id dc16-20020a170906c7d000b006f391eafd1esm3948648ejb.67.2022.04.26.23.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 23:58:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jan Kotas <jank@cadence.com>, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] dt-bindings: ufs: cdns,ufshc: Add power-domains
Date:   Wed, 27 Apr 2022 08:58:02 +0200
Message-Id: <20220427065802.110402-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cadence UFS controller can be part of power domain (as it is in
example DTS of TI J721e UFS Host Controller Glue), so allow such
property.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml b/Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
index d227dea368be..fb45f66d6454 100644
--- a/Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
+++ b/Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
@@ -43,6 +43,9 @@ properties:
       - const: phy_clk
       - const: ref_clk
 
+  power-domains:
+    maxItems: 1
+
   reg:
     maxItems: 1
 
-- 
2.32.0

