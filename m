Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E9B52297C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240636AbiEKCPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiEKCP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:15:28 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F421683F1;
        Tue, 10 May 2022 19:15:28 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v10so523585pgl.11;
        Tue, 10 May 2022 19:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IAnyOLboazy5po7m/eHBvwb+oiA0ecLXwwnI0Wa0X6w=;
        b=f0wl661H7cQPuRQYqKkPNPPRoaVtAChbJPvbirTud+O7pmInscpk4I7FSSPRzdsTXo
         Kd4SlyyE4r+QFfuEiBAdfKPeKmXkOpV6Ec0NXezSSOeQecNB2BdXMpglYUw3xghB7Udu
         MQENRTnWhVMcGJEW0gh0ig5WQJwAP9oLz6w83NyjmZhxKus+G6LBalazIYOjZOd9ZqdC
         5uMONadIks8ritGT5Su/GXXCzsZv+EwLbp4qESPmakQ1yWHjMouwfZc4Pqv+z8kinYof
         dvTJHhjyrIU/Lbizyttrv0zhc8mL1tNZWgicLHRqmQ0toCK4TQQR9DZkhV1vQiC1aELK
         mHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IAnyOLboazy5po7m/eHBvwb+oiA0ecLXwwnI0Wa0X6w=;
        b=WUlf2thU3+qKmMOT4phNjr4j2r+I0nsq9jfwDiD8qAl62AkihJJRIO0LlEBeQC1H2X
         QffMNmb2T76OsNG+xpnLlR/fjsZIdtgRMXgV6G77460BeTo/Uze8RWT30dBrRNIgDnDP
         mh0avNS0hK2eAqqud2XFt0L4+mYU5lZgCVlK/2/23rlOiB6WpcoFe12wLZnYy9+Wx/u8
         60n1iKe+G3APlu2raBP91R3xhV4fqbrEOtM0mIPDHIkAzCVQLjWuAz5Lje7uoTf8jqtt
         /L8uT987gvUNcOg0IwLm/ouBI/nzBshiHLaxR/pcU7yoaEK9VrXVELWDy+ISJl+tkYWr
         ki6Q==
X-Gm-Message-State: AOAM531arec5tuxNgDwpEr+545AEwBSK4IbelovRbqr2TbHiwerHsBY4
        +HBhs0eIhyN7O1yCvF6ANve8EA7Hnnw=
X-Google-Smtp-Source: ABdhPJz3BWINpHXO5RoZIsI3nhh2DNTzVb3J8N0kq5RlKAOX3+gOTJdpUF6a8/XVXDeFocKdI3YZdw==
X-Received: by 2002:aa7:8c4c:0:b0:510:8573:e7c0 with SMTP id e12-20020aa78c4c000000b005108573e7c0mr21518351pfd.52.1652235327750;
        Tue, 10 May 2022 19:15:27 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bj10-20020a170902850a00b0015e8d4eb20fsm313917plb.89.2022.05.10.19.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 19:15:27 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     andy.shevchenko@gmail.com
Cc:     cgel.zte@gmail.com, chi.minghao@zte.com.cn,
        corentin.chary@gmail.com, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, zealci@zte.com.cn
Subject: [PATCH V2] samsung-laptop: use kobj_to_dev()
Date:   Wed, 11 May 2022 02:15:22 +0000
Message-Id: <20220511021522.1488373-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAHp75Vc+G1JNkxBcpyXge9qsGpT0m4erBV1aEi4bMHDYfE-JOw@mail.gmail.com>
References: <CAHp75Vc+G1JNkxBcpyXge9qsGpT0m4erBV1aEi4bMHDYfE-JOw@mail.gmail.com>
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

 drivers/platform/x86/samsung-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
index 19f6b456234f..c187dcdf82f0 100644
--- a/drivers/platform/x86/samsung-laptop.c
+++ b/drivers/platform/x86/samsung-laptop.c
@@ -1208,7 +1208,7 @@ static int __init samsung_backlight_init(struct samsung_laptop *samsung)
 static umode_t samsung_sysfs_is_visible(struct kobject *kobj,
 					struct attribute *attr, int idx)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct samsung_laptop *samsung = dev_get_drvdata(dev);
 	bool ok = true;
 
-- 
2.25.1


