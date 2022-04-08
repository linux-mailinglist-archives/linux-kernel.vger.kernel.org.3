Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32884F923D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiDHJuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiDHJu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:50:28 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A7FC6ECC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 02:48:25 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id e22so7049920qvf.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 02:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xyDhZA5e9MjFYEhmu4FqYjenfAb0FgcF+bALc0FyObg=;
        b=L/o7FYP/4F8bPYwzH/3ca6smL2l0YvLGWRDZPUyjGgT0N4GOX2vXMekuq1O+ouQYWp
         hJmXEAtAN+g9TlrNcA1TmX9g6wpz24ngPsKAPmVxu3YiRi7bB4CUraYOv6wWPEaqf2fN
         wNX70Xok8GRbRCj8h3wfn3XNkJpvXILjoyrfJkF4F/P92zud+xYE17fgn4NSvFL3UGL6
         wQBdyURyl7OxuJZpgQ1ahFwjU1Zq+mQ+eOMDgS1WKiHnF9gunlKXjkqoLGhHImKrmfDQ
         +vGo3P/Z9URQ6WEfRmsGq98Em/rEC+ZUy5mPE66MdGv0X2QXoRKmuEu4RqncmspkdmEm
         PqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xyDhZA5e9MjFYEhmu4FqYjenfAb0FgcF+bALc0FyObg=;
        b=sPbeqyhNSfZO+J0TWJ2/mKE5ynac+j2ye9QbidZlrEyyl7sTZwJmjzIvhiNyrub0lS
         xn1ahOMdB4hD/6002+CrudZFg+MwgJL9co1SoBqdC/jhCK4tMe2mGAFADa9sZc8df0wD
         czY+dM3Xj/lc7uNrECo1SNwGCvtG61cEeJY+10OJ+y88i4oKjFQVzkcyuUV15Kr/kpIs
         VP/YLKlgo1au4fM0rV8d5SA4zlk5OPoJLBV+OLfNHRoUjexd4pTMwpF+1HSDVdoD3k6M
         dZOJie/8FCrrwGP/zzjIQEIqTPkcEgKXQpuYoJlb8N06vLx7odg5DuZGRSH2uBK61YiL
         JkrA==
X-Gm-Message-State: AOAM532Ay7BPq9spdziM0us6BwsqsyuKFA9C+mLGbqEGSnUAL1gRfqpk
        3rrGCiKjc62NWtfew9EkX4WhsiRsX7I=
X-Google-Smtp-Source: ABdhPJwE9jENCkXSpwP8Tco0k4VNtvBAwf6HKl+QSqit0tq20E/Yu11IBPBzWfN2rKqBbsFFGnuqiA==
X-Received: by 2002:a05:6214:4119:b0:441:9eb:d4ba with SMTP id kc25-20020a056214411900b0044109ebd4bamr15338604qvb.54.1649411304104;
        Fri, 08 Apr 2022 02:48:24 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i18-20020ac85c12000000b002e1ce74f1a8sm17525453qti.27.2022.04.08.02.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 02:48:23 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     andre.przywara@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ARM: highbank: Fix missing of_node_put in highbank_init()
Date:   Fri,  8 Apr 2022 09:48:17 +0000
Message-Id: <20220408094817.2494756-1-lv.ruyi@zte.com.cn>
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

of_find_compatible_node() returns node pointer with refcount incremented,
use of_node_put() on it to decrease refcount when done.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 arch/arm/mach-highbank/highbank.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index db607955a7e4..fe82c3d16ffd 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -141,6 +141,7 @@ static void __init highbank_init(void)
 	/* Map system registers */
 	np = of_find_compatible_node(NULL, NULL, "calxeda,hb-sregs");
 	sregs_base = of_iomap(np, 0);
+	of_node_put(np);
 	WARN_ON(!sregs_base);
 
 	pm_power_off = highbank_power_off;
-- 
2.25.1

