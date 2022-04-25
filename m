Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EEF50DFAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiDYMLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiDYMK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:10:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33A4856C05
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650888475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x9icyG6jXOuh0gFgFjOSgaGXc5WizgRAriibQ5e+0eA=;
        b=D1y+WNriie7qvkBOgwmUgPEaYlQGgXjomGFuVaq040xP0a4GSrgl+6cSW1rx6QUoWHXqIh
        8MnhNTaAZgNMnldyBbq0hsd0hgB7csn8/L08NDPkeJQU2WXm8hppajUB5UTg+D2j9vim/9
        7QsC61zXLQs3mAvUKFuYPeNPM5tsKh4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-OJ3-yDKPOLauqwyTrBUagQ-1; Mon, 25 Apr 2022 08:07:50 -0400
X-MC-Unique: OJ3-yDKPOLauqwyTrBUagQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 806BF3811F33;
        Mon, 25 Apr 2022 12:07:49 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 71B5340316B;
        Mon, 25 Apr 2022 12:07:49 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 23PC7nql030551;
        Mon, 25 Apr 2022 08:07:49 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 23PC7mR5030546;
        Mon, 25 Apr 2022 08:07:49 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 25 Apr 2022 08:07:48 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Andy Shevchenko <andy@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: [PATCH v2] hex2bin: make the function hex_to_bin constant-time
In-Reply-To: <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Apr 2022, Linus Torvalds wrote:

> On Sun, Apr 24, 2022 at 1:54 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > + *
> > + * Explanation of the logic:
> > + * (ch - '9' - 1) is negative if ch <= '9'
> > + * ('0' - 1 - ch) is negative if ch >= '0'
> 
> True, but...
> 
> Please, just to make me happier, make the sign of 'ch' be something
> very explicit. Right now that code uses 'char ch', which could be
> signed or unsigned.

OK, I fixed it, here I'm sending the second version.

> Finally, for the same reason - please don't use ">> 8".  Because I do
> not believe that bit 8 is well-defined in your arithmetic. The *sign*

We are subtracting values that are in the 0 ... 255 range. So, the result 
will be in the -255 ... 255 range. So, the bits 8 to 31 of the result are 
equivalent.

> bit will be, but I'm not convinced bit 8 is.
> 
> So use ">> 31" or similar.

We can pick any number between 8 and 28. 31 won't work because the C 
standard doesn't specify that the right shift keeps the sign bit.

To make it standard-compliant, I added a cast that casts the int value to 
unsigned. We have an unsigned value with bits 8 to 31 equivalent. When we 
shift it 8 bits to the right, we have either 0 or 0xffffff - and this 
value is suitable for masking.

> Also, I do worry that this is *exactly* the kind of trick that a
> compiler could easily turn back into a conditional. Usually compilers
> tend to go the other way (ie turn conditionals into arithmetic if
> possible), but..

Some old version that I tried used "(ch - '0' + 1) * ((unsigned)(ch - '0') 
<= 9)" - it worked with gcc, but clang was too smart and turned it into a 
cmov when compiling for i686 and to a conditional branch when compiling 
for i586.

Another version used "-(c - '0' + 1) * (((unsigned)(c - '0') >= 10) - 1)" 
- it almost worked, except that clang still turned it into a conditional 
jump on sparc32 and powerpc32.

So, I came up with this version that avoids comparison operators at all 
and tested it with gcc and clang on all architectures that I could try.

Mikulas

>                     Linus
> 


From: Mikulas Patocka <mpatocka@redhat.com>

The function hex2bin is used to load cryptographic keys into device mapper
targets dm-crypt and dm-integrity. It should take constant time
independent on the processed data, so that concurrently running
unprivileged code can't infer any information about the keys via
microarchitectural convert channels.

This patch changes the function hex_to_bin so that it contains no branches
and no memory accesses.

Note that this shouldn't cause performance degradation because the size of
the new function is the same as the size of the old function (on x86-64) -
and the new function causes no branch misprediction penalties.

I compile-tested this function with gcc on aarch64 alpha arm hppa hppa64
i386 ia64 m68k mips32 mips64 powerpc powerpc64 riscv sh4 s390x sparc32
sparc64 x86_64 and with clang on aarch64 arm hexagon i386 mips32 mips64
powerpc powerpc64 s390x sparc32 sparc64 x86_64 to verify that there are no
branches in the generated code.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 include/linux/kernel.h |    2 +-
 lib/hexdump.c          |   32 +++++++++++++++++++++++++-------
 2 files changed, 26 insertions(+), 8 deletions(-)

Index: linux-2.6/lib/hexdump.c
===================================================================
--- linux-2.6.orig/lib/hexdump.c	2022-04-24 18:51:20.000000000 +0200
+++ linux-2.6/lib/hexdump.c	2022-04-25 13:15:26.000000000 +0200
@@ -22,15 +22,33 @@ EXPORT_SYMBOL(hex_asc_upper);
  *
  * hex_to_bin() converts one hex digit to its actual value or -1 in case of bad
  * input.
+ *
+ * This function is used to load cryptographic keys, so it is coded in such a
+ * way that there are no conditions or memory accesses that depend on data.
+ *
+ * Explanation of the logic:
+ * (ch - '9' - 1) is negative if ch <= '9'
+ * ('0' - 1 - ch) is negative if ch >= '0'
+ * we "and" these two values, so the result is negative if ch is in the range
+ *	'0' ... '9'
+ * we are only interested in the sign, so we do a shift ">> 8"; note that right
+ *	shift of a negative value is implementation-defined, so we cast the
+ *	value to (unsigned) before the shift --- we have 0xffffff if ch is in
+ *	the range '0' ... '9', 0 otherwise
+ * we "and" this value with (ch - '0' + 1) --- we have a value 1 ... 10 if ch is
+ *	in the range '0' ... '9', 0 otherwise
+ * we add this value to -1 --- we have a value 0 ... 9 if ch is in the range '0'
+ *	... '9', -1 otherwise
+ * the next line is similar to the previous one, but we need to decode both
+ *	uppercase and lowercase letters, so we use (ch & 0xdf), which converts
+ *	lowercase to uppercase
  */
-int hex_to_bin(char ch)
+int hex_to_bin(unsigned char ch)
 {
-	if ((ch >= '0') && (ch <= '9'))
-		return ch - '0';
-	ch = tolower(ch);
-	if ((ch >= 'a') && (ch <= 'f'))
-		return ch - 'a' + 10;
-	return -1;
+	unsigned char cu = ch & 0xdf;
+	return -1 +
+		((ch - '0' +  1) & (unsigned)((ch - '9' - 1) & ('0' - 1 - ch)) >> 8) +
+		((cu - 'A' + 11) & (unsigned)((cu - 'F' - 1) & ('A' - 1 - cu)) >> 8);
 }
 EXPORT_SYMBOL(hex_to_bin);
 
Index: linux-2.6/include/linux/kernel.h
===================================================================
--- linux-2.6.orig/include/linux/kernel.h	2022-04-21 17:31:39.000000000 +0200
+++ linux-2.6/include/linux/kernel.h	2022-04-25 07:33:43.000000000 +0200
@@ -285,7 +285,7 @@ static inline char *hex_byte_pack_upper(
 	return buf;
 }
 
-extern int hex_to_bin(char ch);
+extern int hex_to_bin(unsigned char ch);
 extern int __must_check hex2bin(u8 *dst, const char *src, size_t count);
 extern char *bin2hex(char *dst, const void *src, size_t count);
 

