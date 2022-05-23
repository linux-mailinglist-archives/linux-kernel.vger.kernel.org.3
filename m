Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41DC531407
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbiEWOQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbiEWOQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:16:04 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAA0BF64
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:16:03 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 31so13790075pgp.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IEAuGR/HVXfKNxohlFsyWT7u2EwcIVLV4lRM5B6XeE0=;
        b=YhkDJVxSTqh/xLBDj2D6Ai7bTj5pNzDjdcSjUT+SvjfQOLxzkiVSyFqY5L4vMu1T88
         tlkCu6MfadrvxTBqRUcbaS046eqtuMFeVjqNeGN4rmTGKEFR41TF+gV6hehrPKKfq8/K
         VoRzImCoRsK+34Eeif6VfMgcqgRQ9Jjgui9dj9hM9tk9XcgDptni52qNM9Wo3VMkKvpD
         YvXVOrTPVxCw1x/nLF6p1nZyGU0p3pzNV8eMFNvmfNJfMooMs26SdUXvm56KIJ04DkaC
         6xKinM0Tm+Gci+1MYFS2Nx2Igf9fvE8WgDNhhCwB+KhueG668ZvpXm4et14n+J4ZEKZE
         omqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IEAuGR/HVXfKNxohlFsyWT7u2EwcIVLV4lRM5B6XeE0=;
        b=vqjrTZJqlagKVpNqGkw0B2C8gEpa3ITJFEiCQfeVYht+MTP0/cyNs3lPN6jOi1dhZl
         bmDNvAPadR/d5hNXwI7JdX3QGCQIGld11++rnD9unGyzuKUrDZpwOaV+sOINEyQg0xkl
         pZCrHJnk7RoFk4WsTvMGRz2yN9G8eXzNyD0zExeSfpDnZuaArce4QAhmmK5/3+2xG2dM
         rYcCW0t5Pu7yYp11EiDZWQuQFIpFesNPGQO1GgB9E4QEDPo4SaSp5aER3bBwnOYCgnhW
         6aKEl1C0OkX5/eXw0dLP8fzCFQh1XNl6QNYcE4OIgYP/U3J+W0DdRMJGxn7MLVMD2gfm
         1uDA==
X-Gm-Message-State: AOAM531ZNwTxbn3BIaYKL6FvyM2bJQUnHO9uOtOm39crekGYYUz7LAJK
        CW7heiCFQ0b0FxM2shmijHw=
X-Google-Smtp-Source: ABdhPJy06qHpnWYH8JEeVhPNxT40lmuACAQhLcBdtI2jREYRNBFTPxacGw0/h/Xi2iK2aAXQy96kzg==
X-Received: by 2002:a63:1009:0:b0:3fa:9996:386b with SMTP id f9-20020a631009000000b003fa9996386bmr667021pgl.441.1653315362667;
        Mon, 23 May 2022 07:16:02 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id q16-20020a170902eb9000b00161b50c3db4sm5150675plg.94.2022.05.23.07.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:16:02 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] soc: integrator: Fix refcount leak in integrator_soc_init
Date:   Mon, 23 May 2022 18:15:55 +0400
Message-Id: <20220523141555.57346-1-linmq006@gmail.com>
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

Fixes: f956a785a282 ("soc: move SoC driver for the ARM Integrator")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/versatile/soc-integrator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/versatile/soc-integrator.c b/drivers/soc/versatile/soc-integrator.c
index bab4ad87aa75..d5099a3386b4 100644
--- a/drivers/soc/versatile/soc-integrator.c
+++ b/drivers/soc/versatile/soc-integrator.c
@@ -113,6 +113,7 @@ static int __init integrator_soc_init(void)
 		return -ENODEV;
 
 	syscon_regmap = syscon_node_to_regmap(np);
+	of_node_put(np);
 	if (IS_ERR(syscon_regmap))
 		return PTR_ERR(syscon_regmap);
 
-- 
2.25.1

