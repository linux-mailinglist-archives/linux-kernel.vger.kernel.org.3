Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CC35241EA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 03:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349851AbiELBSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 21:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiELBSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:18:23 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A148169B79;
        Wed, 11 May 2022 18:18:22 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id h186so599975pgc.3;
        Wed, 11 May 2022 18:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YQvlML9m3qbfCKIWRjMQfFCHa0mKwk3XGcYuMzqP4uc=;
        b=oNgFP4NY23DSU2i9MxLGgPmgoeg/KibO3pQvnXqYNJTrNVUlcvzz8pTprPJQS2k+Ga
         a9XGoUgYIADflfEFDnynKT1fyspt2C2Bo6MHm/MFPRdI4g0Y7zsV57RYUZC+9OUs4SKd
         X/4FUD47sqYs7fuQ9rz4xlp5+KpbqIRQ8FcB5LY81/3yBC3gCah3QxtBBFUl1hU1gm5Z
         YguXB8U/qIKX8f9W/1JNJXQ6Xqp634PS3qcrlcswMrAsNr8MBmsrLtTtvyR0t93GzIag
         HeL5y+aqiBy6tVuR01hPKAGwR9BTsGwVoKXqma1UCHztCaMd/7iqHjdIwMJTKgUFiHw1
         CEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YQvlML9m3qbfCKIWRjMQfFCHa0mKwk3XGcYuMzqP4uc=;
        b=2cEGdJsnDMcrHkee86Bv1IwL6uvpScqfTnfpYS7IcyhGRV2crlFz4ItXrDEb38fHtV
         jadvBjmnLkwnG/vAzNufzkUv4EslMsvX56VuST74zD1YNoBYQvHsipaTzizmhNASCdA8
         HK7ra0a2t5izh5UIWQBIAc3RxQzASWXvKB34TAjuNcr+alG2KTkKfPA8H4n7+58TrbG6
         ybqCvU/d+2ZElA5OUG4tK0HgAaAxz90LweXbcsH0ewR1ihrhQZU1lEis3KFYPZRRtFrg
         TSukS/rA7PrRQeRye6gxpw4KqStuVuFFUNSXbDJIPi/8aTHFEfaQhzVGQYHoh9zTvyFI
         tnWQ==
X-Gm-Message-State: AOAM531MRyHZcwMNHyonNdnqy2jrWSh/G4+MN4Aw4+vGYA2buVmQO9FL
        Nx2Ve4TeTzaoOqZDcPEgVgM=
X-Google-Smtp-Source: ABdhPJyRhU45OFtrhCPgIZpoTW6lkIFVgv0CJwHrhFrRbGPJjDqHu7JH/7MZg+gwU8D4cu7UVtqiag==
X-Received: by 2002:a05:6a00:16c7:b0:4f7:e497:69b8 with SMTP id l7-20020a056a0016c700b004f7e49769b8mr27486411pfc.6.1652318302226;
        Wed, 11 May 2022 18:18:22 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s20-20020a170902989400b0015e8d4eb206sm2501908plp.80.2022.05.11.18.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 18:18:21 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] [SCSI] scsi_transport_spi: Use kobj_to_dev()
Date:   Thu, 12 May 2022 01:18:18 +0000
Message-Id: <20220512011818.1621754-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Use kobj_to_dev() instead of open-coding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/scsi/scsi_transport_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_transport_spi.c b/drivers/scsi/scsi_transport_spi.c
index bd72c38d7bfc..29a4e6cddda6 100644
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -1468,7 +1468,7 @@ static int spi_host_configure(struct transport_container *tc,
 static umode_t target_attribute_is_visible(struct kobject *kobj,
 					  struct attribute *attr, int i)
 {
-	struct device *cdev = container_of(kobj, struct device, kobj);
+	struct device *cdev = kobj_to_dev(kobj);
 	struct scsi_target *starget = transport_class_to_starget(cdev);
 	struct Scsi_Host *shost = transport_class_to_shost(cdev);
 	struct spi_internal *si = to_spi_internal(shost->transportt);
--
2.25.1


