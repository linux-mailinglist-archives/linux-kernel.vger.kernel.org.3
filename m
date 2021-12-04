Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0121546883C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 00:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbhLDXYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 18:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhLDXYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:24:34 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02314C061751;
        Sat,  4 Dec 2021 15:21:08 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j3so13969399wrp.1;
        Sat, 04 Dec 2021 15:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vmhLeOr94OYlbQhipNIZ1kv4mnRG0TgvipPVx8r866Y=;
        b=RInm1Q/N3j6EcqmgREZi7vD2tPFV7rFOfP2Lea1HDh/SYi0DcXRlHmLpzoMjLcAzj4
         sZXygngRcUGxlUzuBS8KMQ+bY432IIe5YxzUnDuvg5FPnCKlifEGenXKfGSkFQ7BDvcX
         TqBr2CbjPyqoLvUW9V4Bdz2U8CsSy8r8g2LFhqVTFza6Q9hKGOTn5p6vATf72xGcPSy5
         DLxi8lOwFLy7k/rbGDcrzaxFTp4zfHfoeh7jb0ltKldUyjMO0vYI0zQ6TICYYP9bD/Y+
         Jdhsez8lrkwgHEan5blGE4TjhzuxS9ngscmROTyzdaIBHUBlZBWNiC36qhppemrZiOdk
         ubAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vmhLeOr94OYlbQhipNIZ1kv4mnRG0TgvipPVx8r866Y=;
        b=fZHch6rlbI/VnbdMN88pqUxn7gyjw2DLCwNC3aKXZotx7b/61SYOr0Q8h+nvuyMqi4
         sS8SiWG/ZDvo67pnSZYhB2EuoAwA77fmkiFc0RsU6VtfGK1aEBN+VgBmHWWOMZMrURH+
         rELcUktsQF338BZVUeOP1llFlXVf+a1iebtFHHve+R7bguA5wu4p7PzneAgE7J2UsVf1
         ItqWO4S8jhLxErtGoBy56WsBFNQlHR+WAumYjPPCby2PrvPZvjRus7r//lOtJ/kKu6yT
         671xf+6L8e+lQsXYxRFzXbvC0VxC2M9reHAyzBCZpXSgS/qiZ4xpSTEcS6AIW0D0DeI6
         ygog==
X-Gm-Message-State: AOAM532zVKhJ8DcscAR56o8+aRrnqO+k34TAEb4sPE0hzv9lEaogQJKV
        Sgy8u2r4aWEONqxj6riK8eg=
X-Google-Smtp-Source: ABdhPJwK0MCKKGrmYg0/9KFK32EssuGrvF1rMUeX+2SA3jvpySxX91heEhKCNGH76NX7DorbXIEsYg==
X-Received: by 2002:a5d:6e04:: with SMTP id h4mr31041542wrz.127.1638660066603;
        Sat, 04 Dec 2021 15:21:06 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p2sm9290881wmq.23.2021.12.04.15.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 15:21:06 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: tee_bnxt: Remove redundant assignment to variable nbytes
Date:   Sat,  4 Dec 2021 23:21:05 +0000
Message-Id: <20211204232105.31114-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable nbytes is being assigned a value that is never read, it is
being re-assigned in the next statement. The assignment is redundant
and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/firmware/broadcom/tee_bnxt_fw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
index a5bf4c3f6dc7..6d92ec02f2c7 100644
--- a/drivers/firmware/broadcom/tee_bnxt_fw.c
+++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
@@ -143,8 +143,6 @@ int tee_bnxt_copy_coredump(void *buf, u32 offset, u32 size)
 	prepare_args(TA_CMD_BNXT_COPY_COREDUMP, &arg, param);
 
 	while (rbytes)  {
-		nbytes = rbytes;
-
 		nbytes = min_t(u32, rbytes, param[0].u.memref.size);
 
 		/* Fill additional invoke cmd params */
-- 
2.33.1

