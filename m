Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136564B3711
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiBLSTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:19:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiBLSTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:19:03 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F955EDEA
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:18:59 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id m22so2724204pfk.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=074Jgk/bKG11mgzAiyskWNwWnB7OSYIgIxmzC09AYrA=;
        b=SKkU0xpA6/hFKvE15Jtyofh9sHojC6fmBeG1/hdWEVnTbKPp/YkNff4aqQmB9CEl7b
         U2BR4tmremMIB0YE28mYqJeLv0NcLFYR32Y9Qw8jD7seZ/MliYcFhe8UowRylPrrg+zX
         YigLeB2E7mKvv4ILmn8b6w2ncgOG14gWEUGHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=074Jgk/bKG11mgzAiyskWNwWnB7OSYIgIxmzC09AYrA=;
        b=MQMsFOq1dRbLH7KdFRRT3XyM0idLaQRc1gRN8ngz6tiESmaKxB2/n/NzNWhJtI5k0i
         aLEFNKN2/kAVKhJSRwb+vmDNIY6UQSArSXksTc0kAeha3bFRs0xk7nGVMp2RYecX4nyD
         PzknVbgHn0KLeNVItrMM/zN8Q81i+rZLY3PI1+IQ/yPWr0cBcpVKO16pO55rKJN6UeUa
         PRA+QDMsxPia7F0JFNwFoTf6f9DCo7PyPgE88CMEygsl6OyPFLC+lt4n64Ic1lLsC4Bw
         JYnmokIWKdal+vf1pEGYz+WwdkRC/oU8liL0/yX648gMOaYwZvaX4Yb+R9vsWFtg7UPh
         Reiw==
X-Gm-Message-State: AOAM531cMoCtryLaeEToDGWWrQpChDRgn3S4E78kWgebs+J4M9AnXElt
        ZsxOi/W+ZLVgZI9dfqRjIExLoA==
X-Google-Smtp-Source: ABdhPJyt+7/qchjIpVDBgclGTRZtxX+oV4D/IZTFmm+cG0WJ54GFGhjU0IXzvTLVy/kDZixMBlT3tA==
X-Received: by 2002:a63:6982:: with SMTP id e124mr5785094pgc.528.1644689938250;
        Sat, 12 Feb 2022 10:18:58 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id be3sm1732780pfb.8.2022.02.12.10.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 10:18:58 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Justin Forbes <jmforbes@linuxtx.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] tools: Fix use-after-free for realloc(..., 0)
Date:   Sat, 12 Feb 2022 10:18:55 -0800
Message-Id: <20220212181855.3460176-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2421; h=from:subject; bh=gfLUG5BRezAorsaD9PFyU6JfAQleA4jtrlj/yPG8KgQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiB/oOw13KMvgwrXOUcUWhx2qwZdic+XCBaPRZuNle 3v/q4gSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgf6DgAKCRCJcvTf3G3AJliGEA CPJbWUnU77KPt05mNov2PU2yIbEjoGAHbScRRD5xZ+aoGVqtFIJacn/bUUZFzUAJTn6mbac8y+MhOq 6jt0x2XUG+HU8qy2i/a8467JRqDJjf/SyB3CYdfGJQyZazgn9mhtu0Tt2S3TltzW6Ao2E9sS7dkd9q WHilTZ3qSheur+AjOVxl5rOU5n8YNOS6JgpZH6T82O+slddCVv+jD3jI0N9BX/FJXHffzWcI/qPOvF u7STCgaOVAx9IkyvMPFpwlXDjjY/z5KpzaafXlqKs0KMmAYhZET52VuPpcfosRukuGCM+GHqhxzXnY HzHcJoymblFkmp3bb8kQmtDnSZ9kEGWHYd7copV/IIS1mHEDQqIpvIaQvFrRcIPI3t4hVI/4wZX6h1 mmU2G2Yu/zEwvBYUQJXXLAQTaIMzrgoIFJsrNXyewZDY3Y9efhCpz7DTyFz1DYLN48QAdQhWN0JCgV dKKUIshraUI+QUcIHmcuCpkrExp2Q5grLN6jCewxn5HLrKKBuRohja+xxTA0bWJALCD8OV5Ev0yEWi Z5Ov+fLvQfKihSF6iryN7B2zhDVfvFb5yd9FVAsIQDKWix8dlVQGZLjTos3/m/S37QUbiPEQ1jSFRx K/6vMobG68d0w7/oUiJMmTItat0HREhbgzimr2DLRfzHsGQ6e736LQoHY6PQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 12 was correctly reporting a potential use-after-free condition in
the xrealloc helper. Fix the warning by avoiding an implicit "free(ptr)"
when size == 0:

In file included from help.c:12:
In function 'xrealloc',
    inlined from 'add_cmdname' at help.c:24:2: subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
   56 |                 ret = realloc(ptr, size);
      |                       ^~~~~~~~~~~~~~~~~~
subcmd-util.h:52:21: note: call to 'realloc' here
   52 |         void *ret = realloc(ptr, size);
      |                     ^~~~~~~~~~~~~~~~~~
subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
   58 |                         ret = realloc(ptr, 1);
      |                               ^~~~~~~~~~~~~~~
subcmd-util.h:52:21: note: call to 'realloc' here
   52 |         void *ret = realloc(ptr, size);
      |                     ^~~~~~~~~~~~~~~~~~

Reported-by: "Valdis Klētnieks" <valdis.kletnieks@vt.edu>
Fixes: 2f4ce5ec1d44 ("perf tools: Finalize subcmd independence")
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/lib/subcmd/subcmd-util.h | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/lib/subcmd/subcmd-util.h b/tools/lib/subcmd/subcmd-util.h
index 794a375dad36..de392fc5fd3a 100644
--- a/tools/lib/subcmd/subcmd-util.h
+++ b/tools/lib/subcmd/subcmd-util.h
@@ -49,15 +49,24 @@ static NORETURN inline void die(const char *err, ...)
 
 static inline void *xrealloc(void *ptr, size_t size)
 {
-	void *ret = realloc(ptr, size);
-	if (!ret && !size)
-		ret = realloc(ptr, 1);
+	void *ret;
+
+	/*
+	 * Convert a zero-sized allocation into 1 byte, since
+	 * realloc(ptr, 0) means free(ptr), but we don't want
+	 * to release the memory. For a new allocation (when
+	 * ptr == NULL), avoid triggering NULL-checking error
+	 * conditions for zero-sized allocations.
+	 */
+	if (!size)
+		size = 1;
+	ret = realloc(ptr, size);
 	if (!ret) {
-		ret = realloc(ptr, size);
-		if (!ret && !size)
-			ret = realloc(ptr, 1);
-		if (!ret)
-			die("Out of memory, realloc failed");
+		/*
+		 * If realloc() fails, the original block is left untouched;
+		 * it is not freed or moved.
+		 */
+		die("Out of memory, realloc failed");
 	}
 	return ret;
 }
-- 
2.30.2

