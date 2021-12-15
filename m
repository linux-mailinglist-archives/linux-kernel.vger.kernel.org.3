Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36B74754F1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 10:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241080AbhLOJQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 04:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241064AbhLOJQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 04:16:11 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4635C061574;
        Wed, 15 Dec 2021 01:16:10 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id m25so21085895qtq.13;
        Wed, 15 Dec 2021 01:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RYeDCzkTqR8w02XopW3NZUvoT3MLoXV0cjz/EK2A9Iw=;
        b=LyhgNX0m0w54B7uxFXN0PQEdi83OE74cvQdMu1CpSURgFEfnj3+JXCfyKkhbRrNwHG
         27PDPWkussW5k1com1s3FgGNXTUYogzJAQJ3RRP27iNlzCOz9HTfZ6MdStsANWBiX33e
         I01R3z/ZfKOr7E69pKvFGdjbO+q4teTAiBaSXN6GtJdHDtwmDkqZCZKmA2ITdg4/kTgy
         A8m8H8nq1g5n09jGi24CXSlmK4hpufKPCmu1X9QNAQlxo8z213jGOJ72M36uiV+/NbVj
         Ekl5c25mvn2uowpfvKncG3nk7vcnm6iGo2Am5EnBblOYkSeB8Ni0uDnFX9iui0hcSoya
         REvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RYeDCzkTqR8w02XopW3NZUvoT3MLoXV0cjz/EK2A9Iw=;
        b=Vv52RehVCu3G4C1pZFiZGVW38Vy/D5syYhCjWRIYWySfc9OzwzPeiQlXxpD1xFycF7
         Xf3UznvO3nKeQL3p4zMdzMX7HemuBcc9hBWXsMWYpBYJpy3Y/Gm9SVyCKkRdxmU+HVSJ
         tzK9+K54tZnvILu5hwh2fDWXb48CWRExrRky0bFmsHcquAvPJNA17KQjqkPz09PKzJVl
         rr/kh6X/49K2XwfdN6Bf3CQs/wVaWnte1uuNdGfAMn9GwlPDbUUcTPjMirTOJXk2E/I7
         UF3g7xnbfFDS63duAPNTYc0UQ6lC3D+VvehDBi6O1HZIektGVgI46QMKszBOoLD4tpwm
         ZhCw==
X-Gm-Message-State: AOAM530pmB6XJCDQBy+Sj5go5Cz7EUR+vzMSaTUbKai2T8hjsweZGtdf
        tR9Dl1LeKmrFDXzr7UOyL75bVbhKFuY=
X-Google-Smtp-Source: ABdhPJyRpJn1IDfLHPbInYijMkz7jBmtKcQ9FRTV8c2pICByzL6wXTmOLOWQiwhCwLoUNogP06UKOw==
X-Received: by 2002:ac8:5e07:: with SMTP id h7mr10946388qtx.422.1639559770037;
        Wed, 15 Dec 2021 01:16:10 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 196sm727407qkd.61.2021.12.15.01.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 01:16:09 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     mathias.nyman@intel.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] xhci: use max() to make code cleaner
Date:   Wed, 15 Dec 2021 09:16:02 +0000
Message-Id: <20211215091602.445009-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Use max() in order to make code cleaner.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/usb/host/xhci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index f5b1bcc875de..dc357cabb265 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4998,10 +4998,8 @@ static int calculate_max_exit_latency(struct usb_device *udev,
 			enabling_u2)
 		u2_mel_us = DIV_ROUND_UP(udev->u2_params.mel, 1000);
 
-	if (u1_mel_us > u2_mel_us)
-		mel_us = u1_mel_us;
-	else
-		mel_us = u2_mel_us;
+	mel_us = max(u1_mel_us, u2_mel_us);
+
 	/* xHCI host controller max exit latency field is only 16 bits wide. */
 	if (mel_us > MAX_EXIT) {
 		dev_warn(&udev->dev, "Link PM max exit latency of %lluus "
-- 
2.25.1

