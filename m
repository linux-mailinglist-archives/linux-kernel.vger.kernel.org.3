Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BC8531243
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbiEWOCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbiEWOCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:02:18 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE9C5005D
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:02:15 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 10so9741634plj.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/uPYvFeZZTkSS8WJjVNbiWQjecsqWmcRfd8xMpRg01E=;
        b=P3PHrmTAKhkPTFWosISHQujRQUzSuvYr35CbU+SPaqg2lslJhSb5IyhvSw0mzzk9kR
         82VlQKVbOpAqMmhcG7IX6OeFBEZp+1hl6ojaXwFqjLlN/G0vLW8Mh7DfPebUGmT2oki6
         SuvLQOxErrRKGAlI4FhXZ27F5tjbsx1XMsJX2M4LoiA03rh+VZvGDVyLCSXgjXdbwmSz
         bbmNG/+XdAz7/JLXaFY+53DLwEhWI6AkVCxzEEdDlHT9VmAQ8fm9PpyHyQkh0BMcBboR
         abIYgucvKt8pUeTdldsxwNL2sCrMeEAGZQLVYAkduBTspicz7QzptSqQ34NPk/yyfIND
         ++tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/uPYvFeZZTkSS8WJjVNbiWQjecsqWmcRfd8xMpRg01E=;
        b=t0fGtqUb4OQaO9VAxdESEwgn7yh9LvigvAgK3ZjxWz7Cl/PahTkPWCRiaH34nDeSxy
         YqLGmHrVoMz+7bD8/82WiuUAx50/V9G8KNEzTy7yACs+6cakRxxxRYOH/EhSc5VDrK26
         4xCRMMAw3ribE50qZm9yCc0XR2Qeh/LtMEXIhkjX0pmUhkIN0p/BveKcfp1I9zTQuKZg
         HSKIj0UU4FcgN0UdKNdb6S+OZGyXsQvYfERTcM86mA8ic2PysktBeNG60lk63IBXohND
         47YHHo9BLz+0P2DhXb9GiFCRl77LXlW1FG8WEflof5os539jEDFFeTSUt8eOWL/tOcVK
         bBjA==
X-Gm-Message-State: AOAM531JXJ9XLBabShxcUg5bqLaTF+yxyXybhJflsNqH6vJ8xOWRcuWo
        VRU6IxvpNK3u7IwX+IpsuFk=
X-Google-Smtp-Source: ABdhPJycRpTQOgsr2QIRd/XkuP5twDc97y3ftQbX8ngGJKEKcSlErTYDksg8GPnzJ06vkOrXGmWP7w==
X-Received: by 2002:a17:903:32d2:b0:161:d485:613f with SMTP id i18-20020a17090332d200b00161d485613fmr23118997plr.173.1653314534606;
        Mon, 23 May 2022 07:02:14 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id i5-20020a62c105000000b0050dc7628169sm7203366pfg.67.2022.05.23.07.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:02:14 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] mtd: maps: Fix refcount leak in of_flash_probe_versatile
Date:   Mon, 23 May 2022 18:02:05 +0400
Message-Id: <20220523140205.48625-1-linmq006@gmail.com>
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

of_find_matching_node_and_match() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: b0afd44bc192 ("mtd: physmap_of: add a hook for Versatile write protection")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/mtd/maps/physmap-versatile.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/maps/physmap-versatile.c b/drivers/mtd/maps/physmap-versatile.c
index ad7cd9cfaee0..297a50957356 100644
--- a/drivers/mtd/maps/physmap-versatile.c
+++ b/drivers/mtd/maps/physmap-versatile.c
@@ -207,6 +207,7 @@ int of_flash_probe_versatile(struct platform_device *pdev,
 
 		versatile_flashprot = (enum versatile_flashprot)devid->data;
 		rmap = syscon_node_to_regmap(sysnp);
+		of_node_put(sysnp);
 		if (IS_ERR(rmap))
 			return PTR_ERR(rmap);
 
-- 
2.25.1

