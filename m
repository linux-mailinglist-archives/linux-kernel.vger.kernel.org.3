Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13B05AEDD0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242166AbiIFOlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242412AbiIFOjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:39:20 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C109BB4B;
        Tue,  6 Sep 2022 07:01:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso7527014wmb.0;
        Tue, 06 Sep 2022 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=pkMRy8XuGDtx9NMZA7uZCO5i/b7uDNNrxfsjCrj+Lc4=;
        b=o4utixdJwalOBX1Q1sHVX2nwdDOJAJs9T+YbOtRt/UYSkeX5u+HMoGm1pJiYHACN31
         tPj8fkgp7ANeqeE2sj3eT6XkJZtuuNV0koMxFM8zpW9qNBwRfoK8QN5hAzBXGskn6hoe
         KEWGtDvunl3PCmUD8Diy3P+4Smc3U6xHZ/+xZZyaMLlTlUuny5GFIAMDSURhMJrub87d
         BtsM6foajqPixys05COHdkj62R+NJG1UleOYFrNHcyakuGCLZDY2ccM5a+yo7lFbZ0WJ
         a7fJ+elQA2Yf5Lpa9Z0JteOihcRg3zD/EWNHkM2L3pb2jhbLCbZXDaN8E2PCT3AqxOro
         04Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=pkMRy8XuGDtx9NMZA7uZCO5i/b7uDNNrxfsjCrj+Lc4=;
        b=OchJ1IDDoSOLUNiFPWGbIqQfrhymPcgGYayp3aCUNw+oGrpTePIrxmU6HscZCClVCE
         cq/jB24PjE0qwQeEFK66srU8BNP1TIld/Wr2C4E6rqY2PlTqOepASQJaaTKNY1LufpOd
         8pUbzq3sRCUwKGCVnHQ6YY921amXzXwOuoW8FPs3gB4lFpUSkyK58y4ls6tD8eyr/m0y
         pz/hgR5QK5Fg1eiLaYN9gvGqcEa64lAt6PllP7zNcC2kdUqTmhzWvHBhUMYaet7VwegY
         TRXuAgtUViscSq9bJjrtPENbNgWI+OHNkB1h2XvHBXOtK/nWeNK8BK0Vtqz1FxuQ9/MO
         isgw==
X-Gm-Message-State: ACgBeo2M3KhkJGdAFikmQrknQ5rHWOI1DBAs9F69KigHu08lYUC+ffHT
        oCAyJJLBvDlQ6xqLsUFQ/bI=
X-Google-Smtp-Source: AA6agR6n8ts0/UWy/dounDKDCATDUCcX6IigUCNZspTdYgXsA+nwu6S5DsvfuJhzVBBuGPZzK4bqaQ==
X-Received: by 2002:a05:600c:4f04:b0:3a5:f380:69dc with SMTP id l4-20020a05600c4f0400b003a5f38069dcmr14246016wmq.103.1662472812136;
        Tue, 06 Sep 2022 07:00:12 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id e7-20020a05600c4e4700b003a60f0f34b7sm15189468wmq.40.2022.09.06.07.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 07:00:11 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: qla2xxx: Fix spelling mistake "definiton" -> "definition"
Date:   Tue,  6 Sep 2022 15:00:10 +0100
Message-Id: <20220906140010.194273-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
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

There is a spelling mistake in a MODULE_PARM_DESC description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 632f4d2956f4..2c85f3cce726 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -124,7 +124,7 @@ MODULE_PARM_DESC(ql2xextended_error_logging,
 int ql2xextended_error_logging_ktrace = 1;
 module_param(ql2xextended_error_logging_ktrace, int, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(ql2xextended_error_logging_ktrace,
-		"Same BIT definiton as ql2xextended_error_logging, but used to control logging to kernel trace buffer (default=1).\n");
+		"Same BIT definition as ql2xextended_error_logging, but used to control logging to kernel trace buffer (default=1).\n");
 
 int ql2xshiftctondsd = 6;
 module_param(ql2xshiftctondsd, int, S_IRUGO);
-- 
2.37.1

