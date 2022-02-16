Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FA44B9223
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiBPUPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:15:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiBPUPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:15:05 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3966D235865
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:14:52 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x11so2831762pll.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqE2BW0tKVRqM9ZhCDPXCovwSbjof6cI+9q/oGqooSk=;
        b=NR7TiaIkVeb6mYv4qWdPa8tE15JoCJw13yejHxDLUfmlF0RP3HlJZPJp7inuchCg3k
         bLOz3ieHHziV0osXGKcv6SubQC2ZeptScXKgpr+t4GS9WZQjM/OHtElPdNEb4YVPKp3C
         BgrrSZdkcsm8IgTQG6Cl2WHciGSaYcw2pV+NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqE2BW0tKVRqM9ZhCDPXCovwSbjof6cI+9q/oGqooSk=;
        b=ssX9heMZwi5r9j3pwWnuOVIyHYdyHXruTHeL10mCu7QwffcGuRJMMfXglHA2PrYe0j
         4uLfbGNep9189iZ83hrFLLaToJ1+/5scC670mW6X4SuW4oRGE4j8z5MDFDuumSVVrocY
         8rerUMYykqFrLKsnXw1/3v0DEV15qCkG2tYe5C+0mD/GmK5FQGGtmFoes1YZ2ng15seq
         U/4JIokIXxbLtHJMshuWMqPZP3C2hhMSMKZ+3+JO1LcfT6SpID83clFBq/Nh5A3yxKtN
         +9X4B4oElIURA5MzP2NQh1hLTUH/d+tmIj5so+UGJ+Shue4GiCpBkesJPcvskKvk5whp
         j3gg==
X-Gm-Message-State: AOAM530eUtg5wGqJFtgR9YavONKLXKNzZIMLqfO8+4SKvgIg2M37Uj7H
        IwgcrD+x7QrKppuREEhO20xnxg==
X-Google-Smtp-Source: ABdhPJwIU2Fu/iRv2C0QJmBs5y1p/RE21NXtauVHjHeLf70sjR3+jCzd9e3ecNuE5/iHmiiSBEDwiQ==
X-Received: by 2002:a17:90b:4004:b0:1b8:b2eb:4b83 with SMTP id ie4-20020a17090b400400b001b8b2eb4b83mr3691254pjb.149.1645042491710;
        Wed, 16 Feb 2022 12:14:51 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t1sm5964516pgj.43.2022.02.16.12.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:14:51 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] usercopy: Check valid lifetime via stack depth
Date:   Wed, 16 Feb 2022 12:14:49 -0800
Message-Id: <20220216201449.2087956-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2777; h=from:subject; bh=jr1yKp0UMwd5gvvB/ePD/2FkWdtbd+ZCUu7BnVQyulA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiDVs4Hh87CYY9W3rMbKqyfd7+UszuGa3FFWxH8s9m q2FNCVaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYg1bOAAKCRCJcvTf3G3AJttLD/ wNKTVOmCoYdtqtUSIlcd62hL/1Pq8cEu2EynIeBUQSn25cWzaTcMQu47PDzckY8hcz2F6ZCQSrlf2s EGpOHPUFK6E+Yk7LHpnLGg7P/NS3DzdGE7uixLZmooHCROncIbDIsvWDDpX5rKKNACSRKVf9Rx/1PI pnLyZUzDNVtwQK9XDphmrat0BKjWb3OTB7vbbtDz8bkVZnN1IS+eMSbEraPpeRY6Vl0jwktEK5jTRm q29MZlM2AB9X/EuFrzaoR6jXQ7CDtPg7klR/gSM/eQht6pH7UY6HsUqofFfbYziHjFCMzYnxMRZHf6 Cx0cXvZbjrOnzsyoVBdhM1003MSKtlEuUVT8p31J88qXf5d9uvRK/Sj9gFvBWiyxtcpV8Lwf4pOsb1 sBFN0hJ6kaIZoYi+LNf3K2QLBfXymjowRa5WKzhKzzQQxlBdTr5Gt+0UWcyyvjAK4J9IB3BEuo8sbT RAzGeMq122044mgIkhYN7M7rvd5stZnzgA0BOMpFQjvJsdSso5ovUlW46vqQYpWAxEEPhsFNKaICo8 hRnGOa70iGY7KvgyEt/0ePSl2MlN8s2gfyv5dDPGwbjmN/05WKk3zYB2hFPEjZ0uVY19Rv8G13AaMs xHMo/2VEcpc4rQd9KR0qW3usVDOF84bmQwX5tD/twu+aFsKbBov8rVBuORNg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under CONFIG_HARDENED_USERCOPY=y, when exact stack frame boundary checking
is not available (i.e. everything except x86 with FRAME_POINTER), check
a stack object as being at least "current depth valid", in the sense
that any object within the stack region but not between start-of-stack
and current_stack_pointer should be considered unavailable (i.e. its
lifetime is from a call no longer present on the stack).

Additionally report usercopy bounds checking failures with an offset
from current_stack_pointer, which may assist with diagnosing failures.

The LKDTM USERCOPY_STACK_FRAME_TO and USERCOPY_STACK_FRAME_FROM tests
(once slightly adjusted in a separate patch) will pass again with
this fixed.

Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/usercopy.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index d0d268135d96..3846c1634dca 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -29,13 +29,20 @@
  * Returns:
  *	NOT_STACK: not at all on the stack
  *	GOOD_FRAME: fully within a valid stack frame
- *	GOOD_STACK: fully on the stack (when can't do frame-checking)
+ *	GOOD_STACK: within the current stack (when can't frame-check exactly)
  *	BAD_STACK: error condition (invalid stack position or bad stack frame)
  */
 static noinline int check_stack_object(const void *obj, unsigned long len)
 {
 	const void * const stack = task_stack_page(current);
 	const void * const stackend = stack + THREAD_SIZE;
+#ifndef CONFIG_STACK_GROWSUP
+	const void * const high = stackend;
+	const void * const low = (void *)current_stack_pointer;
+#else
+	const void * const high = (void *)current_stack_pointer;
+	const void * const low = stack;
+#endif
 	int ret;
 
 	/* Object is not on the stack at all. */
@@ -55,6 +62,12 @@ static noinline int check_stack_object(const void *obj, unsigned long len)
 	if (ret)
 		return ret;
 
+	/*
+	 * Reject: object not within current stack depth.
+	 */
+	if (obj < low || high < obj + len)
+		return BAD_STACK;
+
 	return GOOD_STACK;
 }
 
@@ -280,7 +293,13 @@ void __check_object_size(const void *ptr, unsigned long n, bool to_user)
 		 */
 		return;
 	default:
-		usercopy_abort("process stack", NULL, to_user, 0, n);
+		usercopy_abort("process stack", NULL, to_user,
+#ifndef CONFIG_STACK_GROWSUP
+				(void *)current_stack_pointer - ptr,
+#else
+				ptr - (void *)current_stack_pointer,
+#endif
+				n);
 	}
 
 	/* Check for bad heap object. */
-- 
2.30.2

