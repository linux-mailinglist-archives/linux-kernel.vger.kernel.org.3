Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E9F48FDD5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 17:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiAPQWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 11:22:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59252 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiAPQWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 11:22:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43170B80D41
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 16:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A21AC36AE7;
        Sun, 16 Jan 2022 16:22:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RGudShtz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642350156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yCXIPqFuRt10dmmNfBcepK4GgRG4RHzZtZM/cUblrww=;
        b=RGudShtzV93iwOqyevGkJFzC94DfuvoyhOIl6Ffi8dH5F3egegyAUGfEQ+510Nl0Lyubgf
        FavgBAOtb3I0dZdm//vMV7xnVxU0/X0H9iOEqlZrfD5DyeA1NzXsKxevj0EwDbO6SLbWA+
        o9NlY5h1wvsnwNSFJChRkhyPKZ5HKiI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 84e4627b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 16 Jan 2022 16:22:35 +0000 (UTC)
Date:   Sun, 16 Jan 2022 17:22:32 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 4/7] random: remove unused reserved argument
Message-ID: <YeRGSPTpJlSTJdgO@zx2c4.com>
References: <20220113154413.29513-1-Jason@zx2c4.com>
 <20220113154413.29513-5-Jason@zx2c4.com>
 <YeQcpzxKWLuJ9Kcz@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YeQcpzxKWLuJ9Kcz@owl.dominikbrodowski.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2022 at 2:45 PM Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> > @@ -1342,7 +1341,7 @@ static size_t account(struct entropy_store *r, size_t nbytes, int min,
> >       /* never pull more than available */
> >       have_bytes = entropy_count >> (ENTROPY_SHIFT + 3);
> > 
> > -     if ((have_bytes -= reserved) < 0)
> > +     if (have_bytes < 0)
> >               have_bytes = 0;
> >       ibytes = min_t(size_t, ibytes, have_bytes);
>
> Hmm. We already WARN_ON(entropy_count < 0) a few lines below. Maybe move
> that assertion before the assignement of have_bytes? Then, have_bytes can
> never be lower than zero, and the code becomes even simpler. What do you
> think?

Can you send a separate patch for this that we can apply on top? It
seems reasonable anyhow. Something like:

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 327086b35797..419156d2146d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1329,7 +1329,7 @@ EXPORT_SYMBOL_GPL(add_disk_randomness);
  */
 static size_t account(struct entropy_store *r, size_t nbytes, int min)
 {
-	int entropy_count, orig, have_bytes;
+	int entropy_count, orig;
 	size_t ibytes, nfrac;

 	BUG_ON(r->entropy_count > POOL_FRACBITS);
@@ -1337,21 +1337,17 @@ static size_t account(struct entropy_store *r, size_t nbytes, int min)
 	/* Can we pull enough? */
 retry:
 	entropy_count = orig = READ_ONCE(r->entropy_count);
-	ibytes = nbytes;
-	/* never pull more than available */
-	have_bytes = entropy_count >> (ENTROPY_SHIFT + 3);
-
-	if (have_bytes < 0)
-		have_bytes = 0;
-	ibytes = min_t(size_t, ibytes, have_bytes);
-	if (ibytes < min)
-		ibytes = 0;
-
 	if (WARN_ON(entropy_count < 0)) {
 		pr_warn("negative entropy count: pool %s count %d\n",
 			r->name, entropy_count);
 		entropy_count = 0;
 	}
+
+	/* never pull more than available */
+	ibytes = min_t(size_t, nbytes, entropy_count >> (ENTROPY_SHIFT + 3));
+	if (ibytes < min)
+		ibytes = 0;
+
 	nfrac = ibytes << (ENTROPY_SHIFT + 3);
 	if ((size_t) entropy_count > nfrac)
 		entropy_count -= nfrac;


