Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E3448F674
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 11:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiAOKy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 05:54:56 -0500
Received: from mail-m975.mail.163.com ([123.126.97.5]:30582 "EHLO
        mail-m975.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiAOKyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 05:54:55 -0500
X-Greylist: delayed 922 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Jan 2022 05:54:55 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/oWUz
        Z37QARouyTR+Z4mzpHTHtRRXJXnDqhNfwCrG0s=; b=B2TjhoCN1tbO5lxks4LFH
        vNfzSu9z5ECOxr778W4phv1xOLpWst3U8TsJ6beCgud2bohFI45CMDY6HFeuPJD4
        l2pgFJgg9wDgIn6MBbezn50UkPDFb9/QxcFSyRbM2I8SNO1hHlomfcJo63d7nSiM
        BleIfUxbfwOlhBucYson3o=
Received: from localhost.localdomain (unknown [112.97.48.74])
        by smtp5 (Coremail) with SMTP id HdxpCgD3yXBSpOJhkl+5AA--.19057S2;
        Sat, 15 Jan 2022 18:39:15 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mani@kernel.org, hemantk@codeaurora.org
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH net] bus: mhi: Add mru_default for Foxconn SDX55
Date:   Sat, 15 Jan 2022 18:39:12 +0800
Message-Id: <20220115103912.3775-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgD3yXBSpOJhkl+5AA--.19057S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw4xuw1rAFyxtF4xtF13Arb_yoW3trX_C3
        9xWFs7uws8Wr95Gwn2van5XryrK3WfuF1kZF1vqrn8J34avwnFqw1ktrZ5AFn0gFWYkF9r
        J34rWr1rAw1a9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU5fH5UUUUU==
X-Originating-IP: [112.97.48.74]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiJROJZGAJmBux2gAAsa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For default mechanism, product would use default MRU 3500 if
they didn't define it. But for Foxconn SDX55, there is a known
issue which MRU 3500 would lead to data connection lost.
So we align it with Qualcomm default MRU settings.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/bus/mhi/pci_generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
index 3a258a677df8..74e8fc342cfd 100644
--- a/drivers/bus/mhi/pci_generic.c
+++ b/drivers/bus/mhi/pci_generic.c
@@ -366,6 +366,7 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
 	.config = &modem_foxconn_sdx55_config,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
 	.dma_data_width = 32,
+	.mru_default = 32768,
 	.sideband_wake = false,
 };
 
-- 
2.25.1

