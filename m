Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F330471517
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 18:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhLKRwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 12:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbhLKRwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 12:52:24 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73F6C061714;
        Sat, 11 Dec 2021 09:52:23 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v11so20098851wrw.10;
        Sat, 11 Dec 2021 09:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=88P9J466zr+4P7jgyoGKoQmE3/rhCTfFbyj3bLyp5SE=;
        b=Zh1HJm120a55SS+8yaq1mGNbIkUCIxPFlDXrdV2EHbIMgN9VEAoSfg9MBtFoFzv/0T
         hLSNpCLCpXIENDptZHVfFmwGKQ2wmHE7MMZQulW0PIltoffYz7ZPuarh39bUNBCBDhX9
         Z4QowxELLR20XQjGyBJrGsz/+4pFMf7RtnqxKNjkKyN9ck/wvPRJrF8eyymcSh1o1HxN
         acsQtLEoYTvCpr4ODpuK8gfBXfX7wTHa9wubnesrQPloDjAFHptgae6ZS3sYcDPzIaYL
         //SX7U8XE+pfROLOhmEqS+gYHp3nqCNVvIOi7LAxeygrMMPIyeT/ASR83beXw2UN4Vz7
         GLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=88P9J466zr+4P7jgyoGKoQmE3/rhCTfFbyj3bLyp5SE=;
        b=Fcql0MuLF7HycrTxNuKurM7UNHffOUswO/0BWQLNb28GpDOswi4vKsDhJROce34RyX
         NgKE/YDWt5QhiKGUIzVY/bsSY9jDJvMVsN6I4lRT3AxovJAOVLWD2Rolyip+n7aJlflJ
         S61hP92JPZ0J3Kkf1sO8R1AD50Nir8aYI669/2hVSS/EjVF8J8sEzY0+ZCNSnW3Ck+5j
         F9Gr5dmvjco35fLaghBTVtsQbTd641sfMg6l2j1zU4zJcBPGUMVm62GxAZM496mFr/CZ
         u+U1be++Io9ptTgU20NGdONQIChneYrje741fzsksfrHJIdZKJw6nz+rwJ3tqHGpxU/W
         //JQ==
X-Gm-Message-State: AOAM530c6P4mzv136WZUz83vMCxm958XG02MrXUHe0R2KN3d5XpNObNJ
        te9DxQvMI4XqN/EQtZHEI0gvsdbQjKYcOvBy
X-Google-Smtp-Source: ABdhPJx/a8cTIBavu3rgOxNQlvbmAxubbORAVtJQ2CGrEpbE+uAIrDvOSWZa9qSxaliY4w4LyQekPg==
X-Received: by 2002:adf:aa08:: with SMTP id p8mr21485800wrd.572.1639245142418;
        Sat, 11 Dec 2021 09:52:22 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v6sm2020890wmh.8.2021.12.11.09.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 09:52:22 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rapidio: Remove redundant variable tmp
Date:   Sat, 11 Dec 2021 17:52:21 +0000
Message-Id: <20211211175221.500674-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable tmp is being assigned a value but it is never read
afterwards. The assignment is redundant and so is the variable, so
remove tmp.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/rapidio/rio-scan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index 19b0c33f4a62..2bc4d1eaf1ce 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -524,7 +524,6 @@ static int rio_enum_peer(struct rio_net *net, struct rio_mport *port,
 {
 	struct rio_dev *rdev;
 	u32 regval;
-	int tmp;
 
 	if (rio_mport_chk_dev_access(port,
 			RIO_ANY_DESTID(port->sys_size), hopcount)) {
@@ -558,7 +557,7 @@ static int rio_enum_peer(struct rio_net *net, struct rio_mport *port,
 	rio_mport_write_config_32(port, RIO_ANY_DESTID(port->sys_size),
 				  hopcount,
 				  RIO_HOST_DID_LOCK_CSR, port->host_deviceid);
-	while ((tmp = rio_get_host_deviceid_lock(port, hopcount))
+	while (rio_get_host_deviceid_lock(port, hopcount)
 	       < port->host_deviceid) {
 		/* Delay a bit */
 		mdelay(1);
-- 
2.34.1

