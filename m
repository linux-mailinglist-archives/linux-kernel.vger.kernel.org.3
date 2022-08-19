Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A17C599507
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346768AbiHSGJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346592AbiHSGIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:08:51 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ABC32EF2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:27 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s11so4418756edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YRpdcaJ4r7VRT3/3i///gd/6IhC/k0ujvr195lrn9Lk=;
        b=dClsiF8/qquQhG3mTRGsAcbFLgD7BqtxZiG5igXl/tQMnq+DIwQy/n4vJcD74RLzhw
         rNVuNVbIvfInB6tJAS5ktMLxANQJGYE6tJI++8kwlx0MVpwVvVVWeLX3wqXy/pUq/vXt
         tuaEzz4CONIC6f00x7TfopRSRwbdWOp3IFUXi28obkv0HnhgvKxHPPtyVoGuwuJlTrPU
         U6R37X9gq0WGh3ocZ2O7O/uBLi1rv88P3Xx/+z22g4XfE4rMpDNDuXTscJg9kFy7ThsW
         B/QjpE6PfUWQ8nozGKYds8I2ZhfTUHWPYdiX+rLRN2Xl9LqofiZaXGXKggMh6F+JH6K+
         KTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YRpdcaJ4r7VRT3/3i///gd/6IhC/k0ujvr195lrn9Lk=;
        b=vvIru6Lv4m1I1giN8nBgLs8gITtsqCCemXXL6D9U59LGvWM6lZ/V6zlWYM250JNVGX
         YTD37z4X/VTiYpthpKDiOkefOuAsZLdwqemtvNvXtTkyCZK6gie8LXOi37DKMeroqWhI
         HWJ/74sc+TqSUEVi/ACNYuR+oTI/cYB00iylOl1X7slFjlU6Rk9KlSCJy2K2vjinvtE3
         mKDPUEbTzgKehu4rRelh5O/drIYg8CZgtwD4ytdWOrd4HFCXeZeVRFisfU5EmR+Dx8RQ
         A978daoVj7Xwq2LISe8z9BQITgZuKWyqzxUUeeCZg/OawrkkW9pA+8zJJffZxHJxdDty
         NxdA==
X-Gm-Message-State: ACgBeo0PJ62IKU0eQH5kKGhntuGvm25f9CcLzEWYNQMYMVDOQzoeuqJg
        eJ4ehtk1xTL5mwEB/1antJOOnN0ebxz0DQbM
X-Google-Smtp-Source: AA6agR76uQfP+U8eTNPUlQ2cBewfTbiI+d5oZ56Bftjg4YGeZIcjKUqA7r+vN12AdAnt1dgkLq5dSg==
X-Received: by 2002:a05:6402:4411:b0:437:b723:72 with SMTP id y17-20020a056402441100b00437b7230072mr5001891eda.38.1660889307277;
        Thu, 18 Aug 2022 23:08:27 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143b:fd00:5207:8c7f:747a:b80d])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm1809660ejd.101.2022.08.18.23.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:08:26 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-kernel@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH v1 16/19] scsi/qlogicpti: Fix dma_map_sg check
Date:   Fri, 19 Aug 2022 08:07:58 +0200
Message-Id: <20220819060801.10443-17-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819060801.10443-1-jinpu.wang@ionos.com>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing error check for dma_map_sg.

Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/scsi/qlogicpti.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 57f2f4135a06..8c961ff03fcd 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -909,7 +909,8 @@ static inline int load_cmd(struct scsi_cmnd *Cmnd, struct Command_Entry *cmd,
 		sg_count = dma_map_sg(&qpti->op->dev, sg,
 				      scsi_sg_count(Cmnd),
 				      Cmnd->sc_data_direction);
-
+		if (!sg_count)
+			return -1;
 		ds = cmd->dataseg;
 		cmd->segment_cnt = sg_count;
 
-- 
2.34.1

