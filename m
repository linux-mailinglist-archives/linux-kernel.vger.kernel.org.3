Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE224B270A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350528AbiBKN0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:26:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240082AbiBKNZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:25:58 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 05:25:57 PST
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20795BBF;
        Fri, 11 Feb 2022 05:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1644585957;
  x=1676121957;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nrmbH9p3Clpi53bf1yANWZ2c4LoJLnrqCZrmomFDYVo=;
  b=jazPqxmbjYkwE968ByNCZdEoqw/QBCalYubiQYZW2IcWs3fn9oU5Fmkm
   LfVxOsYl8JNk4sWamucMTIXGgHr6yV6c9eB1mkVDrwaJl4UAUla6a0hzV
   UMeNz4Of5kMfboij45a8q9mCmelS1aafyi8VZrDwSpuXjZAfeCzwzUMYL
   J2MPkzR02VciqWL6jCqcypikXPaBuE/XFesGXB7bhLOaKSkKlqVYJ71ke
   d/1QuKjMwumoUIWtUN4AkZt2q9RHeiReNx/nrU4Avoiv5MJnB5au/sbiE
   q4Pj2onOflc4BcRZBRxepG43TEaI9icuf7TSo4uS35BJMNMqap3IogZFh
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <kernel@axis.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] regulator: tps62864: Fix bindings for SW property
Date:   Fri, 11 Feb 2022 14:24:49 +0100
Message-ID: <20220211132449.2899924-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The property is not a pattern, so it should use 'properties' instead of
'patternProperties'.  Also, unevaluatedProperties should be set to false
like in the other regulator bindings.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 Documentation/devicetree/bindings/regulator/ti,tps62864.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/ti,tps62864.yaml b/Documentation/devicetree/bindings/regulator/ti,tps62864.yaml
index e3d739a37ab0..0f29c75f42ea 100644
--- a/Documentation/devicetree/bindings/regulator/ti,tps62864.yaml
+++ b/Documentation/devicetree/bindings/regulator/ti,tps62864.yaml
@@ -23,10 +23,11 @@ properties:
   regulators:
     type: object
 
-    patternProperties:
+    properties:
       "SW":
         type: object
         $ref: regulator.yaml#
+        unevaluatedProperties: false
 
     additionalProperties: false
 
-- 
2.34.1

