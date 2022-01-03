Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8A6483478
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiACP7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbiACP7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:59:47 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727D4C061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 07:59:47 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso18797922wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 07:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jHxpQIVhhbZi0yOZgtN9wp+xDeMXXriIvx34cNOPKr0=;
        b=Itd3pvMPNVqsusLITfC3YWxqxW/OB3DbfwdZXnoVSoUstCCEb5jMnnwPfa/tE7yVSF
         JJ3DpTcdYjZGQnBkvxb43XEtmyjrCK2B8hEmBgJtv3xl24wE3zyajEkVyXP6oq3GujSo
         RxRkLXzVPlofvbdkIEoFjL3tq6qll5rAhKHjxs/QkSkvmugkQvI2x0c1620cSNXi5nHw
         /rS0s3chXmBEKJqfleknwNESsM/ovVnWsiDVQs3rsAaPaN5OqLlzVkBaVL9wcrBy/LGm
         3Az/Uwo1mWAA1L3HomMPwOORC3WDACcgaG2Th6/sG6pxtoq45erx83V/vMcUd8BBC0zr
         nQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jHxpQIVhhbZi0yOZgtN9wp+xDeMXXriIvx34cNOPKr0=;
        b=007h0x4e+2QnFlMWv9rc+gyFZbZtiMIYptK7bdq/eNUFCwuwklxzWxu8xvDiqjllwF
         vKZs3i0om4xjqlUDp+fiMG9CwvrgxI/G7StLA4lvc9Sp6npVkZNoHDxdG3TQ9RGBlR/3
         fKFIymtPbC5qpscXWsKW5r6GvC24jqfMBgJ6Zso0mz3jgdrHquTN3fT8Ch3a4GH4xjUP
         UXCseMRBa0EftSvToBquZ4iT32DaHLYQLnMTvxPqzZVBCzk63Y2MPT0KM+iay786r92M
         KvUvrXsmf3pyP1bZ6wFOBu4mS4G5CBYMOPGUmZy87z/Ge9R7WhAORp9qGbF3DksKzKUs
         tfuw==
X-Gm-Message-State: AOAM531ZoxUBaL9lOq4xjQvDItfOitFBQfoX2/DIgAX5WOjR4nhLNNpo
        MxmDNL6hc5Wn9io/JgEu2x0BuA==
X-Google-Smtp-Source: ABdhPJx7brG1T5QCTTrgkfNIsmSG4IeZM7iPlA3xEmC7uJuuRSe+RFZznimMqNE8yvE33PQod27O/A==
X-Received: by 2002:a05:600c:5009:: with SMTP id n9mr39398936wmr.162.1641225585849;
        Mon, 03 Jan 2022 07:59:45 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id n12sm28074899wmq.30.2022.01.03.07.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 07:59:45 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: [PATCH] random: Don't reset crng_init_cnt on urandom_read()
Date:   Mon,  3 Jan 2022 16:59:31 +0100
Message-Id: <20220103155931.411722-1-jannh@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, urandom_read() (used for /dev/urandom) resets crng_init_cnt
to zero when it is called at crng_init<2. This is inconsistent: We do it
for /dev/urandom reads, but not for the equivalent
getrandom(GRND_INSECURE).

(And worse, as Jason pointed out, we're only doing this as long as
maxwarn>0.)

crng_init_cnt is only read in crng_fast_load(); it is relevant at
crng_init=3D=3D0 for determining when to switch to crng_init=3D=3D1 (and wh=
ere in
the RNG state array to write).

As far as I understand:

 - crng_init=3D=3D0 means "we have nothing, we might just be returning the =
same
   exact numbers on every boot on every machine, we don't even have
   non-cryptographic randomness; we should shove every bit of entropy we
   can get into the RNG immediately"
 - crng_init=3D=3D1 means "well we have something, it might not be
   cryptographic, but at least we're not gonna return the same data every
   time or whatever, it's probably good enough for TCP and ASLR and stuff;
   we now have time to build up actual cryptographic entropy in the input
   pool"
 - crng_init=3D=3D2 means "this is supposed to be cryptographically secure =
now,
   but we'll keep adding more entropy just to be sure".

The current code means that if someone is pulling data from /dev/urandom
fast enough at crng_init=3D=3D0, we'll keep resetting crng_init_cnt, and we=
'll
never make forward progress to crng_init=3D=3D1. It seems to be intended to
prevent an attacker from bruteforcing the contents of small individual RNG
inputs on the way from crng_init=3D=3D0 to crng_init=3D=3D1, but that's mis=
guided;
crng_init=3D=3D1 isn't supposed to provide proper cryptographic security
anyway, RNG users who care about getting secure RNG output have to wait
until crng_init=3D=3D2.

This code was inconsistent, and it probably made things worse - just get
rid of it.

Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/char/random.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 605969ed0f96..3c3f5c62378c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1816,7 +1816,6 @@ urandom_read_nowarn(struct file *file, char __user *b=
uf, size_t nbytes,
 static ssize_t
 urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *p=
pos)
 {
-	unsigned long flags;
 	static int maxwarn =3D 10;
=20
 	if (!crng_ready() && maxwarn > 0) {
@@ -1824,9 +1823,6 @@ urandom_read(struct file *file, char __user *buf, siz=
e_t nbytes, loff_t *ppos)
 		if (__ratelimit(&urandom_warning))
 			pr_notice("%s: uninitialized urandom read (%zd bytes read)\n",
 				  current->comm, nbytes);
-		spin_lock_irqsave(&primary_crng.lock, flags);
-		crng_init_cnt =3D 0;
-		spin_unlock_irqrestore(&primary_crng.lock, flags);
 	}
=20
 	return urandom_read_nowarn(file, buf, nbytes, ppos);

base-commit: c9e6606c7fe92b50a02ce51dda82586ebdf99b48
--=20
2.34.1.448.ga2b2bfdf31-goog

