Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC7155CF84
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiF1DYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiF1DYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:24:44 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FC824F33
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:24:42 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b125so8707220qkg.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mG7oGR8KRwS4y6ugg6bXZPvFt3SHfXT7rSf99ndA23o=;
        b=crGhpCK37dISSE50mg2tnh3PefYTv0fPz6hp5MCpJUtgDsZb+SOCM8G5eRXQjacQNz
         5rd7LnntQPMB4JWQUgmAPQNZKbyYMi3xLMLUlzG2fag7rF9/ZktsrzDmsWlX+FE56tcY
         jq97nwKazGjcPXT6uCvArvB0tldkFACCmm7USapuKKmZ0d4tfUD9lZ7ez3s9cXtKQUKs
         WxegbGgOOj44Oyo5fNil82BaQky5QrWgJtMxmK6bpz8JZUXiyTiH1xJsnj+brK5lhwrF
         6fJZ0DJoFygSCCysLp62dpl/IRw8yE3NTlGQqKq5gPbIXqNqZGcnmsJtISn6MiqS6MYC
         +3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mG7oGR8KRwS4y6ugg6bXZPvFt3SHfXT7rSf99ndA23o=;
        b=mbe2mGB78cCWIBh0u5wEaTjGKm0zswJ9yGPTEH0s1T3o78PebxiZeMqCXqZeeWo6uP
         5sjXmNpCQVDoOT0f4Cq0eHLIpYusVMUPgt5Ctev2BXOyV8vzxxltOvej6Pj+EcmchKre
         2D6eDL4nq2G8WWvo/c4yTKYGYWtwR3rA9ZzOjnbNXuDIhqnWn6BIoq3JEJfMc66eDTP+
         G8IbGUco6XraoK3veMzM+QPzFLoY9erNUtN0iaPc+mrG3MyxH4uVKHWGojT2WpNmLRz5
         cO1ZazYGebuBQjVe+7bs8F3VTAFYz4J/5YNAvZuKPKhsdg0fokzJw6DXd4Xtt9FalfXK
         1kjg==
X-Gm-Message-State: AJIora9kbbYvutEZyiWubGVFSUqHCE4hdKasvZgquWFNBk94h2ux8c3t
        acIrD4MDYnL19AupV7fjVw==
X-Google-Smtp-Source: AGRyM1tTcNS0IqH4b47RR/hvWQA+AKAYOQND6OBw9vWzE3TxQKTJflWjcpBIkdFxFLvCrWTxL7QdOQ==
X-Received: by 2002:a37:a08e:0:b0:6ae:f3d0:ab41 with SMTP id j136-20020a37a08e000000b006aef3d0ab41mr10076933qke.274.1656386681978;
        Mon, 27 Jun 2022 20:24:41 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id bi13-20020a05620a318d00b006a6c552736asm9831991qkb.119.2022.06.27.20.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 20:24:41 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v5whatever, now with typechecking] vsprintf: %pf(%p)
Date:   Mon, 27 Jun 2022 23:24:39 -0400
Message-Id: <20220628032439.3314451-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Linus, here's an updated version of the patch implementing %pf(%p) that
implements your typechecking macro and cookie idea we discussed. I haven't done
any additional checking like the whitelist I was talking about - this feels
sufficient to me for now, but I'm happy to revisit it if it comes up.

It's been tested lightly.

I would _really_ like to be able to pass integer arguments as well - if we want
to go ahead with converting existing %p extensions to this it would be really
helpful, and I was wondering if you had any thoughts on that.

I'm not sure if we can depend on integers and pointers being passed the same way
at the ABI level - I got some screaming when I floated the idea, but after
looking at actual ABI docs I couldn't find any archs that were _that_ crazy. The
right way to do this would seem to be with libffi - it supports all Linux
architectures and is designed exactly for this, and compiles down to practically
nothing (under a kilobyte) with the features we don't need turned off. If
pulling that into the kernel is something you'd be ok with, I can look more at
it.

It'll be a bit before I'm ready to mail out the next version of the full
printbuf patch series. I decided to go ahead with converting all our existing
pretty-printers in lib/vsprintf.c to printbuf style:

 - it makes the code _vastly_ easier to read and understand by separating out
   format string parsing from the pretty-printers, and giving actual named
   arguments to the pretty-printers

 - if we _do_ decide to go ahead with the treewide conversion (and I think we
   should, since it'll give us typechecking that we don't have currently), we'll
   want to do them all at once.

-- >8 -
This implements a new %p format string extensions for passing a pretty
printer and its arguments to printk, which will then be inserted into
the formatted output.

A pretty-printer is a function that takes as its first argument a
pointer to a struct printbuf, and then zero or more additional pointer
arguments - these being the objects to format and print.

The arguments to the pretty-printer function are denoted in the format
string by %p, i.e
  %pf()		foo0_to_text(struct printbuf *out)
  %pf(%p)	foo1_to_text(struct printbuf *out, struct foo *)
  %pf(%p,%p)	foo2_to_text(struct printbuf *out, struct foo *)

We'd also like to eventually support non pointer arguments - in
particular, integers - but this will probably require libffi.

Typechecking is accomplished with the CALL_PP macro, which verifies that
the arguments passed to sprintf match the types of the pp-function
arguments, and passes a struct with a cookie to sprintf so that sprintf
can verify that the CALL_PP() macro was used.

Full example:

static void foo_to_text(struct printbuf *out, struct foo *foo)
{
	prt_printf(out, "bar=%u baz=%u", foo->bar, foo->baz);
}

printf("%pf(%p)", CALL_PP(foo_to_text, foo));

The goal is to replace most of our %p format extensions with this
interface, and to move pretty-printers out of the core vsprintf.c code -
this will get us better organization and better discoverability (you'll
be able to cscope to pretty printer calls!), as well as eliminate a lot
of dispatch code in vsprintf.c.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>
---
 Documentation/core-api/printk-formats.rst |  22 +++++
 include/linux/printbuf.h                  |  26 ++++++
 lib/test_printf.c                         |  27 ++++++
 lib/vsprintf.c                            | 100 +++++++++++++++++++++-
 4 files changed, 172 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 5e89497ba3..4f4a35b3aa 100644
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
+        printf("%pf(%p)", CALL_PP(foo_to_text, foo));
+
+Note that a pretty-printer may not sleep if called from printk(). If called from
+prt_printf() or sprintf() there are no such restrictions.
+
 Thanks
 ======
 
diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
index 8186c447ca..189828d48d 100644
--- a/include/linux/printbuf.h
+++ b/include/linux/printbuf.h
@@ -119,4 +119,30 @@ static inline void prt_hex_byte_upper(struct printbuf *out, u8 byte)
 	.size	= _size,				\
 })
 
+/*
+ * This is used for the %pf(%p) sprintf format extension, where we pass a pretty
+ * printer and arguments to the pretty-printer to sprintf
+ *
+ * Instead of passing a pretty-printer function to sprintf directly, we pass it
+ * a pointer to a struct call_pp, so that sprintf can check that the magic
+ * number is present, which in turn ensures that the CALL_PP() macro has been
+ * used in order to typecheck the arguments to the pretty printer function
+ *
+ * Example usage:
+ *   sprintf("%pf(%p)", CALL_PP(prt_bdev, bdev));
+ */
+struct call_pp {
+	unsigned long	magic;
+	void		*fn;
+};
+
+#define PP_TYPECHECK(fn, ...)					\
+	({ while (0) fn((struct printbuf *) NULL, ##__VA_ARGS__); })
+
+#define CALL_PP_MAGIC		(unsigned long) 0xce0b92d22f6b6be4
+
+#define CALL_PP(fn, ...)					\
+	(PP_TYPECHECK(fn, ##__VA_ARGS__),			\
+	 &((struct call_pp) { CALL_PP_MAGIC, fn })), ##__VA_ARGS__
+
 #endif /* _LINUX_PRINTBUF_H */
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 07309c45f3..af0c1c2d2d 100644
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
+	test("0", "%pf()",   CALL_PP(printf_test_fn_0));
+	test("1", "%pf(%p)", CALL_PP(printf_test_fn_1, &i));
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
index 7b24714674..eb57524c5d 100644
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
@@ -2520,8 +2521,14 @@ int format_decode(const char *fmt, struct printf_spec *spec)
 		return ++fmt - start;
 
 	case 'p':
-		spec->type = FORMAT_TYPE_PTR;
-		return ++fmt - start;
+		fmt++;
+		if (fmt[0] == 'f' &&
+		    fmt[1] == '(') {
+			fmt += 2;
+			spec->type = FORMAT_TYPE_FN;
+		} else
+			spec->type = FORMAT_TYPE_PTR;
+		return fmt - start;
 
 	case '%':
 		spec->type = FORMAT_TYPE_PERCENT_CHAR;
@@ -2602,6 +2609,67 @@ set_precision(struct printf_spec *spec, int prec)
 	}
 }
 
+static void call_prt_fn(struct printbuf *out, struct call_pp *call_pp, void **fn_args, unsigned nr_args)
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
+	void *fn;
+	unsigned i;
+
+	if (check_pointer(out, call_pp))
+		return;
+
+	if (call_pp->magic != CALL_PP_MAGIC) {
+		error_string(out, "bad pretty-printer magic");
+		return;
+	}
+
+	fn = call_pp->fn;
+	if (check_pointer(out, fn))
+		return;
+
+	for (i = 0; i < nr_args; i++)
+		if (check_pointer(out, fn_args[i]))
+			return;
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
@@ -2665,6 +2733,32 @@ void prt_vprintf(struct printbuf *out, const char *fmt, va_list args)
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

