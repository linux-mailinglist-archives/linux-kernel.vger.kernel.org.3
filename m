Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40EB467D98
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhLCS7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbhLCS6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:58:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865D8C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 10:55:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D3268CE281A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 18:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA14C53FAD;
        Fri,  3 Dec 2021 18:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638557728;
        bh=lmlqyxxEr757EnH/0V+jIntbZd3A83o/XSNIlIu3lEI=;
        h=From:To:Cc:Subject:Date:From;
        b=Ghh1zMkoHgO12EJClv8DumivVmKGNJNEI6kZBVgFufUgSrxE3zbcsmb8jpY64jw1v
         2Lrj5UCytnKkTtM8jclkJlySU6tIFIF9lqhaMv/rLLL7c9DgVSa73cYvERzB1fj31I
         HPOKBLKEew/sfgGaFmyCw4nKBBu/HqNUkLvXJ+eGK3QhwynbkMhGTTEcTJha0Xqr8H
         WVKtHt2nSKoGDEqe3OVVgLh1mQ85N62XsIMw7i4KC86L8IncAQDB3yRTl+XkyoKCwU
         9xgtfMiEMHKzspfHo2ZGzIjm4L21RSEicvn2KOn8fCMZcfziXLeKjdfTWQfeR02+rf
         qvCnWerTLM/NQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] eni_vdpa: alibaba: select VIRTIO_PCI_LIB
Date:   Fri,  3 Dec 2021 19:55:14 +0100
Message-Id: <20211203185522.692489-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When VIRTIO_PCI_LIB is not built-in but the alibaba driver is, the
kernel runs into a link error:

x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_features':
eni_vdpa.c:(.text+0x23f): undefined reference to `vp_legacy_set_features'
x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_state':
eni_vdpa.c:(.text+0x2fe): undefined reference to `vp_legacy_get_queue_enable'
x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_address':
eni_vdpa.c:(.text+0x376): undefined reference to `vp_legacy_set_queue_address'
x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_ready':
eni_vdpa.c:(.text+0x3b4): undefined reference to `vp_legacy_set_queue_address'
x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_free_irq':
eni_vdpa.c:(.text+0x460): undefined reference to `vp_legacy_queue_vector'
x86_64-linux-ld: eni_vdpa.c:(.text+0x4b7): undefined reference to `vp_legacy_config_vector'
x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_reset':

Selecting VIRTIO_PCI_LIB_LEGACY is not sufficient here since that is
only part of the VIRTIO_PCI_LIB support.

Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/vdpa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 50f45d037611..04466603021f 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -80,6 +80,7 @@ config VP_VDPA
 
 config ALIBABA_ENI_VDPA
 	tristate "vDPA driver for Alibaba ENI"
+	select VIRTIO_PCI_LIB
 	select VIRTIO_PCI_LIB_LEGACY
 	depends on PCI_MSI && X86
 	help
-- 
2.29.2

