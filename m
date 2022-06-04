Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72D753D869
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241275AbiFDTeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241023AbiFDTc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:32:29 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCEB13FB4
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:51 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id v1so7965051qtx.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YAjutGgW/wYFVhGnoiZ1fsOqhShcWq0PsdTZENR4l0g=;
        b=lew23pYoV7S4Tf6ic1SyvsN9LWeifabmlD1EXAsu6b0IbJ+aW9lqa2UcS3j1bmt7mS
         3AokgnpOzGRDuAUoQMSBnaDINnv6P6e2fOuDIMx/yL3jHpWeCYglYKjdiGbBOwZ+LaHM
         i/qzmvMWjKK7h+sSuz5Kmt1X+m3hx2yzGHpB+Z5EqLAfx3Cvk+SSxs+1hf7TQnjmYnNZ
         TlLHjjT72/C5Jphi+lOsu+GovXqFjEWCQAHTiYJTvI0CxFlPczDO9HRGb8Jis7hQAKLm
         cdcmU174jgd42gCm3/+lkauTpIHnJgaPU6fmQ7zjM/VOiJF4Vlf5MjVIFGOKndRJFxNy
         7LKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YAjutGgW/wYFVhGnoiZ1fsOqhShcWq0PsdTZENR4l0g=;
        b=Zdvjw0OytTxLBg2wFNYMTV3i8Lv/SZzl2VghFXZJXsubKon3i+5UAyK5MXSeLEpZWI
         k1kdssePNTu6ebcDvjHi49Xx9rAOgdjMl6AmSEW5h88Rta44rYBGKkF4Qb3mOyxl0BFM
         NYVRSbjhHGH6pgt4Rm9DDZex2Dq23aghZKaJDxKrd+c9AoDxh05XACshsrFFu1bCnZZo
         DAr6bFV0Zh8a+LxywiYcMbeMhUv8gsghoLdnI0Zxm7xcXbBq5TUNpi4BsCzIWRTQMNKu
         y0KobzKJu/su9L5omEKMwcuThUJ328oqsmzTFoZM+z8qPvB/LTrtJWbydUzGqB4FW739
         57eQ==
X-Gm-Message-State: AOAM532QpyVoev0Hr0EMU+O7TjkzFq+ILFyKyPN+ymMBbX1Ufz/zglOq
        Wl8PWbHlvAxZyCehkqOaWP6YlP3jGKCe
X-Google-Smtp-Source: ABdhPJyCpfybNHSstjMUxf6dvDOcB9WIIs+/53XgUVaMaCNS2AiQtse4apCAiDW7UL9SQ75Y5Ub3jQ==
X-Received: by 2002:ac8:7f08:0:b0:304:b3cb:8f5d with SMTP id f8-20020ac87f08000000b00304b3cb8f5dmr12555125qtk.532.1654371101154;
        Sat, 04 Jun 2022 12:31:41 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:39 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 33/33] Delete seq_buf
Date:   Sat,  4 Jun 2022 15:30:42 -0400
Message-Id: <20220604193042.1674951-34-kent.overstreet@gmail.com>
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

No longer has any users, so delete it.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/seq_buf.h | 162 ----------------
 lib/Makefile            |   2 +-
 lib/seq_buf.c           | 397 ----------------------------------------
 3 files changed, 1 insertion(+), 560 deletions(-)
 delete mode 100644 include/linux/seq_buf.h
 delete mode 100644 lib/seq_buf.c

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
deleted file mode 100644
index 5b31c51479..0000000000
--- a/include/linux/seq_buf.h
+++ /dev/null
@@ -1,162 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_SEQ_BUF_H
-#define _LINUX_SEQ_BUF_H
-
-#include <linux/fs.h>
-
-/*
- * Trace sequences are used to allow a function to call several other functions
- * to create a string of data to use.
- */
-
-/**
- * seq_buf - seq buffer structure
- * @buffer:	pointer to the buffer
- * @size:	size of the buffer
- * @len:	the amount of data inside the buffer
- * @readpos:	The next position to read in the buffer.
- */
-struct seq_buf {
-	char			*buffer;
-	size_t			size;
-	size_t			len;
-	loff_t			readpos;
-};
-
-static inline void seq_buf_clear(struct seq_buf *s)
-{
-	s->len = 0;
-	s->readpos = 0;
-}
-
-static inline void
-seq_buf_init(struct seq_buf *s, char *buf, unsigned int size)
-{
-	s->buffer = buf;
-	s->size = size;
-	seq_buf_clear(s);
-}
-
-/*
- * seq_buf have a buffer that might overflow. When this happens
- * the len and size are set to be equal.
- */
-static inline bool
-seq_buf_has_overflowed(struct seq_buf *s)
-{
-	return s->len > s->size;
-}
-
-static inline void
-seq_buf_set_overflow(struct seq_buf *s)
-{
-	s->len = s->size + 1;
-}
-
-/*
- * How much buffer is left on the seq_buf?
- */
-static inline unsigned int
-seq_buf_buffer_left(struct seq_buf *s)
-{
-	if (seq_buf_has_overflowed(s))
-		return 0;
-
-	return s->size - s->len;
-}
-
-/* How much buffer was written? */
-static inline unsigned int seq_buf_used(struct seq_buf *s)
-{
-	return min(s->len, s->size);
-}
-
-/**
- * seq_buf_terminate - Make sure buffer is nul terminated
- * @s: the seq_buf descriptor to terminate.
- *
- * This makes sure that the buffer in @s is nul terminated and
- * safe to read as a string.
- *
- * Note, if this is called when the buffer has overflowed, then
- * the last byte of the buffer is zeroed, and the len will still
- * point passed it.
- *
- * After this function is called, s->buffer is safe to use
- * in string operations.
- */
-static inline void seq_buf_terminate(struct seq_buf *s)
-{
-	if (WARN_ON(s->size == 0))
-		return;
-
-	if (seq_buf_buffer_left(s))
-		s->buffer[s->len] = 0;
-	else
-		s->buffer[s->size - 1] = 0;
-}
-
-/**
- * seq_buf_get_buf - get buffer to write arbitrary data to
- * @s: the seq_buf handle
- * @bufp: the beginning of the buffer is stored here
- *
- * Return the number of bytes available in the buffer, or zero if
- * there's no space.
- */
-static inline size_t seq_buf_get_buf(struct seq_buf *s, char **bufp)
-{
-	WARN_ON(s->len > s->size + 1);
-
-	if (s->len < s->size) {
-		*bufp = s->buffer + s->len;
-		return s->size - s->len;
-	}
-
-	*bufp = NULL;
-	return 0;
-}
-
-/**
- * seq_buf_commit - commit data to the buffer
- * @s: the seq_buf handle
- * @num: the number of bytes to commit
- *
- * Commit @num bytes of data written to a buffer previously acquired
- * by seq_buf_get.  To signal an error condition, or that the data
- * didn't fit in the available space, pass a negative @num value.
- */
-static inline void seq_buf_commit(struct seq_buf *s, int num)
-{
-	if (num < 0) {
-		seq_buf_set_overflow(s);
-	} else {
-		/* num must be negative on overflow */
-		BUG_ON(s->len + num > s->size);
-		s->len += num;
-	}
-}
-
-extern __printf(2, 3)
-int seq_buf_printf(struct seq_buf *s, const char *fmt, ...);
-extern __printf(2, 0)
-int seq_buf_vprintf(struct seq_buf *s, const char *fmt, va_list args);
-extern int seq_buf_print_seq(struct seq_file *m, struct seq_buf *s);
-extern int seq_buf_to_user(struct seq_buf *s, char __user *ubuf,
-			   int cnt);
-extern int seq_buf_puts(struct seq_buf *s, const char *str);
-extern int seq_buf_putc(struct seq_buf *s, unsigned char c);
-extern int seq_buf_putmem(struct seq_buf *s, const void *mem, unsigned int len);
-extern int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
-			      unsigned int len);
-extern int seq_buf_path(struct seq_buf *s, const struct path *path, const char *esc);
-extern int seq_buf_hex_dump(struct seq_buf *s, const char *prefix_str,
-			    int prefix_type, int rowsize, int groupsize,
-			    const void *buf, size_t len, bool ascii);
-
-#ifdef CONFIG_BINARY_PRINTF
-extern int
-seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary);
-#endif
-
-#endif /* _LINUX_SEQ_BUF_H */
diff --git a/lib/Makefile b/lib/Makefile
index b520024852..f8ad89dc9a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -32,7 +32,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 idr.o extable.o sha1.o irq_regs.o argv_split.o \
 	 flex_proportions.o ratelimit.o show_mem.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
-	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
+	 earlycpio.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o \
 	 buildid.o printbuf.o pretty-printers.o
 
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
deleted file mode 100644
index 0a68f7aa85..0000000000
--- a/lib/seq_buf.c
+++ /dev/null
@@ -1,397 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * seq_buf.c
- *
- * Copyright (C) 2014 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
- *
- * The seq_buf is a handy tool that allows you to pass a descriptor around
- * to a buffer that other functions can write to. It is similar to the
- * seq_file functionality but has some differences.
- *
- * To use it, the seq_buf must be initialized with seq_buf_init().
- * This will set up the counters within the descriptor. You can call
- * seq_buf_init() more than once to reset the seq_buf to start
- * from scratch.
- */
-#include <linux/uaccess.h>
-#include <linux/seq_file.h>
-#include <linux/seq_buf.h>
-
-/**
- * seq_buf_can_fit - can the new data fit in the current buffer?
- * @s: the seq_buf descriptor
- * @len: The length to see if it can fit in the current buffer
- *
- * Returns true if there's enough unused space in the seq_buf buffer
- * to fit the amount of new data according to @len.
- */
-static bool seq_buf_can_fit(struct seq_buf *s, size_t len)
-{
-	return s->len + len <= s->size;
-}
-
-/**
- * seq_buf_print_seq - move the contents of seq_buf into a seq_file
- * @m: the seq_file descriptor that is the destination
- * @s: the seq_buf descriptor that is the source.
- *
- * Returns zero on success, non zero otherwise
- */
-int seq_buf_print_seq(struct seq_file *m, struct seq_buf *s)
-{
-	unsigned int len = seq_buf_used(s);
-
-	return seq_write(m, s->buffer, len);
-}
-
-/**
- * seq_buf_vprintf - sequence printing of information.
- * @s: seq_buf descriptor
- * @fmt: printf format string
- * @args: va_list of arguments from a printf() type function
- *
- * Writes a vnprintf() format into the sequencce buffer.
- *
- * Returns zero on success, -1 on overflow.
- */
-int seq_buf_vprintf(struct seq_buf *s, const char *fmt, va_list args)
-{
-	int len;
-
-	WARN_ON(s->size == 0);
-
-	if (s->len < s->size) {
-		len = vsnprintf(s->buffer + s->len, s->size - s->len, fmt, args);
-		if (s->len + len < s->size) {
-			s->len += len;
-			return 0;
-		}
-	}
-	seq_buf_set_overflow(s);
-	return -1;
-}
-
-/**
- * seq_buf_printf - sequence printing of information
- * @s: seq_buf descriptor
- * @fmt: printf format string
- *
- * Writes a printf() format into the sequence buffer.
- *
- * Returns zero on success, -1 on overflow.
- */
-int seq_buf_printf(struct seq_buf *s, const char *fmt, ...)
-{
-	va_list ap;
-	int ret;
-
-	va_start(ap, fmt);
-	ret = seq_buf_vprintf(s, fmt, ap);
-	va_end(ap);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(seq_buf_printf);
-
-#ifdef CONFIG_BINARY_PRINTF
-/**
- * seq_buf_bprintf - Write the printf string from binary arguments
- * @s: seq_buf descriptor
- * @fmt: The format string for the @binary arguments
- * @binary: The binary arguments for @fmt.
- *
- * When recording in a fast path, a printf may be recorded with just
- * saving the format and the arguments as they were passed to the
- * function, instead of wasting cycles converting the arguments into
- * ASCII characters. Instead, the arguments are saved in a 32 bit
- * word array that is defined by the format string constraints.
- *
- * This function will take the format and the binary array and finish
- * the conversion into the ASCII string within the buffer.
- *
- * Returns zero on success, -1 on overflow.
- */
-int seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary)
-{
-	unsigned int len = seq_buf_buffer_left(s);
-	int ret;
-
-	WARN_ON(s->size == 0);
-
-	if (s->len < s->size) {
-		ret = bstr_printf(s->buffer + s->len, len, fmt, binary);
-		if (s->len + ret < s->size) {
-			s->len += ret;
-			return 0;
-		}
-	}
-	seq_buf_set_overflow(s);
-	return -1;
-}
-#endif /* CONFIG_BINARY_PRINTF */
-
-/**
- * seq_buf_puts - sequence printing of simple string
- * @s: seq_buf descriptor
- * @str: simple string to record
- *
- * Copy a simple string into the sequence buffer.
- *
- * Returns zero on success, -1 on overflow
- */
-int seq_buf_puts(struct seq_buf *s, const char *str)
-{
-	size_t len = strlen(str);
-
-	WARN_ON(s->size == 0);
-
-	/* Add 1 to len for the trailing null byte which must be there */
-	len += 1;
-
-	if (seq_buf_can_fit(s, len)) {
-		memcpy(s->buffer + s->len, str, len);
-		/* Don't count the trailing null byte against the capacity */
-		s->len += len - 1;
-		return 0;
-	}
-	seq_buf_set_overflow(s);
-	return -1;
-}
-
-/**
- * seq_buf_putc - sequence printing of simple character
- * @s: seq_buf descriptor
- * @c: simple character to record
- *
- * Copy a single character into the sequence buffer.
- *
- * Returns zero on success, -1 on overflow
- */
-int seq_buf_putc(struct seq_buf *s, unsigned char c)
-{
-	WARN_ON(s->size == 0);
-
-	if (seq_buf_can_fit(s, 1)) {
-		s->buffer[s->len++] = c;
-		return 0;
-	}
-	seq_buf_set_overflow(s);
-	return -1;
-}
-
-/**
- * seq_buf_putmem - write raw data into the sequenc buffer
- * @s: seq_buf descriptor
- * @mem: The raw memory to copy into the buffer
- * @len: The length of the raw memory to copy (in bytes)
- *
- * There may be cases where raw memory needs to be written into the
- * buffer and a strcpy() would not work. Using this function allows
- * for such cases.
- *
- * Returns zero on success, -1 on overflow
- */
-int seq_buf_putmem(struct seq_buf *s, const void *mem, unsigned int len)
-{
-	WARN_ON(s->size == 0);
-
-	if (seq_buf_can_fit(s, len)) {
-		memcpy(s->buffer + s->len, mem, len);
-		s->len += len;
-		return 0;
-	}
-	seq_buf_set_overflow(s);
-	return -1;
-}
-
-#define MAX_MEMHEX_BYTES	8U
-#define HEX_CHARS		(MAX_MEMHEX_BYTES*2 + 1)
-
-/**
- * seq_buf_putmem_hex - write raw memory into the buffer in ASCII hex
- * @s: seq_buf descriptor
- * @mem: The raw memory to write its hex ASCII representation of
- * @len: The length of the raw memory to copy (in bytes)
- *
- * This is similar to seq_buf_putmem() except instead of just copying the
- * raw memory into the buffer it writes its ASCII representation of it
- * in hex characters.
- *
- * Returns zero on success, -1 on overflow
- */
-int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
-		       unsigned int len)
-{
-	unsigned char hex[HEX_CHARS];
-	const unsigned char *data = mem;
-	unsigned int start_len;
-	int i, j;
-
-	WARN_ON(s->size == 0);
-
-	BUILD_BUG_ON(MAX_MEMHEX_BYTES * 2 >= HEX_CHARS);
-
-	while (len) {
-		start_len = min(len, MAX_MEMHEX_BYTES);
-#ifdef __BIG_ENDIAN
-		for (i = 0, j = 0; i < start_len; i++) {
-#else
-		for (i = start_len-1, j = 0; i >= 0; i--) {
-#endif
-			hex[j++] = hex_asc_hi(data[i]);
-			hex[j++] = hex_asc_lo(data[i]);
-		}
-		if (WARN_ON_ONCE(j == 0 || j/2 > len))
-			break;
-
-		/* j increments twice per loop */
-		hex[j++] = ' ';
-
-		seq_buf_putmem(s, hex, j);
-		if (seq_buf_has_overflowed(s))
-			return -1;
-
-		len -= start_len;
-		data += start_len;
-	}
-	return 0;
-}
-
-/**
- * seq_buf_path - copy a path into the sequence buffer
- * @s: seq_buf descriptor
- * @path: path to write into the sequence buffer.
- * @esc: set of characters to escape in the output
- *
- * Write a path name into the sequence buffer.
- *
- * Returns the number of written bytes on success, -1 on overflow
- */
-int seq_buf_path(struct seq_buf *s, const struct path *path, const char *esc)
-{
-	char *buf;
-	size_t size = seq_buf_get_buf(s, &buf);
-	int res = -1;
-
-	WARN_ON(s->size == 0);
-
-	if (size) {
-		char *p = d_path(path, buf, size);
-		if (!IS_ERR(p)) {
-			char *end = mangle_path(buf, p, esc);
-			if (end)
-				res = end - buf;
-		}
-	}
-	seq_buf_commit(s, res);
-
-	return res;
-}
-
-/**
- * seq_buf_to_user - copy the sequence buffer to user space
- * @s: seq_buf descriptor
- * @ubuf: The userspace memory location to copy to
- * @cnt: The amount to copy
- *
- * Copies the sequence buffer into the userspace memory pointed to
- * by @ubuf. It starts from the last read position (@s->readpos)
- * and writes up to @cnt characters or till it reaches the end of
- * the content in the buffer (@s->len), which ever comes first.
- *
- * On success, it returns a positive number of the number of bytes
- * it copied.
- *
- * On failure it returns -EBUSY if all of the content in the
- * sequence has been already read, which includes nothing in the
- * sequence (@s->len == @s->readpos).
- *
- * Returns -EFAULT if the copy to userspace fails.
- */
-int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, int cnt)
-{
-	int len;
-	int ret;
-
-	if (!cnt)
-		return 0;
-
-	len = seq_buf_used(s);
-
-	if (len <= s->readpos)
-		return -EBUSY;
-
-	len -= s->readpos;
-	if (cnt > len)
-		cnt = len;
-	ret = copy_to_user(ubuf, s->buffer + s->readpos, cnt);
-	if (ret == cnt)
-		return -EFAULT;
-
-	cnt -= ret;
-
-	s->readpos += cnt;
-	return cnt;
-}
-
-/**
- * seq_buf_hex_dump - print formatted hex dump into the sequence buffer
- * @s: seq_buf descriptor
- * @prefix_str: string to prefix each line with;
- *  caller supplies trailing spaces for alignment if desired
- * @prefix_type: controls whether prefix of an offset, address, or none
- *  is printed (%DUMP_PREFIX_OFFSET, %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_NONE)
- * @rowsize: number of bytes to print per line; must be 16 or 32
- * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
- * @buf: data blob to dump
- * @len: number of bytes in the @buf
- * @ascii: include ASCII after the hex output
- *
- * Function is an analogue of print_hex_dump() and thus has similar interface.
- *
- * linebuf size is maximal length for one line.
- * 32 * 3 - maximum bytes per line, each printed into 2 chars + 1 for
- *	separating space
- * 2 - spaces separating hex dump and ascii representation
- * 32 - ascii representation
- * 1 - terminating '\0'
- *
- * Returns zero on success, -1 on overflow
- */
-int seq_buf_hex_dump(struct seq_buf *s, const char *prefix_str, int prefix_type,
-		     int rowsize, int groupsize,
-		     const void *buf, size_t len, bool ascii)
-{
-	const u8 *ptr = buf;
-	int i, linelen, remaining = len;
-	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
-	int ret;
-
-	if (rowsize != 16 && rowsize != 32)
-		rowsize = 16;
-
-	for (i = 0; i < len; i += rowsize) {
-		linelen = min(remaining, rowsize);
-		remaining -= rowsize;
-
-		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
-				   linebuf, sizeof(linebuf), ascii);
-
-		switch (prefix_type) {
-		case DUMP_PREFIX_ADDRESS:
-			ret = seq_buf_printf(s, "%s%p: %s\n",
-			       prefix_str, ptr + i, linebuf);
-			break;
-		case DUMP_PREFIX_OFFSET:
-			ret = seq_buf_printf(s, "%s%.8x: %s\n",
-					     prefix_str, i, linebuf);
-			break;
-		default:
-			ret = seq_buf_printf(s, "%s%s\n", prefix_str, linebuf);
-			break;
-		}
-		if (ret)
-			return ret;
-	}
-	return 0;
-}
-- 
2.36.0

