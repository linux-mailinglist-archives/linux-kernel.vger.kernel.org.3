Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1142555E076
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344628AbiF1LnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345167AbiF1Lml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:42:41 -0400
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC23C33897
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:42:36 -0700 (PDT)
Received: by mail-pl1-f195.google.com with SMTP id b2so3825949plx.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AodosWw+e9JUkc1HE6/7GTMHEot2cQ8Je02YdqyThw8=;
        b=2rgwSBytGVOOcjKvzpzIyBkx5SZ1jIVBFvjc/QIivtEa1/kUmbprVa+k+A20gX7yZ/
         2Rla9ewhFnH8R4iUTr1EduVoafaVJZtNE6mZOFSajmSMWBABYwg95dveTDylDx+9p8ym
         dZEp6UQHsn+ywzwMR84PbD5BA3+M6PGM2CDpFaPJqKKivuNlRSxsFfdeWW7rnHaYJhF0
         KUMfbfEFOsSI+TeMaxvU7q3eLb/g/Z49OT90qHldEUQT23VgkYMI1KSa8ss9E0uW9C2K
         TDK7oLRWfhL3Xp+52Y56tm/KQnlgCfWHfApyWC/TI91m4DCrq+4X/AglivTMC95IT6Wg
         jKTw==
X-Gm-Message-State: AJIora9ed0tCTXKTNwm8YW1FNTmCOfw9PNxc146tUt7VUIoKSdOYCG6F
        Ef06+gcbUm3otkCQGRql8rArZK7TWe5n
X-Google-Smtp-Source: AGRyM1vwMdr0LtO4kQTR0mnBJtZdpdBZQUwNoEBhvek4zA5FeOZujQI9w24F+Z9PjdqxODlyXy3lyg==
X-Received: by 2002:a17:90b:2248:b0:1ea:8403:d81c with SMTP id hk8-20020a17090b224800b001ea8403d81cmr27287293pjb.97.1656416555622;
        Tue, 28 Jun 2022 04:42:35 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id i7-20020aa796e7000000b0051bb61c0eacsm9228780pfq.20.2022.06.28.04.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 04:42:35 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kelulanainsley@gmail.com, sunliming@kylinos.cn
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH] ARM: pxa: make corgipm_read_devdata static
Date:   Tue, 28 Jun 2022 19:42:26 +0800
Message-Id: <20220628114226.884388-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This symbol is not used outside of corgi_pm.c, so marks it static.

Fixes the following w1 warning:

arch/arm/mach-pxa/corgi_pm.c:137:15: warning: no previous prototype for function 'corgipm_read_devdata' [-Wmissing-prototypes]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 arch/arm/mach-pxa/corgi_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
index 555a5c1afd96..02a229425969 100644
--- a/arch/arm/mach-pxa/corgi_pm.c
+++ b/arch/arm/mach-pxa/corgi_pm.c
@@ -133,7 +133,7 @@ static bool corgi_charger_wakeup(void)
 		!gpio_get_value(CORGI_GPIO_WAKEUP);
 }
 
-unsigned long corgipm_read_devdata(int type)
+static unsigned long corgipm_read_devdata(int type)
 {
 	switch(type) {
 	case SHARPSL_STATUS_ACIN:
-- 
2.25.1

