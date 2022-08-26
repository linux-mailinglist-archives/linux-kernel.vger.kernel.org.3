Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E885A25A3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbiHZKOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbiHZKOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:14:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB23C2FBC
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:14:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e20so1212136wri.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=YRpdcaJ4r7VRT3/3i///gd/6IhC/k0ujvr195lrn9Lk=;
        b=VSUkeWQzqxVlhVFu4DC9tyaajVlj//djUl8X7BaKZwQua+k3/xBJFtIuDLjNJjQWLL
         GUaedmIJPtnNIiSBpY5M30o+30Jmmq1+sM9Rcp9s3vlmgwWWjzOLVA9s2rUJiYwfzqSI
         ruXSplnM+iFUnlzG+3jlq28Y6R/yJQmNN42YpzLUNlvU/DMtnH8RREhwp6CNmsiD6cAn
         P+odQZOAnBZyjm6qfeiccNeyztJh7Y0leBhqXWaNypkUwVE/lTfDMjJZ14dvEqlveVCO
         JbSmJo0t4quHGh+3J0eEE02Ec8Xn1LwKIkbOSGlqxJVVetWJH28se8Gz+WiQRhVspY0M
         RAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=YRpdcaJ4r7VRT3/3i///gd/6IhC/k0ujvr195lrn9Lk=;
        b=A9HoUC2TGG9C5iQgn89BwowORj+i0lRPv0zXFA7TIuRAxvgsey+OJ4T8XFs8bHPpLf
         6k3XpB6pS8/AujSPGaR+nOFuuaup7BFU01p526MQQe+zKoB9/iyCOdE4QKLiCfSN0S81
         4PlDY/y+dCnYvO9lj1BJN83dPnViFGEzSJMgSGCMV52VSQet12CoPNY7Pzdmp+llf7i8
         qOwEMq/yuJjmQ8Wy5U1o8aJ8EXVnQzzqN2BO8ssyPb/xAhDnFCXCz87Nhf9ae65RQ4Sx
         jKjVnksloJ+98KWSZHTWjgEWQiW5n2ZYmPFb9B0ozpgxpiMBntj2JcuUZ72EsF3YdwZV
         oOrQ==
X-Gm-Message-State: ACgBeo1hT69q5V45MtaI09BXruA9msxEeOL5gY+AsR3uv8ynZXfoJ6+z
        leinJuBmvqViWT8QZ/3l7Yh97aRpVJXV/w==
X-Google-Smtp-Source: AA6agR6XuzcSJ7avTDDbXtkKVvQcQEVjKXh2P9x7wWoHp7sT5sEudBIMCpUai6U2OGmhHrEje1PKMg==
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id b13-20020adff90d000000b0020cde324d35mr4466170wrr.583.1661508877365;
        Fri, 26 Aug 2022 03:14:37 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:140d:2300:3a17:fa67:2b0b:b905])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c284800b003a3561d4f3fsm1920423wmb.43.2022.08.26.03.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 03:14:36 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     jejb@linux.ibm.com
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi/qlogicpti: Fix dma_map_sg check
Date:   Fri, 26 Aug 2022 12:14:35 +0200
Message-Id: <20220826101435.79170-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
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

