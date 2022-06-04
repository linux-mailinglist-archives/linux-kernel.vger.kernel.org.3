Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6DE53D845
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240263AbiFDTbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240076AbiFDTbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:04 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294764F479
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:00 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id br33so6651041qkb.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VuSGpywTiP+XNlJFgYYd30bm0eWVeLuCUR5InbQcSJk=;
        b=aRcJJPa0fMAqsl7O6dSdeTYtZq958RKkNPREaJ9rAb4nFT93yGzWSGbwI5vjehvPuo
         2w7oJzlYK1iOtNA3+kuLL4EfQxcufSTiKCG5YHx0xJ/LEDdcD8mYTFL/QkRWvMxqyzBd
         k8E+cs5XWl1QfVLklBWDy6NS20CI6tcDGDpt2TYQJFTqvq5tNkdnLhmEnaXaN7YLu4bb
         3OVs6dEQwM7sVoWB67IRPum1FEf7FvvZQvB8BpJWcEqQIPgrVfmUZnNuBNhMIFajIsEl
         H4AXTXWrUlzVMtqA8hIav8D+gaSGGhYcVZKCo1PF/nBJnDejdkQJQkliW1i9JFwuu+Ss
         4/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VuSGpywTiP+XNlJFgYYd30bm0eWVeLuCUR5InbQcSJk=;
        b=oRcHpNnsneN4mV1E4ccRGwCW1FYJbzpIBkkJxibhvzNm0+k7K2ly1hc4ck+70dB60W
         +iaxQHRu4giVyoZ++gQPDHjhlt54vga4FJajRZaTw5vMVNr1DsEGu7drxY+R24llTFP7
         9y/9RrfEwiNUd6vzfPkZsda6zwiCdN++xHI5EIu2/ODEB/r+yx2KBZ1vFFQtseDgC3RD
         1JiGYcKwuWBpBzpu4vZvZYb402DlTXyvPiz2xu0L9TFi1E9HrcROsFtjkHjYDOVxX4Tx
         fZegg95dQ9m2QkN1RRLV2jrc4sUlOm3pxCakN6C9AAWsM81BsgQwSWZYtWHS2HMuhEpo
         7nYQ==
X-Gm-Message-State: AOAM530WHHjcBm5i+b89aHA7JQiOPsE0/8AnEkxPc6VfSKDhW3viAdTD
        5sD+QznbGxi27iBd6QmkK+srEstQnTJO
X-Google-Smtp-Source: ABdhPJwAzHY46X7uc03KPavJ/ytAC51QD5yixFjg1AjRyfYaUCtWbbAJf7CGspJ/+Z8M9PyN9pAKQQ==
X-Received: by 2002:a05:620a:44c6:b0:6a5:a3c9:bf6b with SMTP id y6-20020a05620a44c600b006a5a3c9bf6bmr11082955qkp.100.1654371059128;
        Sat, 04 Jun 2022 12:30:59 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:30:58 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 06/33] lib/string_helpers: string_get_size() now returns characters wrote
Date:   Sat,  4 Jun 2022 15:30:15 -0400
Message-Id: <20220604193042.1674951-7-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220604193042.1674951-1-kent.overstreet@gmail.com>
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
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

printbuf now needs to know the number of characters that would have been
written if the buffer was too small, like snprintf(); this changes
string_get_size() to return the the return value of snprintf().

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/string_helpers.h | 4 ++--
 lib/string_helpers.c           | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 67de398944..52e0f1d283 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -19,8 +19,8 @@ enum string_size_units {
 	STRING_UNITS_2,		/* use binary powers of 2^10 */
 };
 
-void string_get_size(u64 size, u64 blk_size, enum string_size_units units,
-		     char *buf, int len);
+int string_get_size(u64 size, u64 blk_size, enum string_size_units units,
+		    char *buf, int len);
 
 #define UNESCAPE_SPACE		BIT(0)
 #define UNESCAPE_OCTAL		BIT(1)
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 3b1118337e..22aa161005 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -33,8 +33,8 @@
  * at least 9 bytes and will always be zero terminated.
  *
  */
-void string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
-		     char *buf, int len)
+int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
+		    char *buf, int len)
 {
 	static const char *const units_10[] = {
 		"B", "kB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"
@@ -127,8 +127,7 @@ void string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 	else
 		unit = units_str[units][i];
 
-	snprintf(buf, len, "%u%s %s", (u32)size,
-		 tmp, unit);
+	return snprintf(buf, len, "%u%s %s", (u32)size, tmp, unit);
 }
 EXPORT_SYMBOL(string_get_size);
 
-- 
2.36.0

