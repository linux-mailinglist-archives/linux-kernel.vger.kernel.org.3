Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F535A665D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiH3Od2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiH3Od0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:33:26 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57222B530F;
        Tue, 30 Aug 2022 07:33:25 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s206so10856081pgs.3;
        Tue, 30 Aug 2022 07:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=fUwt7yj09XB0Ng50ttOlbYr2HPETQA5wazbCmht9hZM=;
        b=YIEPpO/4BwljrKam4CEanBvRJL9EW3SDkoP2ZVwKPVDHmNoulkmF8hbq/8J5omlqGM
         ASCsm8dxfvvoqhHRjzLseP788VNZ8nM8MlTNzdLoDNpw+RI81Xah4+EuzNN67gQ/U81A
         DCipa8xTsgV8HhJPYKBt8ZHrkPavEVpJxEdvg/CKl/I7BXhQ53BR0/ZHXpaVoWyOA7E8
         3kuYOtyQ+cdEhc4xaRJKX9PouQ3htxsZ9sXqeyLrCVgEdK6r2IWBHk0XE9sqy2a/5B8t
         KI+klDTRdfqdZN5AUirf+2dngiWlDDl0vQz7Aa8LUN3UwLdqpwjm+PgBWh3SguhnQQhJ
         615Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=fUwt7yj09XB0Ng50ttOlbYr2HPETQA5wazbCmht9hZM=;
        b=OAKCe88CTvnXi8e74AJTumij1f56DOJrAobSsdx4WA8msYm10YjoYLiR6SB6nAENIn
         IgCTyEVAW4y3ng7iIR4Kcf+JFSipC+vxioGKIEIelu44eWfgkfgzAk2q6bT4oRuDXbtg
         9ylsCMfHTOjOz91WVOCJMVJvY7xll7rXkGkHpIX34+dnicrKpRODB03ymCJny6o5NWtf
         XBCFnTMxdGAxz02DuEgqneIcN+kuu0cxmr5qgTk+cN6k2YUcgWOAJLJWN9yxkGHwM5Py
         n2HkbxaXGH+hGu5gdI7DAtzfR72hLtrMXN4VfVlud8lqBAu7UwPRD3n/nypMIRXiYEQP
         UsTQ==
X-Gm-Message-State: ACgBeo2RwjNrBnyjd0XfPDvqK2HFR45Uypz/yPy9RW3yA3AMOxEHKrXR
        Q/Y1iQ0aIdbtQfVyFFFtzYY=
X-Google-Smtp-Source: AA6agR6QqrPzpRSg1am4AEwOixlGhH2Ny4FkY75lwCi5RCBm7QuPJwLJEcMdiSL2SGnVbC6gQ+1XVw==
X-Received: by 2002:a05:6a00:1a44:b0:52a:ecd5:bbef with SMTP id h4-20020a056a001a4400b0052aecd5bbefmr21272004pfv.28.1661870004824;
        Tue, 30 Aug 2022 07:33:24 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902dac400b0016d10267927sm1545909plx.203.2022.08.30.07.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 07:33:24 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     stern@rowland.harvard.edu, skhan@linuxfoundation.org,
        richard.leitner@skidata.com, tasos@tasossah.com
Cc:     wsa+renesas@sang-engineering.com, ingo.rohloff@lauterbach.com,
        cui.jinpeng2@zte.com.cn, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] usb: core: remove redundant variables ret
Date:   Tue, 30 Aug 2022 14:33:18 +0000
Message-Id: <20220830143318.299640-1-cui.jinpeng2@zte.com.cn>
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

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Rturn value directly from usbdev_do_ioctl() instead of
getting value from redundant variable ret.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 drivers/usb/core/devio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 837f3e57f580..043d934ead83 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -2802,11 +2802,8 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 static long usbdev_ioctl(struct file *file, unsigned int cmd,
 			unsigned long arg)
 {
-	int ret;
-
-	ret = usbdev_do_ioctl(file, cmd, (void __user *)arg);
 
-	return ret;
+	return usbdev_do_ioctl(file, cmd, (void __user *)arg);
 }
 
 /* No kernel lock - fine */
-- 
2.25.1

