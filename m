Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6513D53D842
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239985AbiFDTa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239929AbiFDTax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:30:53 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB8922519
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:30:52 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id k4so1354273qth.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pibz/KENrk8dWYPVgji9GTuoqUjjn4PZ4o1W4g097Gg=;
        b=e4nBobTgPn+CP4VPeQfBie8q+Tc0uce9HxMY3ySOdDDEaejD6kTUJJbMPVfsf9NJhH
         qP/dYAIIPCQ64UBzy3+TglHoVkl2B6YChj6UmnkRtkWVjtD+x2jVVJmHVYbKxxfokRze
         cCC/so1OBZfyBE3h/WXnS0wNzbXsPpg5rQ6k/sxpvtAHbYHIdVsTp5VvQwqXLHR7yD3M
         CqsYYrKr41Szj80vPehyPaVxnV0SQTgLeFUYp1bLzZigOatpDhu+Juk17/MoYDqe0WM3
         Ef0Psb3C7zZkE6TLavDET2mYK+oVKx7VidVZYHc3nTuFzZjiy+WYnDCkAON44q6KNdW0
         8MRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pibz/KENrk8dWYPVgji9GTuoqUjjn4PZ4o1W4g097Gg=;
        b=DEdQvRwsvrASdQ/zsyS8ALrkLNRFzPJtfjpuBhECQ+5Sgmift/RcETcAaeSa3AIfzv
         YLDacfrKlRl5V3MGpT7SSKYL4PnecQZtXAmhf+oNKZhpEgNUID9yKLQXHwc1ihq66Ujq
         Od2F5utZOFEeirzbbQLGpUxoy7nvuHVgTCv7QbVCh3qFF36SD90Q3Uks1I5b9l8lwsMz
         tDRxXJcxqPq+nK+/5+EvMiOcUxBHuSdOD4AQmtMNfG0cOvwXMCbiAX9i/YUVPKWCewXk
         BoyBXz9rjzZ1xlQSN2q+FrauRtJfCZmNTcPCcVPOZMQuegibh+diSQA2dyeIzskbvaYj
         lgLA==
X-Gm-Message-State: AOAM532bnq25SLCC/q+HN4L7gcLbuaEmYkfmyo3SAahzjR0D7ENcCKxX
        m3KBPi0hIqb4EyuSOOn9gcEUPdpgCd70
X-Google-Smtp-Source: ABdhPJymKW+MPe/S4MobSQMjYUgg5DQ1K2vtoEIDaam+ZH+mHf1pGF2CZoRaW0byl2/6KFzQYSGDiw==
X-Received: by 2002:a05:622a:1101:b0:304:e4ad:f492 with SMTP id e1-20020a05622a110100b00304e4adf492mr4123050qty.452.1654371051359;
        Sat, 04 Jun 2022 12:30:51 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:30:50 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 01/33] lib/printbuf: New data structure for printing strings
Date:   Sat,  4 Jun 2022 15:30:10 -0400
Message-Id: <20220604193042.1674951-2-kent.overstreet@gmail.com>
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

This adds printbufs: a printbuf points to a char * buffer and knows the
size of the output buffer as well as the current output position.

Future patches will be adding more features to printbuf, but initially
printbufs are targeted at refactoring and improving our existing code in
lib/vsprintf.c - so this initial printbuf patch has the features
required for that.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/printbuf.h | 118 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 include/linux/printbuf.h

diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
new file mode 100644
index 0000000000..8b3797dc4b
--- /dev/null
+++ b/include/linux/printbuf.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/* Copyright (C) 2022 Kent Overstreet */
+
+#ifndef _LINUX_PRINTBUF_H
+#define _LINUX_PRINTBUF_H
+
+#include <linux/string.h>
+
+/*
+ * Printbufs: String buffer for outputting (printing) to, for vsnprintf
+ */
+
+struct printbuf {
+	char			*buf;
+	unsigned		size;
+	unsigned		pos;
+};
+
+/*
+ * Returns size remaining of output buffer:
+ */
+static inline unsigned printbuf_remaining_size(struct printbuf *out)
+{
+	return out->pos < out->size ? out->size - out->pos : 0;
+}
+
+/*
+ * Returns number of characters we can print to the output buffer - i.e.
+ * excluding the terminating nul:
+ */
+static inline unsigned printbuf_remaining(struct printbuf *out)
+{
+	return out->pos < out->size ? out->size - out->pos - 1 : 0;
+}
+
+static inline unsigned printbuf_written(struct printbuf *out)
+{
+	return min(out->pos, out->size);
+}
+
+/*
+ * Returns true if output was truncated:
+ */
+static inline bool printbuf_overflowed(struct printbuf *out)
+{
+	return out->pos >= out->size;
+}
+
+static inline void printbuf_nul_terminate(struct printbuf *out)
+{
+	if (out->pos < out->size)
+		out->buf[out->pos] = 0;
+	else if (out->size)
+		out->buf[out->size - 1] = 0;
+}
+
+static inline void __prt_chars(struct printbuf *out, char c, unsigned n)
+{
+	memset(out->buf + out->pos,
+	       c,
+	       min(n, printbuf_remaining(out)));
+	out->pos += n;
+}
+
+static inline void prt_chars(struct printbuf *out, char c, unsigned n)
+{
+	__prt_chars(out, c, n);
+	printbuf_nul_terminate(out);
+}
+
+static inline void __prt_char(struct printbuf *out, char c)
+{
+	if (printbuf_remaining(out))
+		out->buf[out->pos] = c;
+	out->pos++;
+}
+
+static inline void prt_char(struct printbuf *out, char c)
+{
+	__prt_char(out, c);
+	printbuf_nul_terminate(out);
+}
+
+static inline void prt_bytes(struct printbuf *out, const void *b, unsigned n)
+{
+	memcpy(out->buf + out->pos,
+	       b,
+	       min(n, printbuf_remaining(out)));
+	out->pos += n;
+	printbuf_nul_terminate(out);
+}
+
+static inline void prt_str(struct printbuf *out, const char *str)
+{
+	prt_bytes(out, str, strlen(str));
+}
+
+static inline void prt_hex_byte(struct printbuf *out, u8 byte)
+{
+	__prt_char(out, hex_asc_hi(byte));
+	__prt_char(out, hex_asc_lo(byte));
+	printbuf_nul_terminate(out);
+}
+
+static inline void prt_hex_byte_upper(struct printbuf *out, u8 byte)
+{
+	__prt_char(out, hex_asc_upper_hi(byte));
+	__prt_char(out, hex_asc_upper_lo(byte));
+	printbuf_nul_terminate(out);
+}
+
+#define PRINTBUF_EXTERN(_buf, _size)			\
+((struct printbuf) {					\
+	.buf	= _buf,					\
+	.size	= _size,				\
+})
+
+#endif /* _LINUX_PRINTBUF_H */
-- 
2.36.0

