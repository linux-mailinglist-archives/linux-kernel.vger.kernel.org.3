Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B261352DB21
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241281AbiESRZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242582AbiESRYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:24:42 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDE3A5036;
        Thu, 19 May 2022 10:24:38 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id bh5so5376893plb.6;
        Thu, 19 May 2022 10:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KezD3kfL2rJaxz73jmeIdmWUTP5JswkB1sqSfdCS7Nk=;
        b=Sv4CpsY5gZOPnxw2hhkBifiwf/Z9F6vWxInFppvcO4lgxcigcYj6nCMSIcs4BWPZh0
         wijlPWIeLY1qKHN9EYWbG5fFhlOZ+llQRVNikmUb7crMDg/YnHGUmSuQKRksQb1LIRvR
         km7qLFcltoy5T2JtCR5vXcF6ii3S59rYsILQnEC7fWZCWnWV40Lw3CaxjZnt5GqeNiXH
         BYDJlVkdyo122/rK+XpYlvj/nasdfE12T7zRa39WBh3fDZFhZ5nGDg+kEoanICGs5nPH
         0Uv16gcGHTrrVaVhhA0U0QV1/wdctSpFdCRiDaocSYF/5CHVvTWdI2GgbD9t6OY48MdG
         rd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KezD3kfL2rJaxz73jmeIdmWUTP5JswkB1sqSfdCS7Nk=;
        b=1PqxSgXfEawSaqc7R/80Ead+akH4/vrIC9r6/5wo9J05oWIPw36bEKTl0afrsw0i8r
         cIxBdhiOr60U+zhkVjYUJGsun2fGePYKF0KHAieFvyE+GrWPJWepu4AU7OB3BcIbAnKY
         NaFwPu3SAsrw+yH6FfeaSMK0fR+jX6d4bQxKF/RmWS0U7S0xyFsR5DAUgMzXzmu8S88W
         Zv3RH/EDoRpZfOkoptsFCpfNx1hDo2aLEoFBEimAH+uAE14ng0IR4jXj7/sojMzj79l/
         HaPmHEnNUr2KZbTGrfMtoGF9K6lxeVyxBeaz2WL4Nhf/iIn+U3yGNPI3u2GOQdtTc+rX
         a5kg==
X-Gm-Message-State: AOAM532suEbE2DF2B0llDHzbr59LGgd0F/B4o4gSOka+nxCkCey4KuEa
        HWagj6AK8ZZ7h9u5WK2IrBOUHOQ04HJQ
X-Google-Smtp-Source: ABdhPJxnqTf8vOeejJX87OBSIDtc6xFKWDKNsZsXQBir9VBe+WezI5BtPcdzvylFmNpsvnf7l1KQuw==
X-Received: by 2002:a17:902:9a83:b0:15e:f718:4ced with SMTP id w3-20020a1709029a8300b0015ef7184cedmr5416529plp.69.1652981076974;
        Thu, 19 May 2022 10:24:36 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:24:36 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 03/28] vsprintf: %pf(%p)
Date:   Thu, 19 May 2022 13:23:56 -0400
Message-Id: <20220519172421.162394-4-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220519172421.162394-1-kent.overstreet@gmail.com>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
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

 %p(%p) - more compatible
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
---
 Documentation/core-api/printk-formats.rst | 19 ++++++
 lib/test_printf.c                         | 17 +++++
 lib/vsprintf.c                            | 81 ++++++++++++++++++++++-
 3 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 5e89497ba3..e4ed40960e 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -625,6 +625,25 @@ Examples::
 	%p4cc	Y10  little-endian (0x20303159)
 	%p4cc	NV12 big-endian (0xb231564e)
 
+Calling a pretty printer function
+---------------------------------
+
+::
+
+        %p(%p)     pretty printer function taking one argument
+        %p(%p,%p)  pretty printer function taking two arguments
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
+        printf("%p(%p)", foo_to_text, foo);
+
 Thanks
 ======
 
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 07309c45f3..1e1604ef1a 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -783,6 +783,22 @@ test_pointer(void)
 	fourcc_pointer();
 }
 
+static void printf_test_fn(struct printbuf *out, void *p)
+{
+	int *i = p;
+
+	pr_buf(out, "%i", *i);
+}
+
+static void __init
+test_fn(void)
+{
+	int i = 1;
+
+	test("1", "%pf(%p)", printf_test_fn, &i);
+	test("1", "%(%p)", printf_test_fn, &i);
+}
+
 static void __init selftest(void)
 {
 	alloced_buffer = kmalloc(BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL);
@@ -794,6 +810,7 @@ static void __init selftest(void)
 	test_number();
 	test_string();
 	test_pointer();
+	test_fn();
 
 	kfree(alloced_buffer);
 }
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 09b259e030..7fbeaf50d1 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -431,7 +431,8 @@ enum format_type {
 	FORMAT_TYPE_UINT,
 	FORMAT_TYPE_INT,
 	FORMAT_TYPE_SIZE_T,
-	FORMAT_TYPE_PTRDIFF
+	FORMAT_TYPE_PTRDIFF,
+	FORMAT_TYPE_FN,
 };
 
 struct printf_spec {
@@ -2512,7 +2513,16 @@ int format_decode(const char *fmt, struct printf_spec *spec)
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
@@ -2594,6 +2604,49 @@ set_precision(struct printf_spec *spec, int prec)
 	}
 }
 
+static void call_pr_fn(struct printbuf *out, void *fn, void **fn_args, unsigned nr_args)
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
  * vpr_buf - Format a string, outputting to a printbuf
  * @out: The printbuf to output to
@@ -2657,6 +2710,30 @@ void vpr_buf(struct printbuf *out, const char *fmt, va_list args)
 				fmt++;
 			break;
 
+		case FORMAT_TYPE_FN: {
+			unsigned nr_args = 0;
+			void *fn_args[8];
+			void *fn = va_arg(args, void *);
+
+			while (1) {
+				if (WARN_ON_ONCE(nr_args == ARRAY_SIZE(fn_args)))
+					goto out;
+				if (*fmt++ != '%')
+					goto out;
+				if (*fmt++ != 'p')
+					goto out;
+				fn_args[nr_args++] = va_arg(args, void *);
+				if (*fmt == ')')
+					break;
+				if (*fmt++ != ',')
+					goto out;
+			}
+
+			call_pr_fn(out, fn, fn_args, nr_args);
+			fmt++; /* past trailing ) */
+			break;
+		}
+
 		case FORMAT_TYPE_PERCENT_CHAR:
 			__pr_char(out, '%');
 			break;
-- 
2.36.0

