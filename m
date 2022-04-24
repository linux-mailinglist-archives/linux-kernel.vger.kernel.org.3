Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160C350D009
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 08:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbiDXG1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 02:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbiDXG1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 02:27:49 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DC517BF8A;
        Sat, 23 Apr 2022 23:24:50 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d9so8368418qty.12;
        Sat, 23 Apr 2022 23:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YLpMsPvRAfX6udmXoRJxXwHw2EOhu4J52HQ7muhAMJw=;
        b=jjNtdI7ZYNHG/6XfAgSK95XkyOCwAGjh0AQa+0zP9Nufdaqr0FRifMHSIEPULmqmfL
         wmZEKVMB4IA63XKk0WZqeU99F8xclpKSYSn6A2qoF3V+YhScBMMAZTL4AianqUr1W4Ux
         uqpLweLdZD/lhks67PEuibzhzO7/0UkKnSAHUqG3e0oE6m5s8BRaCFXv/3l/Zp+x+i+J
         LSUWrThF7OiHwmn6ETvCXIZM98iUsW38yMZaMkFTlpMJ/QZ0IwWRFsO4qwmeq9BcwJba
         ndwbZlUohVL/YdG1f37WBfKHb2xs4h/BsI+7OtaVPYXd2EFLzdHvEL7wHs2BsEzHfnCR
         uJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YLpMsPvRAfX6udmXoRJxXwHw2EOhu4J52HQ7muhAMJw=;
        b=WoOtrtEN5aWBZkRW2RCiCvseRVLvMkh91ZEsxBb7xsTWOQKw7/iPdX5lfBPCw0H1nW
         fNqfPwOnUhzufEMgLKEBTBbSyo+Ots85KpEV9qYoXCh25WpyqICG5IRvu9D44XuHrAx5
         tFCcl/3u4ljuuJR4H1jeen9O3erHM4ZMF0iVn68U5yytclIhurAxDvHGofC7DPDluxOc
         SDcq/jXm65JStydRX6NCrUK8ZSqRz2G91eUtrh4Kon81k2fJSFPZOhmfQsF74KaDZWDv
         6vNnXmRS4XbpxSH5PBY0YZ7SS4i+n1zKEhdP7NLDmDQmLjtqzDUY9P5kdBrogoW/HNLx
         NNQA==
X-Gm-Message-State: AOAM531MxgiWVlNkW8iFYQchyU2XFZRk9TS/S1Igu0Mm93CxadvxSiuW
        g+vwFCZgzSuLaQv6cJzuq+I=
X-Google-Smtp-Source: ABdhPJwsWYEbc1gB3qIjICtF2AGpDLhNtocemr7slKWO+M0xEZIm5JpSvAnGSjOf5RdP67hhOP3hGw==
X-Received: by 2002:ac8:5855:0:b0:2f3:3eb4:51ee with SMTP id h21-20020ac85855000000b002f33eb451eemr8269058qth.644.1650781489990;
        Sat, 23 Apr 2022 23:24:49 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x13-20020a05620a258d00b0069c7468e123sm3296269qko.122.2022.04.23.23.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 23:24:49 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     njavali@marvell.com
Cc:     GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] scsi: qla2xxx: remove unneeded flush_workqueue
Date:   Sun, 24 Apr 2022 06:24:13 +0000
Message-Id: <20220424062413.3220315-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ran jianping <ran.jianping@zte.com.cn>

All work currently pending will be done first by calling destroy_workqueue,
so there is no need to flush it explicitly.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 drivers/scsi/qla2xxx/qla_os.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 762229d495a8..73073fb08369 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3933,7 +3933,6 @@ qla2x00_free_device(scsi_qla_host_t *vha)
 
 	/* Flush the work queue and remove it */
 	if (ha->wq) {
-		flush_workqueue(ha->wq);
 		destroy_workqueue(ha->wq);
 		ha->wq = NULL;
 	}
-- 
2.25.1

