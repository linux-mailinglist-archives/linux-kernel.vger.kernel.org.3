Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82ED549D96
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349875AbiFMTYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349732AbiFMTWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:22:49 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E87532ED7;
        Mon, 13 Jun 2022 10:18:16 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id y79so6801553iof.2;
        Mon, 13 Jun 2022 10:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2mnX/lv1CoSM2GJgNr/IeYJZ7Y+yiMOfA3Jp6IUIPGQ=;
        b=wK3R7Qdmm9ctJdd4k0HyzT+RIAV+PJ1c5rPCj4TFH1iElbP+RTfI6/gajhFf/kI0M1
         lS5HABbzirAC1QTSiuWwgenge0+KuOnj8b+DKsoqnHpk5Kn0EFg1Lkzje9OipNsC54Y4
         c/qSSZKnayOEaTtLWqoBnS485keIiVj3SBeFqdlvTmtmvdZXSqJ4VSF1PN9o4RqTP43l
         lXdXHERqKMIViLxj7DQ3SuIEsGTzDSfbCRoD05xpkQUFLOo4Al4fv0ipka2TNdoUQesZ
         gN7xqCK86tVsg3FaOpf8rAJ9UJrQDdR6e2f5APFcGyeAxzV72C2fPMflm+nE2hpI7VZ0
         OIcg==
X-Gm-Message-State: AOAM532W6JLtm/XGgptEJg413wpyJxzh/3rRtQN3CK71XJWgePd22rkr
        AR3MwtCYIXucI24fx0nVtQ==
X-Google-Smtp-Source: ABdhPJyT+r+axI1HGJ7u/QULVEEOiPQMBKwM12KG6nBrTwWFQLTAWYm0Y3TfwVYELfwpCFVfsRf3pw==
X-Received: by 2002:a05:6638:22d4:b0:333:f776:e896 with SMTP id j20-20020a05663822d400b00333f776e896mr475569jat.75.1655140694423;
        Mon, 13 Jun 2022 10:18:14 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id ck19-20020a0566383f1300b00331a211407fsm3740374jab.93.2022.06.13.10.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:18:14 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: vexpress-sysreg: Allow for no child nodes
Date:   Mon, 13 Jun 2022 11:18:08 -0600
Message-Id: <20220613171809.3928949-2-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220613171809.3928949-1-robh@kernel.org>
References: <20220613171809.3928949-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is valid for arm,vexpress-sysreg to have no child nodes when either
the deprecated binding without child nodes is used or a platform
has no GPIOs. If there are no child nodes, then "#address-cells" and
"#size-cells" should not be required. However, "reg" should be present
in all cases, so let's add it now.

Cc: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/vexpress-sysreg.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/vexpress-sysreg.yaml b/Documentation/devicetree/bindings/arm/vexpress-sysreg.yaml
index 2d2afada5ad1..f04db802a732 100644
--- a/Documentation/devicetree/bindings/arm/vexpress-sysreg.yaml
+++ b/Documentation/devicetree/bindings/arm/vexpress-sysreg.yaml
@@ -74,8 +74,7 @@ patternProperties:
 
 required:
   - compatible
-  - "#address-cells"
-  - "#size-cells"
+  - reg
 
 examples:
   - |
-- 
2.34.1

