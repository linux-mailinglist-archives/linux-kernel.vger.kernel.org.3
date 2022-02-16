Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0514A4B922C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiBPUSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:18:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiBPUR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:17:59 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC30256EC9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:17:46 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id y5so3075302pfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1CQ3e4LmGdBNkn8J0Xh4T4TteU4rCgSYMdgdDt/RPvw=;
        b=lNyV9zSsZq+dmQhzA3T49jEEYBN5Jb7yWT/zVg9vqExqpGD7WQx1SOplo1xG4o73Nv
         gILh22iN3MXbvISnUP6DL+EmPnRXl8g8kC02mGS37echzeOABVHV3UdcHqyTFrkCLBCs
         do2CMs0rCFmfa8MswqyeaMg1mrvXei9x4Z1R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1CQ3e4LmGdBNkn8J0Xh4T4TteU4rCgSYMdgdDt/RPvw=;
        b=bWmrGXgSjsUSQZHGL6e6tbgyokbV5Hcy6Lo8b+ZFG6ESa/XzykuuR+r044ol981D0X
         Mgrr4RB3y64vZQ7aMCaIEE6rhdr5PUUWF8l2JBULY3dw30OAkpcwUFuevbektlCaRrc4
         7tQRkEK0C2CwGtoSAZanKloy84ufxYdEV1QrrMIgOKrvL0+3JzpVDjknk0WxXpOi5S3Z
         WWOh2ONCagGBmz8ukOQSlx9pH7S83EzuXGt/6bZEUReMEzpA6NXF4/2tFm2c6LkRj4YL
         Jwy3OW4A1h7qMg4pMuNdtKcHeigklFFzVdF/lY5jjD21UA61XDMBuLYsuH11id7SncQ/
         mohQ==
X-Gm-Message-State: AOAM533Yed9/H9l0KdvY8j2eb/oi5sTqT5nC9/FAETIfFSKgvpbLIt7S
        5TZKHMN9/yDa7HY3IGvkJwEcfQ==
X-Google-Smtp-Source: ABdhPJyC4Y5JXgGZidIXBFGAp800bP6PQMJWttROYEf/sXG4nwUaecw0o0cVJrygUfpVmp7a0Qfbhg==
X-Received: by 2002:a63:6d0d:0:b0:370:14d8:5962 with SMTP id i13-20020a636d0d000000b0037014d85962mr3628788pgc.463.1645042665782;
        Wed, 16 Feb 2022 12:17:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y20sm25544608pfi.87.2022.02.16.12.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:17:45 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] lkdtm/usercopy: Expand size of "out of frame" object
Date:   Wed, 16 Feb 2022 12:17:43 -0800
Message-Id: <20220216201743.2088344-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2224; h=from:subject; bh=8yZ/Tdt8BG4aUa0vMrljSrZbhWwVIs3OtFM0Be04X5o=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiDVvmOtNUr/1pMc582pfphqTzlO2/tNfUWNp/07eP RxLKwmuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYg1b5gAKCRCJcvTf3G3AJsz5EA CDVZlagFbsoFvCSozMc5toker3Thm4jAqHp65mLbE4x7bi/ruvQWqlKg0sf1p86bId0kASp8HY+0hX rDzz17rUWVoF8I4QlZuY5YdA5Nl6T+NSYlChzKn75aae0cHqgZ3K4gavZLlyck5/XMeJaJESPB1EKy EwmIgyTcqPSqke0ptePmqK3oUAf6yfyLYiHI6YSRF8/yzoZm/8YLFp7BCaUArhewrgwBqWEqwrdySE YfbwpwxscmC/18Da0I5FNwtcDNUXj0urKK7/uHS/it0bsseI+b6DopdetHp5m2HS3Xatie53pjzb+Z jWZVlZvE3Cx1uhyfkxJae80Sv559aJgeABOIRB1R5DnPwHTdemFFk/ze/hl0LnKma8mEZlDlWtrayH iPo8oPJb3zmXggO86vP/W7IXpsc3jbHRkViucszppZaThJ/Alu9BsmCIbHO9BWQbZ1JLvZpcCh4wRy ANeaYL5IYnfqw+us8gOmFFCX08MwVN5R9LboPt9RQ+LnxdAmVhs3xSj2i3T/qdkvX9rnVYdcz6FytU ouVc7RbAkj4TGwmJFbInCsDh0BbPKnZLBPXaYLQGZcrzPvHQF2Jhmc412cEwcKyo8nfQJiKLL82nYI jW6WV63iUqasstniiJN4Y8owHPJ3m2aENbfI4rixme3SuhhtMVm6hm3PRODQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be sufficient out of range for the usercopy test to see the lifetime
mismatch, expand the size of the "bad" buffer, which will let it be
beyond current_stack_pointer regardless of stack growth direction.
Paired with the recent addition of stack depth checking under
CONFIG_HARDENED_USERCOPY=y, this will correctly start tripping again.

Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/usercopy.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 9161ce7ed47a..781345ea3b07 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -30,12 +30,12 @@ static const unsigned char test_text[] = "This is a test.\n";
  */
 static noinline unsigned char *trick_compiler(unsigned char *stack)
 {
-	return stack + 0;
+	return stack + unconst;
 }
 
 static noinline unsigned char *do_usercopy_stack_callee(int value)
 {
-	unsigned char buf[32];
+	unsigned char buf[128];
 	int i;
 
 	/* Exercise stack to avoid everything living in registers. */
@@ -43,7 +43,12 @@ static noinline unsigned char *do_usercopy_stack_callee(int value)
 		buf[i] = value & 0xff;
 	}
 
-	return trick_compiler(buf);
+	/*
+	 * Put the target buffer in the middle of stack allocation
+	 * so that we don't step on future stack users regardless
+	 * of stack growth direction.
+	 */
+	return trick_compiler(&buf[(128/2)-32]);
 }
 
 static noinline void do_usercopy_stack(bool to_user, bool bad_frame)
@@ -66,6 +71,10 @@ static noinline void do_usercopy_stack(bool to_user, bool bad_frame)
 		bad_stack -= sizeof(unsigned long);
 	}
 
+	pr_info("stack     : %px\n", (void *)current_stack_pointer);
+	pr_info("good_stack: %px-%px\n", good_stack, good_stack + sizeof(good_stack));
+	pr_info("bad_stack : %px-%px\n", bad_stack, bad_stack + sizeof(good_stack));
+
 	user_addr = vm_mmap(NULL, 0, PAGE_SIZE,
 			    PROT_READ | PROT_WRITE | PROT_EXEC,
 			    MAP_ANONYMOUS | MAP_PRIVATE, 0);
-- 
2.30.2

