Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10E54F9236
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbiDHJuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbiDHJuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:50:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A3B15A1C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 02:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=H0zGZefTADwvigW1D0vpiANQqKSo6vKMHDxn2SEyLSg=; b=fGNnvJPAv1U69TpVTCYtFFoCky
        zO/o23MmVR9taBr5gWoSKPQajgplALlM6dDeWPWPbxMKOJZx1jaLN5bgkVXc5/CcDbjvxgH24vOBj
        o7qquDwARlIB3aLIkwObJuOvUj1YMgvh10+rFz8yzljMAWtBRjfnWk3RUjBmqsOJ3TsBwVC4mX3dX
        UBUW0YWH33AyxAB11O84U0Wc+rNq+qiDT/CMk8UHFORPn2sS3FYEonMyRsHI8X6sRIlTxNY+1BqLI
        0+d36SYrOFMGjlvlvAVVA26xO91pO7CZi6WQZLxYbSr3cuXYtkOtOpapp8Yw1XHKVww1UvVZ4rU3q
        YumSvhCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nclDW-002rgS-6U; Fri, 08 Apr 2022 09:47:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0C48D30076D;
        Fri,  8 Apr 2022 11:47:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B16252B38B6C3; Fri,  8 Apr 2022 11:47:43 +0200 (CEST)
Message-ID: <20220408094718.262932488@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Apr 2022 11:45:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        rick.p.edgecombe@intel.com, jpoimboe@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/4] lib/strn*,objtool: Enforce user_access_begin() rules
References: <20220408094552.432447640@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently GCC can fail to inline a 'static inline' single caller
function:

  lib/strnlen_user.o: warning: objtool: strnlen_user()+0x33: call to do_strnlen_user() with UACCESS enabled
  lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x33: call to do_strncpy_from_user() with UACCESS enabled

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/strncpy_from_user.c |    2 +-
 lib/strnlen_user.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -25,7 +25,7 @@
  * hit it), 'max' is the address space maximum (and we return
  * -EFAULT if we hit it).
  */
-static inline long do_strncpy_from_user(char *dst, const char __user *src,
+static __always_inline long do_strncpy_from_user(char *dst, const char __user *src,
 					unsigned long count, unsigned long max)
 {
 	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -20,7 +20,7 @@
  * if it fits in a aligned 'long'. The caller needs to check
  * the return value against "> max".
  */
-static inline long do_strnlen_user(const char __user *src, unsigned long count, unsigned long max)
+static __always_inline long do_strnlen_user(const char __user *src, unsigned long count, unsigned long max)
 {
 	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
 	unsigned long align, res = 0;


