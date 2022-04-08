Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0034F9CED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbiDHSlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238807AbiDHSkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:40:25 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F592E09D;
        Fri,  8 Apr 2022 11:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649443086;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=i4fDakP+s/1gf997GR3ZeOPcr+RbLezz1DCLHLX9yR0=;
    b=qw6WbTrWyXLaC2QLh5Ea9dFbcB/8Yxh0i7IsiPau1ux0fxGuCVcNIewOnGRAlgF2Tg
    f3ldQR/fUiXKzSuotYI31mneOnrWEqgpPJW8fulOUkXCSUw/3gSDq5u7Oh53m5DiHnF1
    wfulXNIrhtuOs6DwJ4wkHGxBD4B3O/nSjPxDbEAKeOHp+lT0lCE1G0PIMhpfiuRCyI3E
    h9nm9NzXAv783jwmDW4wnE0hTxKKtKiwFABArfvXuHXScp+Z9zVwRUfFzxl3qoocSaAm
    xZnpgeGhSq7igOpclODf0RWR/cURxOkWOw/p08o5tK0qQmpX9g4MJxgH7xIcR4xYzOgw
    6mzw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgdr/a"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy38Ic5so4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 8 Apr 2022 20:38:05 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 13/18] dt-bindings: fix jz4780-nemc issue as reported by dtbscheck
Date:   Fri,  8 Apr 2022 20:37:56 +0200
Message-Id: <84adfe6237cd4cfd52cb9723416f69926e556e55.1649443080.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1649443080.git.hns@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jz4780-nemc needs to be compatible to simple-mfd as well or we get

arch/mips/boot/dts/ingenic/ci20.dtb: memory-controller@13410000: compatible: 'oneOf' conditional failed, one must be fixed:
	['ingenic,jz4780-nemc', 'simple-mfd'] is too long
	'ingenic,jz4725b-nemc' was expected
	'ingenic,jz4740-nemc' was expected
	From schema: Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 .../devicetree/bindings/memory-controllers/ingenic,nemc.yaml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
index 24f9e19820282..3b1116588de3d 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
@@ -17,7 +17,7 @@ properties:
     oneOf:
       - enum:
           - ingenic,jz4740-nemc
-          - ingenic,jz4780-nemc
+          - [ ingenic,jz4780-nemc, simple-mfd ]
       - items:
           - const: ingenic,jz4725b-nemc
           - const: ingenic,jz4740-nemc
-- 
2.33.0

