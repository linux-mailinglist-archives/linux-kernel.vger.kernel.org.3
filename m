Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAB84E6C56
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 03:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357656AbiCYCH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 22:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiCYCH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:07:28 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48BD6D3B3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 19:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648173955; x=1679709955;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VE+B5juNovbg84QJfTQJEL3Xvi7JcDEApkqDSivM+1Q=;
  b=kCayTrJuHGpocqiYo9tslySYBK4hU3OH8CNq9S3gI6UTi/gkevr7Hhnk
   I7z9i9Ss8BPdrYvO8mx98n5N4fq+8jJ4vItkLBjpUaad1Pf2ndQoMA7Jj
   t02j59jTRH4b95Z8pieDbA3BqSCLiL9wZN79ZiV+mYOyH5UYzO7Un3m5j
   A=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Mar 2022 19:05:55 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 19:05:55 -0700
Received: from mingxue-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 24 Mar 2022 19:05:53 -0700
Date:   Fri, 25 Mar 2022 10:05:49 +0800
From:   Minghao Xue <quic_mingxue@quicinc.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_ztu@quicinc.com>
Subject: [PATCH v2 2/2] virtio_mmio: add support to set IRQ of a virtio
 device as wakeup source
Message-ID: <20220325020549.GA17663@mingxue-gv.qualcomm.com>
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

According to virtio_mmio wakeup flag in device trees, set its IRQ
as wakeup source in virtqueue initialization.

Signed-off-by: Minghao Xue <quic_mingxue@quicinc.com>
---
v1 -> v2: rename property from "virtio,wakeup" to "wakeup-source"

 drivers/virtio/virtio_mmio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 56128b9..6637d85 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -474,6 +474,9 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
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

