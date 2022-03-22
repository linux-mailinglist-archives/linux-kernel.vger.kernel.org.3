Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB264E35B8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbiCVAtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiCVAtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:49:14 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CC42715E;
        Mon, 21 Mar 2022 17:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647910068; x=1679446068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ubdrenh8RZbdb9SUuFRL3yPGdNKdx7dpJeScfreUfxs=;
  b=oV/gQ17iGHzNyojLz15qsnxaDROH+Rej42hWjC0+p4lE5Z1eJ5I8xAKY
   dA8HbI562z07F4HgPFv04SjVvicx0E8bc1VEVHuDCN40F5iGEqQTMRzXx
   aqIRIbqHy/nJeuiNkRi9yO01he6a52rSc8K+8L7zBf3tpecWhD0ShV95X
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Mar 2022 17:47:48 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:47:48 -0700
Received: from collinsd-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 17:47:47 -0700
From:   David Collins <quic_collinsd@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <devicetree@vger.kernel.org>
CC:     David Collins <quic_collinsd@quicinc.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Subbaraman Narayanamurthy" <quic_subbaram@quicinc.com>
Subject: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: define support for name based regulators
Date:   Mon, 21 Mar 2022 17:47:19 -0700
Message-ID: <4c94b4351b8d38167e972df46fbc507f9499513a.1647909090.git.quic_collinsd@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1647909090.git.quic_collinsd@quicinc.com>
References: <cover.1647909090.git.quic_collinsd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow SCMI regulator subnodes to be specified either by ID using
the "reg" property or by name using the "arm,scmi-domain-name"
property.

Name based SCMI regulator specification helps ensure that an SCMI
agent doesn't need to be aware of the numbering scheme used for
Voltage Domains by the SCMI platform.  It also ensures that the
correct Voltage Domain is selected for a given physical regulator.
This cannot be guaranteed with numeric Voltage Domain IDs alone.

Signed-off-by: David Collins <quic_collinsd@quicinc.com>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml    | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 5c4c6782e052..08cb5de967ac 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -155,7 +155,7 @@ properties:
           The list of all regulators provided by this SCMI controller.
 
         patternProperties:
-          '^regulators@[0-9a-f]+$':
+          '^regulator.+$':
             type: object
             $ref: "../regulator/regulator.yaml#"
 
@@ -164,8 +164,17 @@ properties:
                 maxItems: 1
                 description: Identifier for the voltage regulator.
 
-            required:
-              - reg
+              arm,scmi-domain-name:
+                description:
+                  A string matching the name of the SCMI voltage domain for this
+                  regulator.
+                $ref: "/schemas/types.yaml#/definitions/string"
+
+            anyOf:
+              - required:
+                  - reg
+              - required:
+                  - arm,scmi-domain-name
 
 additionalProperties: false
 
-- 
2.17.1

