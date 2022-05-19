Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B408152DB41
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbiESR2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242708AbiESRZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:25:24 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2917EAFB18;
        Thu, 19 May 2022 10:25:20 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d22so5362505plr.9;
        Thu, 19 May 2022 10:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zZ5b0xdEpn+CBBGAkA6i9eo0UnhdgnmaKiuhK5IzIAE=;
        b=nnzeicYYieFIceMJFH+7n68Pgzl2q2bBoiF9O1WjNCu5cSEMr+10//1MNuypvgaVM1
         /bZ22uIrgQ71QtzfO/gAWHluPbZa9OJmocvpehzINqQvPgdjwNB6Shqx96PbdUuuJQ+I
         sRmS8/ffi6dzUM+LzUEduSsbcDSBSUiUIxxvhrQkzwhIbKup0bbIYjsx3peaxVRSzO9O
         Dt2PC0l3Nqp3HxfovEHYJIl1uwN1SLXTJP1neevx0kchvbNZdeQCkUrMnDKlZXjk6uhz
         x1Qo+DPGi6yXQLEF/tomaBkSevvzEq9r8oObPGl1rFkH2voVtxJVUySVTiChXlXcaNE8
         EcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zZ5b0xdEpn+CBBGAkA6i9eo0UnhdgnmaKiuhK5IzIAE=;
        b=p0wzNbOMkQOitoa0zIKjDYjEJHhboig9uh01eQpmaVYmgMLB74BosIMYaI+BUtnuu4
         qVr30USnoNEOWIP5gHepota1jgxqk+m8YYYgQuegKB9kW5oeI2sTmkjJG895EeLmkJVt
         LuG3W+/vncimETvYjITXG/W/2OQmmhWQJ7RzotRGSsC9TsoF0NAai+nnCHB6UV0R+o89
         eq7N2idwC+7KEwBmp/F5e4Y5k1En1L1vfZtS22Ygy5TOlFPcXn6sSoA8BDAxu4zyTByq
         6N1fz8S0PCxA3OAWNM64jEJF85UJKLhJcyJKjEVMOJbudDM4kf6RKH7l9fUL4BihJHB5
         iKKA==
X-Gm-Message-State: AOAM532kdlOEg/lqTs/AXR/V7Dw4dhdrZ1NczGA6odVfFlTLGM8SHa7u
        f/v7mKvhoqEmSwimuSPhFLqJfDoJx+r0
X-Google-Smtp-Source: ABdhPJzoWpILxPY/FtcHe7auDf4GKTb4QiQq9qKUQETSfuC0bEz6CKeeIQzjc++0XSfsmCG5aefFGw==
X-Received: by 2002:a17:90a:a384:b0:1dc:a407:b5ac with SMTP id x4-20020a17090aa38400b001dca407b5acmr6150964pjp.11.1652981119128;
        Thu, 19 May 2022 10:25:19 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:25:18 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 19/28] vsprintf: flags_string() no longer takes printf_spec
Date:   Thu, 19 May 2022 13:24:12 -0400
Message-Id: <20220519172421.162394-20-kent.overstreet@gmail.com>
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

We're attempting to consolidate printf_spec and format string handling
in the top level vpr_buf(), this changes time_and_date() to not
take printf_spec.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 837a3f967e..971cf17d33 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1916,12 +1916,12 @@ void format_page_flags(struct printbuf *out, unsigned long flags)
 
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
@@ -1936,7 +1936,7 @@ void flags_string(struct printbuf *out, void *flags_ptr,
 		names = gfpflag_names;
 		break;
 	default:
-		return error_string_spec(out, "(%pG?)", spec);
+		return error_string(out, "(%pG?)");
 	}
 
 	return format_flags(out, flags, names);
@@ -2313,7 +2313,8 @@ void pointer(struct printbuf *out, const char *fmt,
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

