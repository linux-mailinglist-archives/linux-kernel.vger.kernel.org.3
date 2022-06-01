Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F00539C47
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 06:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241770AbiFAEch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 00:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239901AbiFAEcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 00:32:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDF436B76
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 21:32:30 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p8so850205pfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 21:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u8oXvzgsPDokGXbbQqW5mZSJKLe9u7jo42pqhyNk1aU=;
        b=lny4u5WEB0SwnVl0DcBe75qccs2CaDXsu0LXbNUyLS1k6N9c8LQJaO8Zmw0qhvT/4p
         xqjWuIVwDYYGF1ocsDpxv3tVhG2EnFsgSO7Z7MAirCiC4ismUjVSUd2+qlYSD6gx0ImS
         fFJovZim/t0ELzy6Lv5HPuCp4DmCKTn47JuKAageXVOfoaVboPa1o7l7DavhCAFs8zAX
         e1Y5lK91cJ8f3spV+yBpSDzcCEGYEbGCswHIMknMbQf+Yo7dg7q3dJoL4Y9vxXXzoD1R
         FzhN7BqNntTXqAjwRQobN8MCu8PJzebCjOzCFWjj9kL4W8enF4/JoUjmT14AbPbv1w8I
         mROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u8oXvzgsPDokGXbbQqW5mZSJKLe9u7jo42pqhyNk1aU=;
        b=N1yMug/QfP5FKdy8eqR1UD2QrGPBGHkNe/e+bE5fdWzS8tpWCWHndKqdHqJb4cgFVJ
         IFIwex4DaBjsMFjL1dkmJxVtmrNsrOTK1U3Ff+pDYhjW83m0XMuYtw0vFKKN71YHnNZn
         r//XB4Cflr3ahiuUvcrU9Zns+dJSGwu03ib4/xfPtoiHogeE8Elm6AXkVowtQx9j987J
         gj6b8AOZWhYGNwzaspREzN5kroFzRanywAJBRjNIgD98kchgS0ixGPWd7nFgAsIzvSr2
         5Oai9fkCK+8duD7nPNqMFrpAwTLn8YwewjEhDVk4hqfRltzoFohewcr8Va9uM2KFwdsd
         p4+A==
X-Gm-Message-State: AOAM532g5eNoYqaeQ1T3g0YzQlql817oW9wR/R5/Aowkouaj35g/8hSB
        itWngywUHMzOhNLhLqVNyrE=
X-Google-Smtp-Source: ABdhPJyfVbNso+tpXyAJ+XD1Q27S1YS0bjqC62No760mtWEY7ybVq4VRDo37XrajFkOrG5pEGDwSpQ==
X-Received: by 2002:a05:6a00:234b:b0:519:c7c:e58b with SMTP id j11-20020a056a00234b00b005190c7ce58bmr30615598pfj.32.1654057950220;
        Tue, 31 May 2022 21:32:30 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id x28-20020a056a000bdc00b0051ba90d55acsm284125pfu.207.2022.05.31.21.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 21:32:29 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] mfd: max77620: Fix refcount leak in max77620_initialise_fps
Date:   Wed,  1 Jun 2022 08:32:22 +0400
Message-Id: <20220601043222.64441-1-linmq006@gmail.com>
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

of_get_child_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 327156c59360 ("mfd: max77620: Add core driver for MAX77620/MAX20024")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/mfd/max77620.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index fec2096474ad..a6661e07035b 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -419,9 +419,11 @@ static int max77620_initialise_fps(struct max77620_chip *chip)
 		ret = max77620_config_fps(chip, fps_child);
 		if (ret < 0) {
 			of_node_put(fps_child);
+			of_node_put(fps_np);
 			return ret;
 		}
 	}
+	of_node_put(fps_np);
 
 	config = chip->enable_global_lpm ? MAX77620_ONOFFCNFG2_SLP_LPM_MSK : 0;
 	ret = regmap_update_bits(chip->rmap, MAX77620_REG_ONOFFCNFG2,
-- 
2.25.1

