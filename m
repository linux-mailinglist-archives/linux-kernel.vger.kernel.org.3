Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574D6550E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbiFTApf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbiFTAnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:12 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72E8B85E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:03 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id g18so6506831qvn.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jzrJaN7GJ4zvwlB0O2GIJnZ1v/nEIhK2TK9aO5Rtgmc=;
        b=Lx1lmnEKLmHMo8GHFAGvtwT3kPHmLRskpKD6CEVJIlEOc7OOqPkS+AyPuQjC6rkL/R
         RVK8+PQf6sJtv6K7a1/JuyP1Tc8zux4etc1R1OE3bbgEZ3C8RrskO7A6KayUFnodw0Pi
         /nvSWAOB9bk2S6Md2QizVlUhMvW8PKZGGu8BijiTIUeuUUB/OGAuTBxCrEE/ciQCaAUX
         Rml/JegJzNmIz1eCPDhc3Qw9qhEClxDG6UowIKZUFCXu6kOW63ydkkszQeUimcN+3KHr
         RuJ/x1XnWgd11/FREucrvMRD+5RQLlaQC0XKRsSPIHg0Gshd7s5dqqdASW/2g/yvTaQo
         gWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jzrJaN7GJ4zvwlB0O2GIJnZ1v/nEIhK2TK9aO5Rtgmc=;
        b=r8kdixNkOjs59Imbledaw3FOrWGPzvT6xQmayshKJwD/N1zq057SQW/C5EKuj11kaW
         ATE9+F3KtTqVf9/60FYZagzso9ZynING9Za4yQuGrT356cdBVDVzjiMKa+/yK1qsN5Nb
         iKuM0GqmFFi9su34S9IMQS7W2vHqXYU+3jf4ASKJSDhBIzAD64PJfQhOK+wHrRfbeCEj
         zCWgbACSMhO7h9nZZx8qNuuCk/u7rZcR/7c0+SLU+70jNRGFK19LJyhwdhPogMil+Pfz
         Jq/ds9WcENSNt5EB+Bdo7O24kuok2TI9p4uaT6IVjuioJgpEhLseWShCEKROoxxyPjT7
         LvOA==
X-Gm-Message-State: AJIora/tDIjIcNd/qc1oXV78HzTIV37qp+Ha+rsOdWz2jOin8BT/wW2i
        5t0EUSUSbx5MSsRGoqz0KSHb2pAcsBQiDpA=
X-Google-Smtp-Source: AGRyM1sksTfZsVTyUyCjlAQdG4wXyI6RZnc1sCTZrHrYV9IC64sOB5+yfZ27xlwBXuwuV9wyMa93IA==
X-Received: by 2002:ac8:5750:0:b0:304:fcfa:67db with SMTP id 16-20020ac85750000000b00304fcfa67dbmr17632697qtx.249.1655685781656;
        Sun, 19 Jun 2022 17:43:01 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id c10-20020a05620a0cea00b006a6ab259261sm9905480qkj.29.2022.06.19.17.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:43:01 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 13/34] test_printf: Drop requirement that sprintf not write past nul
Date:   Sun, 19 Jun 2022 20:42:12 -0400
Message-Id: <20220620004233.3805-14-kent.overstreet@gmail.com>
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

The current test code checks that sprintf never writes past the
terminating nul. This is a rather strange requirement, completely
separate from writing past the end of the buffer, which of course we
can't do: writing anywhere to the buffer passed to snprintf, within size
of course, should be perfectly fine.

Since this check has no documentation as to where it comes from or what
depends on it, and it's getting in the way of further refactoring
(printf_spec handling is right now scattered massively throughout the
code, and we'd like to consolidate it) - delete it.

Also, many current pretty-printers building up their output on the
stack, and then copy it to the actual output buffer - by eliminating
this requirement we can kill those extra buffers.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/test_printf.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index e3de52da91..853e89e2f8 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -79,12 +79,6 @@ do_test(int bufsize, const char *expect, int elen,
 		return 1;
 	}
 
-	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, BUF_SIZE + PAD_SIZE - (written + 1))) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
-			bufsize, fmt);
-		return 1;
-	}
-
 	if (memcmp(test_buffer, expect, written)) {
 		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'\n",
 			bufsize, fmt, test_buffer, written, expect);
-- 
2.36.1

