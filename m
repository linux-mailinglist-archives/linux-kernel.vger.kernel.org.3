Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EBD534AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 09:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346435AbiEZHhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 03:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbiEZHhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 03:37:36 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE339BAD3;
        Thu, 26 May 2022 00:37:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id b5so778399plx.10;
        Thu, 26 May 2022 00:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+NgMOM+ok4zxWwg9Vf/2/wo0zo4GMHikcMmNLxvO/Ws=;
        b=AEKzVL6iIL3khRFAC+Zjy43JnLL++bZTFEMJFoQfjaKQ1gEKZj0RmVg1Jx4HG/7wwZ
         5Id/4ij3TEeWyZYRkISruTZeRUQdZF8bwh3ifxpwhR8Na0XnGahVyXxjc5SuJSig9BMk
         c4cKBPm5ZsQGfkQzE//rV7awKx+KYwENFVNyUs1bhmiSCUe8k7pB8xiVCiKi0LM/Rjcd
         JjcXBdAJnWvykvFf0y4p789EUuUuFQUOHhDnCaWgPNY2OSx7qEuWRxb5CRB1BuYX2kLb
         idWCg1PgQl1NCtrKrknnmRQfYgPRGMb14vz1wLAflA7lxrPOvYvv4cI7sk/9A5gBkXW6
         lG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+NgMOM+ok4zxWwg9Vf/2/wo0zo4GMHikcMmNLxvO/Ws=;
        b=Ud5y6gfVI2GWPbrmUHssQslG8lrXFqlC04edb+HzGZ+72vAU3qSkWiGT4RsyH/bEYt
         4D4dpvHkJtmBe0B4Hu5xtxZCwJZ1BJ+9vD9xufZ7gpkfvOu5DMb3p7Ra02T6QidUshyx
         UqLkwJm6/ssvTIVgg6zHVQN6dicLa8M/AT3KTBudKFkMOnr6vJ12yHZDUjygbVPG0Woj
         8f0rkoVL6w5JVMq/NdetaydFr228cV0JiIoU4/RVO3PMVVx6SPRct0Wpeyx8RcUlCPbW
         fyRWWwzYqbqG2JNvl13YztKEy/r2CBn0vyUGO3FBzFDD5mkGcSdZZuE/55sU/hGSuXRJ
         blpg==
X-Gm-Message-State: AOAM533cZR+KAuxsh6kFgQjaYHZ/zjnZ5miwC3hd5bcYT8EtHBEPWp5/
        pSytwkS+6PJREh7jzzHUfW8=
X-Google-Smtp-Source: ABdhPJyWPLneCa/1iG6itH+eO72owGWS+56WVHLVWARX419vnc4rka51Hh1VmlMXU1mywT8Y4502ug==
X-Received: by 2002:a17:90a:4587:b0:1de:c6ee:80f with SMTP id v7-20020a17090a458700b001dec6ee080fmr1245282pjg.196.1653550655010;
        Thu, 26 May 2022 00:37:35 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id je2-20020a170903264200b0016196bd15f4sm769204plb.15.2022.05.26.00.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 00:37:34 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ARM: omap2: Fix refcount leak in omap3xxx_prm_late_init
Date:   Thu, 26 May 2022 11:37:24 +0400
Message-Id: <20220526073724.21169-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_matching_node() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 1e037794f7f0 ("ARM: OMAP3+: PRM: register interrupt information from DT")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-omap2/prm3xxx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 1b442b128569..63e73e9b82bc 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -708,6 +708,7 @@ static int omap3xxx_prm_late_init(void)
 	}
 
 	irq_num = of_irq_get(np, 0);
+	of_node_put(np);
 	if (irq_num == -EPROBE_DEFER)
 		return irq_num;
 
-- 
2.25.1

