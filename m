Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6505547ECEF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 09:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351921AbhLXIDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 03:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351894AbhLXIDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 03:03:01 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330D9C061401;
        Fri, 24 Dec 2021 00:03:01 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o63-20020a17090a0a4500b001b1c2db8145so10933928pjo.5;
        Fri, 24 Dec 2021 00:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=D51fQZBhO4q4Cm0avYX+cRbtMjz2KAKj00r0OKNhh+I=;
        b=dyIA+Emu30lS2Bm4JS1H5P40bObwHMOsES8kEME4k7o6/eR/rWcf4uw9IB88/69uxx
         zCHSe2xT60P+k+dEzKr8hTRRI1m/tgbHxfOXMwZa5xpK/z77YhdFSymr0r3Pffoeu/GN
         0JnXBxug4CvaseqYJK876Iemsp4hRW1MhXOOYSCCnwQv0lSrANbIewTTxfmGgOVriaec
         QvTc7A7Z9nh0jde6WLBMX/PdG6kQBzCQT6sZ3IuQw53oL8lCDwpFGBv8hX65obbrQwUI
         o87tCaugDya9V5kSDQpKaKGnxZ0pLfSN3s16I9zJUylIWTHmP6bsEl436h2yJWmmkSW3
         aaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D51fQZBhO4q4Cm0avYX+cRbtMjz2KAKj00r0OKNhh+I=;
        b=2biJtrkSlOD3vmE55DAprxjifr2gMweJytG0fXSlWHh1hT2Ap5bvWnfgPLQWJF2k8N
         c3z15f2f1fmyPlnf8O58J6uiT1pDlrl6dH4WYuOflaXkp3I8056nVKH52Rj1cT34VaOn
         pSXg7VX8He7Yn8fb0UMXyGGVYtPssZkmXdeUTo8GMgCMhAsSSGE0V6bhiKSCUEJ5zDAI
         qrQuO1KL/XYixkHZi1jQsNd12Bb/hizI+M0o3SUYRytcd5+5P3VFnlDQITGGHAy2Jzi5
         dFktdYba/M2RWVdzIjw0ZITmt6LVowYXIWNWi20P9O3rRMF9nHKUT4iHJHFtgtOGswC4
         MAZA==
X-Gm-Message-State: AOAM5311R0WmEqml4BufhDJdl8DGkMgf9lDImsZPkfFT/de12qt2AzC4
        03OHMkrcShDy1LXW7hd3vgU=
X-Google-Smtp-Source: ABdhPJxoaVhLz1dHdGWLx6WfCTqHpPja6+nd2LL2ASNKv5c7phlV1gpVOsvAKfv4e9NF+CfxpUFf9g==
X-Received: by 2002:a17:90b:33cd:: with SMTP id lk13mr6884536pjb.35.1640332980695;
        Fri, 24 Dec 2021 00:03:00 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id w7sm6936640pgo.56.2021.12.24.00.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 00:03:00 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <rjliao@codeaurora.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_qca: Fix NULL vs IS_ERR_OR_NULL check in qca_serdev_probe
Date:   Fri, 24 Dec 2021 08:02:49 +0000
Message-Id: <20211224080250.3123-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function devm_gpiod_get_index() return error pointers on error.
Thus devm_gpiod_get_index_optional() could return NULL and error pointers.
The same as devm_gpiod_get_optional() function. Using IS_ERR_OR_NULL()
check to catch error pointers.

Fixes: 77131dfe ("Bluetooth: hci_qca: Replace devm_gpiod_get() with devm_gpiod_get_optional()")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/bluetooth/hci_qca.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index dd768a8ed7cb..a6957447a7b3 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2056,14 +2056,14 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
-		if (!qcadev->bt_en && data->soc_type == QCA_WCN6750) {
+		if (IS_ERR_OR_NULL(qcadev->bt_en) && data->soc_type == QCA_WCN6750) {
 			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
 			power_ctrl_enabled = false;
 		}
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
-		if (!qcadev->sw_ctrl && data->soc_type == QCA_WCN6750)
+		if (IS_ERR_OR_NULL(qcadev->sw_ctrl) && data->soc_type == QCA_WCN6750)
 			dev_warn(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
 
 		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
@@ -2085,7 +2085,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
-		if (!qcadev->bt_en) {
+		if (IS_ERR_OR_NULL(qcadev->bt_en)) {
 			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
 			power_ctrl_enabled = false;
 		}
-- 
2.17.1

