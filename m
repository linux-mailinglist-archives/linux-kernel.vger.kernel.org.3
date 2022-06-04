Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0F153D84B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbiFDTcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240665AbiFDTbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:40 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E02B50017
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:21 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c8so7974406qtj.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Kz0pz7Mia/gmCNDAqKt9rpofsruelzWNSzQfxnNHsE=;
        b=Yk9lCBml1xUExBB5xXCaE6uEJorrNxMZIJaf6Ac+vckzLUw2vXxnWgP/R5Z06V1W2m
         HCmlEOHThU6UsI7c1aYjZ/PV5nVou+3TJOpL1+8xJWmqtQRlIm6FOhYGzr8nYYWgYPHM
         Ofo8xS2GBBVX3b7q8epm+vTtSx/pJoPVajwkPBgaSd0eJ8X6dunRl6BY2IlgA/l/50dL
         NwCipFS0qJ5unGzOPey6Ay45+OVkLuJpVlPHdi+/osxop4f6hOXN74t5XVi95AtDhBmV
         qhcgbFoW+mJ0fI1x/T/yEdM9/9oNPDSV3DsojUqFEg6HGGcQXvI/PZcLsaC39Q5B8E5J
         v75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Kz0pz7Mia/gmCNDAqKt9rpofsruelzWNSzQfxnNHsE=;
        b=ukH2PQg9X1IsZLGabB8iX497FN1Ajc+u+peGeuXQGTT4IO5gHs8Vu7p43TWYJQy6qh
         /i9sj+xcFvT9tneiDPfN3kn3dfVTXmrmMWvoPu8pEDhQfJpx8a3ZujIyqy7nrsA2JK3f
         llFkKBNFlTzH6JpvRGdjVrPmss9ioSXyLDwDewymWnyBNMK+PlZoQwCGqqgXioFq6aBg
         Na3gzK5u8aDFwWNAsC8qex31iRLdgfdQtY0+9Y0FRkqcGjjpFdww9K2nRyLXGKn1V7fG
         wdOYC6It4sP08Oit3fzwW2aDLRCzQtlb/TR6/GTxD016rvYV6luINOcmfNvjO3wsffvF
         0VsA==
X-Gm-Message-State: AOAM530sR4jimShmH6R5rR5nIOTINjeAK6+GyzJl6UfP3Xrzo9ZY+E/m
        2x4vNIBEyPobctu877JRF1wUYWUJqgRB
X-Google-Smtp-Source: ABdhPJzIHTtna/1os7r4Gh4AU9wLMHUo8ofSn1AcfAhxWyFKssjKHFrHde23TLJfuYShzMR9eaeDvg==
X-Received: by 2002:ac8:5e13:0:b0:304:b452:9ec8 with SMTP id h19-20020ac85e13000000b00304b4529ec8mr13038713qtx.356.1654371080158;
        Sat, 04 Jun 2022 12:31:20 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:19 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 20/33] vsprintf: flags_string() no longer takes printf_spec
Date:   Sat,  4 Jun 2022 15:30:29 -0400
Message-Id: <20220604193042.1674951-21-kent.overstreet@gmail.com>
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

We're attempting to consolidate printf_spec and format string handling
in the top level vpr_buf(), this changes time_and_date() to not
take printf_spec.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 5de25723a3..1cd08d0d5b 100644
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
2.36.0

