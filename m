Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B714E4EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbiCWJLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiCWJLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:11:35 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C443958E4F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 02:10:03 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KNjBj2pW5zBrft;
        Wed, 23 Mar 2022 17:06:05 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 23 Mar
 2022 17:10:00 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <pierre-louis.bossart@linux.intel.com>, <lgirdwood@gmail.com>,
        <ranjani.sridharan@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, <daniel.baluta@nxp.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <peter.ujfalusi@linux.intel.com>,
        <sound-open-firmware@alsa-project.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <limingming.li@huawei.com>, <tangyizhou@huawei.com>
Subject: [PATCH -next] ASoC: SOF: Intel: Fix build error without SND_SOC_SOF_PCI_DEV
Date:   Wed, 23 Mar 2022 17:25:01 +0800
Message-ID: <20220323092501.145879-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If SND_SOC_SOF_PCI_DEV is n, bulding fails:

sound/soc/sof/intel/pci-tng.o:(.data+0x1c0): undefined reference to `sof_pci_probe'
sound/soc/sof/intel/pci-tng.o:(.data+0x1c8): undefined reference to `sof_pci_remove'
sound/soc/sof/intel/pci-tng.o:(.data+0x1e0): undefined reference to `sof_pci_shutdown'
sound/soc/sof/intel/pci-tng.o:(.data+0x290): undefined reference to `sof_pci_pm'

Make SND_SOC_SOF_MERRIFIELD select SND_SOC_SOF_PCI_DEV to fix this.

Fixes: 8d4ba1be3d22 ("ASoC: SOF: pci: split PCI into different drivers")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 sound/soc/sof/intel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index b53f216d4ecc..172419392b33 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -84,6 +84,7 @@ if SND_SOC_SOF_PCI
 config SND_SOC_SOF_MERRIFIELD
 	tristate "SOF support for Tangier/Merrifield"
 	default SND_SOC_SOF_PCI
+	select SND_SOC_SOF_PCI_DEV
 	select SND_SOC_SOF_INTEL_ATOM_HIFI_EP
 	help
 	  This adds support for Sound Open Firmware for Intel(R) platforms
--
2.31.1

