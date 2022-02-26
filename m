Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D36A4C53D2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 06:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiBZFUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 00:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiBZFUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 00:20:44 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F2A201A2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 21:20:10 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o26so5843604pgb.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 21:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lJmu7tk8xpKWgNbS1VGsvLnHCFD03b7u0DqWAbwVAlY=;
        b=Gmaw4zGkCWLwlSAttIdxC2od4Vj4HVX00LVsVr4U/a2ha/XD/CS4LBGVL95CqESWvw
         +688rEm99/TrZ+Ah4nafBOrwfirz0zAc13OLS4cIJuo06p/A/vekT1ks1zI6kFxiTeoQ
         gf1P714kaAkMMDvEyaEy2T5ANb8hf5gXc/kFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lJmu7tk8xpKWgNbS1VGsvLnHCFD03b7u0DqWAbwVAlY=;
        b=7y8xXlHh92/TBFP8k3ETrlZEWwGiIBYSgL5/rJW62ibmrUQQ3UkpN3GnUwUes0vIPs
         D0z11E01mavJLDbogNgAKkSAnOde5IHUdQuPfO7J7ps4oMLkk/39PUkG6AELlVGO8jY6
         vwIyitbYRYBNICEytl/9/Llvz1UUsh5mnQfe0blh72F6vy9hSzbqyEyl7PtCKwlq9s/V
         aBWAr1QrGAthK/JWk1Pz27vELwbkoLYYNc0Pd2bNHzYSmpEp0ZAef5Lr1edkIZpZwthV
         M0Y1egsbOvDm0QaK5YKtMrB3Cbv+Vb/RXLhP/hhBd6HVg3jRpjQPA/luHh4KsiahiMpu
         sbFQ==
X-Gm-Message-State: AOAM532VI9bUJyOc4wx+shoPRLzTe6fgwhLbx8LJDeCi9CkwTG1MHRwp
        GFTAGgXFG2haeJUZMDTMUqSkQw==
X-Google-Smtp-Source: ABdhPJxarm99G1J+berVF4Ui2IyEN1x3MoJnP2vQxP2xgKS+tGux0UIJeF3jiNPjtnHqtgwO+epytA==
X-Received: by 2002:a63:d354:0:b0:372:fbd2:a22a with SMTP id u20-20020a63d354000000b00372fbd2a22amr9001809pgi.438.1645852809965;
        Fri, 25 Feb 2022 21:20:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h7-20020a056a00218700b004e0314bc83csm5155739pfi.139.2022.02.25.21.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 21:20:09 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] lkdtm/usercopy: Expand size of "out of frame" object
Date:   Fri, 25 Feb 2022 21:20:08 -0800
Message-Id: <20220226052008.3553312-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2567; h=from:subject; bh=kFzk9pTiN2SY6j6CSIXkIcPGBQLKynx1uz4PRq5mvTA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiGbiHPaLYl3NPgM80Man7jeQWKmN8DZ32AOmZzQYy u7RB/LyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhm4hwAKCRCJcvTf3G3AJinXD/ 9xQWn64MIPxSJenCXyfRMp/T7pe3T2i/c8G4HgUibyb4FRosmcyX7s9bZ1SKvaHmAcITVjX1T8KV9W XmzN09iuVHYEC3Eyc+Hb87Wqr/U3tIPz0GXDeeLNYV6Sxb33o/zLcbyogtZSG7AazS30+mTdcyVc7G 81iDM4EBPopkwyb5Bk7xFG86CyemUwgiJkj0yT0jgvI0QUt+Q0aTIS1VfdbHq5esCV4ILFKQjtrBTx 7aI+KSV9AR+dQsYfDtbBW/o7x+gmZnNv3CuVXREfNE/RrHfyVclN+Z/LcPeBrEHUqh5hxgY/Vkd3uU UJ1QNjrmNhLtZTgWdzi8s4ayd96S/Zwnc9yoE2ybcjf/WzTTh3bXroNTZE0FP5vqHIF/TFKOBwcGzt oESjCjpJnlHvzaWnaiEJoGY4SYM1wobcg2gwwbAHbPpsS+92j9xb776ISKRp9uC5kcvbfN9WlVyjxM 258YUjONvRotGy7dPw/aoPYIHUvg0WvkcYhy01fFSJ/vwdhh+ciBlnB4rBcmVeiX9pI44Io6km9vzr I7XTSXquZP3AheCfPIUchHc2bQIOSBq0nFXutfLdj6yUfOreCpXEhjjOMwPgS/2Q0ztjVx4zzSrO+D WK1bQVoUyZK9dGJSpvZEpYs5xxLJrPbdjDpXaszFeeyM6/Sv3/la88vf/erg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be sufficiently out of range for the usercopy test to see the lifetime
mismatch, expand the size of the "bad" buffer, which will let it be
beyond current_stack_pointer regardless of stack growth direction.
Paired with the recent addition of stack depth checking under
CONFIG_HARDENED_USERCOPY=y, this will correctly start tripping again.

Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/lkml/762faf1b-0443-5ddf-4430-44a20cf2ec4d@collabora.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20220216201743.2088344-1-keescook@chromium.org/
v2: check for ARCH_HAS_CURRENT_STACK_POINTER (lkp)
---
 drivers/misc/lkdtm/usercopy.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 9161ce7ed47a..3fead5efe523 100644
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
@@ -66,6 +71,12 @@ static noinline void do_usercopy_stack(bool to_user, bool bad_frame)
 		bad_stack -= sizeof(unsigned long);
 	}
 
+#ifdef ARCH_HAS_CURRENT_STACK_POINTER
+	pr_info("stack     : %px\n", (void *)current_stack_pointer);
+#endif
+	pr_info("good_stack: %px-%px\n", good_stack, good_stack + sizeof(good_stack));
+	pr_info("bad_stack : %px-%px\n", bad_stack, bad_stack + sizeof(good_stack));
+
 	user_addr = vm_mmap(NULL, 0, PAGE_SIZE,
 			    PROT_READ | PROT_WRITE | PROT_EXEC,
 			    MAP_ANONYMOUS | MAP_PRIVATE, 0);
-- 
2.30.2

