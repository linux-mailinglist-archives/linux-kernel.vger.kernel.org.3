Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CD14E6C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357633AbiCYCBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 22:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbiCYCBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:01:24 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753395838A;
        Thu, 24 Mar 2022 18:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648173591; x=1679709591;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qXWblDe4HsHFMi+tKXTftleNt+R0MButl08RTTOauzY=;
  b=eaGqq9HbkY2ZZuM6POMCl0WSGY0TTba8EwirvAzuaz63cR4Qh6pTJJfQ
   jQg8WEP2GnO1hBGR26iINSgPznNLj3uQ7+mSRIFfcFd32HV7AN0ZSd24O
   BDJzJGjpPJci8FWFz+dpNUtAtVjm2xk8MAYllwU0fPxg6vKv4ZfWJo/xs
   w=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Mar 2022 18:59:51 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 18:59:50 -0700
Received: from mingxue-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 24 Mar 2022 18:59:48 -0700
Date:   Fri, 25 Mar 2022 09:59:45 +0800
From:   Minghao Xue <quic_mingxue@quicinc.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <robh+dt@kernel.org>,
        <jean-philippe@linaro.org>,
        <virtualization@lists.linux-foundation.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_ztu@quicinc.com>
Subject: [PATCH v2 1/2] dt-bindings: virtio: mmio: add optional wakeup-source
 property
Message-ID: <20220325015945.GA17578@mingxue-gv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some systems want to set the interrupt of virtio_mmio device
as a wakeup source. On such systems, we'll use the existence
of the "wakeup-source" property as a signal of requirement.

Signed-off-by: Minghao Xue <quic_mingxue@quicinc.com>
---
v1 -> v2: rename property from "virtio,wakeup" to "wakeup-source"

 Documentation/devicetree/bindings/virtio/mmio.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
index 4b7a027..160b21b 100644
--- a/Documentation/devicetree/bindings/virtio/mmio.yaml
+++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
@@ -31,6 +31,10 @@ properties:
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

