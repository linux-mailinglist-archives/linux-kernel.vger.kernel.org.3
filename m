Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C625153D848
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240165AbiFDTbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239929AbiFDTa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:30:59 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F902251B
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:30:58 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id o73so3422380qke.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mjIR862E2LgyLcevyWp6TfuujVUQc54PnX3xUP5Jd7s=;
        b=HZDC0bmvjT+5VYL8OWw1rlUHmleIDkpsoMtEAaxU6RtY8fBSfM++3BC4ATxmUGjvk9
         eOf02mksA7GrEH+902oe1lLDHcH10nZBypNBT/loFrW9ymeX4Fhahe9+yFYmbOLrEMvX
         CPKGKJlw6QHoVVviqgk7J1zD8DwLuVfjXURQs5XJZ22px17VNdNI03xmiSI0IzTBSzF+
         TjHwjNjk52CSLwTyCLJNlKS4c6CCgTyV2j/MTAObl/vDh/vF1wO4gLz6lIoDpQd5vuQ+
         ENJ91x/847fTSRtv/irEeghUnvqZXFS/0FMMEr5WPMUHMs0M43bVBqQtxzJLTSncD2ih
         f8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mjIR862E2LgyLcevyWp6TfuujVUQc54PnX3xUP5Jd7s=;
        b=swl4FUQsLiYxlCZLirHDDvXIN6/ArazDov1DcfdEzwowc6ifEX3U94TuH2yB2NJ98a
         44A1RP89tA5uGEo/vC2iaWaBHQxHV0x7IcIA0vQNFR/UmRxw0fff2I2PJzC6pIuDYj97
         SIlh0QwQqVUbwjEUUl+65+qlXyKcPTGhSF1MQPp9X3R6f0hCV2EoEU5gU3RGGaZxfEEL
         HJuigKYlNWLKycS0U7lGx46NRlsae3PpCNPiyBSBoqise434aZegXY5tHDDVWlH15Obp
         UaznEQ0KDqtl6LB9AA9MmjqjQIAN2bYbT2d7taezqBFzROFGivF16maXGKdLtwY4UurB
         qyig==
X-Gm-Message-State: AOAM533MLSkq/RhMSXnqT5KTuJpmRVTq5eQPwCWrUXBmi0E8L4w1TiKB
        B2aFPecPVBF2Yx82zX4x048pJOe8LeW6
X-Google-Smtp-Source: ABdhPJxMzLkksh4MvUhAIW5st+lWRa57IlBLJv/z5SNW0fec1gYOd5ho2vvHutWglThuCMWRzi9ORw==
X-Received: by 2002:a37:a683:0:b0:6a6:ae13:7df8 with SMTP id p125-20020a37a683000000b006a6ae137df8mr2472594qke.385.1654371057456;
        Sat, 04 Jun 2022 12:30:57 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:30:56 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 05/33] vsprintf: %pf(%p)
Date:   Sat,  4 Jun 2022 15:30:14 -0400
Message-Id: <20220604193042.1674951-6-kent.overstreet@gmail.com>
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
 lib/test_printf.c                         | 20 ++++++
 lib/vsprintf.c                            | 81 ++++++++++++++++++++++-
 3 files changed, 121 insertions(+), 2 deletions(-)

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
index 07309c45f3..ff833870f5 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -783,6 +783,25 @@ test_pointer(void)
 	fourcc_pointer();
 }
 
+static void printf_test_fn(struct printbuf *out, void *p)
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
+	test("1", "%pf(%p)", printf_test_fn, &i);
+	/*
+	 * Not tested, so we don't fail the build with -Werror:
+	 */
+	//test("1", "%(%p)", printf_test_fn, &i);
+}
+
 static void __init selftest(void)
 {
 	alloced_buffer = kmalloc(BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL);
@@ -794,6 +813,7 @@ static void __init selftest(void)
 	test_number();
 	test_string();
 	test_pointer();
+	test_fn();
 
 	kfree(alloced_buffer);
 }
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index b686dafb2f..118d6f65c3 100644
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
@@ -2519,7 +2520,16 @@ int format_decode(const char *fmt, struct printf_spec *spec)
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
@@ -2601,6 +2611,49 @@ set_precision(struct printf_spec *spec, int prec)
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
@@ -2664,6 +2717,30 @@ void prt_vprintf(struct printbuf *out, const char *fmt, va_list args)
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
+			call_prt_fn(out, fn, fn_args, nr_args);
+			fmt++; /* past trailing ) */
+			break;
+		}
+
 		case FORMAT_TYPE_PERCENT_CHAR:
 			__prt_char(out, '%');
 			break;
-- 
2.36.0

