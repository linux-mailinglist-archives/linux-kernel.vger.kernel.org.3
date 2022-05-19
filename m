Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD68352DB24
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242856AbiESR0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242623AbiESRZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:25:05 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27049A3093;
        Thu, 19 May 2022 10:25:03 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i24so5706065pfa.7;
        Thu, 19 May 2022 10:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sYyJmhJ1UJuNTKSNkznuVgdOa0YLmomkOmOhYpxJCFI=;
        b=B1Heee3hxpN0aBQABPk0xvOT+jNBu4aa7AW9HK6xt/c87pzEb/DTZi7S+zuAx7PfOi
         Ugk+cjgRwVIq0AfPCPScAmiJDJinvCqHIbGwupmjTb3JM3sMnmnbqB79XrgM5gwDVatp
         DltHbvP8sTARpXH5IhZ3fAthfr4j1lR5OO2INzRNnl9acSGvlZhHf2euPwAZVBTSJ8si
         CZbQIn3QSEfbI5qbXSHNv2G4GXSdwjhtMOznL6S5rKQFb+CMk73ITxWA1Gez162dP7UI
         oi9ial8S6TM8MW23ND5h0h8wcA+lsIW4YDX+5lQMe8sJ+MsFwpTlpFAx+9j2yenqSqi4
         xHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sYyJmhJ1UJuNTKSNkznuVgdOa0YLmomkOmOhYpxJCFI=;
        b=HHBc+sXsT0fHkYnrEEY3HGC35DqmQ0Mk3iwDPmrZGaQLvAbkYpgC1WolbKR0U86ZZ5
         HFhrFTJBJKPx4b1SLgXEdrtq6j9oNLbaW4y7Io4aiBJQuSFyu6wI4Q6GC5Au3OsagDeQ
         t4KficODlqEQV8HFox/VQJEfryuh0N/V332UxYx/jIjIxa+eUBH90I9RfMv6xQv/O1nF
         5wNRq3b6gPaqJsXHgXjp/ChgyzNIvhflpgHOLqbuXOKQmhgkW44Zj6vvk4i+8M7vsYnI
         wiC3cDME+A4gY2q6opet644fAy1FeYv97GkfYPb5VGGtiz7Qerq9nDe/NN4BlHtsKVzG
         HJsQ==
X-Gm-Message-State: AOAM531aeALEZCBhiEVhH2z+HPphW74l9IlGs565S3AbMK1vBjo8isti
        SQZCbeG4FRcHVCtiNou3uov+zqngLk54
X-Google-Smtp-Source: ABdhPJzZY5YP8RElcJziKMe2Pb+9bzOWxPxFDsokqdhQLlpUQtMJ7p36gRVAP/eKYVsQomShn6d3Ew==
X-Received: by 2002:a63:2c15:0:b0:3f6:6a5f:8f0a with SMTP id s21-20020a632c15000000b003f66a5f8f0amr495864pgs.76.1652981102152;
        Thu, 19 May 2022 10:25:02 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:25:01 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 12/28] test_printf: Drop requirement that sprintf not write past nul
Date:   Thu, 19 May 2022 13:24:05 -0400
Message-Id: <20220519172421.162394-13-kent.overstreet@gmail.com>
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
index 1e1604ef1a..0804ab788d 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -78,12 +78,6 @@ do_test(int bufsize, const char *expect, int elen,
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
2.36.0

