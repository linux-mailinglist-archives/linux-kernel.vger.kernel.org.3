Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA9349D789
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 02:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiA0Bjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 20:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbiA0Bjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:39:43 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74D5C06161C;
        Wed, 26 Jan 2022 17:39:42 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id o9so1487505qvy.13;
        Wed, 26 Jan 2022 17:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y8QihzFyYSHPb4QWaKgu9ao8NtkYQJhcqAWxoAcNWMI=;
        b=WPEfiyyWwv8bImjKKaTrdrwQRjy1rJn9MB7ek5L+NTigJDQyPlRjYS7rUpcgvN4JfE
         iK8Itxpc5sZGyC7hVWG8RGpFu4QkZPKyDw1hLGPozb3IjuulLUr6ksRR2uA0ba8bnCgk
         YzvH83sdI3W0ZKc4JR/3UxKI7bptncEYKrs7OGQfAmIADOwOosftA7fWr9Fri933Q2Q0
         nZh/R0nEif01IxIMoVJ30pNIMgUcxi+DFHnsKfyBu9G2HLrj1ojt/QCdWZI8VDq6oLOI
         S6gptgeXR8X9EZWQ3pm4ickJGOzRlRINpRJoUVTKikv/eMrHH6UZ6Ps6Bzj6+bSlQJ02
         oBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y8QihzFyYSHPb4QWaKgu9ao8NtkYQJhcqAWxoAcNWMI=;
        b=MPdMPMNCNmPsxDkWlX7zzi5wl+YpLtEEyMSnH/EHzImw3ywUkcIoUSwW/JYC+3let1
         jpSi+YCKxtWki5z/wxUAW+qUgX+cnjvNDHyeb5eOVFCz1ZLO/I1SDQmgOonOojEz2OL7
         9upkXJGFkxDzFI5jdyUye7zfVtdyHtc02K+0TOjttlirnJn7d5DA5rDc+dj0NXpfpHXX
         W7eUuv4Ly7zv9BuQDporYoMml1dwOsIkbuMF/R7k9ecZvVL9vPcNhihJ0XWTBV9gVtHz
         QmauFqEKH8/H3Uowsr/vykYRgvDqz0rI7e4yFirm/3Jd0H36qt4yM1ggcF9sqqG4poGR
         8b6g==
X-Gm-Message-State: AOAM533AdbowRapNkhviOy9u/76VF/fazCGyw3rqWVDULaf9+TsYeqoT
        kricjYHPu8V3x7nGwb78zJU=
X-Google-Smtp-Source: ABdhPJzgmBAc7Qlj1KUmK3MG/V/OIeW2JSfDO03Wk9tAjbja509ljWCFx1Rh0WA81BMIYpRbMHkSSw==
X-Received: by 2002:a05:6214:3005:: with SMTP id ke5mr1203861qvb.83.1643247582027;
        Wed, 26 Jan 2022 17:39:42 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x4sm538439qkm.47.2022.01.26.17.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:39:41 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     njavali@marvell.com
Cc:     mrangankar@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] qedi: Remove redundant 'flush_workqueue()' calls
Date:   Thu, 27 Jan 2022 01:39:34 +0000
Message-Id: <20220127013934.1184923-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>

'destroy_workqueue()' already drains the queue before destroying it, so
there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/scsi/qedi/qedi_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 832a856dd367..83ffba7f51da 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -2418,13 +2418,11 @@ static void __qedi_remove(struct pci_dev *pdev, int mode)
 		iscsi_host_remove(qedi->shost);
 
 		if (qedi->tmf_thread) {
-			flush_workqueue(qedi->tmf_thread);
 			destroy_workqueue(qedi->tmf_thread);
 			qedi->tmf_thread = NULL;
 		}
 
 		if (qedi->offload_thread) {
-			flush_workqueue(qedi->offload_thread);
 			destroy_workqueue(qedi->offload_thread);
 			qedi->offload_thread = NULL;
 		}
-- 
2.25.1

