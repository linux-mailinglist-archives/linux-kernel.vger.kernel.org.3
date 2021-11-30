Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D868F463F43
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343717AbhK3UdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240208AbhK3Uc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:32:57 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9C5C061748;
        Tue, 30 Nov 2021 12:29:37 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id v19so15844179plo.7;
        Tue, 30 Nov 2021 12:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9AUA3ZcTGLZuhJBadpCxqn3J8UAzKaK/JfL/vt60iZs=;
        b=i9iXy7CxdOoGBELj+ri1Gg1mukcuBmPWg48FAo6u5tVeQ3oLDGW8j0V/B16z6queXE
         kpwmd20FMw7rvb+PGc8SXuxgieTRP57x4Tcwc+XD6J9Ogh8rE7FHXsuZavp7oY9w0VSH
         w6QmHhV+iP2HVLqRIiizpWjvAlnt9S6gTIv62PKmSUpjk4ZPNlMtS0dbSu99fepbj1PW
         BS7tn1Dfhm9v8/YJsWuKXRrRA3PUJNAbagVacXGBV1jMh/liKi+vqqEee1AS0xaAUBIj
         0BiZCV3bpIEn7xUmBFhaK8CsF2ikoFnJON0axOFVNp6dVk1qGFVIbcGDWJh3pybyeVKm
         JWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9AUA3ZcTGLZuhJBadpCxqn3J8UAzKaK/JfL/vt60iZs=;
        b=7LR1JAq/F14GmXNF2gN5fsFTQcYKp8rZZBu6MKzjNyFBEswd5mONISmK0vTL71/dIa
         D+0JMjnUkC9A5GZnJqoL6XrNcNwIRNHx15ddZqVGZQuAC4+mHaLlBl7zzUAkDmRFh5Nh
         xY8YGNt40R7CuRlQfONMzxPNS5TLF7tNTSTynVCrvfIJuAEd7cz/E5vRPs++2kOE93VX
         PfH3VBBb5Ws9vtvdE3LvUMAEk1ItH9UwT8Gr3H8j0V2grqXMMhMhpeXBGpk3ikMwLH32
         wY8pex50eRXzcq9/rcuaDFLAHyPn33q7TlkZGu3KRtVx8gTQ9NkYlIC1iLBzzi4tFOap
         FA7A==
X-Gm-Message-State: AOAM530rKQV/kZGcLY/WWobq8C1F+eP5Dg1cmisPNTrwVM2EI/iPMarI
        Wwd5Iwc2A2JfrDsqvFAOR7q0mU4gHV8=
X-Google-Smtp-Source: ABdhPJyU8olIP5WMuEb5lIT8rLg0BCv4TthDUul45el4g+CVBpm2VpuWFxq7qvuG0LdDPlCLW9HfhA==
X-Received: by 2002:a17:90a:7086:: with SMTP id g6mr1649154pjk.34.1638304176306;
        Tue, 30 Nov 2021 12:29:36 -0800 (PST)
Received: from 7YHHR73.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id lw1sm3512435pjb.38.2021.11.30.12.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:29:35 -0800 (PST)
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
Subject: [PATCH 1/2] scsi: qedi: Fix SYSFS_FLAG_FW_SEL_BOOT formatting
Date:   Tue, 30 Nov 2021 12:29:33 -0800
Message-Id: <20211130202934.5023-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211130202934.5023-1-f.fainelli@gmail.com>
References: <20211130202934.5023-1-f.fainelli@gmail.com>
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

