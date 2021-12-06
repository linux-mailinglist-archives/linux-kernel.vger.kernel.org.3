Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2464691C8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239761AbhLFIyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239749AbhLFIyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:54:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B48C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 00:50:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DC69B8104A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 08:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFC3C341C2;
        Mon,  6 Dec 2021 08:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638780639;
        bh=nu9G/ebYTcjspMw8ipenDK/HZMD2txlYmwKe8/Ph1NU=;
        h=From:To:Cc:Subject:Date:From;
        b=sqidPrZGqSQjPu1EK/QH1ZSYAOp6ne+nNi9NC0fIo11vJghU20Bm6PNGPZFmvwsmD
         HpGob1iMajIeFk9cDM3W1OpDE5FKj4BkoSMCKkVuHA4f0SJrrv/7drUQAY6tFlesQQ
         88riRqdRU5bobqk0uJ2vf6sA+bNJAPNw3fxAVFlJfDT8aZZAUr8LRQ3vOcATpRv55E
         MhkWj6ivTXiece8F/lVSzuycaToYHxjh4eptwskzx/22ze0SfZNi/YCBlMUWcoWzpf
         d3Eqe0/raR5EoSQJ5hPbhQ1PgZkDzbaPmiJRxTnxOyx+K0mKLkY8Y2u8Tbfnm5WcM6
         /Dae85bmOnx7Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] virtio: always enter drivers/virtio/
Date:   Mon,  6 Dec 2021 09:50:18 +0100
Message-Id: <20211206085034.2836099-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When neither VIRTIO_PCI_LIB nor VIRTIO are enabled, but the alibaba
vdpa driver is, the kernel runs into a link error because the legacy
virtio module never gets built:

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

When VIRTIO_PCI_LIB was added, it was correctly added to drivers/Makefile
as well, but for the legacy module, this is missing.  Solve this by always
entering drivers/virtio during the build and letting its Makefile take
care of the individual options, rather than having a separate line for
each sub-option.

Fixes: 64b9f64f80a6 ("vdpa: introduce virtio pci driver")
Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
Fixes: d89c8169bd70 ("virtio-pci: introduce legacy device module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index be5d40ae1488..a110338c860c 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -41,8 +41,7 @@ obj-$(CONFIG_DMADEVICES)	+= dma/
 # SOC specific infrastructure drivers.
 obj-y				+= soc/
 
-obj-$(CONFIG_VIRTIO)		+= virtio/
-obj-$(CONFIG_VIRTIO_PCI_LIB)	+= virtio/
+obj-y				+= virtio/
 obj-$(CONFIG_VDPA)		+= vdpa/
 obj-$(CONFIG_XEN)		+= xen/
 
-- 
2.29.2

