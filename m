Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AECB550E04
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbiFTAo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238152AbiFTAn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:29 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E004BC28
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:22 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id cu16so13426196qvb.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oFSr89aEU92gWcunlU5vS2f7TnOlgJfvUBwY+HXlWFw=;
        b=cgxYlVJ4GLr3WkdItoWKiuQPJXd0/Yj+V7c1QPL/3/kcDcVxN2pyVSRSVKCySEDzli
         BNYCNb17DVymCnCJL362udOhu/AJAbK9iwMjJuy9M9l+18C16sPzNhw3Tco8nWT3Qu7W
         vMhLiaOq69smKx8migXhSCfkKo6rlhgmyYvB1Mvx2m3CAcHjCiiHi1tOoLHuBZS2FaTZ
         73/zfoNTLVn4p5wG5pTLFURCPiku9Qa75shYPRR3B+Gq0OXW3D54CnGhCFQA0KxQIELo
         zNFaycSH2cHnwvWQteHgtf2UnrkymMkegc2Qr3q6snyK1xQjVN0RIbwRRzORQ/SJG8AM
         AUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFSr89aEU92gWcunlU5vS2f7TnOlgJfvUBwY+HXlWFw=;
        b=z+IaC8L2nVjUwv4gre2MIDMuctWKx4LOYbNYM+Wm9SHnXO+V25p4qFWQJ+hd2XSNA3
         9shf+hw17l0YCmgjKFzfHhThl4hPuzcFVFbsTbTrVCXbGs0hHYGq99x4jekrcZkHaX8h
         6KFLc6jim1AF2fSIeQHU11T7AhyQv+qBhqrKgp6n/ulp829+y9f5UgjMLeV4GEeTTs/H
         1d269igLOoK3VtQn2MENT5zEhjzjK6tNz2XUe09oVILemnYibim2Px93ZRDT1HGHUi1Z
         3Ud4UEInnFfgx3bQuZQ/mHAGOiOrDVF+xD6mflIpmzjUoFVxWbjQJ5Xkse1nsItD3bQf
         vnUQ==
X-Gm-Message-State: AJIora/dgEpoQhco/JPjpaCz8XiniXHcHpdQKHL/i8QSWVU1e3hTgfms
        0wwgMcQsnmrcJOMAXWjEMSl6ZS7Ab9MYiBU=
X-Google-Smtp-Source: AGRyM1uM1OOd6wF+UQ3AdfkXj7CcsIPtdmf+wpKlLPB24tvyPh8HWTFZTJz/0aRTR4yVX2WPdDwz8w==
X-Received: by 2002:ac8:5a01:0:b0:305:205e:5b61 with SMTP id n1-20020ac85a01000000b00305205e5b61mr17841821qta.218.1655685801680;
        Sun, 19 Jun 2022 17:43:21 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id g2-20020ac80702000000b00304f79b2bcfsm9626734qth.49.2022.06.19.17.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:43:20 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 20/34] vsprintf: flags_string() no longer takes printf_spec
Date:   Sun, 19 Jun 2022 20:42:19 -0400
Message-Id: <20220620004233.3805-21-kent.overstreet@gmail.com>
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

We're attempting to consolidate printf_spec and format string handling
in the top level vpr_buf(), this changes time_and_date() to not
take printf_spec.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index affe2b0bcc..3900f7a1a5 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1942,12 +1942,12 @@ void format_page_flags(struct printbuf *out, unsigned long flags)
 
 static noinline_for_stack
 void flags_string(struct printbuf *out, void *flags_ptr,
-		  struct printf_spec spec, const char *fmt)
+		  const char *fmt)
 {
 	unsigned long flags;
 	const struct trace_print_flags *names;
 
-	if (check_pointer_spec(out, flags_ptr, spec))
+	if (check_pointer(out, flags_ptr))
 		return;
 
 	switch (fmt[1]) {
@@ -1962,7 +1962,7 @@ void flags_string(struct printbuf *out, void *flags_ptr,
 		names = gfpflag_names;
 		break;
 	default:
-		return error_string_spec(out, "(%pG?)", spec);
+		return error_string(out, "(%pG?)");
 	}
 
 	return format_flags(out, flags, names);
@@ -2335,7 +2335,8 @@ void pointer(struct printbuf *out, const char *fmt,
 #endif
 
 	case 'G':
-		return flags_string(out, ptr, spec, fmt);
+		flags_string(out, ptr, fmt);
+		return do_width_precision(out, prev_pos, spec);
 	case 'O':
 		return device_node_string(out, ptr, spec, fmt + 1);
 	case 'f':
-- 
2.36.1

