Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78080545C32
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 08:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243737AbiFJG1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 02:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238058AbiFJG1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 02:27:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C8F232AE5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 23:27:46 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j7so23237345pjn.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 23:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lcfc-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=rlV3dIPvaKWA7+M0tIEoBUCgebgsvn7zaaO4PhXs6fo=;
        b=cARfW3uLjeQWAfAbHIi6Ol7bEqyyKoi+dfCFzQiA01cojWhIgATxAC/3wlr5O5re8X
         +Oz9G9wb8sJMLPIhnNggbv2fYJLUkwFcpEwGf15j2RYkPHNDBKuCQnEnF2bka/JLhSSh
         0KH4QRk5hfj7B+EZlawiLKwxU9etmj5jhIX4wUYipgPoTTNMWVzpdtQ4PqswjI0SLpf2
         ta1hvSqO8qgQQ7nThc7Zc5ojC7ghurxUWUQ6RjNNCJZig9JfXumQBYKmtonIfmH8BT/R
         G5tpSWg94QIuctDowK6S6+bGkE8hl2rXet1AWhCPbh/+vTO7EwII1Y1Knwvt5f65NSOQ
         9WVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=rlV3dIPvaKWA7+M0tIEoBUCgebgsvn7zaaO4PhXs6fo=;
        b=eA6SP81wNiAoc+Tp3ZIY2kVEkJD0pjtC4uVurFtMCBLiOvMTBR6GPiijMXuBvKo6nM
         3jMBLO765Dl8TIXx7M37/Tby3lGXtVD+wYWtzpO7jc+RpRBM+NngBr2jaVhMCqSiWrN9
         YBpw0/jR+nk+0Vj6v6oGlXDeth7J3IBDs+O/msL0iKR3lO1XSzW+8BQklAsvsjnaP/mr
         hJBmrtXPd4MZhiawpq9H4qAYII6euFK3+XVtoP1aJh09IbJBb6u//4e8qHVqhBEFLuEF
         GRHBjdLgCohprrB0pyKSAxnPZRJzOPhvvzCy3NBTTExanr4KYdV0YH/PBYeKnRUXctqg
         9WJg==
X-Gm-Message-State: AOAM530qStz2UmsEfE8Djd6oSNqN9JHONTIpjWDYh0A+83p2RLZBcfki
        g7RIQhxR7AZBA+MjjrODA21SZg==
X-Google-Smtp-Source: ABdhPJy+HnP1U3vBdekMtJ7cnKxj2DpnCawinXE+s2NcRqUQ2jTvUOyjZgC944UNKUxZxK/MFa3N1g==
X-Received: by 2002:a17:90b:1e47:b0:1e6:7d04:2f4 with SMTP id pi7-20020a17090b1e4700b001e67d0402f4mr7100684pjb.93.1654842466115;
        Thu, 09 Jun 2022 23:27:46 -0700 (PDT)
Received: from rasheed-i7-P52.LCFutureCenter.com (211-23-25-187.hinet-ip.hinet.net. [211.23.25.187])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090a578400b001dc37aef4ffsm817511pji.48.2022.06.09.23.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 23:27:45 -0700 (PDT)
From:   "rasheed.hsueh" <rasheed.hsueh@lcfc.corp-partner.google.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rasheed.Hsueh@lcfuturecenter.com, wuxy23@lenovo.com,
        gwendal@chromium.org, rasheed.yh@gmail.com,
        "rasheed.hsueh" <rasheed.hsueh@lcfc.corp-partner.google.com>
Subject: [PATCH v1 1/1] nvme-pci: disable write zeros support on UMIC and Samsung SSDs
Date:   Fri, 10 Jun 2022 14:27:34 +0800
Message-Id: <20220610062734.9927-2-rasheed.hsueh@lcfc.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220610062734.9927-1-rasheed.hsueh@lcfc.corp-partner.google.com>
References: <20220610062734.9927-1-rasheed.hsueh@lcfc.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
Write Zeroes command"), UMIS and Samsung has the same issue:
[ 6305.633887] blk_update_request: operation not supported error,
dev nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES) flags 0x0
phys_seg 0 prio class 0

So also disable Write Zeroes command on UMIS and Samsung.

Signed-off-by: rasheed.hsueh <rasheed.hsueh@lcfc.corp-partner.google.com>
---
 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 48f4f6eb877b..cddafeaa9fe2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3453,6 +3453,14 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x144d, 0xa80b),   /* Samsung PM9B1 256G and 512G */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x144d, 0xa809),   /* Samsung MZALQ256HBJD 256G */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x1cc4, 0x6303),   /* UMIS RPJTJ512MGE1QDY 512G */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x1cc4, 0x6302),   /* UMIS RPJTJ256MGE1QDY 256G */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x2646, 0x2262),   /* KINGSTON SKC2000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
-- 
2.17.1

