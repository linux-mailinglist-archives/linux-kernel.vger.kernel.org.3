Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E2D547D71
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 03:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbiFMBbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 21:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiFMBbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 21:31:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D262F10FFD;
        Sun, 12 Jun 2022 18:31:22 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id e9so4302330pju.5;
        Sun, 12 Jun 2022 18:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B/tXSka1WN37Dsk7yd+7cqxFlK5QPU6UEZJReaGSWJg=;
        b=OUsHOmGhX8vvwvZCdkcj65eCPKECMo6pROFKQ0ec1bcNFSWCd1UnbqMACAd0kgWPWT
         0F1jeYwLOVAfRvNOZQWzWSxRUqTM/ZEJD3kt5msfYEKTkkniU3iC2++x+cD+VaFC1gL/
         DpoWIahwHcBT0sAver63ndgcEoyDx1GIqGsr5WP+tLib7+G1HJqwhiwpLJ63hhmzO5Lt
         7Ek8Mt8M27JKjRz0uWrwBe33PAFdyCl/1xsF7RPVJv1AdXRdljZIa4j3T2k12g0eB0pm
         Qh2T+OCfBgncAAzUKGIX22TcgzCFoxC0VgpY8FZnwc08DC9Cw91oSTTX6E2BRio8utSY
         teXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B/tXSka1WN37Dsk7yd+7cqxFlK5QPU6UEZJReaGSWJg=;
        b=OiKT2N9bICLoE3z4wu+HqaRG0bdrJ7sEQLtINhiPZsIEVZZJFUGbVQyEBz6FZ57PFY
         wChDIQUQm9DgqDkTQdqD8krDddygo7o5ex4QQgqnfcBNY30iN+bgmOsOCVpK8msygrpq
         hWX474l25sv6mjC2ekWMEuJnqmSApXIhBMiVgqRUC4cXj4U0ptiAy6jG70s7I4mb6w5Q
         eel+u/flGz49nkNyc0iIHI5qTlb2MUWKBXdXeq2Ou1az0WWIm+SkFm4TnR+vTeQJBfb0
         5UCkkxHQevfkxi0swlrkDbDgbaTvJEJOlOnzdPo6TYshuUKLL0V+5x6GW0h0RNEPO37E
         w6hg==
X-Gm-Message-State: AOAM533XFTOwzwOfKl5fq7UyybJmxVPLRkndq1rahwz9Dm1FCV5t9v0G
        V+J45CKVC2DI/Dx0t2k6CNFn8mJTxpY=
X-Google-Smtp-Source: ABdhPJxdFcKpYemPoANAFGgzGDgwyCVgJlJvWhDv5N3f+o8H7h5ZxbIq4WYXg7ygYLWEDxS54XjNUw==
X-Received: by 2002:a17:90b:1a8d:b0:1e8:a809:af4b with SMTP id ng13-20020a17090b1a8d00b001e8a809af4bmr13093766pjb.76.1655083882346;
        Sun, 12 Jun 2022 18:31:22 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id jg21-20020a17090326d500b001679a4711d9sm3669050plb.162.2022.06.12.18.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 18:31:21 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     gregkh@linuxfoundation.org
Cc:     olebowle@gmx.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH V2] usb: core: Remove redundant NULL checks before kfree
Date:   Mon, 13 Jun 2022 01:31:16 +0000
Message-Id: <20220613013116.900591-1-chi.minghao@zte.com.cn>
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

Checking a pointer for NULL before calling kfree() on it is redundant,
kfree() deals with NULL pointers just fine.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
v1->v2:
	remove "quirk_list = NULL"
 drivers/usb/core/quirks.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index f99a65a64588..9ec12c42db30 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -56,10 +56,7 @@ static int quirks_param_set(const char *value, const
struct kernel_param *kp)
 		if (val[i] == ',')
 			quirk_count++;
 
-	if (quirk_list) {
-		kfree(quirk_list);
-		quirk_list = NULL;
-	}
+	kfree(quirk_list);
 
 	quirk_list = kcalloc(quirk_count, sizeof(struct quirk_entry),
 			     GFP_KERNEL);
-- 
2.25.1

