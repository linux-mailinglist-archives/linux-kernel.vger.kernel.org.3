Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848F0590A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 04:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbiHLCz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 22:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbiHLCzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 22:55:48 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D24061129;
        Thu, 11 Aug 2022 19:55:46 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m2so18543227pls.4;
        Thu, 11 Aug 2022 19:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=4V+srtUP/XvzP/j2oB3pMS4rLsqrIlMM9Z63xf/Nr1g=;
        b=fALtvvpw9MsvH1m4qFLYNCiUthZgcprhb/l9uNQEfDfS3XVKFGY9nGPkPMAW8sEcXh
         j5GfCH2mWGdQZNTkrhYnrrrzc4aWmgnF8FPBQNGzrdnv8L+Rcjnr63VNZ5Tb0aFOCD6n
         aTIwM2UTzHkWcTQmf6SULwaDtkK1tlobF1UVYenJs9a/Z3oLuFlFALpg/HjAB4Dhj4XX
         vno+EhnMJZ4uimJJVvOHHIjYgKVHgp/UEsy5xBxJIaDMYQVtW6kCDEx4ZyAyi9NzN2Uj
         v94rfomvekslFvAGxR8ioq21TMKV1vdjPb1n8EPpWfvZzA0uOfZ/AB2TppUWdMpOA/rx
         zutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=4V+srtUP/XvzP/j2oB3pMS4rLsqrIlMM9Z63xf/Nr1g=;
        b=fiHr84AdgG2Yl6Mtnfz3FslfYLInageV6EPj8fzy1GWi/vhZtwtDtd+0KrcvAL0rv5
         XJl1R5tmGEcQk1xh+T8GpSr8822fkn/xb9mbt82bxJYOe5VKAMvTyB4jwL3UyKkNWydZ
         9dNYINhqg5mLh70YRwjTIYfQZD0AwmgQBzd1iCyW0g2P8KeMDKKvxaRw/morsKNXBHe/
         TpxgbKS9W/TVsq/gC4rt+GQrbJqVZDEOy5LIZ0rAfO32OU64ezVwTLBsxJnLnz1St9fk
         I48PwSm3rfF4fSit2Fjyj67tBMMyOXPtYLYeIRlFFas1nnJ0YUwDWsd9PKnN/Ep/5O3H
         GtuA==
X-Gm-Message-State: ACgBeo3V+S0T4dEfxycvy7ZtEyNcYiuALg83Sy5qKD/50aVNhPjkxtLT
        7qxwSC0ZcAfbu9dDlJ5IlUhf7qNnmRDmiQ==
X-Google-Smtp-Source: AA6agR55WD22+CqAEbzak06JCKHHLDVA5juEWhz96/RvN4W90rMYEidoPpqJBXmK/oKhPizoGI2Wqg==
X-Received: by 2002:a17:90b:4b4c:b0:1f4:da77:3f80 with SMTP id mi12-20020a17090b4b4c00b001f4da773f80mr1942581pjb.55.1660272945485;
        Thu, 11 Aug 2022 19:55:45 -0700 (PDT)
Received: from localhost.localdomain ([129.227.148.126])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090264c100b0016d10267927sm399340pli.203.2022.08.11.19.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 19:55:44 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     lains@riseup.net, jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] hid: hid-logitech-hidpp: avoid unnecessary assignments in hidpp_connect_event
Date:   Fri, 12 Aug 2022 10:55:15 +0800
Message-Id: <20220812025515.19467-1-hbh25y@gmail.com>
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

hidpp->delayed_input can't be assigned to an object that already call
input_free_device when input_register_device fails.

Fixes: c39e3d5fc9dd ("HID: logitech-hidpp: late bind the input device on wireless connection")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 68f9e9d207f4..c3602bf8f9b9 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3959,8 +3959,10 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	hidpp_populate_input(hidpp, input);
 
 	ret = input_register_device(input);
-	if (ret)
+	if (ret) {
 		input_free_device(input);
+		return;
+	}
 
 	hidpp->delayed_input = input;
 }
-- 
2.25.1

