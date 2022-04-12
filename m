Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAE44FDA38
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379959AbiDLIVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 04:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351752AbiDLHdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:33:11 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EB15006C;
        Tue, 12 Apr 2022 00:08:39 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id bo5so16713771pfb.4;
        Tue, 12 Apr 2022 00:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=4fzpyZsSZ8MB/OESakwuykL/h7QjXDh8jwM2tR5aekQ=;
        b=L8aAup+xdNnWuw249ZD6hgE4GGJ9esOXKuRAdS5MHIf46QB1cv/i9GFgnMEI44oshf
         78kk0faDuNwDF1mKY2mjrpWztlmGM8Qy+MCDc3T4yREVXIgn365mz5+WNOlaF1HsS7Ls
         ItDLUIa061z/9azpxGGajCR3HGDsUw03dWM6Phpion1hAh5JW09QQD6BiyUEK8ZTaRrL
         CXfH7uZ/gFwPHGzBXjp1KpAWASso1plw6K6TKMMLs1e4OGgbjeljWg71dmfbWlXd7xxH
         bRPQv4xVouA8gVgrjr/mQfcNXjwfelD9vmDPEFICJvL78el5uqWL9zQnJWcTRydmHpAK
         lv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4fzpyZsSZ8MB/OESakwuykL/h7QjXDh8jwM2tR5aekQ=;
        b=c9HwYGWA/ilhMdIDkeqCcP6KNquDt8FiIk0HHDVzqnJ40497+xAtlyCFG9IkoSXFNY
         zAYvHQ0nYIRDi8DJXoedKshHTopPdtodO/Zw+32cHudPI/jWPU4kRwCuqHHQEvl3LS85
         8d3MAldr8AwSVCO+O5l58ijZsIo3/ph1vQnXXK6fzalmJskLdbIbvlQf+yRw3LZwv3B8
         KhvTPkSqwsMhfJLSMRn/CMAPuc2QbtQN5Cd5LYgUXYO9Ks8hWxN0zgMAEANrBkNv3cDl
         8g2ClfPoMJmlX9tUMGsdUCPkbqQ5/XKTcWSOFjHNgGyWFFAuM+o9QkZnG6sG0y5foRWu
         R46A==
X-Gm-Message-State: AOAM5314BWiWe7RRt/euCILim2STfZlID0dZYsT2mympCQ0hAR3S/tLR
        ME9HpRfIf8SCa5v/RZnVRJM=
X-Google-Smtp-Source: ABdhPJwwpBGQ1fiwAHZgJjr2E7llUx7x4MIkQUIYOKYPbOYwpYHkouXoGJ70QjdXZI0bjwmmW0OT9w==
X-Received: by 2002:a05:6a00:1903:b0:4fa:fa9e:42e6 with SMTP id y3-20020a056a00190300b004fafa9e42e6mr36721734pfi.1.1649747318954;
        Tue, 12 Apr 2022 00:08:38 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id h19-20020a632113000000b0039d9c5be7c8sm763916pgh.21.2022.04.12.00.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 00:08:38 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tero Kristo <t-kristo@ti.com>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] watchdog: rti-wdt: Fix pm_runtime_get_sync() error checking
Date:   Tue, 12 Apr 2022 07:08:23 +0000
Message-Id: <20220412070824.23708-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device is already in a runtime PM enabled state
pm_runtime_get_sync() will return 1, so a test for negative
value should be used to check for errors.

Fixes: 2d63908bdbfb ("watchdog: Add K3 RTI watchdog support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/watchdog/rti_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index db843f825860..00ebeffc674f 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -226,7 +226,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
-	if (ret) {
+	if (ret < 0) {
 		pm_runtime_put_noidle(dev);
 		pm_runtime_disable(&pdev->dev);
 		return dev_err_probe(dev, ret, "runtime pm failed\n");
-- 
2.17.1

