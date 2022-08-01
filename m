Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08ECA5862BB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbiHACjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239206AbiHACjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:39:16 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FF913D03;
        Sun, 31 Jul 2022 19:39:16 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h132so8520353pgc.10;
        Sun, 31 Jul 2022 19:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=jjfcu4xtKjaEBPUgzRDUuCQBApVMV8uqOSyXiyO56a4=;
        b=oUBazO0Tpl3pf+8gCrV/5GcxzHg7QOs9PwjGSs00At1eY5pS2oFDF2cLIip8WaOg7L
         LepWWUlzGOqxUE6ElV3PMZAK2u752YXC3mvRJXPMOGgrd9BEjOo5SPOd4K8oBe+bv+OC
         vUzkzdlRppkIuaCuGH/Q+SRF9grDRIPd0l6kC+AMg2vCwhHTaPqo4BKy6uzQi9IJN6Kr
         oVNpNkw2sNfJiaDY8+ygGSaCuHJcNkyB6/P1Kv5SV/+av5lKqHiMNXnJ0QFSbywM6myY
         9X1tsWC9rfnBO0VXkOUVeyQLA1l3S/B6O9toEcZ/jy2g4wxwAUEDB0lL1BFj/a+2SC2T
         qJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=jjfcu4xtKjaEBPUgzRDUuCQBApVMV8uqOSyXiyO56a4=;
        b=ADYI1pFrmH7UQr4b04ZaLHyXXP7Stn7RrTFg/P1CTOgbXm0zhyS5aOdU+nQlTKB85b
         g6qaBMd14yVGJl0o7bLjBz7h7zsFYDRngNMrMmfONWxqUix7bzPY8ebQSIHPusWCU8m/
         9mdepiob7Rly8Vu5rliGNf0aEBhVQxUsYxfC73RrcubOmNjv2UpyomUeVrdB8ezApVaq
         qZsZn3SKiB+jlirTr+/2dkpuE4mN6mlMpxBrgTIRa2HoV4fDGtXMLrDsVNmAGPZdeCCj
         VAoLiH3Ga31TQHr4iF5tYDntfK1kanSA2bF+hOedET8ApRNy+S0Wyh7hFHegKPWnc//Q
         x49Q==
X-Gm-Message-State: ACgBeo10k+jxjsMjReVZQCYB0OAGLVtisu+H52CB+AV6DnlnLoe9/YBM
        xhjPZc1EHvvrHzPYgpkZQ4bdou7Wo7Q=
X-Google-Smtp-Source: AA6agR636+P/oJqY3i6OVhgEcpXcUfZND8HMKGYAe2R22PFElxwvYhdSXq4jTwhmpFISO7Zgzlx/rA==
X-Received: by 2002:a63:195f:0:b0:41c:48c:f57 with SMTP id 31-20020a63195f000000b0041c048c0f57mr2922986pgz.261.1659321555301;
        Sun, 31 Jul 2022 19:39:15 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w194-20020a6282cb000000b0052ba88f2dd6sm7213750pfd.57.2022.07.31.19.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:39:15 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     linux-spi@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] spi:using the pm_runtime_resume_and_get  to simplify the code
Date:   Mon,  1 Aug 2022 02:39:10 +0000
Message-Id: <20220801023910.1595331-1-ye.xingchen@zte.com.cn>
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
 drivers/spi/spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8f97a3eacdea..2cd538c9bd2c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1556,9 +1556,8 @@ static int __spi_pump_transfer_message(struct spi_controller *ctlr,
 	int ret;
 
 	if (!was_busy && ctlr->auto_runtime_pm) {
-		ret = pm_runtime_get_sync(ctlr->dev.parent);
+		ret = pm_runtime_resume_and_get(ctlr->dev.parent);
 		if (ret < 0) {
-			pm_runtime_put_noidle(ctlr->dev.parent);
 			dev_err(&ctlr->dev, "Failed to power device: %d\n",
 				ret);
 			return ret;
-- 
2.25.1
