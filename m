Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53845547BF8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 22:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbiFLU1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 16:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiFLU1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 16:27:12 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC071CFFD;
        Sun, 12 Jun 2022 13:27:11 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a15so4859567wrh.2;
        Sun, 12 Jun 2022 13:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xvxzy223FFQJfshyxjElH9L36mSmmC81px6ACmnLyK8=;
        b=CZxkQSy7UoHTCD4dneKKa+nLhgsUf6WHxNQ7ny3hMnYPuqHYG9gj1IHlYrwb6Yy9Xr
         EnqQ6GwO8w6MoCEK9UMajyiM59RWdg61hC/B+rQXUIV+YwZBogMeCdA5uOtZqPoWv0OG
         VuvSzy0c9q3/WUcGklPgeZ9FlsNSRDadjfS420dhp9/S4Ti1a1sdVfnSPjmhtJE+3ZBw
         YPtt5CvNNtd8m6F1qCOM+Oxya9LXhVSD4ZyyRtI+BF1GYtvrofGrGfiEh1UHXzEcY1cS
         5btNAbkIlKWE2qUNIP3dHTj0yOEF6HV4WU6qvMlu/Z1wCum/uOMD48OUima4rOX0suXM
         2lag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xvxzy223FFQJfshyxjElH9L36mSmmC81px6ACmnLyK8=;
        b=kDfs2fv8WqNmuz7eHTETEhAN4fd5NQWbt8pKwVvENPc32bG2ed1eNMsJRnA1YPaipH
         kR1rzbsKkvBduZOV57JbgFkmUOcR+bEckhIpn93LlMeluTzpB7C9dq3q77uJsJs+6vmT
         Hl3uRDzRAyRZz/GkL476p7A858wAVU1UVJet1BY4uITe8yuutS4uzR2OeAl2KzmjCj4Z
         drgvy82FAAvR5a1a9XUfF0eYwxGnh1vber0ql1SkJmq2qzpbhp3vF+dDk7ovtGNQOK4Z
         DI9nM/vfo4+GqdpV/ocHsTO/022XLIcdUks65l26t7FT6TRRi5jtr54Ty35OvjTm0baC
         A2ag==
X-Gm-Message-State: AOAM531mHqOtkHkVHz28KIuTfYUbiWqYYNQT0RC408xP6NGfW8+1W8iQ
        OjcT0xr4BC5iaxpcPIpaZcM=
X-Google-Smtp-Source: ABdhPJwU3NQ70vtIxzoTKWKSW7xmb948Lxhl6faZc7H2PRpuMapE/NaKLkv0PWTQkMWEelZsNk26Fg==
X-Received: by 2002:a05:6000:184b:b0:219:bee5:6b75 with SMTP id c11-20020a056000184b00b00219bee56b75mr16118671wri.80.1655065629975;
        Sun, 12 Jun 2022 13:27:09 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a10-20020a056000100a00b0020d106c0386sm6347382wrx.89.2022.06.12.13.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 13:27:08 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lkdtm: cfi: use NULL for a null pointer rather than zero
Date:   Sun, 12 Jun 2022 21:27:08 +0100
Message-Id: <20220612202708.2754270-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a pointer being initialized with a zero, use NULL instead.

Cleans up sparse warning:
drivers/misc/lkdtm/cfi.c:100:27: warning: Using plain integer as NULL pointer

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/misc/lkdtm/cfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
index 666a7f4bc137..71483cb1e422 100644
--- a/drivers/misc/lkdtm/cfi.c
+++ b/drivers/misc/lkdtm/cfi.c
@@ -97,7 +97,7 @@ static volatile int force_check;
 static void lkdtm_CFI_BACKWARD(void)
 {
 	/* Use calculated gotos to keep labels addressable. */
-	void *labels[] = {0, &&normal, &&redirected, &&check_normal, &&check_redirected};
+	void *labels[] = { NULL, &&normal, &&redirected, &&check_normal, &&check_redirected };
 
 	pr_info("Attempting unchecked stack return address redirection ...\n");
 
-- 
2.35.3

