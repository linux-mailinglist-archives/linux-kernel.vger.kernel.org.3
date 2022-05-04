Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B44519C17
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbiEDJqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238227AbiEDJqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:46:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178AF275F4;
        Wed,  4 May 2022 02:42:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89262B8247D;
        Wed,  4 May 2022 09:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECB8C385A4;
        Wed,  4 May 2022 09:42:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pnyjJaBx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651657353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rW8jljRy3Yv58kuAXOgiGvBjEiUQtfJh49L05E5LnJg=;
        b=pnyjJaBxYB8uxpm85cAzg+UNyvNUKlJY68olIPhtFJxzIB6Az8cAmeZn05XBKXoj6KdN3D
        dJ0ZMZKvhABjnKudXmfoGJffPOJgxEyK/Pgc5HavqgBr96VCCH6zl/ibmtnbfSJJ66KYUv
        R0f/AYldMZwS+QxwVl7hgN9DknE4VmE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 63f3361b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 4 May 2022 09:42:32 +0000 (UTC)
Date:   Wed, 4 May 2022 11:42:27 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH v2] hex2bin: make the function hex_to_bin constant-time
Message-ID: <YnJI4Ru0AlUgrr9C@zx2c4.com>
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com>
 <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com>
 <YnI7hE4cIfjsdKSF@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnI7hE4cIfjsdKSF@antec>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 05:38:28PM +0900, Stafford Horne wrote:
> Just a heads up it seems this patch is causing some instability with crypto self
> tests on OpenRISC when using a PREEMPT kernel (no SMP).
> 
> This was reported by Jason A. Donenfeld as it came up in wireguard testing.
> 
> I am trying to figure out if this is an OpenRISC PREEMPT issue or something
> else.

The code of this commit looks fine. And actually the bug goes away if
you just add a `pr_err("hello!\n");` to the function. Plus, the function
is never called by that test kernel.

Actually, the bug even goes away if you change the sign of the input
back to naked char (which might be semantically better anyway) and then
let the function itself do the sign change (see below).

So more likely is that this patch just helps unmask a real issue
elsewhere -- linker, compiler, or register restoration after preemption.
I don't think there's anything to do with regards to the patch of this
thread, as it's clearly fine. Unless you want that sign thing below, but
even then, who cares. We should keep digging in on the OpenRISC front.

Jason

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index fe6efb24d151..a890428bcc1a 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -285,7 +285,7 @@ static inline char *hex_byte_pack_upper(char *buf, u8 byte)
 	return buf;
 }

-extern int hex_to_bin(unsigned char ch);
+extern int hex_to_bin(char ch);
 extern int __must_check hex2bin(u8 *dst, const char *src, size_t count);
 extern char *bin2hex(char *dst, const void *src, size_t count);

diff --git a/lib/hexdump.c b/lib/hexdump.c
index 06833d404398..b636b4dcabe9 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -43,9 +43,9 @@ EXPORT_SYMBOL(hex_asc_upper);
  *	uppercase and lowercase letters, so we use (ch & 0xdf), which converts
  *	lowercase to uppercase
  */
-int hex_to_bin(unsigned char ch)
+int hex_to_bin(char ch)
 {
-	unsigned char cu = ch & 0xdf;
+	unsigned char cu = ch & 0xdfU;
 	return -1 +
 		((ch - '0' +  1) & (unsigned)((ch - '9' - 1) & ('0' - 1 - ch)) >> 8) +
 		((cu - 'A' + 11) & (unsigned)((cu - 'F' - 1) & ('A' - 1 - cu)) >> 8);

