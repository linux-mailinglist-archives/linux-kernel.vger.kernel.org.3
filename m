Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B76249061E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbiAQKkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:40:53 -0500
Received: from mail-m974.mail.163.com ([123.126.97.4]:44280 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbiAQKkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yFV6Y
        NSi4Vb9QBZh0XwgcOfZ3owMie3kscsPISoVnHo=; b=m5i0JBosUPiN6c7QA3WQi
        a0iMo9B98P18WhvQCXanKYn+nkH3/nPFK58q1dOq0DKYMd8LgrarJ25Td5OkeT1I
        Cw9bb4PAu85f1Ci1hlm91bCeUbFvp42Y/2dKhh1MdlJhJvrFLaaM/27nW1s3uU2j
        ieVVXQqoqMtVkL3cbIBc1A=
Received: from localhost.localdomain (unknown [112.97.53.17])
        by smtp4 (Coremail) with SMTP id HNxpCgAnPPyYR+VhcIvZAQ--.302S2;
        Mon, 17 Jan 2022 18:40:26 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mani@kernel.org, hemantk@codeaurora.org, jarvis.w.jiang@gmail.com,
        loic.poulain@linaro.org, thomas.ulrich@thalesgroup.com,
        gregkh@linuxfoundation.org
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH net] bus: mhi: Add mru_default for Foxconn SDX55 and Cinterion MV31-W
Date:   Mon, 17 Jan 2022 18:40:16 +0800
Message-Id: <20220117104016.23046-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgAnPPyYR+VhcIvZAQ--.302S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFWUJw47Wr1UJF4UCr13XFb_yoW8Gr48pF
        40vrWIyr4vqrWYqF4vk34kWFn5WanxGFy7KFZrK342yrn8Aa4qvFyqgw1SgF12qrWxXFWa
        yrn0gFZrXF1DXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UUKs8UUUUU=
X-Originating-IP: [112.97.53.17]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBrRqLZF75dU7ZwQAAsc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For default mechanism, product would use default MRU 3500 if
they didn't define it. But for Foxconn SDX55, there is a known
issue which MRU 3500 would lead to data connection lost.
So we align it with Qualcomm default MRU settings.
We also validate it with Cinterion product and find it also
works.

Fixes: aac426562f56 ("bus: mhi: pci_generic: Introduce Foxconn T99W175 support")
Fixes: 87693e092bd0 ("bus: mhi: pci_generic: Add Cinterion MV31-W PCIe to MHI")
Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/bus/mhi/pci_generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
index 3a258a677df8..b79895810c52 100644
--- a/drivers/bus/mhi/pci_generic.c
+++ b/drivers/bus/mhi/pci_generic.c
@@ -366,6 +366,7 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
 	.config = &modem_foxconn_sdx55_config,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
 	.dma_data_width = 32,
+	.mru_default = 32768,
 	.sideband_wake = false,
 };
 
@@ -401,6 +402,7 @@ static const struct mhi_pci_dev_info mhi_mv31_info = {
 	.config = &modem_mv31_config,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
 	.dma_data_width = 32,
+	.mru_default = 32768,
 };
 
 static const struct mhi_channel_config mhi_sierra_em919x_channels[] = {
-- 
2.25.1

