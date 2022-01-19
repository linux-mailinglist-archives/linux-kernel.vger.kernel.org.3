Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4270493864
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353619AbiASKZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:25:50 -0500
Received: from mail-m972.mail.163.com ([123.126.97.2]:28107 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353586AbiASKZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:25:49 -0500
X-Greylist: delayed 792 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Jan 2022 05:25:48 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=MyVyh
        UzHDpS+tQkN7XqEyXNW73XLWBRPypfXZLk+yDs=; b=QHgj9xcB3jb1h2aGKGgP4
        6c3+5hgRfaIkJt+tme80I2GFXRRYL1e0Sz32Vpy1GFQjxJ+QZJ4REe2pWzQnLEPP
        U+ZbnddH8VFaKXnWCCxZSY0qN0z5ppXv0yH8zhB7pnSmFunzOeBQgNzoh/pAomIw
        oQZbsZ6XyU3AvjG0Bd6SIM=
Received: from localhost.localdomain (unknown [112.97.57.111])
        by smtp2 (Coremail) with SMTP id GtxpCgDnaK0b5+dhP3MFAw--.8215S2;
        Wed, 19 Jan 2022 18:25:32 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mani@kernel.org, hemantk@codeaurora.org,
        thomas.ulrich@thalesgroup.com, gregkh@linuxfoundation.org
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH net] bus: mhi: Add mru_default for Cinterion MV31-W
Date:   Wed, 19 Jan 2022 18:25:19 +0800
Message-Id: <20220119102519.5342-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgDnaK0b5+dhP3MFAw--.8215S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw4xuw1rAFyxtF4xtr4rGrg_yoWDWrX_uw
        sxWFsruwsxWr90kwn2va1rA3yFy3WxuF1kA3WktFn8t347ZwnFvwnYqFZYyFn5uF43uF9r
        J3s5uFy5Zw1avjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUVMNUUUUUU==
X-Originating-IP: [112.97.57.111]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiJRyNZGAJmFxP5wAAsV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For default mechanism, product would use default MRU 3500 if
they didn't define it. But for Foxconn SDX55, there is a known
issue which MRU 3500 would lead to data connection lost.
So we align it with Qualcomm default MRU settings.
We also validate it with Cinterion product and find it also
works.

Fixes: 87693e092bd0 ("bus: mhi: pci_generic: Add Cinterion MV31-W PCIe to MHI")
Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/bus/mhi/pci_generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
index 3a258a677df8..79c16b2a52c7 100644
--- a/drivers/bus/mhi/pci_generic.c
+++ b/drivers/bus/mhi/pci_generic.c
@@ -401,6 +401,7 @@ static const struct mhi_pci_dev_info mhi_mv31_info = {
 	.config = &modem_mv31_config,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
 	.dma_data_width = 32,
+	.mru_default = 32768,
 };
 
 static const struct mhi_channel_config mhi_sierra_em919x_channels[] = {
-- 
2.25.1

