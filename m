Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9838463F69
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343774AbhK3Ulh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhK3Ule (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:41:34 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E9CC061574;
        Tue, 30 Nov 2021 12:38:14 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so18368936pjb.4;
        Tue, 30 Nov 2021 12:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9AUA3ZcTGLZuhJBadpCxqn3J8UAzKaK/JfL/vt60iZs=;
        b=BNzSUVEtdQRSEaeI7XnJdhtaq/XqYPoO1wdaG44wT4mqBDZi2mBRIuS1HayxPc/7fo
         vaFiRcYhCB2KlO8Vm0HXTNwYLzf8qRQRjXzCY/sK+5yG93gGrAb5k2MMIEQSQesBH0OB
         R3ZiEbzYwMDcPXQTvWHpb9mAGyXxQ/Q6tlumaf+rlds2o3gJtfpGzZgHtZhqtc6DoEw6
         OOs3WtKygxudRPG2vWzeVbRJaVXybKP8WzoLkJ7OhkDn5TyzThOfYXM5UXvCWty77Wej
         J/0jI/9Q/2yC27HuJwQDPCqdG/wwpSqBrDDrktxSGnG+WdZJU/Qe4MC8IT9ZBZ+vV8G/
         CzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9AUA3ZcTGLZuhJBadpCxqn3J8UAzKaK/JfL/vt60iZs=;
        b=c7DHFgVXLopLofwpZrb0+hW3S3OyemoUS+4Wa05EmuQ6S8lG1QMCDdzdZ92iTwqdus
         0xv5JC2rubtYiFj8fzLRydy5kj6LK88Rh4GrdFGua5Cx9L6u+E9z3SxzxEa44fDKDfgS
         rClH9+eJSVvbYEpztpUcyZfU23B7F7vdu2qvGr05xp6AU7+kJ/P4DbSWUPDjFPYAZT6w
         5z9mMpdzMt0MAbgFycG1nYlbDt47I9LQ8hVrmOESYpr1zz5F5dYGaJ37H2THy2Pim9Gu
         Ks6NR/yC0tfK/2fsPAN6BQV67ukFCHOHM++YzYGBKJJMHeBgh23nbsytLtK8p1nb2COU
         V+bg==
X-Gm-Message-State: AOAM532L5mgpY0Vk3XpBE61ItIHp3mx/xxLNsjvqOIxrvjcy6H8rRSx3
        +qz9bO796PiVkcnkciM3IA7KcZjBidI=
X-Google-Smtp-Source: ABdhPJzjauQlILGuJjcyWvGep0hjS8osGDlHDkHtTv+K4Psw4GoH/oVWZauLCxMXUnZB89Zizp4KUg==
X-Received: by 2002:a17:90a:bb03:: with SMTP id u3mr1634358pjr.85.1638304694105;
        Tue, 30 Nov 2021 12:38:14 -0800 (PST)
Received: from 7YHHR73.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j7sm23071520pfc.74.2021.11.30.12.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:38:13 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com (supporter:QLOGIC QL41xxx ISCSI
        DRIVER), "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org (open list:QLOGIC QL41xxx ISCSI DRIVER)
Subject: [PATCH v2 1/2] scsi: qedi: Fix SYSFS_FLAG_FW_SEL_BOOT formatting
Date:   Tue, 30 Nov 2021 12:38:12 -0800
Message-Id: <20211130203813.12138-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211130203813.12138-1-f.fainelli@gmail.com>
References: <20211130203813.12138-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The format used for formatting SYSFS_FLAG_FW_SEL_BOOT creates the
following warning:

drivers/scsi/qedi/qedi_main.c:2259:35: warning: format specifies type
'char' but the argument has type 'int' [-Wformat]
                   rc = snprintf(buf, 3, "%hhd\n",
SYSFS_FLAG_FW_SEL_BOOT);

Fix this to cast the constant as a char since the intention is to print
it via sysfs as a byte.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/scsi/qedi/qedi_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index f1c933070884..e7d2bc9026f8 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -2086,8 +2086,7 @@ static ssize_t qedi_show_boot_eth_info(void *data, int type, char *buf)
 		rc = snprintf(buf, ip_len, fmt, gw);
 		break;
 	case ISCSI_BOOT_ETH_FLAGS:
-		rc = snprintf(buf, 3, "%hhd\n",
-			      SYSFS_FLAG_FW_SEL_BOOT);
+		rc = snprintf(buf, 3, "%hhd\n", (char)SYSFS_FLAG_FW_SEL_BOOT);
 		break;
 	case ISCSI_BOOT_ETH_INDEX:
 		rc = snprintf(buf, 3, "0\n");
@@ -2254,7 +2253,7 @@ qedi_show_boot_tgt_info(struct qedi_ctx *qedi, int type,
 			     mchap_secret);
 		break;
 	case ISCSI_BOOT_TGT_FLAGS:
-		rc = snprintf(buf, 3, "%hhd\n", SYSFS_FLAG_FW_SEL_BOOT);
+		rc = snprintf(buf, 3, "%hhd\n", (char)SYSFS_FLAG_FW_SEL_BOOT);
 		break;
 	case ISCSI_BOOT_TGT_NIC_ASSOC:
 		rc = snprintf(buf, 3, "0\n");
-- 
2.25.1

