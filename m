Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2235094AB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 03:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383650AbiDUBmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 21:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiDUBmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 21:42:21 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A62F1573F;
        Wed, 20 Apr 2022 18:39:33 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id h1so3575348pfv.12;
        Wed, 20 Apr 2022 18:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3QEbTDGt0straKhpg0rCVQsn/f1GRvKcTRPt9MLhJp8=;
        b=khRCXpbeiyPHSr2v/FRQdVI8sk/HqMJlhF9DAae8Xx2t0mow7AueRwPP7Uiwcm8/rh
         i8rH7xdFsZLoaRUrjYENscZ1B9YlIT++isPeNo3qcH7GtwoVzHIWUJ4L6RInCLo+uItL
         pO6+gEE80DJy6Fjhd97hwJcWKMpEPCPdo9Z4FLd5M/2sU9dCI8VE4LAQKh+Hh/ySZEvH
         Yk/zwTQMXtpmdWKqbA9irdj4EBQNtmnH3jO78q6+oVkkyKcsM5/oZLQsMFLfH2uCyeeb
         QvEdvlOqM+Y+39meUWrtXbOYEltjxyc4VySIvN0qkh/F/qOvhKI5A6Fgd+fIAKibWyhx
         74MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3QEbTDGt0straKhpg0rCVQsn/f1GRvKcTRPt9MLhJp8=;
        b=lpuEIsyErNnkx8Ki28GPLCPNUSOWwngBQDiEvzsBazX0nTfWmCQMYxNFq78xO5yGM6
         R0nmQ2vTNYYhWjC8qIdFj0A1EKvOBTnKzHZv0/jML8S2PTL+Nrr4tU1AKlA/lDTbZXK2
         12XKefE4OtwJowXsd/5rWMNPlEa2uS269lxkbtFUyFWdwHCFF8+XCh6M8HmbYLIcuDjd
         peV/NZjdZakfgLC7wwmObyQLGF0nvs287RPDa7KeIlWO26vz4VP5cSwqzhVHO2EhUm0K
         lYuDsJ1FoLwDvjqS/zYJoMf7xEGs1ysDMmEclHdR7TdFkH/9eSEygJ5aL4tmcM8o+WP/
         dhuw==
X-Gm-Message-State: AOAM533HfwbzSNomof1BU+BsNWcgWls2foKM7IMLKuqJav54qkOI1LiK
        /epdj1GYEO9wyvhM/bt7mw==
X-Google-Smtp-Source: ABdhPJzw97Gew3BX5ppWVOA2Cb4I10yy5UlhXZ40jaN7QzCLCI/cnl6aEabedyKtAveXXU3EQlstSQ==
X-Received: by 2002:a05:6a00:1702:b0:50a:8181:fed3 with SMTP id h2-20020a056a00170200b0050a8181fed3mr16352907pfc.60.1650505172801;
        Wed, 20 Apr 2022 18:39:32 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id m13-20020a17090a34cd00b001cd4989ff64sm444285pjf.43.2022.04.20.18.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 18:39:32 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     s.shtylyov@omp.ru, damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v2] ata: pata_marvell: Check the 'bmdma_addr' beforing reading
Date:   Thu, 21 Apr 2022 09:39:20 +0800
Message-Id: <20220421013920.3503034-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before detecting the cable type on the dma bar, the driver should check
whether the 'bmdma_addr' is zero, which means the adapter does not
support DMA, otherwise we will get the following error:

[    5.146634] Bad IO access at port 0x1 (return inb(port))
[    5.147206] WARNING: CPU: 2 PID: 303 at lib/iomap.c:44 ioread8+0x4a/0x60
[    5.150856] RIP: 0010:ioread8+0x4a/0x60
[    5.160238] Call Trace:
[    5.160470]  <TASK>
[    5.160674]  marvell_cable_detect+0x6e/0xc0 [pata_marvell]
[    5.161728]  ata_eh_recover+0x3520/0x6cc0
[    5.168075]  ata_do_eh+0x49/0x3c0

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---Changes in v2:
    - Delete the useless 'else'
---
 drivers/ata/pata_marvell.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index 0c5a51970fbf..014ccb0f45dc 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -77,6 +77,8 @@ static int marvell_cable_detect(struct ata_port *ap)
 	switch(ap->port_no)
 	{
 	case 0:
+		if (!ap->ioaddr.bmdma_addr)
+			return ATA_CBL_PATA_UNK;
 		if (ioread8(ap->ioaddr.bmdma_addr + 1) & 1)
 			return ATA_CBL_PATA40;
 		return ATA_CBL_PATA80;
-- 
2.25.1

