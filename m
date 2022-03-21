Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AE64E1F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 03:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344182AbiCUCd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 22:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242162AbiCUCdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 22:33:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A00F78072
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 19:32:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j5-20020a056902020500b00628ab64be30so10996432ybs.16
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 19:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=boRSKJ2tOd7N5XEAa4B8sR46+PMs9h1rt8wOI6es9nU=;
        b=e+DYSJ6J4paaD5hjVJ9z6K3g9Dlc5iJR/piV9wrM7WrJ62idld4T8gp1NZeiabtn75
         m4fc6XPBgq8fwxOKGaCHlORLI0CKCHWQahMug7WecFa9t+Did6gkp+Ruil0tcsW2gWp4
         WG6FAKuS+XCAQ34muSpOMVixjI7Bw3mDUHdOjTgYD4PFKNEY6xHkkqMcAV3MyNx/paqb
         nVZ8XJ0tzt0qGIbw5XfG/s0xpaCVpyDXkpZTO0JCCijAhOvoHbLMPlxTMrFrFR0pRBz8
         VcYeka/aU89nRe2QkdTfRzYwlLXrsXPOKlppn9kCfY7Y6tbefdlzWbLqUJNBxm5UjU9n
         m0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=boRSKJ2tOd7N5XEAa4B8sR46+PMs9h1rt8wOI6es9nU=;
        b=ViCwtZp7PqOQbP84zHtRNPkkoxOXwPipLluk+ytDGhNleeOq3xRKnifPhPEyQc4pS2
         yOhcwOXkumWzDVKi52QZXO6VvhuUaN8C9mSXCNDdJ12aiRhcs058EGGkEs5CoFLUyYVy
         Or0TgnMFbbgffTPGdJflo+hfGg4boLYOqqtCY1OoW+XfWS6L7hNWaizQ8aXH8+yWqMl8
         tXk904qF2aoQKTwKlnBKWVEMLeuPHWX0CCLNR9sX0HZD2jAPS4wAkigJ9Bv0onTpxltt
         C4LResSJkQ4ddfIPJm6hsVU3ugCICkNIbkZjtBxrmpfqzqENmk0T54w53gzdEz99lfvq
         dPMw==
X-Gm-Message-State: AOAM532srDiA9QY6bKQuFu0jQk5F7BsCZY7aWviAqPromS2XUrB+sY1V
        O8Q/XLNwe2YLNpxx8w/U4hz5/a70
X-Google-Smtp-Source: ABdhPJyzrvk3yeBbTRFVV+NGZxPwVpkPI8MBUPHkVocMLRjo1fQjiUwhSHaaXmPhtnYe163M9H0VAvC6qw==
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:27bd:2eea:bd8:2ea5])
 (user=morbo job=sendgmr) by 2002:a25:86cf:0:b0:633:8702:1bb3 with SMTP id
 y15-20020a2586cf000000b0063387021bb3mr20571751ybm.515.1647829920673; Sun, 20
 Mar 2022 19:32:00 -0700 (PDT)
Date:   Sun, 20 Mar 2022 19:31:55 -0700
Message-Id: <20220321023155.106066-1-morbo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH] bnx2x: truncate value to original sizing
From:   Bill Wendling <morbo@google.com>
To:     Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original behavior was to print out unsigned short or unsigned char
values. The change in commit d65aea8e8298 ("bnx2x: use correct format
characters") prints out the whole value if not truncated. So truncate
the value to an unsigned {short|char} to retain the original behavior.

Fixes: d65aea8e8298 ("bnx2x: use correct format characters")
Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Bill Wendling <morbo@google.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
index bede16760388..7071604f9984 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
@@ -6178,7 +6178,8 @@ static int bnx2x_format_ver(u32 num, u8 *str, u16 *len)
 		return -EINVAL;
 	}
 
-	ret = scnprintf(str, *len, "%x.%x", num >> 16, num);
+	ret = scnprintf(str, *len, "%x.%x", (num >> 16) & 0xFFFF,
+			num & 0xFFFF);
 	*len -= ret;
 	return 0;
 }
@@ -6193,7 +6194,8 @@ static int bnx2x_3_seq_format_ver(u32 num, u8 *str, u16 *len)
 		return -EINVAL;
 	}
 
-	ret = scnprintf(str, *len, "%x.%x.%x", num >> 16, num >> 8, num);
+	ret = scnprintf(str, *len, "%x.%x.%x", (num >> 16) & 0xFF,
+			(num >> 8) & 0xFF, num & 0xFF);
 	*len -= ret;
 	return 0;
 }
-- 
2.35.1.894.gb6a874cedc-goog

