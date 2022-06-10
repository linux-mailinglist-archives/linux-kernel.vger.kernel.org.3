Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EDC54609F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344313AbiFJI7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344194AbiFJI65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:58:57 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0B72FE58;
        Fri, 10 Jun 2022 01:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654851535; x=1686387535;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=HKg9Wlwj2ESBBVWPm24HfM+TeEHSYVCZhAB8J6dKuBc=;
  b=c/EEPku5eIAM2M/9LvoR+Wu/WJkc9f8hUwTPDSDKosjNseyqLZnlv0v0
   KaDQBjAEPv+A2uQquv0g/sTx1+ZT+IZFYUH9zv3UsF7TqELZWfAusjb8y
   4VIUZAmKTB87v3h6+M2UWeCB64NON2pdNGvI5+35xCg2vIpOVkrEM493d
   s=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Jun 2022 01:58:54 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 01:58:54 -0700
Received: from mingxue-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 10 Jun 2022 01:58:52 -0700
From:   Minghao Xue <quic_mingxue@quicinc.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Minghao Xue <quic_mingxue@quicinc.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <virtualization@lists.linux-foundation.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ztu@quicinc.com>
Subject: [PATCH v2 0/2] virtio_mmio: add support to set IRQ of a virtio device as wakeup source
Date:   Fri, 10 Jun 2022 16:58:25 +0800
Message-ID: <1654851507-13891-1-git-send-email-quic_mingxue@quicinc.com>
X-Mailer: git-send-email 2.7.4
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

Hi,
Some systems want to set the interrupt of virtio_mmio device as a wakeup source of system.
This patch series add support for such use case. And it can be enbaled by adding "wakeup-source" property to the device tree.

Patch 1: Add an optional "wakeup-source" property into binding file of virtio_mmio device.
Patch 2: Set IRQ of virtio_mmio device as wakeup source in virtqueue initialization, if "wakeup-source" is set in the device tree.

Version 2 changes (mostly feedback from Krzysztof Kozlowski)
-rename property from "virtio,wakeup" to "wakeup-source"

Minghao Xue (2):
  dt-bindings: virtio: mmio: add optional wakeup-source property
  virtio_mmio: add support to set IRQ of a virtio device as wakeup
    source

 Documentation/devicetree/bindings/virtio/mmio.yaml | 4 ++++
 drivers/virtio/virtio_mmio.c                       | 3 +++
 2 files changed, 7 insertions(+)

-- 
2.7.4

