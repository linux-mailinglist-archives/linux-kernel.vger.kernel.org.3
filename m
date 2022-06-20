Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBA2550E19
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbiFTAnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237661AbiFTAnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:06 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F41331C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:42:50 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id n15so10001087qvh.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mEyqeuvyYVFCq68f4Sk4QZALU7t6VA5DEezL7DQis8Y=;
        b=fLu3mcbah3LeFFcLd6Sx4ixRcKu0bTfXOqe3wbxf8BJ/DFjC9wL0kNwb/EUtHx+yFz
         8ppi9jdAqVGLub6K7TW0N1Rw5me8QfiKIL50CH8ksgTyNpisxLe4Q/4nO2shsPeItLEw
         /Cr7czGYPiY9moaX2Rc+i/wFJT9AsM05eEQrpNPzBi8ZRTNFaYrgX3v2HIu/HlJ4JpU0
         uYU/mgQmWRG73TeXu6m04lU1h8RaMkVD9JobbgM8IkCBpjakHTvS1J8xWo3NglcCQeM3
         bdjGN0Zxo4FCJ5RnoRqUif+F4XMSg5aVyUViwoU34GrE5kWhyORUvLbgup9Vw3TrAkuG
         Vs8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mEyqeuvyYVFCq68f4Sk4QZALU7t6VA5DEezL7DQis8Y=;
        b=IyH4VP5Z23Kedf/MF0TrGYS/nul7dACcy/XyNb4Ns47VvfkDESCyFHJ4/3MnlWxuoi
         G3PA4+QBT+pwltIPKOXlD8RCrmBzR0X18jdyOSO8anT6PygiC9rtF6/rKfsTg7Izuh47
         eWoAuunybfU7ztiDJ4oKnN7k4ir2hQ7fFRnGTNKOet5IIwmH8781mNOFAv4NkbywEoac
         fWXgak+tBP8LGF86yFaVUNM6gj+u0JFHhpkn5POBoeOtNvt/cAdDhfvOeqdtGulUN+Mh
         chz4234OmP45sdwTWXHhxVUoFvSeSPqGzJqHSSSXwHMUlCXuy31uSgyW4TGc/0CT0MzJ
         66Qg==
X-Gm-Message-State: AJIora9zDXDRirpRXpNdz3zfRW4j8xsLVBhLdpkisqbOWf/1AUhQLzNw
        FgFlEmyVVzCI2ccYzxMPCYPi0yrrDynikX4=
X-Google-Smtp-Source: AGRyM1vqcEN8zqRw3lIFKIxZcvzXrdHxzPNSGUo0ecIByl4eOVuaZ3nH1CAHTH2mUn4bKReF7j7P5A==
X-Received: by 2002:a05:6214:d05:b0:464:6293:be35 with SMTP id 5-20020a0562140d0500b004646293be35mr17200317qvh.120.1655685767967;
        Sun, 19 Jun 2022 17:42:47 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id a2-20020ac86102000000b00307c9b5e087sm7097089qtm.3.2022.06.19.17.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:42:46 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 06/34] lib/string_helpers: string_get_size() now returns characters wrote
Date:   Sun, 19 Jun 2022 20:42:05 -0400
Message-Id: <20220620004233.3805-7-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620004233.3805-1-kent.overstreet@gmail.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
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
index 167c31f377..c1c8d4dfc9 100644
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
2.36.1

