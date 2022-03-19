Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CC54E18F6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 00:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244339AbiCSXM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 19:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbiCSXMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 19:12:49 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7079E24F282;
        Sat, 19 Mar 2022 16:11:25 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 185-20020a1c02c2000000b0038c99618859so70730wmc.2;
        Sat, 19 Mar 2022 16:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uGTM8cTyUrNxkrBXIY5/ILn8OVYTkQ9XS5eNr97qsmk=;
        b=E5BPRyZ2scf1rICA8FIIVqCeXi8CPtc56ogyIuYQEudewVmLw8reeSZ8fJSoz/GEA4
         hVhmjI1D/quIHyzCJoGQ9yjTAAAVBtxP8wh5tvuACKT+8dTAw3qYAv0NUcrpl4vCdPbO
         axpOpZOLtRnkMbnWuyFKI0lUO9kaZapkKV87sQ/BpM9RCNV78lmMp0TYEdZbxV7+obhF
         S9/OqwY4bB8FcD/OiR6K2JBsFiLJAyUEuLNB4z5XHMKElSr/pyd09Rb5l2XkNdui7C2+
         /MKYbyhM4pUH6V5qHZ+sn97dXWY02dvp6uzuSViJ9y0rEZpsnp5yt18+FLSByVTFf2s/
         cpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uGTM8cTyUrNxkrBXIY5/ILn8OVYTkQ9XS5eNr97qsmk=;
        b=LAy8bTarjgSe9o9San9wt4X20Wa0LVyJTeKNnbWNkOwJvA1MReuOMgja6gYOSzx45i
         h8RSv5j7mZ1KOfAfLxgEDtjm1iMtWafdLUrwYlOWQgYbxeQ4bdNyJwnvcMyemwbOHNZk
         WmcGbllFofVC0py5yDe+es+aYqgBSahOPLnBJFLUzB+fuw4mypMJr31G1bNY6TefqYAc
         zsaBFtz5//xd+wjjcCEC1xpehL5M/DjSjsXU65vAVLlm/eMwRzgG7xbFSfoq1ICbhBKA
         2u0I7DEmSv5maEOBRnLWdK52WDOMBwSTqFm7XFoR6fqlmJ4zgytFfSO/nyaItqhWAEAk
         lBLg==
X-Gm-Message-State: AOAM530ltrHfaRGvQ5UTJlpBqwpmrVMqfU+UAJq0H2VBPOkPhcvYK193
        DMi2vtn4QdRBmOTAW9Kg/hE4VdszY0A+JQ==
X-Google-Smtp-Source: ABdhPJw/7SCTozzd3Ykpe8ud9T+4+rxpQzAlRrXy1KgEOi1h7FxxbNRjMUn9fZQaTsRaI/q7NXP5xw==
X-Received: by 2002:a05:600c:4e4c:b0:38c:7af6:4fa1 with SMTP id e12-20020a05600c4e4c00b0038c7af64fa1mr12146423wmq.125.1647731483858;
        Sat, 19 Mar 2022 16:11:23 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d64cc000000b00203d45bfbc7sm2079892wri.7.2022.03.19.16.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 16:11:23 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: bnx2fc: Fix spelling mistake "mis-match" -> "mismatch"
Date:   Sat, 19 Mar 2022 23:11:22 +0000
Message-Id: <20220319231122.21476-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few spelling mistakes in some error messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/bnx2fc/bnx2fc_hwi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_hwi.c b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
index 0103f811cc25..776544385598 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_hwi.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
@@ -1169,7 +1169,7 @@ static void bnx2fc_process_ofld_cmpl(struct bnx2fc_hba *hba,
 		ofld_kcqe->fcoe_conn_context_id);
 	interface = tgt->port->priv;
 	if (hba != interface->hba) {
-		printk(KERN_ERR PFX "ERROR:ofld_cmpl: HBA mis-match\n");
+		printk(KERN_ERR PFX "ERROR:ofld_cmpl: HBA mismatch\n");
 		goto ofld_cmpl_err;
 	}
 	/*
@@ -1226,12 +1226,12 @@ static void bnx2fc_process_enable_conn_cmpl(struct bnx2fc_hba *hba,
 	 * and enable
 	 */
 	if (tgt->context_id != context_id) {
-		printk(KERN_ERR PFX "context id mis-match\n");
+		printk(KERN_ERR PFX "context id mismatch\n");
 		return;
 	}
 	interface = tgt->port->priv;
 	if (hba != interface->hba) {
-		printk(KERN_ERR PFX "bnx2fc-enbl_cmpl: HBA mis-match\n");
+		printk(KERN_ERR PFX "bnx2fc-enbl_cmpl: HBA mismatch\n");
 		goto enbl_cmpl_err;
 	}
 	if (!ofld_kcqe->completion_status)
-- 
2.35.1

