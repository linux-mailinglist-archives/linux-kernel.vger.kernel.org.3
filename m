Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2674934BA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 07:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351660AbiASGAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 01:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351640AbiASGAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 01:00:03 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875F8C061574;
        Tue, 18 Jan 2022 22:00:03 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id t66so1744224qkb.4;
        Tue, 18 Jan 2022 22:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S/df0ocBS3nJ+4HRCExy2/8XWcPplGO/DwjAYLYB2wk=;
        b=jpCtCsBgZ1USIHEVvv3GCGb/tmvybGgrGEtw4LhLvIvCVC7LVzdk5Jm0JpUF/T7Dc+
         guE4Hqfmn7Cl9XmzuX9TMpEtuaXEicaWP5fdI2ovHrDObBkOqM1ArMY5rWi4XFs4zn3u
         Z4KxLRsmLT9BqA0Lvfak2SbqPj7Uf+PEWc2CvEpfAYwoqp504xO6VTPZd3UBk5iQAz6D
         puRd/yois7wkmxxkpuVDsoTP06GjarjRmf9LkleLSREPLMDBCDvLMPiAVviKBG4vI4ws
         dn24QUvSiS+/eRiAYyd/o+ytSjUtyZb2fo0VUZ8XoYlh3qvROZ4ZahTxK0CZwlvsK0Qm
         2wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S/df0ocBS3nJ+4HRCExy2/8XWcPplGO/DwjAYLYB2wk=;
        b=FHB+Bsf7oeoggYLOvEDNWRq4p5BdYjcHjuf046jvI2ji/fPktWT47XX+SY7mf3WLJ1
         N6bZQd3ySShhH+ItOI7//FJUTagVeo2JNUGmNSSjEi/2tSRAFWDsxNrDNJ/etTlZmmX/
         Setm0BwN7rAnFawsBrWtdoxs71CPhqkT4JCEkw7X2z082j9jCJtoYpns5hsfYt9wd0Lf
         nc9MftVusQYBG9pUhEPoOY9ZzexWB8ilNi5cOfFtiYMPxZ+zMK6tgKTDcMFhakXXMU+3
         q5tdtQ99ptw9ZrsM/T/gChasTCS1nF2OGTV0+zbYHoqsR+RtqXW1UirXBdX3EBsF2q7l
         LaQw==
X-Gm-Message-State: AOAM532B+B799u4NffcfVQYLih6k8sPmeJhGX4eYv7gMih8NdvVFEti8
        N9Ll34YBdoQrVm3C8p5tYNg=
X-Google-Smtp-Source: ABdhPJwKl8KVANRnAxe28WSDMdT5ZVVXzRaSjkBoMmKiJuMg9ypIePOGIlE3fitm9IIIv4MctKl17A==
X-Received: by 2002:a05:620a:2445:: with SMTP id h5mr9085592qkn.751.1642572002550;
        Tue, 18 Jan 2022 22:00:02 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j1sm11002290qki.24.2022.01.18.22.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 22:00:02 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] drivers/scsi/csiostor: do not sleep with a spin lock held
Date:   Wed, 19 Jan 2022 05:59:55 +0000
Message-Id: <20220119055955.931355-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

The might_sleep_if function in the mempool_alloc
may cause a sleep lock.We can't mempool_alloc()
with a spin lock held, so bring it up front.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/scsi/csiostor/csio_attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_attr.c b/drivers/scsi/csiostor/csio_attr.c
index 200e50089711..3d4ab439c756 100644
--- a/drivers/scsi/csiostor/csio_attr.c
+++ b/drivers/scsi/csiostor/csio_attr.c
@@ -424,8 +424,8 @@ csio_fcoe_alloc_vnp(struct csio_hw *hw, struct csio_lnode *ln)
 
 	/* Issue VNP cmd to alloc vport */
 	/* Allocate Mbox request */
-	spin_lock_irq(&hw->lock);
 	mbp = mempool_alloc(hw->mb_mempool, GFP_ATOMIC);
+	spin_lock_irq(&hw->lock);
 	if (!mbp) {
 		CSIO_INC_STATS(hw, n_err_nomem);
 		ret = -ENOMEM;
@@ -505,8 +505,8 @@ csio_fcoe_free_vnp(struct csio_hw *hw, struct csio_lnode *ln)
 	/* Issue VNP cmd to free vport */
 	/* Allocate Mbox request */
 
-	spin_lock_irq(&hw->lock);
 	mbp = mempool_alloc(hw->mb_mempool, GFP_ATOMIC);
+	spin_lock_irq(&hw->lock);
 	if (!mbp) {
 		CSIO_INC_STATS(hw, n_err_nomem);
 		ret = -ENOMEM;
-- 
2.25.1

