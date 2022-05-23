Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45DC5314CE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbiEWOKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiEWOKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:10:19 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04616590A1;
        Mon, 23 May 2022 07:10:18 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gg20so14190024pjb.1;
        Mon, 23 May 2022 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R3RSpzzzY3JZZbYrwfIv8X7HA01iUXqRO11CiRRnNTA=;
        b=CCaXciB0HrPIfHW4OYFfp8Xu+XcV8jkOLQieBcUvCvw8ktgh5+W7sS5XCmfgoOqJvA
         FUdVGvohBwrH3OxvN/j1TSAbchsq5yCUjHPRuQcKBR8FVsN2+G2ZamzujfGCBiM4WgB4
         HhhJ1XuXymf7noXgUUUr6Acs81sv4GIJWCbN/SoEwti9MLDODJT2GGX2JVsB9XWLgA7t
         usBMPdNt083prkxSZaF6Y1BkfuQPQz0SKOUGTIGPM8YMXmlkw4L1hBjlkIxKT0+6z4U6
         Awn37ymRsYTm0+R4subOFSdGXLv9ETh+rqKAhZq9/mehFGeO8g27zTnKeDWaa7nCTmlx
         1Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R3RSpzzzY3JZZbYrwfIv8X7HA01iUXqRO11CiRRnNTA=;
        b=E8LQJLBklBFfH/MbUgF/Jl+p72kYc9nP6N8KDqvI03qJbNsxAySSVLrB9xa6AGVRJ8
         AVD1whkyAeFkYa8nB0M+9I+SYY8CwAVA3rtpEspafDnsGdLsfEUa8RNy83vYTfiaMiId
         e3/M5TeK3pOq40BAbqPBiqiMqxlNdRgjAz5B6YqmVBpWzuakd9NYddju3bPjUkWYrdPf
         BsfYgbTuDcoq0FxbrrW4F0q/Y/cAPVLY4xiVk0JJiK242zUvpXMEun5wiLeZIlSJO+EG
         auBpoy8d3XbuOm4DQUjvVxpPv+ya/rPad0VeCtHg95TI9llEQJvuLkyqzZs7xDRkL2ZP
         Lmog==
X-Gm-Message-State: AOAM533cpkP0jhyQkPTrp+MCF2GZlw663xj2oGewwR/cEuxgEut+3oo5
        0Wo+te2PVxFu9fQmZx8dmXcnRFxeUvtH+Q==
X-Google-Smtp-Source: ABdhPJwnwzZ247rGnWWT561/VOBtHcUhdKJaqnbkD3UvumIf37wGGxc3SxdbdgOwKLJor6GuR3pLNw==
X-Received: by 2002:a17:902:a517:b0:161:e5f2:9a26 with SMTP id s23-20020a170902a51700b00161e5f29a26mr19611785plq.132.1653315017546;
        Mon, 23 May 2022 07:10:17 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id jb11-20020a17090b408b00b001dcf9fe5cddsm7225190pjb.38.2022.05.23.07.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:10:17 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] power/reset: arm-versatile: Fix refcount leak in versatile_reboot_probe
Date:   Mon, 23 May 2022 18:10:09 +0400
Message-Id: <20220523141009.52965-1-linmq006@gmail.com>
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

Fixes: 0e545f57b708 ("power: reset: driver for the Versatile syscon reboot")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/power/reset/arm-versatile-reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/arm-versatile-reboot.c b/drivers/power/reset/arm-versatile-reboot.c
index 08d0a07b58ef..c7624d7611a7 100644
--- a/drivers/power/reset/arm-versatile-reboot.c
+++ b/drivers/power/reset/arm-versatile-reboot.c
@@ -146,6 +146,7 @@ static int __init versatile_reboot_probe(void)
 	versatile_reboot_type = (enum versatile_reboot)reboot_id->data;
 
 	syscon_regmap = syscon_node_to_regmap(np);
+	of_node_put(np);
 	if (IS_ERR(syscon_regmap))
 		return PTR_ERR(syscon_regmap);
 
-- 
2.25.1

