Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9084D997E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346680AbiCOKt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348451AbiCOKt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:49:27 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50EB517EB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:47:09 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id a5so18993102pfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wistron-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=L0zB6xiTLN7TUWW0GnFoc7P7DsjjNa+huYBviFNpk/k=;
        b=kurHOyncJijHKQ/3NU/w4TnCG4BMWG7pbxNOcYWuXQ/xXSBjk8A4LBzinXx6+nXYo8
         ddg5aBlyeH2nOKElyxrDjgcTu9bP5Uu9tFZ1sbRaIFmrLJtvQYtd9W8WJ97iLZ64r+nB
         WxSa+5pA6UakEfS4S8StqdQNAtzBK7VQtx8gp0pBDetC/cgD5BHm0tZx9yUgrUkvCVhL
         kr6symltjySqL7Cwfx6URza/fxWatbf50CmTo3HDDxE2a7Q6CY13J0T542TeVSThMAzF
         3bUIpiSW5KL9MAIdFZkpjCi9fPQRtWiicn8HwyFBIoI0+wCIqngNm76PmSf2VdUhnK2W
         1rFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L0zB6xiTLN7TUWW0GnFoc7P7DsjjNa+huYBviFNpk/k=;
        b=8D3IE3mJM3GpZa4Y7f7bHj0T/ZjAqP5RGuZsa5JH/D7DwCl/GCnYlNQakIUU9e4qzK
         QvEGPfwNybgz7xPReBwtPIZCcsM9wo9RmeYw341pYq/GE2HjOUCjdPhgyPESxBN2aQPJ
         Lp1x+7UbSrd2ujWCEg+RhViVcWRVIdIony3aD92Cxp8yvhuL8rstQP5zQO3G2zuqsPiz
         jvtmTL16wEA8IaiSAXOat5H14ctaRJzP3nJo/5NjphlVg/JudJOqo6sQ84aJ3OxX19d5
         TZQOYbQR4Ffbocmf4IVDEpy0RvBTlSdRpIftbweOQ0M7pS+YzbcC3SvvPThy6oqR6PJy
         P9hg==
X-Gm-Message-State: AOAM530qFvevQfEiIl4lYXkEmkI64a9Q/ll58I+H/A86hR/7Pr+Uyjdg
        r1DTS5UadvIq6b5w3ohkx9mwGq78YbPrCQ==
X-Google-Smtp-Source: ABdhPJxA2V6ApdodQ8a2vNaSyz81PLMVWnDWdh3IHXNxCSKTXOy7wpqb+nBs6S14gJeSDmqUCo2VtQ==
X-Received: by 2002:a62:7793:0:b0:4f6:27a8:ae6d with SMTP id s141-20020a627793000000b004f627a8ae6dmr28183056pfc.65.1647341227975;
        Tue, 15 Mar 2022 03:47:07 -0700 (PDT)
Received: from localhost.localdomain (60-251-182-145.hinet-ip.hinet.net. [60.251.182.145])
        by smtp.gmail.com with ESMTPSA id il7-20020a17090b164700b001bfc017a0adsm2740346pjb.37.2022.03.15.03.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 03:47:07 -0700 (PDT)
From:   Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@fb.com, kbusch@kernel.org, Mark_Hsieh@wistron.com,
        Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
Subject: [PATCH] nvme-pci: disable write zeros support on specific SSDs
Date:   Tue, 15 Mar 2022 18:47:02 +0800
Message-Id: <20220315104702.20798-1-mark_hsieh@wistron.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
Write Zeroes command"), Micron has the same issue:
[ 6305.633887] blk_update_request: operation not supported error, dev
nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0

So also disable Write Zeroes command on Micron.

Signed-off-by: Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
Change-Id: Ic6ebfe141702d1869490bbf210627055b5b4d80f
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a7a502a5b2b5..68745e1d7b6a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3245,6 +3245,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x2646, 0x500d),   /* Kingston OM3PDP3256B-AH 256G */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x1344, 0x5411),   /* Micron 2450 MTFDKCD256TFK 256G */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
-- 
2.17.1

