Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96295212E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240437AbiEJK7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238735AbiEJK6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:58:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DCA532DB;
        Tue, 10 May 2022 03:52:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o69so15531427pjo.3;
        Tue, 10 May 2022 03:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJ19cK/envJskyodpfZTbyEN4RvPNH8GFQqBxIv1mp8=;
        b=OqQX04ELVSJkzn03+KnPYLsZV/PfYbrAvIteqwvsBMA95bBx0tMBOfzm37QUmroTp7
         C6XjObXqZIPtcJ16IUFV0OywxvJQdtiHt1vQ3QI0w65BtqO4V83QyAt1QMs108+/tmSy
         J8bhF+HrO/KzjEvBNueFuBVM8NX8dacOzF/u4QgFCHaPmZqRh0yrwpYtOY37g1Tvjw1B
         WePpiQh4WnJe4VO6ZdK4PzqNWZdeD3payqUMSDAZb3p2eA/mrKyvoWtXSWXhchrMA8Oh
         naFgZkwiKYtnpRH+xJ9EvMho9ldUtdpYLIUq0XKEloh8wkh2NSuBTiUi8LDQ/Es/zCFd
         NqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJ19cK/envJskyodpfZTbyEN4RvPNH8GFQqBxIv1mp8=;
        b=6xpa9F/qgTcc7Ppshqpr60/gMKWhMR6ChPoOjP0t+Lorpfx8LeE9sdVQLswmeDKTmP
         5gGeCFx2MF5vm7MEFbqlSFckAOjYaTi63EdZ9PPue6Wv07hWib05SKX0tWoLTBSLMFOa
         0kqgkEFmKgTIlyzhuUAffWWOL+wiklFE9bwCwAt60GJBRBCZb4dIB4hVrHMVAtt8e7UJ
         zo2hEb2dlLgt7Qr6iGxQ17p3+wPwMT6yY30tuNGhDfdtkxIsrWHNLmafo03Csbx4kYjx
         SXJF7axhB66ObSr8jh9wf5LkTA5XE+Skk9tsorDEgJr189yhHj6rDKKuz536evXSSFiR
         4awQ==
X-Gm-Message-State: AOAM533n3jIPygLXsgof/rU5F0gO7ROaHZoZz8ZTD2ZrX/dfgeElsBbD
        CXhkSIhWj0zM4g+3EVlL77A=
X-Google-Smtp-Source: ABdhPJy2AlVyshNEMGtTlQ5Qqj2C39ByBFIUe0dpJOjCLSjfphGlb1eCyT4322y484FXlMN+Ep2NLA==
X-Received: by 2002:a17:903:40cf:b0:15e:9bd0:2cab with SMTP id t15-20020a17090340cf00b0015e9bd02cabmr19787997pld.170.1652179946124;
        Tue, 10 May 2022 03:52:26 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b9-20020aa78709000000b0050dc7628202sm10230135pfo.220.2022.05.10.03.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 03:52:25 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     coproscefalo@gmail.com
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] toshiba_acpi: use kobj_to_dev()
Date:   Tue, 10 May 2022 10:52:22 +0000
Message-Id: <20220510105222.1352180-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Use kobj_to_dev() instead of open-coding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/platform/x86/toshiba_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
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


