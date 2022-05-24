Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97F5532389
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiEXG54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiEXG5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:57:52 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8689544C5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:57:51 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p8so15658632pfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XnhPJWRti5irdiFCJ82HXC9jEWYkqiMNZIjhk1PChYM=;
        b=Atux7LbREZXCCH4u0g+KBxF1ChuFjZ+2Dz+Rt3WWPxbwFE3pcgfIySu+/GuxEVjGLJ
         6+WOrnRsmElAXa+hGg9S4dmzG5JIb3PV3kzf/GxmIer3lr9F6yK0ME1VOBE49uSWv8hl
         S5R26XrucgnUIYmd6NnVyj44/5dXDteX7lM2LVBJg1quRDuffYNcImRSQdODkInSMaPk
         fKJn8aKkZCMV+P3GrvkbwbtB2X0Gj9MgR3TvkV7qD7dNOS426ZThdY6ht2VFJWyVva8a
         16Ct5cZtvDQYXxyX2PVSG+KAmxza+U6qfVXNoGnvM++VdU05NVsF8ETIAkB1l9DBY+IM
         XsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XnhPJWRti5irdiFCJ82HXC9jEWYkqiMNZIjhk1PChYM=;
        b=myNCYDY8OdQkemFZQuYIiTyYb4ijMeUzRjlGfaSLR0bNsYdx/vtcAUj33DZ0c17Wqa
         QZCPGWH+EYISud8t4uVv0MGlyaxdyqHRBfCDROwF/Gk2au81PWtXr6E03eIVHoAXfQAz
         3KzbdHSzJ79tuT4eW/qbLqQdtYSSZN7ohSzLLxhXAZT7D1MKAdMiO3+IWd6RuGJTUKKM
         Jjl35aGPfD+m/hF5BS28UrlVHOXb7noyZsGYViDKCT53LnPDdP9YdiJ1E2JxqHyPDcKW
         Q4Pr4ADDzWmqle4lW502WS21vRKd0T9t77kql0vD8818HnlH8WtZmat1ftVD8KdGS4GC
         nZ9Q==
X-Gm-Message-State: AOAM533orBgK+YwNZ/BHvPWY5qej7RklhkSwC11lKewYyUB6MXyocJch
        wkZKXnO46xDOdqiUzu0CHok=
X-Google-Smtp-Source: ABdhPJxjCHLfeE5M+/EvxtMUDVpKvze/ODF+6ndhlHLMXll9vfEzQqL6ESlbbAmma2BfFYzfrI8N+A==
X-Received: by 2002:a63:5a13:0:b0:3c6:3d28:87e5 with SMTP id o19-20020a635a13000000b003c63d2887e5mr24008160pgb.452.1653375471366;
        Mon, 23 May 2022 23:57:51 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id t1-20020a17090aae0100b001cd4989ff53sm882847pjq.26.2022.05.23.23.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 23:57:51 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] meson-mx-socinfo: Fix refcount leak in meson_mx_socinfo_init
Date:   Tue, 24 May 2022 10:57:29 +0400
Message-Id: <20220524065729.33689-1-linmq006@gmail.com>
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

Fixes: 5e68c0fc8df8 ("soc: amlogic: Add Meson6/Meson8/Meson8b/Meson8m2 SoC Information driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/amlogic/meson-mx-socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/amlogic/meson-mx-socinfo.c b/drivers/soc/amlogic/meson-mx-socinfo.c
index 78f0f1aeca57..92125dd65f33 100644
--- a/drivers/soc/amlogic/meson-mx-socinfo.c
+++ b/drivers/soc/amlogic/meson-mx-socinfo.c
@@ -126,6 +126,7 @@ static int __init meson_mx_socinfo_init(void)
 	np = of_find_matching_node(NULL, meson_mx_socinfo_analog_top_ids);
 	if (np) {
 		analog_top_regmap = syscon_node_to_regmap(np);
+		of_node_put(np);
 		if (IS_ERR(analog_top_regmap))
 			return PTR_ERR(analog_top_regmap);
 
-- 
2.25.1

