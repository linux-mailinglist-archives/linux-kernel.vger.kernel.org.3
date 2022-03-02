Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C6B4CA16D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbiCBJ5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiCBJ5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:57:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20197E58D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 01:56:39 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 50A2B21121;
        Wed,  2 Mar 2022 09:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646214998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AsBBJp+vpeojcN6nK12nMkVYJtAIRctCNR7mUwGffGU=;
        b=jn8kfNZOwRxK667m3IpT1XdbOyixz/CozEsfm9DoPCJq/hAfv3kLcquT/0UJkIQKSH6dBq
        ZcQ3ia5vZQF7D7mbJxtKE6xvLjySKiQJ/6QSkq/iMmA4oA7YU1+6NJBlI5XHPcHs/EN5E5
        3hEqfJ//XJinHfWS3qHN2s0oncTJTV0=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 93EA8A3B93;
        Wed,  2 Mar 2022 09:56:37 +0000 (UTC)
Date:   Wed, 2 Mar 2022 10:56:37 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vaneet Narang <v.narang@samsung.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [hnaz-mm:master 272/379] lib/vsprintf.c:991:13: warning:
 variable 'modbuildid' set but not used
Message-ID: <Yh8/Vbu05MEQylMx@alley>
References: <202203012040.uFWGm3My-lkp@intel.com>
 <20220301102448.ff9bf910213d705842a2dd45@linux-foundation.org>
 <Yh5yhoW+y9qcn1RM@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yh5yhoW+y9qcn1RM@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-03-01 19:22:46, Matthew Wilcox wrote:
> On Tue, Mar 01, 2022 at 10:24:48AM -0800, Andrew Morton wrote:
> > >    lib/vsprintf.c: In function 'va_format':
> > >    lib/vsprintf.c:1759:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
> > >     1759 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
> > >          |         ^~~
> > 
> > I wonder what this means.
> 
> It means the compiler thinks we might want to add:
> 
> __attribute__((format(gnu_printf, x, y))) to the function declaration so it
> can type-check the arguments.
> 
> 'format (ARCHETYPE, STRING-INDEX, FIRST-TO-CHECK)'
>      The 'format' attribute specifies that a function takes 'printf',
>      'scanf', 'strftime' or 'strfmon' style arguments that should be
>      type-checked against a format string.  For example, the
>      declaration:
> 
>           extern int
>           my_printf (void *my_object, const char *my_format, ...)
>                 __attribute__ ((format (printf, 2, 3)));
> 
>      causes the compiler to check the arguments in calls to 'my_printf'
>      for consistency with the 'printf' style format string argument
>      'my_format'.
> 
> 
> I haven't looked into this at all and have no idea if we should.

There is the macro __printf(x, y). This particular warning can be
fixed by:

--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1672,6 +1672,7 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 	return buf;
 }
 
+__printf(5, 0)
 static char *va_format(char *buf, char *end, struct va_format *va_fmt,
 		       struct printf_spec spec, const char *fmt)
 {


But it seems to be can of worms. I get more warnings after fixing this
one. The following patch calmed down the warnings in vsprintf.o. But
it triggered another warning elsewhere, for example:

kernel/trace/bpf_trace.c: In function ‘____bpf_trace_printk’:
kernel/trace/bpf_trace.c:383:2: warning: function ‘____bpf_trace_printk’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
  ret = bstr_printf(buf, sizeof(buf), fmt, bin_args);
  ^~~
kernel/trace/bpf_trace.c: In function ‘____bpf_trace_vprintk’:
kernel/trace/bpf_trace.c:439:2: warning: function ‘____bpf_trace_vprintk’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
  ret = bstr_printf(buf, sizeof(buf), fmt, bin_args);
  ^~~


From 66f6166e968d8c7e752260e7ee7e1c0414cd2cce Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Wed, 2 Mar 2022 10:03:14 +0100
Subject: [PATCH] vsprintf: Fix warnings about missing gnu_printf attribute in vsprintf.o
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following warning is produced by: make W=1 lib/vsprintf.o

lib/vsprintf.c:1770:1: error: multiple storage classes in declaration specifiers
 static char *va_format(char *buf, char *end, struct va_format *va_fmt,
 ^~~~~~
lib/vsprintf.c:1770:14: warning: no previous prototype for ‘va_format’ [-Wmissing-prototypes]
 static char *va_format(char *buf, char *end, struct va_format *va_fmt,
              ^~~~~~~~~

More similar warnings are printed after fixing the 1st one:

lib/vsprintf.c: In function ‘pointer’:
lib/vsprintf.c:2522:3: warning: function ‘pointer’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
   return va_format(buf, end, ptr, spec, fmt);
   ^~~~~~
lib/vsprintf.c: In function ‘vbin_printf’:
lib/vsprintf.c:3213:12: warning: function ‘vbin_printf’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
            spec);
            ^~~~
lib/vsprintf.c: In function ‘bstr_printf’:
lib/vsprintf.c:3398:5: warning: function ‘bstr_printf’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
     str = pointer(fmt, str, end, get_arg(void *), spec);
     ^~~

Add the proposed annotation.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/string.h | 3 +++
 lib/vsprintf.c         | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index b6572aeca2f5..e37eaecb7906 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -196,8 +196,11 @@ int __sysfs_match_string(const char * const *array, size_t n, const char *s);
 #define sysfs_match_string(_a, _s) __sysfs_match_string(_a, ARRAY_SIZE(_a), _s)
 
 #ifdef CONFIG_BINARY_PRINTF
+__printf(3, 0)
 int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args);
+__printf(3, 0)
 int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf);
+__printf(3, 4)
 int bprintf(u32 *bin_buf, size_t size, const char *fmt, ...) __printf(3, 4);
 #endif
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3b8129dd374c..981c71da5e3d 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1672,6 +1672,7 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 	return buf;
 }
 
+__printf(5, 0)
 static char *va_format(char *buf, char *end, struct va_format *va_fmt,
 		       struct printf_spec spec, const char *fmt)
 {
@@ -2498,6 +2499,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
  * @precision: precision of a number
  * @qualifier: qualifier of a number (long, size_t, ...)
  */
+__printf(1, 0)
 static noinline_for_stack
 int format_decode(const char *fmt, struct printf_spec *spec)
 {
-- 
2.26.2

