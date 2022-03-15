Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764124D9C09
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348618AbiCONWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiCONWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:22:19 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049B73BA56
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:21:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id t5so19644434pfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wistron-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=U8P88lCh/VwB2wUul8vJe/3MyhfV7Zsin+/7eQmPKwE=;
        b=CGNQE+Y7o6dJhK3Ix3rctbGZ3d7y/SZinSIvHEqwYEbv0L7LoDn+ercdgfN/W+ZgQy
         7JFKUiGx8JCTdQik3W60vE1OrEqjjYaMdJ5E6Jk9T4GZwdTvGEhSG6LLMx1jTcudPd2f
         tKBYNDjpqijSWglvm0zpj/Yiz/tec1ViKhxvkvHruZrsV77kj54np315IZoWtZ5nZCwn
         tkBGm67+CMaeBIdRxF4eCRjGpR7toHHIuIRw986IFaW0WurEB1K+pBC0vWDLQvSGUnk3
         hIzKfUv90b0FLO2bJETZYP5sjj9AMzpsnicpI/59dOhp/+z9SuWNKyDHQD1cpB/1MQNK
         1okA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U8P88lCh/VwB2wUul8vJe/3MyhfV7Zsin+/7eQmPKwE=;
        b=axTeKWxFobg5rUdnNmoW183kuD6ul5EaZ1Ms9FRPs4Ltu1DTK2WkizXMMml+Q2Xas4
         83aQQhrV3klLL0bROECSXQ0M3Fu/e0aLL0Y7a47DWpfoX5STCLYlKRfrEOUdp+RFDAn5
         nVsgJPj14q1Drj6CjwhcRUiPne/q0a461znWunzq2T9iilu6YRjvK37ZiukyeWWoh+sX
         TC6GGDZrd5CyB2H7oR4d+TfAbGCgMisnxRuCIZNAX8x8lxTI+vW5gy9gA4RW7OwUzsJt
         2LHkLW4RqT7DSAtPDw+dq1j/7dmywGQVXKb6PNqEv/Gxo2mB/q88yGkqRvNIZNtSDDSh
         ENQg==
X-Gm-Message-State: AOAM532SA5zKdsUblhILSHFQx8Sf16O+6epPUC4MR90cJCx+jhF2adkB
        pmWsb/yMVX4P4a0ru2+QiBRmzPQiMJUz6w==
X-Google-Smtp-Source: ABdhPJyhzBKkWPvMhy/74LFEX3gJL3CN4TZBwIzQE+DlCZozw2t3UHKFnBLVOMEQZbyh7TivzeRfeQ==
X-Received: by 2002:a65:6951:0:b0:381:f10:ccaa with SMTP id w17-20020a656951000000b003810f10ccaamr17361593pgq.587.1647350466322;
        Tue, 15 Mar 2022 06:21:06 -0700 (PDT)
Received: from localhost.localdomain (60-251-182-145.hinet-ip.hinet.net. [60.251.182.145])
        by smtp.gmail.com with ESMTPSA id a22-20020a056a000c9600b004f7b8b3a44csm11589987pfv.29.2022.03.15.06.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 06:21:05 -0700 (PDT)
From:   Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@fb.com, kbusch@kernel.org, alsa-devel@alsa-project.org,
        Mark_Hsieh@wistron.com,
        Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
Subject: [PATCH] [v2] nvme-pci: disable write zeros support on specific SSDs
Date:   Tue, 15 Mar 2022 21:20:59 +0800
Message-Id: <20220315132059.12747-1-mark_hsieh@wistron.corp-partner.google.com>
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

