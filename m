Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E35476762
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 02:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhLPBVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 20:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhLPBVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 20:21:08 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC75C061574;
        Wed, 15 Dec 2021 17:21:08 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id o17so23886073qtk.1;
        Wed, 15 Dec 2021 17:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pdEv0OCuEaZxcoDSUkQ+CoSfgNw3rkzYB10lIPbj9x0=;
        b=A8kNMpS6daY2UKVU7D8VCJYJlv3FDB73Z9ONm7GwJLYkOejaK+up8rT0b2gLvGkWPq
         Spv7d9NJuVFUOM1XQvitRyCDZZupNJljpARd/Gy7hA9MidKQcBqbh/W5J984Mb+F7yzT
         PPARQSPMZNLLMJxUwx88I99vfYxWDBlrEfNNOGPVij2B5lDLOMaMWXbQih1n/RZqU2OC
         c0NBVCGT9ozm4X3e/cbqutjPgKjgrgwZVwD4pDL4/9Bei9YzThiZ+f0n0XARQXG6j810
         Ecaz44Ajv8kcLVSc5NKgzsX/t4nUYFxdp4IRWrhSUxzm9zy9M4sbEJMWnPtBh6wiE1EZ
         UU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pdEv0OCuEaZxcoDSUkQ+CoSfgNw3rkzYB10lIPbj9x0=;
        b=5sEOW+VXS3+UbMc4+GfooN6Nowyeb6qZTt7TJjKSztFZWt05m1E3MYlSCHHpe7e/zF
         sKhnAj5R6B15DdL7yki3n3LfoKbQi0mt2uvVxFITrEiVlA7Dc2NnjzzVJ6KDgMK1iFeR
         IqAMppV0hRI58GjS9G1OPcCNMKcdnxNuNCh7jq3NSqbmXEZVBOpNNEJJXoMApNexsoVj
         UUbaqVrHJsoEIQijUqCIL1l5cHJ+pwwEa3c3viW9t90dGqFAGH6YN50o5Kukry/t7AtR
         pWYPwnrgsTXJOD8Dy3gqg4wfY1zv2Ep2MSxwkJd19Ce0QEL/OAIMl5u5ZzZgHCJ/wm/i
         SgdQ==
X-Gm-Message-State: AOAM531SUuo7TGXAAvYiN6VN7P9Olt2I5hPHIkrb8cR1K2O7ozEO2p1p
        9g/4z5GNtlUfnpnEWW9GmKc=
X-Google-Smtp-Source: ABdhPJx5RAjZNWxl0FR/7JgigyFsgj66NN05WmUj31G0aHTCkD1JYqOWrAggGIYPVQiQWAEvqzy7wQ==
X-Received: by 2002:ac8:59ce:: with SMTP id f14mr15075718qtf.30.1639617667387;
        Wed, 15 Dec 2021 17:21:07 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id r16sm2029147qkp.42.2021.12.15.17.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 17:21:06 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     kashyap.desai@broadcom.com
Cc:     sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] scsi: megaraid_sas: use max() to make code cleaner
Date:   Thu, 16 Dec 2021 01:21:00 +0000
Message-Id: <20211216012100.446477-1-deng.changcheng@zte.com.cn>
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
 drivers/scsi/megaraid/megaraid_sas_base.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 82e1e24257bc..095275aca139 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5995,10 +5995,7 @@ megasas_alloc_irq_vectors(struct megasas_instance *instance)
 			instance->msix_vectors - instance->iopoll_q_count,
 			i, instance->iopoll_q_count);
 
-	if (i > 0)
-		instance->msix_vectors = i;
-	else
-		instance->msix_vectors = 0;
+	instance->msix_vectors = max(i, 0);
 
 	if (instance->smp_affinity_enable)
 		megasas_set_high_iops_queue_affinity_and_hint(instance);
-- 
2.25.1

