Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17E558756B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 04:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbiHBCIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 22:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiHBCId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 22:08:33 -0400
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8C64331E;
        Mon,  1 Aug 2022 19:08:31 -0700 (PDT)
Received: by mail-pl1-f193.google.com with SMTP id x10so11422311plb.3;
        Mon, 01 Aug 2022 19:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=5t8YdSCit9Ty96RekM4UJNc7grp60HZVSHT6eIxMCH0=;
        b=kmBnknLPeKUDam4c7UBEkrNkPtQlxMd80yFwjXDaDSU4VDnUkCR7vS7PbV4zBov5c4
         BCVhOsNJ/2SlRKe3RVi5Vn49BGPLNAkEPHdPMZeQJuQ/aY/wRJc49RNS74OWz6rZdFxQ
         XsVRC50o1hvrCh2NaOUyALIIuaExsNnQyteHprTw3CTqg8q4utAeDIr+WSz5aajTS9u7
         61aQR17ljpZrnz21K8L9lDLpmJpvx7Tx9fvOxATb6TF1ppwgCHW1FWThgZJH+ktDoTKc
         k0z+7T2w3bV4B1uR+VfeHOT67KPhvQPB8nHnLcYoy1JrFdEcOxrdR7/bWgQrGV1G1c53
         a/wA==
X-Gm-Message-State: ACgBeo3srDXyBR/ggQapI6HUvsbBJtOHwAFczrtVUR+W/ynj/IODg50a
        bohAWffxrdJRlYxWNwocSA==
X-Google-Smtp-Source: AA6agR4uxWsch5pYg/gaUsVGabaIimDA5ozylNx1b/0zOzvhXRQDY4OmqBDM1jvUKD6TOLaENZlqRg==
X-Received: by 2002:a17:90b:3b49:b0:1f4:df09:d671 with SMTP id ot9-20020a17090b3b4900b001f4df09d671mr13940191pjb.129.1659406110927;
        Mon, 01 Aug 2022 19:08:30 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id n7-20020a622707000000b0052dbad1ea2esm1552941pfn.6.2022.08.01.19.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 19:08:30 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     wim@linux-watchdog.org, linux@roeck-us.net, arnd@arndb.de
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        kelulanainsley@gmail.com, sunliming <sunliming@kylinos.cn>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] watchdog: sa1100: make variable sa1100dog_driver static
Date:   Tue,  2 Aug 2022 10:08:19 +0800
Message-Id: <20220802020819.1226454-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This symbol is not used outside of sa1100_wdt.c, so marks it static.

Fixes the following warning:

>> drivers/watchdog/sa1100_wdt.c:241:24: sparse: sparse: symbol 'sa1100dog_driver'
was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 drivers/watchdog/sa1100_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/sa1100_wdt.c b/drivers/watchdog/sa1100_wdt.c
index 2d0a06a158a8..82ac5d19f519 100644
--- a/drivers/watchdog/sa1100_wdt.c
+++ b/drivers/watchdog/sa1100_wdt.c
@@ -238,7 +238,7 @@ static int sa1100dog_remove(struct platform_device *pdev)
 	return 0;
 }
 
-struct platform_driver sa1100dog_driver = {
+static struct platform_driver sa1100dog_driver = {
 	.driver.name = "sa1100_wdt",
 	.probe	  = sa1100dog_probe,
 	.remove	  = sa1100dog_remove,
-- 
2.25.1

