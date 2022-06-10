Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C09C5460A3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348231AbiFJI72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244940AbiFJI7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:59:23 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F66829B;
        Fri, 10 Jun 2022 01:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654851560; x=1686387560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=GFzPPyRigQvJYoVong+5JXGtIBe7lpEFv8dMfU0UCZ4=;
  b=Ovvs9FLMgbteDdZfgbxza4CmdfuIkkqAga3bczLnsfA7PgmFQfTDDcRL
   75QeQD2ApUBiXPH1gtUox0gCtZUI7MD1AYbV0kOsm3I4SDnG5gZ+wQoFZ
   1pSvj1PNe4AjdK47cSJu1OowIRA6uPME8UnRz1XKce9iHI/RTkJ9sAZE/
   A=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Jun 2022 01:59:20 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 01:59:19 -0700
Received: from mingxue-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 10 Jun 2022 01:59:17 -0700
From:   Minghao Xue <quic_mingxue@quicinc.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Minghao Xue <quic_mingxue@quicinc.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <virtualization@lists.linux-foundation.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ztu@quicinc.com>
Subject: [PATCH v2 1/2] dt-bindings: virtio: mmio: add optional wakeup-source property
Date:   Fri, 10 Jun 2022 16:58:26 +0800
Message-ID: <1654851507-13891-2-git-send-email-quic_mingxue@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654851507-13891-1-git-send-email-quic_mingxue@quicinc.com>
References: <1654851507-13891-1-git-send-email-quic_mingxue@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some systems want to set the interrupt of virtio_mmio device
as a wakeup source. On such systems, we'll use the existence
of the "wakeup-source" property as a signal of requirement.

Signed-off-by: Minghao Xue <quic_mingxue@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/virtio/mmio.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
index 10c22b5..0aa8433 100644
--- a/Documentation/devicetree/bindings/virtio/mmio.yaml
+++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
@@ -33,6 +33,10 @@ properties:
     description: Required for devices making accesses thru an IOMMU.
     maxItems: 1
 
+  wakeup-source:
+    type: boolean
+    description: Required for setting irq of a virtio_mmio device as wakeup source.
+
 required:
   - compatible
   - reg
-- 
2.7.4

