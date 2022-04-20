Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE215087FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357473AbiDTMYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353164AbiDTMYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:24:32 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D10E31DC4;
        Wed, 20 Apr 2022 05:21:46 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p3so438719pfw.0;
        Wed, 20 Apr 2022 05:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PnY2RV2uT4v9sH336lb/RKV9xcdjUoGG2IsZ0A8hZGA=;
        b=NyxvwoA0HdhUbVFKo9pXR5aK1iHlUBqWbkgmQ9X/YcB5oA/dCnltiFNfCliSGglHp6
         ZlpzzoQa81EGUrgVeDD0bms5/g0ArBFtf51rRV+AH7cyLWVVl6SSpCS3UCMmS/MNy/p9
         ABm61uCOBfNfUbIMHvQHzDzBcnr3kF95b27ey6dAYvNa1FIhcg+D+691QyVx5cmO7HHZ
         +R0eNaw2/KEHmhIpPI5PafYjP4SvkdqTp26+0qE4IGupcJKV4mBQwJk1XCxlZZKj11B6
         G/LhdFR23rOepiNJH6CShm4EOVt7IKgFOJKymTD0jZLAlUYL840mV3AbrzAL42dactjY
         fSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PnY2RV2uT4v9sH336lb/RKV9xcdjUoGG2IsZ0A8hZGA=;
        b=FelATS8AW9UpgzAABW3YKwX7nahHqhh2aOUd6PnKrryRjsezrgWGCn34k4HhJga5Cl
         ArTYUsftg/k0WaNeUT8n31k+L3vy8Xc0SWn4/NEWho42+VctUj10ys9nBDrMP4TYvp1i
         zjrM7y4ZThtJ+B9GXkgkjER4svJk9suTzKHAn4zL3akibpOaoDVzjqcPnmeLJE4j/wDT
         Gl80tVf1r/1xUkXz9T0724VuvMZxzU8lwlI3lW7QQkVzca67KaQyg3aGNTZfbdf085O1
         g1p2lg43Nxf3bKc87YXo40neSq6UBn/0bWydQb2e+GVr0zfdMF8P3zyYUj0Pt9M/pRwW
         dQsQ==
X-Gm-Message-State: AOAM5325SM391jqQ9FbmUOWxV1Zq02H6TdBcpYajrwW3AkpngQk0QPas
        OVpqdj8c2TI22zK0Tpgy2QybczUlO9shccw=
X-Google-Smtp-Source: ABdhPJyvCM410O7a/VsEoNc/ZVVieOGoOtu06BpBKyGtxUvTkqN1o9XGktLIG7VFqgBsnMGACXG1yw==
X-Received: by 2002:a63:224f:0:b0:399:4a1a:b01f with SMTP id t15-20020a63224f000000b003994a1ab01fmr19521638pgm.123.1650457306034;
        Wed, 20 Apr 2022 05:21:46 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id u7-20020aa78487000000b00505d9277cb3sm19480063pfn.38.2022.04.20.05.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 05:21:45 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     s.shtylyov@omp.ru, damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] ata: pata_marvell: Check the 'bmdma_addr' beforing reading
Date:   Wed, 20 Apr 2022 20:21:34 +0800
Message-Id: <20220420122134.430997-1-zheyuma97@gmail.com>
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
---
 drivers/ata/pata_marvell.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index 0c5a51970fbf..d2922699be5e 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -77,7 +77,9 @@ static int marvell_cable_detect(struct ata_port *ap)
 	switch(ap->port_no)
 	{
 	case 0:
-		if (ioread8(ap->ioaddr.bmdma_addr + 1) & 1)
+		if (!ap->ioaddr.bmdma_addr)
+			return ATA_CBL_PATA_UNK;
+		else if (ioread8(ap->ioaddr.bmdma_addr + 1) & 1)
 			return ATA_CBL_PATA40;
 		return ATA_CBL_PATA80;
 	case 1: /* Legacy SATA port */
-- 
2.25.1

