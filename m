Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EAC48ADDC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 13:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239861AbiAKMuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 07:50:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35736 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239820AbiAKMuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 07:50:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70638B81A8F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0388C36AF2;
        Tue, 11 Jan 2022 12:50:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UBAbYeA9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641905404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=erS4Z6OHpa1Qwgxxt0kXQo12tYB13k/8yMqTkzv/xOo=;
        b=UBAbYeA9dy6d+8aXC1o/2Roz3bB8PFvxGd6n9IPc5v22UmnsSwxgUdkIPwVdc685s5o8lR
        Q+e2MzMvNt4m3SF+PtXiONwSdqyG8HTkPk00e+0/55S5HgK4DsML3eq5a32gciIJCfk3Il
        BKkKa3DYG6KFmdhKK3Jx82U6kr6vnII=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 43480a02 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 11 Jan 2022 12:50:04 +0000 (UTC)
Date:   Tue, 11 Jan 2022 13:50:02 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: Re: [PATCH v2 2/2] random: use BLAKE2s instead of SHA1 in extraction
Message-ID: <Yd18+iQ8zicsSPa0@zx2c4.com>
References: <20211223141113.1240679-1-Jason@zx2c4.com>
 <20211223141113.1240679-2-Jason@zx2c4.com>
 <CAMuHMdU0spv9X_wErkBBWQ9kV9f1zE_YNcu5nPbTG_64Lh_h0w@mail.gmail.com>
 <CAHmME9pZu-UvCK=uP-sxXL127BmbjmrD2=M7cNd9vHdJEsverw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9pZu-UvCK=uP-sxXL127BmbjmrD2=M7cNd9vHdJEsverw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 1:28 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> If you're really quite concerned about m68k code size, I can probably
> do some things to reduce that. For example, blake2s256_hmac is only
> used by wireguard and it could probably be made local there. And with
> some trivial loop re-rolling, I can shave off another 2300 bytes. And
> I bet I can find a few other things too. The question is: how
> important is this to you?

And with another trick (see below), another extra 1000 bytes or so
shaved off. Aside from moving blake2s256_hmac, I'm not really super
enthusiastic about making these changes, but depending on how important
this is to you, maybe we can make something work. There are probably
additional possibilities too with the code.

====

diff --git a/lib/crypto/blake2s-generic.c b/lib/crypto/blake2s-generic.c
index 75ccb3e633e6..8e3c6372363a 100644
--- a/lib/crypto/blake2s-generic.c
+++ b/lib/crypto/blake2s-generic.c
@@ -46,7 +46,7 @@ void blake2s_compress_generic(struct blake2s_state *state, const u8 *block,
 {
 	u32 m[16];
 	u32 v[16];
-	int i;
+	int i, j;
 
 	WARN_ON(IS_ENABLED(DEBUG) &&
 		(nblocks > 1 && inc != BLAKE2S_BLOCK_SIZE));
@@ -76,29 +76,11 @@ void blake2s_compress_generic(struct blake2s_state *state, const u8 *block,
 	b = ror32(b ^ c, 7); \
 } while (0)
 
-#define ROUND(r) do { \
-	G(r, 0, v[0], v[ 4], v[ 8], v[12]); \
-	G(r, 1, v[1], v[ 5], v[ 9], v[13]); \
-	G(r, 2, v[2], v[ 6], v[10], v[14]); \
-	G(r, 3, v[3], v[ 7], v[11], v[15]); \
-	G(r, 4, v[0], v[ 5], v[10], v[15]); \
-	G(r, 5, v[1], v[ 6], v[11], v[12]); \
-	G(r, 6, v[2], v[ 7], v[ 8], v[13]); \
-	G(r, 7, v[3], v[ 4], v[ 9], v[14]); \
-} while (0)
-		ROUND(0);
-		ROUND(1);
-		ROUND(2);
-		ROUND(3);
-		ROUND(4);
-		ROUND(5);
-		ROUND(6);
-		ROUND(7);
-		ROUND(8);
-		ROUND(9);
-
+		for (i = 0; i < 10; ++i) {
+			for (j = 0; j < 8; ++j)
+				G(i, j, v[j % 4], v[((j + (j / 4)) % 4) + 4], v[((j + 2 * (j / 4)) % 4) + 8], v[((j + 3 * (j / 4)) % 4) + 12]);
+		}
 #undef G
-#undef ROUND
 
 		for (i = 0; i < 8; ++i)
 			state->h[i] ^= v[i] ^ v[i + 8];

