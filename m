Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA86556CEC1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 13:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiGJL0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 07:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJL0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 07:26:31 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883A511807
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 04:26:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id m2so2293239plx.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 04:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HkJLpJbTqJljuHwc41oIV98WOZVVg8AC/4qY1rY8O9s=;
        b=YlXMd/mDdE6lO3Ny8Qa5svKnW1Bz0l7N1kJDlPb6+5I+u6TynHuNhaSLurFTMv3iB/
         9dj84nKmt19nBbubHA6asgjGhtB2PQH9VjxiWLtV2pVfg2kvatFzFxPBndemwtOiKzWT
         x62j1ARtB9zdEUoQCPQuGiuKdELlIfRV4ES5Y+Z19hos/cNARbgVQFd1nEIOjJq/OI2T
         p9MuZoUoma0LiqT+97b2Ij9JWgAvmVKOdxuzJypodf5wLHZmn5/n7uPIFTBUBzxLHGkb
         o72Z1Fr6A9Ox89x0FmX+mSPoKPLv5zRk7vxiIa+TQ7q7Uu528xsntnrxww/MA8GAa9g0
         xazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HkJLpJbTqJljuHwc41oIV98WOZVVg8AC/4qY1rY8O9s=;
        b=s74qzBXP2OsqoBAXruvpOAB3Uyzb4ndvWik3FOxIasbLOa8/pHGb2xdY21fAmoGi5T
         mPie2A24TwaK6VNR+1RXopgtWIZw59RVj16CZhLdoVQw4aaRvwDaztwcibvCij7ArtO4
         j2+KgxeyJ8Mgt5qMjB1cjXjG+Kik7Z8f/GzezVanDOd4V5KeL1D/LdptJzJE1QFdikMZ
         978Em4ZOPnhc93U8vOCl1LVG3UoAw/s62HMzSn3OCN8Uqs8/Aboq9JvK9LdW0GFZ1ZAW
         H+Vxgfa6pqeABLRwRmxiJ09ew2alqyEvcVIpoDjL9R6JkenT9FySdSwV5cor+FEMEy0C
         a0BQ==
X-Gm-Message-State: AJIora9AwJaRHCvRurgoy44uGDiC2BiWM0IVEtCZXRMUgV5MTXSFbqA3
        4HPvJvBnnfZEerp+emabPMM=
X-Google-Smtp-Source: AGRyM1su3yyR8P3J06F37UpL6r9TOHjRVnVzDITa4IgaokEUdh9vVNmup2hqm71VcGF6AITyg+Xg7g==
X-Received: by 2002:a17:902:d292:b0:16b:e6a4:5768 with SMTP id t18-20020a170902d29200b0016be6a45768mr13152231plc.128.1657452390026;
        Sun, 10 Jul 2022 04:26:30 -0700 (PDT)
Received: from DESKTOP-NK4TH6S.localdomain ([118.33.58.98])
        by smtp.gmail.com with ESMTPSA id b6-20020a62cf06000000b00528d3d7194dsm2782124pfg.4.2022.07.10.04.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 04:26:29 -0700 (PDT)
From:   Paran Lee <p4ranlee@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Austin Kim <austindh.kim@gmail.com>,
        Paran Lee <p4ranlee@gmail.com>
Subject: [PATCH] [PATCH RESEND v2] genirq: Refactor actions_show
Date:   Sun, 10 Jul 2022 20:26:14 +0900
Message-Id: <20220710112614.19410-1-p4ranlee@gmail.com>
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

Refactor for loop to macro for_each_action_of_desc

Signed-off-by: Paran Lee <p4ranlee@gmail.com>
---
 kernel/irq/irqdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index d323b180b0f3..5db0230aa6b5 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -251,7 +251,7 @@ static ssize_t actions_show(struct kobject *kobj,
 	char *p = "";
 
 	raw_spin_lock_irq(&desc->lock);
-	for (action = desc->action; action != NULL; action = action->next) {
+	for_each_action_of_desc(desc, action) {
 		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
 				 p, action->name);
 		p = ",";
-- 
2.25.1

