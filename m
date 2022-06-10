Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AE35460A0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347921AbiFJI7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348236AbiFJI7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:59:30 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865CF29B;
        Fri, 10 Jun 2022 01:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654851568; x=1686387568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=oletbdRLgOOIrpRC0SenT9n3b/8WunGfWJ1H8zz84LY=;
  b=RXEs48vIT3rp0py71xweEuj128201oaO5YY3taQLmv4lxnMNzBCpNr4n
   SxaG/4dzjTfAcgcztMzhpBz0sq9LdfmmBlbQMS5e9hR0OpyROhdPt1JsA
   Mx9Clmn54Pu8VSiG+RiTQ/yey/Th9B8FRnK/ZfQBNohHixnJbwPylZpuX
   Y=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Jun 2022 01:59:27 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 01:59:26 -0700
Received: from mingxue-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 10 Jun 2022 01:59:24 -0700
From:   Minghao Xue <quic_mingxue@quicinc.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Minghao Xue <quic_mingxue@quicinc.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <virtualization@lists.linux-foundation.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ztu@quicinc.com>
Subject: [PATCH v2 2/2] virtio_mmio: add support to set IRQ of a virtio device as wakeup source
Date:   Fri, 10 Jun 2022 16:58:27 +0800
Message-ID: <1654851507-13891-3-git-send-email-quic_mingxue@quicinc.com>
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

According to virtio_mmio wakeup flag in device trees, set its IRQ
as wakeup source in virtqueue initialization.

Signed-off-by: Minghao Xue <quic_mingxue@quicinc.com>
---
 drivers/virtio/virtio_mmio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index f9a36bc..c144442 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -486,6 +486,9 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	if (err)
 		return err;
 
+	if (of_property_read_bool(vm_dev->pdev->dev.of_node, "wakeup-source"))
+		enable_irq_wake(irq);
+
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i]) {
 			vqs[i] = NULL;
-- 
2.7.4

