Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11C75863E0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbiHAGIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiHAGIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:08:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091CAB849;
        Sun, 31 Jul 2022 23:08:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id q19so337953pfg.8;
        Sun, 31 Jul 2022 23:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=uURXq1o8zPy8kBNbXRu1fsY4+FJW1JU5uvH5/iofuOI=;
        b=X38sMtbVw10EoxxrfF8/ubFdVUKAJvxuQ75TwkyDIC1Ok/wXwyKzEmOlAWPEQv1bzb
         FLxzzWbrrkmAn2hsDcWcpJAc9WrZ3U2JwZHnrh51NODYqObyrdswRftfdWs0GgQjI44m
         mqDB4zplEXeMp/4LpnEzVKxHQJvaKGOylhu566J6LZF8t/z4P6FB4aiH0ogTs8MaS/g6
         J1Y8ehWM5rLeLuSFGiEpPLdzf5doAz0twXWa5ZGJb+CRGWPmebDwCEZCp4ahdFhyfCGl
         5TDjLIZN8jMRy7CGhZj0+FlAL4tWEGBqj1TYPE9n/PJErrXUJhEkxp89P2t+BV/QvYJ7
         vNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=uURXq1o8zPy8kBNbXRu1fsY4+FJW1JU5uvH5/iofuOI=;
        b=aDfPi9SCZFEDfA+GjGZZ/pkHDt65wLAC8ZH8+X3GNirhlI0r/suuXTEOPjNxgFZkcH
         yU/kf9BcA/Tqte4Z8DSputIKxsMnTZRbJvFpz7MFfGPvF/v5Wq1aeRarnvlsILcmvR/r
         1lYWDfpCsw9/bnpsR19nDb50ihlDJsRBBFLW+egUseE5EOcPs2Zs7FU5jv0KrLcx6WON
         HxggLJP98TZvIyH44A4COs2iY/PxT99RF7JFU0wLw8ysC80C32XAXlLrcUUZM3AefcXY
         FTVGHEcXaHLWWznvsGkByG0Saq4UKRop60kYzxg9DTDNZ6cgKhdkKP75VEiX206T3QOz
         oYNg==
X-Gm-Message-State: AJIora9+QZX9ukUD2vHm5t0Cz3dxTd+D8KCJ9fhkzzYWHUt69NfK3zUO
        BFnNpMEjVwheq6HchiTOqow=
X-Google-Smtp-Source: AGRyM1uwGAtgc2eoB6MRwIiqmRSWObleqzmE5vZMYSMCrYYWunQYxFIoJPB1qbB95STA6zVq4XZeKA==
X-Received: by 2002:a63:db09:0:b0:41b:6744:a255 with SMTP id e9-20020a63db09000000b0041b6744a255mr12096992pgg.556.1659334113428;
        Sun, 31 Jul 2022 23:08:33 -0700 (PDT)
Received: from sebin-inspiron.bbrouter ([2409:4073:2115:6e1b:8b67:c426:26:e09])
        by smtp.gmail.com with ESMTPSA id x14-20020a63cc0e000000b0041aa01c8bb0sm6556681pgf.10.2022.07.31.23.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 23:08:32 -0700 (PDT)
From:   Sebin Sebastian <mailmesebin00@gmail.com>
Cc:     mailmesebin00@gmail.com, Don Brace <don.brace@microchip.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike McGowen <mike.mcgowen@microchip.com>,
        Kumar Meiyappan <Kumar.Meiyappan@microchip.com>,
        Scott Teel <scott.teel@microchip.com>,
        storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH -next] scsi: smartpqi: Overwriting previous value
Date:   Mon,  1 Aug 2022 11:38:21 +0530
Message-Id: <20220801060821.52386-1-mailmesebin00@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coverity warning 'Unused value'. Assigning value 256 in
shost->max_lun but that stored value is overwritten before it can be
used.

Fixes: 904f2bfda65e0 (Add driver support for multi-LUN devices)
Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 7a8c2c75acba..5a9fd52c6e7c 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -7405,7 +7405,6 @@ static int pqi_register_scsi(struct pqi_ctrl_info *ctrl_info)
 	shost->max_channel = PQI_MAX_BUS;
 	shost->max_cmd_len = MAX_COMMAND_SIZE;
 	shost->max_lun = PQI_MAX_LUNS_PER_DEVICE;
-	shost->max_lun = ~0;
 	shost->max_id = ~0;
 	shost->max_sectors = ctrl_info->max_sectors;
 	shost->can_queue = ctrl_info->scsi_ml_can_queue;
-- 
2.34.1

