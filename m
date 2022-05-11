Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64676522981
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241047AbiEKCQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiEKCQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:16:44 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAE481644;
        Tue, 10 May 2022 19:16:42 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id v10so525638pgl.11;
        Tue, 10 May 2022 19:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=buRI718RFPrTtdiRLJoEyVax+0RYy5X13JOpEpadUuU=;
        b=O38Tu6+beNDnnVNtxh7fOgBixYQaJXblJOrMVxDv629pCOwVzoPH1O4x3it3LR9GWm
         WmSwqKjedt/f3uWUmwbXgxDqBSAIELGRm2sEUwe7zPkn4uf9k9o0tjRlGY+58AlIX6f+
         3ivEDQw1au4QnXgkrtPV5V6tcCB889NVaX4KMa3/OvLO/e4P1RmYFS4c1cySw6G2UaaJ
         pNIW64MLUCJlsBgvHGUQWppfXYV34agKMin093B8ASOXxiXK3SArgPcUhCo7v7WYjCM0
         rIOBwuwZccdegIbYgwgn1cocMgNXJkytVusVODABrIKITsRpgDWE9bUwm9seX6/2SraB
         oWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=buRI718RFPrTtdiRLJoEyVax+0RYy5X13JOpEpadUuU=;
        b=VYiwUQgLjrm62sRwqRJz0EIW3FGOvvN92JJvTdeJQ91c48mskCSy7k5lz0krQ/fWhK
         okj2SWzfm46tRe/U+J09zyoVK97vULTJcbwFqEH86iK3Tbl7cVidCPCot3YZlg/mWkQa
         ZVlEdn+9WpiCSM8TVRDCEAceGgOp2nuEc7hvc69MQF3nxmmBLnpUm8QbacWFK2JvJYan
         z4wYrez3KVYozjL1UTa8BLx7bU61k9y332+65c25SwDLu3ylOuuB8Jt6mLrZmDDyAcJr
         DG8qr36FpodCGin9ym7b0NK85x3jBqDGRgdERijfK7d7CYrPRqOZargMqCqCia9TQsBT
         bZaw==
X-Gm-Message-State: AOAM532Wa3qVJByOYnjChE+vQcjbH+VCSuju1ORmwfe7Y/oUKXnhbQjn
        WOotTTh2pBpfguGG0bGwp7BoAcLCxo4=
X-Google-Smtp-Source: ABdhPJwSTNC7XV5g8rgzvLhMnHke+15+xCA+f/9KoLJUeFW2q/tcqIfUyrGoJdlVs17dXjSkPjgyjA==
X-Received: by 2002:a63:d241:0:b0:3db:11bc:8d6e with SMTP id t1-20020a63d241000000b003db11bc8d6emr2313497pgi.229.1652235402492;
        Tue, 10 May 2022 19:16:42 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j12-20020a17090a2a8c00b001d792761e2esm2566405pjd.47.2022.05.10.19.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 19:16:42 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     andy.shevchenko@gmail.com
Cc:     cgel.zte@gmail.com, chi.minghao@zte.com.cn, coproscefalo@gmail.com,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        zealci@zte.com.cn
Subject: [PATCH V2] toshiba_acpi: use kobj_to_dev()
Date:   Wed, 11 May 2022 02:16:38 +0000
Message-Id: <20220511021638.1488650-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAHp75VfzbWAS6phV3eB7ehe50NrXitkuS54sYjdVK-OqqYVieA@mail.gmail.com>
References: <CAHp75VfzbWAS6phV3eB7ehe50NrXitkuS54sYjdVK-OqqYVieA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Use kobj_to_dev() instead of open-coding it.

Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
v1->v2:
	remove Reported-by: Zeal Robot <zealci@zte.com.cn>

 drivers/platform/x86/toshiba_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c
b/drivers/platform/x86/toshiba_acpi.c
index f113dec98e21..0fc9e8b8827b 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -2353,7 +2353,7 @@ static struct attribute *toshiba_attributes[] = {
 static umode_t toshiba_sysfs_is_visible(struct kobject *kobj,
 					struct attribute *attr, int idx)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct toshiba_acpi_dev *drv = dev_get_drvdata(dev);
 	bool exists = true;
 
-- 
2.25.1


