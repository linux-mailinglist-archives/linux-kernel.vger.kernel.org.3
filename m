Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A7D52DB32
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240047AbiESR02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242644AbiESRZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:25:08 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017C6A5015;
        Thu, 19 May 2022 10:25:06 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a11so5732211pff.1;
        Thu, 19 May 2022 10:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Z2kNVHcs0MhZJmIj7x/+zDze1ru4sjeHsll7v+JHTQ=;
        b=ZkPr9ahoZHZ0TgU3UsWyaUbc23S0SH5oWnuYJi5dTO7X7FDHuXdErSUrkNhcy9VbzC
         4wCX5CUAUmq9TWjU5dHsQUIVutA2sMBEhFl2cfy0aYRnHKSDXwq/t9C8NUtsxateoUKr
         n3uxu6y/G1snZsbmI7uX0FZeC0XIZqP/+sEHoflabUu1aIHpxbVFkVvhVeyOD7OFLVhN
         BQNrgJfzjYAD24UFiRdmcrFNml23b+WeLhf8m5pRgU1pMsB+a9415IWA3+tBt5tS9+Uj
         kl9+TGrZ4AF8JdN0I4XzKtLHdEO59aljRmY5/hwqzLnQjo62Bvqm0jecGKhDUjzfcvae
         EJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Z2kNVHcs0MhZJmIj7x/+zDze1ru4sjeHsll7v+JHTQ=;
        b=3Ffe3u6EE8lsNgn6eovHIjUiuOwMwvbn2a0XX9uyFYnZhpffg78C+qdgIso3f90dU5
         hMGy9Z6YCae7Uxuz/i2PEvXVR6THf51xnrY1+BeVIRjpsTOn3H1w3NyeWFycqc+zW5Gt
         iauwdTukck9YcmVQb+wSvy6wzqqSU6yvL4VFFAJsxAcFEaA7/sKLabXluT7h8CEmaHNX
         j0v6grN5R3iZb9Q8rGopt2ekS+FEgPR99XNcuMqTvuD0HFhiDNZCSaTTe37Blw/kxGs/
         LVBBSpocXDZNJQjc9NW4rZzG0r+ftDcN6E8p7sntj8aH+rdfLkR6JzRYGnR7kd8oBNYs
         bCWA==
X-Gm-Message-State: AOAM533JS9h/s5EI41b3KWtjIiS2RDo+ibXpXq76JE5kAQDSwCDOL3bp
        Wf10e1JoaIjMrdTc5VETBgolt03srMIu
X-Google-Smtp-Source: ABdhPJyQ4d8Ldgogj0mgkSSyH2jXGBhzIWwVXHbeP6HFGaB0YvxRNh7zC5J6SErqmrXxCag3dqAONQ==
X-Received: by 2002:a63:5d1d:0:b0:3c6:480:1ab7 with SMTP id r29-20020a635d1d000000b003c604801ab7mr4775746pgb.228.1652981104471;
        Thu, 19 May 2022 10:25:04 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:25:03 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 13/28] vsprintf: Start consolidating printf_spec handling
Date:   Thu, 19 May 2022 13:24:06 -0400
Message-Id: <20220519172421.162394-14-kent.overstreet@gmail.com>
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

printf_spec is right now something of a mess - it's a grab-bag of state
that's interpreted inconsistently by different code, and it's scattered
throughout vsprintf.c.

We'd like to get it out of the pretty-printers, and have it be solely
the responsibility of vsprintf()/vpr_buf(), the code that parses and
handles format strings.

Most of the code that uses printf_spec is only using it for a minimum &
maximum field width - that can be done at the toplevel by checking how
much we just printed, and padding or truncating it as necessary. This
patch takes those "simple" uses of printf_spec and moves them as far up
the call stack as possible.

This patch also renames some helpers and creates new ones that don't
take printf_spec:
 - do_width_precision: new helper that handles with/precision of
   printf_spec
 - error_string		-> error_string_spec
 - check_pointer	-> check_pointer_spec
 - string		-> string_spec

Next patches will be reducing/eliminating uses of the *_spec versions.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 248 +++++++++++++++++++++++++++----------------------
 1 file changed, 138 insertions(+), 110 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d4293b4a40..6bbbb52bb0 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -613,6 +613,19 @@ void widen_string(struct printbuf *out, int n,
 		pr_chars(out, ' ', spaces);
 }
 
+static void do_width_precision(struct printbuf *out, unsigned prev_pos,
+			       struct printf_spec spec)
+{
+	unsigned n = out->pos - prev_pos;
+
+	if (n > spec.precision) {
+		out->pos -= n - spec.precision;
+		n = spec.precision;
+	}
+
+	widen_string(out, n, spec);
+}
+
 /* Handle string from a well known address. */
 static void string_nocheck(struct printbuf *out,
 			   const char *s,
@@ -645,7 +658,7 @@ static void err_ptr(struct printbuf *out, void *ptr,
 }
 
 /* Be careful: error messages must fit into the given buffer. */
-static void error_string(struct printbuf *out, const char *s,
+static void error_string_spec(struct printbuf *out, const char *s,
 			 struct printf_spec spec)
 {
 	/*
@@ -675,7 +688,7 @@ static const char *check_pointer_msg(const void *ptr)
 	return NULL;
 }
 
-static int check_pointer(struct printbuf *out,
+static int check_pointer_spec(struct printbuf *out,
 			 const void *ptr,
 			 struct printf_spec spec)
 {
@@ -683,7 +696,7 @@ static int check_pointer(struct printbuf *out,
 
 	err_msg = check_pointer_msg(ptr);
 	if (err_msg) {
-		error_string(out, err_msg, spec);
+		error_string_spec(out, err_msg, spec);
 		return -EFAULT;
 	}
 
@@ -691,16 +704,47 @@ static int check_pointer(struct printbuf *out,
 }
 
 static noinline_for_stack
-void string(struct printbuf *out,
+void string_spec(struct printbuf *out,
 	    const char *s,
 	    struct printf_spec spec)
 {
-	if (check_pointer(out, s, spec))
+	if (check_pointer_spec(out, s, spec))
 		return;
 
 	string_nocheck(out, s, spec);
 }
 
+static void error_string(struct printbuf *out, const char *s)
+{
+	/*
+	 * Hard limit to avoid a completely insane messages. It actually
+	 * works pretty well because most error messages are in
+	 * the many pointer format modifiers.
+	 */
+	pr_bytes(out, s, min(strlen(s), 2 * sizeof(void *)));
+}
+
+static int check_pointer(struct printbuf *out, const void *ptr)
+{
+	const char *err_msg;
+
+	err_msg = check_pointer_msg(ptr);
+	if (err_msg) {
+		error_string(out, err_msg);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static void string(struct printbuf *out, const char *s)
+{
+	if (check_pointer(out, s))
+		return;
+
+	pr_str(out, s);
+}
+
 static void pointer_string(struct printbuf *out,
 			   const void *ptr,
 			   struct printf_spec spec)
@@ -824,7 +868,7 @@ static void ptr_to_id(struct printbuf *out,
 	if (ret) {
 		spec.field_width = 2 * sizeof(ptr);
 		/* string length must be less than default_width */
-		return error_string(out, str, spec);
+		return error_string_spec(out, str, spec);
 	}
 
 	pointer_string(out, (const void *)hashval, spec);
@@ -851,7 +895,7 @@ void restricted_pointer(struct printbuf *out,
 		if (in_irq() || in_serving_softirq() || in_nmi()) {
 			if (spec.field_width == -1)
 				spec.field_width = 2 * sizeof(ptr);
-			return error_string(out, "pK-error", spec);
+			return error_string_spec(out, "pK-error", spec);
 		}
 
 		/*
@@ -881,14 +925,12 @@ void restricted_pointer(struct printbuf *out,
 }
 
 static noinline_for_stack
-void dentry_name(struct printbuf *out,
-		 const struct dentry *d, struct printf_spec spec,
+void dentry_name(struct printbuf *out, const struct dentry *d,
 		 const char *fmt)
 {
-	const char *array[4], *s;
+	const char *array[4];
 	const struct dentry *p;
-	int depth;
-	int i, n;
+	int i, depth;
 
 	switch (fmt[1]) {
 		case '2': case '3': case '4':
@@ -900,7 +942,7 @@ void dentry_name(struct printbuf *out,
 
 	rcu_read_lock();
 	for (i = 0; i < depth; i++, d = p) {
-		if (check_pointer(out, d, spec)) {
+		if (check_pointer(out, d)) {
 			rcu_read_unlock();
 			return;
 		}
@@ -914,55 +956,46 @@ void dentry_name(struct printbuf *out,
 			break;
 		}
 	}
-	s = array[--i];
-	for (n = 0; n != spec.precision; n++) {
-		char c = *s++;
-		if (!c) {
-			if (!i)
-				break;
-			c = '/';
-			s = array[--i];
-		}
-		__pr_char(out, c);
+	while (1) {
+		pr_str(out, array[--i]);
+		if (!i)
+			break;
+		__pr_char(out, '/');
 	}
 	rcu_read_unlock();
-	widen_string(out, n, spec);
 }
 
 static noinline_for_stack
-void file_dentry_name(struct printbuf *out,
-		      const struct file *f,
-		      struct printf_spec spec, const char *fmt)
+void file_dentry_name(struct printbuf *out, const struct file *f,
+		      const char *fmt)
 {
-	if (check_pointer(out, f, spec))
+	if (check_pointer(out, f))
 		return;
 
-	return dentry_name(out, f->f_path.dentry, spec, fmt);
+	return dentry_name(out, f->f_path.dentry, fmt);
 }
 #ifdef CONFIG_BLOCK
 static noinline_for_stack
-void bdev_name(struct printbuf *out,
-	       struct block_device *bdev,
-	       struct printf_spec spec, const char *fmt)
+void bdev_name(struct printbuf *out, struct block_device *bdev)
 {
 	struct gendisk *hd;
 
-	if (check_pointer(out, bdev, spec))
+	if (check_pointer(out, bdev))
 		return;
 
 	hd = bdev->bd_disk;
-	string(out, hd->disk_name, spec);
+	string(out, hd->disk_name);
 	if (bdev->bd_partno) {
 		if (isdigit(hd->disk_name[strlen(hd->disk_name)-1]))
 			__pr_char(out, 'p');
-		number(out, bdev->bd_partno, spec);
+		pr_u64(out, bdev->bd_partno);
 	}
 }
 #endif
 
 static noinline_for_stack
 void symbol_string(struct printbuf *out, void *ptr,
-		   struct printf_spec spec, const char *fmt)
+		   const char *fmt)
 {
 	unsigned long value;
 #ifdef CONFIG_KALLSYMS
@@ -985,17 +1018,12 @@ void symbol_string(struct printbuf *out, void *ptr,
 	else
 		sprint_symbol_no_offset(sym, value);
 
-	string_nocheck(out, sym, spec);
+	pr_str(out, sym);
 #else
 	special_hex_number(out, value, sizeof(void *));
 #endif
 }
 
-static const struct printf_spec default_str_spec = {
-	.field_width = -1,
-	.precision = -1,
-};
-
 static const struct printf_spec default_flag_spec = {
 	.base = 16,
 	.precision = -1,
@@ -1054,7 +1082,7 @@ void resource_string(struct printbuf *out, struct resource *res,
 	int decode = (fmt[0] == 'R') ? 1 : 0;
 	const struct printf_spec *specp;
 
-	if (check_pointer(out, res, spec))
+	if (check_pointer_spec(out, res, spec))
 		return;
 
 	__pr_char(&sym, '[');
@@ -1119,7 +1147,7 @@ void hex_string(struct printbuf *out, const u8 *addr,
 		/* nothing to print */
 		return;
 
-	if (check_pointer(out, addr, spec))
+	if (check_pointer_spec(out, addr, spec))
 		return;
 
 	switch (fmt[1]) {
@@ -1152,7 +1180,7 @@ void bitmap_string(struct printbuf *out, unsigned long *bitmap,
 	int i, chunksz;
 	bool first = true;
 
-	if (check_pointer(out, bitmap, spec))
+	if (check_pointer_spec(out, bitmap, spec))
 		return;
 
 	/* reused to print numbers */
@@ -1191,7 +1219,7 @@ void bitmap_list_string(struct printbuf *out, unsigned long *bitmap,
 	bool first = true;
 	int rbot, rtop;
 
-	if (check_pointer(out, bitmap, spec))
+	if (check_pointer_spec(out, bitmap, spec))
 		return ;
 
 	for_each_set_bitrange(rbot, rtop, bitmap, nr_bits) {
@@ -1218,7 +1246,7 @@ void mac_address_string(struct printbuf *out, u8 *addr,
 	char separator;
 	bool reversed = false;
 
-	if (check_pointer(out, addr, spec))
+	if (check_pointer_spec(out, addr, spec))
 		return;
 
 	switch (fmt[1]) {
@@ -1295,8 +1323,6 @@ void ip4_string(struct printbuf *out,
 			__pr_char(out, '.');
 		index += step;
 	}
-
-	printbuf_nul_terminate(out);
 }
 
 static noinline_for_stack
@@ -1525,7 +1551,7 @@ void ip_addr_string(struct printbuf *out, const void *ptr,
 {
 	char *err_fmt_msg;
 
-	if (check_pointer(out, ptr, spec))
+	if (check_pointer_spec(out, ptr, spec))
 		return;
 
 	switch (fmt[1]) {
@@ -1546,12 +1572,12 @@ void ip_addr_string(struct printbuf *out, const void *ptr,
 		case AF_INET6:
 			return ip6_addr_string_sa(out, &sa->v6, spec, fmt);
 		default:
-			return error_string(out, "(einval)", spec);
+			return error_string_spec(out, "(einval)", spec);
 		}}
 	}
 
 	err_fmt_msg = fmt[0] == 'i' ? "(%pi?)" : "(%pI?)";
-	return error_string(out, err_fmt_msg, spec);
+	return error_string_spec(out, err_fmt_msg, spec);
 }
 
 static noinline_for_stack
@@ -1566,7 +1592,7 @@ void escaped_string(struct printbuf *out, u8 *addr,
 	if (spec.field_width == 0)
 		return;				/* nothing to print */
 
-	if (check_pointer(out, addr, spec))
+	if (check_pointer_spec(out, addr, spec))
 		return;
 
 	do {
@@ -1611,7 +1637,7 @@ static void va_format(struct printbuf *out,
 {
 	va_list va;
 
-	if (check_pointer(out, va_fmt, spec))
+	if (check_pointer_spec(out, va_fmt, spec))
 		return;
 
 	va_copy(va, *va_fmt->va);
@@ -1620,16 +1646,13 @@ static void va_format(struct printbuf *out,
 }
 
 static noinline_for_stack
-void uuid_string(struct printbuf *out, const u8 *addr,
-		 struct printf_spec spec, const char *fmt)
+void uuid_string(struct printbuf *out, const u8 *addr, const char *fmt)
 {
-	char uuid_buf[UUID_STRING_LEN + 1];
-	struct printbuf uuid = PRINTBUF_EXTERN(uuid_buf, sizeof(uuid_buf));
 	int i;
 	const u8 *index = uuid_index;
 	bool uc = false;
 
-	if (check_pointer(out, addr, spec))
+	if (check_pointer(out, addr))
 		return;
 
 	switch (*(++fmt)) {
@@ -1646,32 +1669,28 @@ void uuid_string(struct printbuf *out, const u8 *addr,
 
 	for (i = 0; i < 16; i++) {
 		if (uc)
-			pr_hex_byte_upper(&uuid, addr[index[i]]);
+			pr_hex_byte_upper(out, addr[index[i]]);
 		else
-			pr_hex_byte(&uuid, addr[index[i]]);
+			pr_hex_byte(out, addr[index[i]]);
 		switch (i) {
 		case 3:
 		case 5:
 		case 7:
 		case 9:
-			__pr_char(&uuid, '-');
+			__pr_char(out, '-');
 			break;
 		}
 	}
-
-	printbuf_nul_terminate(&uuid);
-
-	string_nocheck(out, uuid_buf, spec);
 }
 
 static noinline_for_stack
 void netdev_bits(struct printbuf *out, const void *addr,
-		 struct printf_spec spec,  const char *fmt)
+		 const char *fmt)
 {
 	unsigned long long num;
 	int size;
 
-	if (check_pointer(out, addr, spec))
+	if (check_pointer(out, addr))
 		return;
 
 	switch (fmt[1]) {
@@ -1681,7 +1700,7 @@ void netdev_bits(struct printbuf *out, const void *addr,
 		special_hex_number(out, num, size);
 		break;
 	default:
-		error_string(out, "(%pN?)", spec);
+		error_string(out, "(%pN?)");
 		break;
 	}
 }
@@ -1696,9 +1715,9 @@ void fourcc_string(struct printbuf *out, const u32 *fourcc,
 	u32 val;
 
 	if (fmt[1] != 'c' || fmt[2] != 'c')
-		return error_string(out, "(%p4?)", spec);
+		return error_string_spec(out, "(%p4?)", spec);
 
-	if (check_pointer(out, fourcc, spec))
+	if (check_pointer_spec(out, fourcc, spec))
 		return;
 
 	val = *fourcc & ~BIT(31);
@@ -1718,17 +1737,17 @@ void fourcc_string(struct printbuf *out, const u32 *fourcc,
 	__pr_char(&output, ')');
 	printbuf_nul_terminate(&output);
 
-	string(out, output_buf, spec);
+	string_spec(out, output_buf, spec);
 }
 
 static noinline_for_stack
 void address_val(struct printbuf *out, const void *addr,
-		 struct printf_spec spec, const char *fmt)
+		 const char *fmt)
 {
 	unsigned long long num;
 	int size;
 
-	if (check_pointer(out, addr, spec))
+	if (check_pointer(out, addr))
 		return;
 
 	switch (fmt[1]) {
@@ -1779,7 +1798,7 @@ void rtc_str(struct printbuf *out, const struct rtc_time *tm,
 	bool found = true;
 	int count = 2;
 
-	if (check_pointer(out, tm, spec))
+	if (check_pointer_spec(out, tm, spec))
 		return;
 
 	switch (fmt[count]) {
@@ -1849,7 +1868,7 @@ void time_and_date(struct printbuf *out,
 	case 'T':
 		return time64_str(out, *(const time64_t *)ptr, spec, fmt);
 	default:
-		return error_string(out, "(%pt?)", spec);
+		return error_string_spec(out, "(%pt?)", spec);
 	}
 }
 
@@ -1858,16 +1877,16 @@ void clock(struct printbuf *out, struct clk *clk,
 	   struct printf_spec spec, const char *fmt)
 {
 	if (!IS_ENABLED(CONFIG_HAVE_CLK))
-		return error_string(out, "(%pC?)", spec);
+		return error_string_spec(out, "(%pC?)", spec);
 
-	if (check_pointer(out, clk, spec))
+	if (check_pointer_spec(out, clk, spec))
 		return;
 
 	switch (fmt[1]) {
 	case 'n':
 	default:
 #ifdef CONFIG_COMMON_CLK
-		return string(out, __clk_get_name(clk), spec);
+		return string_spec(out, __clk_get_name(clk), spec);
 #else
 		return ptr_to_id(out, clk, spec);
 #endif
@@ -1885,7 +1904,7 @@ void format_flags(struct printbuf *out, unsigned long flags,
 		if ((flags & mask) != mask)
 			continue;
 
-		string(out, names->name, default_str_spec);
+		string(out, names->name);
 
 		flags &= ~mask;
 		if (flags)
@@ -1943,7 +1962,7 @@ void format_page_flags(struct printbuf *out, unsigned long flags)
 		if (append)
 			__pr_char(out, '|');
 
-		string(out, pff[i].name, default_str_spec);
+		string(out, pff[i].name);
 		__pr_char(out, '=');
 		number(out, (flags >> pff[i].shift) & pff[i].mask, *pff[i].spec);
 
@@ -1959,7 +1978,7 @@ void flags_string(struct printbuf *out, void *flags_ptr,
 	unsigned long flags;
 	const struct trace_print_flags *names;
 
-	if (check_pointer(out, flags_ptr, spec))
+	if (check_pointer_spec(out, flags_ptr, spec))
 		return;
 
 	switch (fmt[1]) {
@@ -1974,7 +1993,7 @@ void flags_string(struct printbuf *out, void *flags_ptr,
 		names = gfpflag_names;
 		break;
 	default:
-		return error_string(out, "(%pG?)", spec);
+		return error_string_spec(out, "(%pG?)", spec);
 	}
 
 	return format_flags(out, flags, names);
@@ -1991,10 +2010,8 @@ void fwnode_full_name_string(struct printbuf *out,
 		struct fwnode_handle *__fwnode =
 			fwnode_get_nth_parent(fwnode, depth);
 
-		string(out, fwnode_get_name_prefix(__fwnode),
-		       default_str_spec);
-		string(out, fwnode_get_name(__fwnode),
-		       default_str_spec);
+		string(out, fwnode_get_name_prefix(__fwnode));
+		string(out, fwnode_get_name(__fwnode));
 
 		fwnode_handle_put(__fwnode);
 	}
@@ -2015,12 +2032,12 @@ void device_node_string(struct printbuf *out, struct device_node *dn,
 	str_spec.field_width = -1;
 
 	if (fmt[0] != 'F')
-		return error_string(out, "(%pO?)", spec);
+		return error_string_spec(out, "(%pO?)", spec);
 
 	if (!IS_ENABLED(CONFIG_OF))
-		return error_string(out, "(%pOF?)", spec);
+		return error_string_spec(out, "(%pOF?)", spec);
 
-	if (check_pointer(out, dn, spec))
+	if (check_pointer_spec(out, dn, spec))
 		return;
 
 	/* simple case without anything any more format specifiers */
@@ -2041,7 +2058,7 @@ void device_node_string(struct printbuf *out, struct device_node *dn,
 			p = fwnode_get_name(of_fwnode_handle(dn));
 			precision = str_spec.precision;
 			str_spec.precision = strchrnul(p, '@') - p;
-			string(out, p, str_spec);
+			string_spec(out, p, str_spec);
 			str_spec.precision = precision;
 			break;
 		case 'p':	/* phandle */
@@ -2051,7 +2068,7 @@ void device_node_string(struct printbuf *out, struct device_node *dn,
 			p = fwnode_get_name(of_fwnode_handle(dn));
 			if (!p[1])
 				p = "/";
-			string(out, p, str_spec);
+			string_spec(out, p, str_spec);
 			break;
 		case 'F':	/* flags */
 			tbuf[0] = of_node_check_flag(dn, OF_DYNAMIC) ? 'D' : '-';
@@ -2061,18 +2078,18 @@ void device_node_string(struct printbuf *out, struct device_node *dn,
 			tbuf[4] = 0;
 			string_nocheck(out, tbuf, str_spec);
 			break;
-		case 'c':	/* major compatible string */
+		case 'c':	/* major compatible string_spec */
 			ret = of_property_read_string(dn, "compatible", &p);
 			if (!ret)
-				string(out, p, str_spec);
+				string_spec(out, p, str_spec);
 			break;
-		case 'C':	/* full compatible string */
+		case 'C':	/* full compatible string_spec */
 			has_mult = false;
 			of_property_for_each_string(dn, "compatible", prop, p) {
 				if (has_mult)
 					string_nocheck(out, ",", str_spec);
 				string_nocheck(out, "\"", str_spec);
-				string(out, p, str_spec);
+				string_spec(out, p, str_spec);
 				string_nocheck(out, "\"", str_spec);
 
 				has_mult = true;
@@ -2097,16 +2114,16 @@ void fwnode_string(struct printbuf *out,
 	str_spec.field_width = -1;
 
 	if (*fmt != 'w')
-		return error_string(out, "(%pf?)", spec);
+		return error_string_spec(out, "(%pf?)", spec);
 
-	if (check_pointer(out, fwnode, spec))
+	if (check_pointer_spec(out, fwnode, spec))
 		return;
 
 	fmt++;
 
 	switch (*fmt) {
 	case 'P':	/* name */
-		string(out, fwnode_get_name(fwnode), str_spec);
+		string_spec(out, fwnode_get_name(fwnode), str_spec);
 		break;
 	case 'f':	/* full_name */
 	default:
@@ -2277,13 +2294,16 @@ static noinline_for_stack
 void pointer(struct printbuf *out, const char *fmt,
 	     void *ptr, struct printf_spec spec)
 {
+	unsigned prev_pos = out->pos;
+
 	switch (*fmt) {
 	case 'S':
 	case 's':
 		ptr = dereference_symbol_descriptor(ptr);
 		fallthrough;
 	case 'B':
-		return symbol_string(out, ptr, spec, fmt);
+		symbol_string(out, ptr, fmt);
+		return do_width_precision(out, prev_pos, spec);
 	case 'R':
 	case 'r':
 		return resource_string(out, ptr, spec, fmt);
@@ -2314,28 +2334,34 @@ void pointer(struct printbuf *out, const char *fmt,
 	case 'E':
 		return escaped_string(out, ptr, spec, fmt);
 	case 'U':
-		return uuid_string(out, ptr, spec, fmt);
+		uuid_string(out, ptr, fmt);
+		return do_width_precision(out, prev_pos, spec);
 	case 'V':
 		return va_format(out, ptr, spec, fmt);
 	case 'K':
 		return restricted_pointer(out, ptr, spec);
 	case 'N':
-		return netdev_bits(out, ptr, spec, fmt);
+		netdev_bits(out, ptr, fmt);
+		return do_width_precision(out, prev_pos, spec);
 	case '4':
 		return fourcc_string(out, ptr, spec, fmt);
 	case 'a':
-		return address_val(out, ptr, spec, fmt);
+		address_val(out, ptr, fmt);
+		return do_width_precision(out, prev_pos, spec);
 	case 'd':
-		return dentry_name(out, ptr, spec, fmt);
+		dentry_name(out, ptr, fmt);
+		return do_width_precision(out, prev_pos, spec);
 	case 't':
 		return time_and_date(out, ptr, spec, fmt);
 	case 'C':
 		return clock(out, ptr, spec, fmt);
 	case 'D':
-		return file_dentry_name(out, ptr, spec, fmt);
+		file_dentry_name(out, ptr, fmt);
+		return do_width_precision(out, prev_pos, spec);
 #ifdef CONFIG_BLOCK
 	case 'g':
-		return bdev_name(out, ptr, spec, fmt);
+		bdev_name(out, ptr);
+		return do_width_precision(out, prev_pos, spec);
 #endif
 
 	case 'G':
@@ -2355,9 +2381,9 @@ void pointer(struct printbuf *out, const char *fmt,
 	case 'k':
 		switch (fmt[1]) {
 		case 's':
-			return string(out, ptr, spec);
+			return string_spec(out, ptr, spec);
 		default:
-			return error_string(out, "(einval)", spec);
+			return error_string_spec(out, "(einval)", spec);
 		}
 	}
 
@@ -2665,6 +2691,7 @@ void vpr_buf(struct printbuf *out, const char *fmt, va_list args)
 
 	while (*fmt) {
 		const char *old_fmt = fmt;
+		unsigned prev_pos = out->pos;
 		int read = format_decode(fmt, &spec);
 
 		fmt += read;
@@ -2694,7 +2721,8 @@ void vpr_buf(struct printbuf *out, const char *fmt, va_list args)
 			break;
 
 		case FORMAT_TYPE_STR:
-			string(out, va_arg(args, char *), spec);
+			string(out, va_arg(args, char *));
+			do_width_precision(out, prev_pos, spec);
 			break;
 
 		case FORMAT_TYPE_PTR:
@@ -3206,7 +3234,7 @@ int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
 		case FORMAT_TYPE_STR: {
 			const char *str_arg = args;
 			args += strlen(str_arg) + 1;
-			string(&out, (char *)str_arg, spec);
+			string_spec(&out, (char *)str_arg, spec);
 			break;
 		}
 
-- 
2.36.0

