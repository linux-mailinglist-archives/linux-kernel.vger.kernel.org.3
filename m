Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D45C4F114C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245702AbiDDIuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241883AbiDDItq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:49:46 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFA93BA5F;
        Mon,  4 Apr 2022 01:47:51 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o10so1663154ple.7;
        Mon, 04 Apr 2022 01:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6lQXVT/uUsnfVE8WcNYNQC83df5wSK/7H6QlhzyGSpQ=;
        b=KHLiQpb41/Jw+rhklJELDpaMOhckeHIcsw9AtQfrQZVhXUpiSvQOoEqLOWnWZt5N1z
         fvw5nL32fYw19ijPqYbuxD1CKpEfwJ5AWt/SVteFr4bVvwv6VdXylzhAcHNAJ2DDNUoD
         uJYWZuWDo3vo/IlAuNirkKPlaCiPaYIxYxkT6R1KdmrLjESBZ8q1NViVRwLfWSDjIaJ1
         zHy5Alslrx8QGBPFt4DtgHTz7U+DYAGT0DlpOpDG4CIRSZnMFJxfQ1HxmLAHtuNWexeX
         KsPVNi1JlUl1f0C3+1/nq7L4cfl9ib7E3+w4a5wLnn86lSz0M+PNAdC0Jm3TUXKx2Yc3
         IyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6lQXVT/uUsnfVE8WcNYNQC83df5wSK/7H6QlhzyGSpQ=;
        b=4q1Pj6gP3mQJAmitA3+OVSu8pkvIAYXQv3mRT9gSdrO7sOTOV6XuojrLW8mkHL3/UZ
         SKXj8it6iHnMV3tSZ6FIMQehDDbYKKQA9l/tNDv504I3l41wRX7Ddzfay4oYVzVpZz3Z
         RvFRjmSqayWUYhhAVmWXKUjuFs6yMcr9KcsMZNPHjzdHgAsqiJk79U7ECkFUgkt/ky49
         nMeR8jd1UkzJhZjZKFRHFcFJOi5YKSHi3slztLZCcBz9fSXaygzXpN1jaj1CVXYJ4Z62
         G0kjav7U0RxF0IJ094+Hy/Cfewm/VsOTAgjm/duqH9EOk+jDB34ZFlrRJrYIBtY38uZI
         9QKg==
X-Gm-Message-State: AOAM532KeJwK1H12LxHiv99s2Y2GAXc/cjqOICd/0tPw0cIZ1Ey5Vjcb
        CcZuYiI9MyRET2mRMKkZzw==
X-Google-Smtp-Source: ABdhPJz4d1wgPvWQSKcf0Ti+XkoQbDjoaZEPj5OUoHAmUr4JUgtLaBghkz4cZl6tbHh/c+SMdrjEVQ==
X-Received: by 2002:a17:902:7887:b0:156:788a:56d1 with SMTP id q7-20020a170902788700b00156788a56d1mr10208376pll.110.1649062070526;
        Mon, 04 Apr 2022 01:47:50 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090a3fc600b001ca88b0bdfesm3991960pjm.13.2022.04.04.01.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 01:47:50 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 2/7] video: fbdev: neofb: Fix the check of 'var->pixclock'
Date:   Mon,  4 Apr 2022 16:47:18 +0800
Message-Id: <20220404084723.79089-3-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220404084723.79089-1-zheyuma97@gmail.com>
References: <20220404084723.79089-1-zheyuma97@gmail.com>
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

The previous check against 'var->pixclock' doesn't return -EINVAL when
it equals zero, but the driver uses it again, causing the divide error.

Fix this by returning when 'var->pixclock' is zero.

The following log reveals it:

[   49.704574] divide error: 0000 [#1] PREEMPT SMP KASAN PTI
[   49.704593] RIP: 0010:neofb_set_par+0x190f/0x49a0
[   49.704635] Call Trace:
[   49.704636]  <TASK>
[   49.704650]  fb_set_var+0x604/0xeb0
[   49.704702]  do_fb_ioctl+0x234/0x670
[   49.704745]  fb_ioctl+0xdd/0x130
[   49.704753]  do_syscall_64+0x3b/0x90

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/video/fbdev/neofb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/neofb.c b/drivers/video/fbdev/neofb.c
index 966df2a07360..28d32cbf496b 100644
--- a/drivers/video/fbdev/neofb.c
+++ b/drivers/video/fbdev/neofb.c
@@ -585,7 +585,7 @@ neofb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 	DBG("neofb_check_var");
 
-	if (var->pixclock && PICOS2KHZ(var->pixclock) > par->maxClock)
+	if (!var->pixclock || PICOS2KHZ(var->pixclock) > par->maxClock)
 		return -EINVAL;
 
 	/* Is the mode larger than the LCD panel? */
-- 
2.25.1

