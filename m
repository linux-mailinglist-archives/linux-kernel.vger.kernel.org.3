Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307F0550E18
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbiFTAm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237414AbiFTAms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:42:48 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A629B1FA
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:42:47 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id o43so14020228qvo.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UGrl8Qfcvy38ICSsYjz56YZufleI8goZ2x0Erajkju0=;
        b=hr/Ir5woPFK9OzqwRCmFDwrKbx66HzKzOiP/kqFPd253JcHiOLK+E2/VlVUngKqRla
         TxjJbCOAxMmiHbAJSg+qYn6tQJ5i9tBvbCGTJdggjO4kfIYsj0VOqBHU1wOUOwRJkF2o
         Sdn7YOlzrXOAwToTO3jrU3w2QcmyBz27dHiWRg5AGs0OYVi1DXMCejBsywZtgmkho8JD
         s6f+MWt767GkbKxOxvttAV+4iB5ZcIoe6G/evlADxaxgsEi8c3PCw6w2jLJ5ZNo3igEa
         rehXbxaElnZRvJ38AHeBW++w4msBYLSJKWcN99Qv66iLYGLiY+1G7x+ReQvR7CJDrePg
         +BsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UGrl8Qfcvy38ICSsYjz56YZufleI8goZ2x0Erajkju0=;
        b=jQ00nW6A657PqxAfPNEMgnD9jLDaDBr4zyGkLDWJG/RafMLosErCyotDtQzhYotW+T
         q+pEGF1971htZsEf7+KYulTSwkLHdWrEIw6OFmLCCK1UpbP1EQyzxVVPf1n6i1JyQKLY
         CWL/Rv3SibK7wBmHpvpodHBvbL/AoRzSYfGyxY2/qzpALFVID7UNVWEwE85vkkO0EfoR
         3C+UYJEIm9ViW7YpCtQDciqWu9085p4KFiQhW2MPQ26xl1RdyNTFt2gyczl7zL4fUJYE
         Z2HXRuPw1ZOuZJI3wiVaqhUip84IQk/kfx1NBCZDT31r370La8qcIEs2/rQ0k6aZzmtf
         UPSQ==
X-Gm-Message-State: AJIora/5vlTc4miuMGgLWr8LLcNlsxbhtdwDvjUKigC59WT+YvqK/cbR
        kHLtzDqy9ypBmErQW4IAOeY7Wuq+x38NT3c=
X-Google-Smtp-Source: AGRyM1u8sStuUMJqJg8ijOIqYDwWaCA1Kva76DfZ22wXKjzTr96sGWWaXsdGat0PSBiOiFmPTe0TXg==
X-Received: by 2002:a05:622a:486:b0:304:ec30:8c0f with SMTP id p6-20020a05622a048600b00304ec308c0fmr17526034qtx.236.1655685765685;
        Sun, 19 Jun 2022 17:42:45 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id w10-20020ac84d0a000000b00304dec6452csm9345092qtv.78.2022.06.19.17.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:42:45 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 05/34] vsprintf: %pf(%p)
Date:   Sun, 19 Jun 2022 20:42:04 -0400
Message-Id: <20220620004233.3805-6-kent.overstreet@gmail.com>
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

This implements two new format strings: both do the same thing, one more
compatible with current gcc format string checking, the other that we'd
like to standardize:

 %pf(%p) - more compatible
 %(%p)  - more prettier

Both can take variable numbers of arguments, i.e. %(%p,%p,%p).

They're used to indicate that snprintf or pr_buf should interpret the
next argument as a pretty-printer function to call, and subsequent
arguments within the parentheses should be passed to the pretty-printer.

A pretty printer takes as its first argument a printbuf, and then zero
or more pointer arguments - integer arguments are not (currently) supported.

Example usage:

static void foo_to_text(struct printbuf *out, struct foo *foo)
{
	pr_buf(out, "bar=%u baz=%u", foo->bar, foo->baz);
}

printf("%(%p)", foo_to_text, foo);

The goal is to replace most of our %p format extensions with this
interface, and to move pretty-printers out of the core vsprintf.c code -
this will get us better organization and better discoverability (you'll
be able to cscope to pretty printer calls!), as well as eliminate a lot
of dispatch code in vsprintf.c.

Currently, we can only call pretty printers with pointer arguments. This
could be changed to also allow at least integer arguments in the future
by using libffi.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/core-api/printk-formats.rst | 22 ++++++
 lib/test_printf.c                         | 27 ++++++++
 lib/vsprintf.c                            | 83 ++++++++++++++++++++++-
 3 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 5e89497ba3..8fc0b62af1 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -625,6 +625,28 @@ Examples::
 	%p4cc	Y10  little-endian (0x20303159)
 	%p4cc	NV12 big-endian (0xb231564e)
 
+Calling a pretty printer function
+---------------------------------
+
+::
+
+        %pf(%p)     pretty printer function taking one argument
+        %pf(%p,%p)  pretty printer function taking two arguments
+
+For calling generic pretty printers. A pretty printer is a function that takes
+as its first argument a pointer to a printbuf, and then zero or more additional
+pointer arguments. For example:
+
+        void foo_to_text(struct printbuf *out, struct foo *foo)
+        {
+                pr_buf(out, "bar=%u baz=%u", foo->bar, foo->baz);
+        }
+
+        printf("%pf(%p)", foo_to_text, foo);
+
+Note that a pretty-printer may not sleep, if called from printk(). If called
+from pr_buf() or sprintf() there are no such restrictions.
+
 Thanks
 ======
 
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 07309c45f3..e3de52da91 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/printk.h>
+#include <linux/printbuf.h>
 #include <linux/random.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
@@ -783,6 +784,31 @@ test_pointer(void)
 	fourcc_pointer();
 }
 
+static void printf_test_fn_0(struct printbuf *out)
+{
+	prt_str(out, "0");
+}
+
+static void printf_test_fn_1(struct printbuf *out, void *p)
+{
+	int *i = p;
+
+	prt_printf(out, "%i", *i);
+}
+
+static void __init
+test_fn(void)
+{
+	int i = 1;
+
+	test("0", "%pf()",   printf_test_fn_0);
+	test("1", "%pf(%p)", printf_test_fn_1, &i);
+	/*
+	 * Not tested, so we don't fail the build with -Werror:
+	 */
+	//test("1", "%(%p)", printf_test_fn, &i);
+}
+
 static void __init selftest(void)
 {
 	alloced_buffer = kmalloc(BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL);
@@ -794,6 +820,7 @@ static void __init selftest(void)
 	test_number();
 	test_string();
 	test_pointer();
+	test_fn();
 
 	kfree(alloced_buffer);
 }
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 7b24714674..5afa74dda5 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -436,7 +436,8 @@ enum format_type {
 	FORMAT_TYPE_UINT,
 	FORMAT_TYPE_INT,
 	FORMAT_TYPE_SIZE_T,
-	FORMAT_TYPE_PTRDIFF
+	FORMAT_TYPE_PTRDIFF,
+	FORMAT_TYPE_FN,
 };
 
 struct printf_spec {
@@ -2520,7 +2521,16 @@ int format_decode(const char *fmt, struct printf_spec *spec)
 		return ++fmt - start;
 
 	case 'p':
-		spec->type = FORMAT_TYPE_PTR;
+		fmt++;
+		if (fmt[0] == 'f' &&
+		    fmt[1] == '(') {
+			fmt += 2;
+			spec->type = FORMAT_TYPE_FN;
+		} else
+			spec->type = FORMAT_TYPE_PTR;
+		return fmt - start;
+	case '(':
+		spec->type = FORMAT_TYPE_FN;
 		return ++fmt - start;
 
 	case '%':
@@ -2602,6 +2612,49 @@ set_precision(struct printf_spec *spec, int prec)
 	}
 }
 
+static void call_prt_fn(struct printbuf *out, void *fn, void **fn_args, unsigned nr_args)
+{
+	typedef void (*printf_fn_0)(struct printbuf *);
+	typedef void (*printf_fn_1)(struct printbuf *, void *);
+	typedef void (*printf_fn_2)(struct printbuf *, void *, void *);
+	typedef void (*printf_fn_3)(struct printbuf *, void *, void *, void *);
+	typedef void (*printf_fn_4)(struct printbuf *, void *, void *, void *, void *);
+	typedef void (*printf_fn_5)(struct printbuf *, void *, void *, void *, void *, void *);
+	typedef void (*printf_fn_6)(struct printbuf *, void *, void *, void *, void *, void *, void *);
+	typedef void (*printf_fn_7)(struct printbuf *, void *, void *, void *, void *, void *, void *, void *);
+	typedef void (*printf_fn_8)(struct printbuf *, void *, void *, void *, void *, void *, void *, void *, void *);
+
+	switch (nr_args) {
+	case 0:
+		((printf_fn_0)fn)(out);
+		break;
+	case 1:
+		((printf_fn_1)fn)(out, fn_args[0]);
+		break;
+	case 2:
+		((printf_fn_2)fn)(out, fn_args[0], fn_args[1]);
+		break;
+	case 3:
+		((printf_fn_3)fn)(out, fn_args[0], fn_args[1], fn_args[2]);
+		break;
+	case 4:
+		((printf_fn_4)fn)(out, fn_args[0], fn_args[1], fn_args[2], fn_args[3]);
+		break;
+	case 5:
+		((printf_fn_5)fn)(out, fn_args[0], fn_args[1], fn_args[2], fn_args[3], fn_args[4]);
+		break;
+	case 6:
+		((printf_fn_6)fn)(out, fn_args[0], fn_args[1], fn_args[2], fn_args[3], fn_args[4], fn_args[5]);
+		break;
+	case 7:
+		((printf_fn_7)fn)(out, fn_args[0], fn_args[1], fn_args[2], fn_args[3], fn_args[4], fn_args[5], fn_args[6]);
+		break;
+	case 8:
+		((printf_fn_8)fn)(out, fn_args[0], fn_args[1], fn_args[2], fn_args[3], fn_args[4], fn_args[5], fn_args[6], fn_args[7]);
+		break;
+	}
+}
+
 /**
  * prt_vprintf - Format a string, outputting to a printbuf
  * @out: The printbuf to output to
@@ -2665,6 +2718,32 @@ void prt_vprintf(struct printbuf *out, const char *fmt, va_list args)
 				fmt++;
 			break;
 
+		case FORMAT_TYPE_FN: {
+			unsigned nr_args = 0;
+			void *fn_args[8];
+			void *fn = va_arg(args, void *);
+
+			while (*fmt != ')') {
+				if (nr_args) {
+					if (fmt[0] != ',')
+						goto out;
+					fmt++;
+				}
+
+				if (fmt[0] != '%' || fmt[1] != 'p')
+					goto out;
+				fmt += 2;
+
+				if (WARN_ON_ONCE(nr_args == ARRAY_SIZE(fn_args)))
+					goto out;
+				fn_args[nr_args++] = va_arg(args, void *);
+			}
+
+			call_prt_fn(out, fn, fn_args, nr_args);
+			fmt++; /* past trailing ) */
+			break;
+		}
+
 		case FORMAT_TYPE_PERCENT_CHAR:
 			__prt_char(out, '%');
 			break;
-- 
2.36.1

