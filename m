Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B15D58781F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbiHBHpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbiHBHps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:45:48 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C940911A18
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:45:47 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w17-20020a17090a8a1100b001f326c73df6so12894794pjn.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 00:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=pofh/mBkV9iyAkeXPvhTnC/91KwnyKUAxl/+MJcDnJ8=;
        b=MlHjDd/GSzDh3km2sHGBqB0VrnzdSkUBCbxa9MN3lgM23qg+QH/9cn4YqdLrGkxnF7
         wvbXX8dg6WSQHtw2TD4m/mQNWtuA+UEY2UtI4YBWGFMPmMuTzm+GisZaSjTOZ3MV8MUP
         mn8O2jylhlnhZWMNqllv1BzSV55JL86WuisDkfUvjiluCwzJYtauV5R1d81tCJyS4jLO
         tQAsxcC5FyGZcieEIbdfS8DgJ5Q8693mLFFtb7FT4xw2pGhHxMp/UnOQwVpoau+su6uC
         WC9sEvmtEbfpmwdbIBfZWlzEaS5fdILrh2HaLfr4TkUt0aof9VnVYX62ShHwOBx0OFSS
         xHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=pofh/mBkV9iyAkeXPvhTnC/91KwnyKUAxl/+MJcDnJ8=;
        b=p/RJdvq/edPGKef86xb+xvolAghF1fNpzVZRVw7pfA63/eRc1V6ByEnWVIf0ABX0dH
         FHtqVhWYhULWvYtyWpX+ExmYYhPMN2qKIU73je+aDZ2Dywi19ISMvAc5gkLGA2JmKXFA
         c2SeHG9/W5ggl8HHfW7WZcIy6kccYnLMtas7+z470MUpcyAJnTEZiTrKlUa/oFnxKGwN
         zR6nPMbSgzp5ce8z7df2ncNwwgDRpA58CFKpbJ/+ceSpzwG9JvNSeDWLENgkOi8pKxpb
         nlRAqA9GDiOigPIAIpeqsQ8f1J04dtkU2hqDfmhu4NiFIn+qiPyB4Dz26oHIB27Z+fwP
         skPw==
X-Gm-Message-State: ACgBeo2CVy7FhdmXe11J6F6Y6Tf/CdCTJW0og20mhvRNHfua4HT1YLsJ
        ay1384r9UJhWCRVnu83GY++Yu3KqHMQ=
X-Google-Smtp-Source: AA6agR6Qie5f4zp9P90DnxSZqjxV+ccwBszUIewBvDwJKYthIFEVqwyKd4RY5WxXaeO/kYsXE/sdYg==
X-Received: by 2002:a17:902:c406:b0:16e:df76:5267 with SMTP id k6-20020a170902c40600b0016edf765267mr11157809plk.8.1659426347138;
        Tue, 02 Aug 2022 00:45:47 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o66-20020a625a45000000b005289ef6db79sm4651850pfb.32.2022.08.02.00.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 00:45:46 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] staging: greybus:using the pm_runtime_resume_and_get  to simplify the code
Date:   Tue,  2 Aug 2022 07:45:42 +0000
Message-Id: <20220802074542.1648594-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Using pm_runtime_resume_and_get() to instade of  pm_runtime_get_sync
and pm_runtime_put_noidle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/greybus/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/greybus/core.c b/drivers/greybus/core.c
index e546c6431877..b9063e86534b 100644
--- a/drivers/greybus/core.c
+++ b/drivers/greybus/core.c
@@ -174,9 +174,8 @@ static int greybus_probe(struct device *dev)
 	if (!id)
 		return -ENODEV;
 
-	retval = pm_runtime_get_sync(&bundle->intf->dev);
+	retval = pm_runtime_resume_and_get(&bundle->intf->dev);
 	if (retval < 0) {
-		pm_runtime_put_noidle(&bundle->intf->dev);
 		return retval;
 	}
 
-- 
2.25.1
