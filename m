Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1599A47A8C6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhLTLeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhLTLeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:34:04 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82018C06173E;
        Mon, 20 Dec 2021 03:34:04 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id t83so8978359qke.8;
        Mon, 20 Dec 2021 03:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b11GC6J4naFP7ut6C4B/nZYlxhKbFfvvWnmwwNFdTEU=;
        b=Rp2GrJE4cRgLy6yNipKkd3fxMoKIHtY0SSxIs2HM6VKTjDnwNl8qeEluaXwGN3gI2K
         xOESW+kxNRZRpVH+N52Msy8c0emSegLQuLI9Z2NGj5KZTKdoOU5flhxWRO9CzGPFYEyz
         AbQ+vWaHfRZjVNNUP+lTsBbizarZX0EbqfaHly1uF8PaBEt8PG0pWIlg5QhN5fAopxS7
         kHvTP0uvm6eG4LLoD45OZKyoN+YE5SjfuhCuZt+3WNlxBQd7Ho1D+iN6z2nH5P1HSS07
         7FpzB90kivqQFjr3DiTvgdyiD9/UpZh6zngvVX1Sfi44sq1F9Da1/e3LrIRtsMxsQXx/
         IJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b11GC6J4naFP7ut6C4B/nZYlxhKbFfvvWnmwwNFdTEU=;
        b=mey7fm8e6g8qWyXO3VQvG6KYUnaNDyJmQm1udf5ydQu/kuC8n7CBT34a/+Ebn/fUJk
         91vrtgvFFarMEFN1n5n3VGpGOFqJDdFXk0S6yaXMPPL/ezPvShrKBTQjjSwr9T6VZkB3
         /QKlX6ISeJ2r7ljwHleNoDpyUeL97awYE+FvMhIgI6yGEUI7e2sjhBmHstFaQt4gi8MB
         lGaJkoXCfrI8XZM/4AV2Drv+edr8yeWjWGggizM7hzFVnuYwxfez+wrNhd2EY/XVEr9/
         w9JTWs5gnXnVKUKPpfnmmX8JQ9TtyKw9vKkvukNt2tUYaRKxiGZy61cQvsvAYNG/Kihx
         mCEg==
X-Gm-Message-State: AOAM5307LsW4tSQ5ijBJN6axHlcnedTzULBE7Ky/NqQ07Vdu4Y1OWxLP
        BUizAf9dOTvioD1tspgC6sA=
X-Google-Smtp-Source: ABdhPJy6WAwqT1a4mQNzGvF0P80VcjecEaXKV/165KhWgRLWo3jomZsvO8M5GJ+IE0tGz62vm5C+ng==
X-Received: by 2002:a37:716:: with SMTP id 22mr9196462qkh.674.1640000043705;
        Mon, 20 Dec 2021 03:34:03 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id br13sm11602405qkb.10.2021.12.20.03.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 03:34:03 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] libata: use min() to make code cleaner
Date:   Mon, 20 Dec 2021 11:33:58 +0000
Message-Id: <20211220113358.472974-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Use min() in order to make code cleaner.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/ata/libata-scsi.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 313e9475507b..0dc849415e3a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3591,10 +3591,7 @@ static int ata_mselect_caching(struct ata_queued_cmd *qc,
 	 */
 
 	if (len != CACHE_MPAGE_LEN - 2) {
-		if (len < CACHE_MPAGE_LEN - 2)
-			*fp = len;
-		else
-			*fp = CACHE_MPAGE_LEN - 2;
+		*fp = min(len, CACHE_MPAGE_LEN - 2);
 		return -EINVAL;
 	}
 
@@ -3647,10 +3644,7 @@ static int ata_mselect_control(struct ata_queued_cmd *qc,
 	 */
 
 	if (len != CONTROL_MPAGE_LEN - 2) {
-		if (len < CONTROL_MPAGE_LEN - 2)
-			*fp = len;
-		else
-			*fp = CONTROL_MPAGE_LEN - 2;
+		*fp = min(len, CONTROL_MPAGE_LEN - 2);
 		return -EINVAL;
 	}
 
-- 
2.25.1

