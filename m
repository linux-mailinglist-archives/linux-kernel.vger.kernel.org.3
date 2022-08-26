Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EB85A222E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245533AbiHZHpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245557AbiHZHpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:45:15 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA7A6B655
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:45:13 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y127so837190pfy.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=qIh8T4+4nOwG9GFhkeivft0t29HmdMlLLogsNGytBt4=;
        b=YO8O7tpev6lVgcxchYkRVcQ6hFDrP+lFEu8x2WdB49uULsX4NDK+pYzZq2mjY1aaNO
         YIVEzlBLL5QQTtbnDZnv7KV+vCGI7b0QktibVCNxznZyArvhMwU2y+porhxQELMr2ANH
         Ah7UGB6Jf/1Z/MYlITTd/PlDMHY4TzxGzi2Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=qIh8T4+4nOwG9GFhkeivft0t29HmdMlLLogsNGytBt4=;
        b=keIWWNZJy6KCt1IMh8XMrlWPRqcoPDRcyVKfytwUwzaLdnpHPbVN7pBISGXajjY7wq
         13RoGHkeM68fi07RSPBcm1+xBZzLRh81KpobFTiXNAgpIlR+yXWTDuBia8AWTxVVfj5O
         vrO8pughpUVvfwmvcpi8LaSbp24yARz6yK/sqvi4Dd/fUW6vp4Q0r0Dm9k0tOQk96/Yp
         zS/5lQrpEfmUZlJlh+syJXvbCTriIMXwQc4x978y2yDYuyh40r7JjXseAgQZ75w4AObC
         KYXvyCoBR3QLaP6PIGw/wgydB6OPF+t8w4AwUouDBJkIVk0ftwuFVwUijNesr+/wNkv8
         pUeg==
X-Gm-Message-State: ACgBeo3xQzCQsE453K3uUYTkJfpRBGHTFQogZbr1neseTPHKjdMh53kQ
        SR9c9ndw7J4oPgEZJ4JYZiMdCCQ3y8Shfw==
X-Google-Smtp-Source: AA6agR7V0nJEYo+vZ6oEyQt6Lh08k0kUBlPTQ7+pfNeEXy0eMbx8w7SA+6es/3lIo4WTWX7ekaQasw==
X-Received: by 2002:a63:4c05:0:b0:41d:12ad:e885 with SMTP id z5-20020a634c05000000b0041d12ade885mr2384548pga.130.1661499913066;
        Fri, 26 Aug 2022 00:45:13 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:2e1e:8706:dfc7:5c74])
        by smtp.gmail.com with UTF8SMTPSA id u9-20020a170902e5c900b00172f4835f65sm851422plf.271.2022.08.26.00.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 00:45:12 -0700 (PDT)
From:   Mani Milani <mani@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Mani Milani <mani@chromium.org>, Jean Delvare <jdelvare@suse.com>,
        linux-i2c@vger.kernel.org
Subject: [PATCH] i2c: i801: Prefer async probe
Date:   Fri, 26 Aug 2022 17:44:30 +1000
Message-Id: <20220826074430.1333272-1-mani@chromium.org>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This i801 driver probe can take more than ~190ms in some devices, since
the "i2c_register_spd()" call was added inside
"i801_probe_optional_slaves()".

Prefer async probe so that other drivers can be probed and boot can
continue in parallel while this driver loads, to reduce boot time. There is
no reason to block other drivers from probing while this driver is
loading.

Signed-off-by: Mani Milani <mani@chromium.org>
---

 drivers/i2c/busses/i2c-i801.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index a176296f4fff..e06509edc5f3 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1838,6 +1838,7 @@ static struct pci_driver i801_driver = {
 	.shutdown	= i801_shutdown,
 	.driver		= {
 		.pm	= &i801_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
-- 
2.37.2.672.g94769d06f0-goog

