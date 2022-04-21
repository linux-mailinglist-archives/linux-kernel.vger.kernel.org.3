Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED26750AA43
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392541AbiDUUrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349411AbiDUUrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:47:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A234E391;
        Thu, 21 Apr 2022 13:44:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 082E1B828D8;
        Thu, 21 Apr 2022 20:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A652DC385A7;
        Thu, 21 Apr 2022 20:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650573851;
        bh=8xH5wV1KvrkMTwGdQxQZPmkY2ffhRKacNykV31qXzQA=;
        h=From:To:Cc:Subject:Date:From;
        b=ll979oUoHbSxXuVHKN9EkSPu3NI0XxkU+Xe2izKWxGiK6wBGtmrtZA8ncRq8kIuJ0
         u7gXJh+q/F88e4uAwPEiJKrDm1jy4tT8iH20ArGHJNFC4DYpRwYHEkUzYSXNWPKKgQ
         RRtZ74nI1LStL9ozF3v/tG77EEp2XEjGYgfV1SPU3dRmzzUbDGCGwTPl66RD7z8SJi
         k6+i1Er7adPa015OAr2wRzO/WTikDK6zO6zm6FLxbr/3qH5tUTF8UP9bjr2DfTZh/T
         n/WippRsMYbWH/HkzfV3XIgCbZWiTIGDfxIOpVOhmFX80VgFjNIMxteE26O9KK53/k
         wCI8RYjAP2YPg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A . Donenfeld " <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] siphash: update the HalfSipHash documentation
Date:   Thu, 21 Apr 2022 13:43:20 -0700
Message-Id: <20220421204320.258010-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Update the documentation for HalfSipHash to correctly explain that the
kernel actually implements either HalfSipHash-1-3 or SipHash-1-3, and
that HalfSipHash-1-3 is not entirely limited to hashtable functions,
with it now being used in the interrupt entropy accumulator.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/security/siphash.rst | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/Documentation/security/siphash.rst b/Documentation/security/siphash.rst
index bd9363025fcbc..9b079b2ac2a1a 100644
--- a/Documentation/security/siphash.rst
+++ b/Documentation/security/siphash.rst
@@ -121,15 +121,23 @@ even scarier, uses an easily brute-forcable 64-bit key (with a 32-bit output)
 instead of SipHash's 128-bit key. However, this may appeal to some
 high-performance `jhash` users.
 
-Danger!
+**Danger!** HalfSipHash should only be used in a very limited set of use cases
+where nothing better is possible, namely:
 
-Do not ever use HalfSipHash except for as a hashtable key function, and only
-then when you can be absolutely certain that the outputs will never be
-transmitted out of the kernel. This is only remotely useful over `jhash` as a
-means of mitigating hashtable flooding denial of service attacks.
+- Hashtable key functions, where the outputs will never be transmitted out of
+  the kernel. This is only remotely useful over `jhash` as a means of mitigating
+  hashtable flooding denial of service attacks.
 
-Generating a HalfSipHash key
-============================
+- The interrupt entropy accumulator in ``drivers/char/random.c``. This is a very
+  special case; do *not* use this as example code for anything else.
+
+Note, 64-bit kernels actually implement SipHash-1-3 instead of HalfSipHash-1-3;
+the "hsiphash" functions redirect to either algorithm. This is done for
+performance reasons; it does *not* mean that the hsiphash functions are
+cryptographically secure on 64-bit platforms.
+
+Generating a hsiphash key
+=========================
 
 Keys should always be generated from a cryptographically secure source of
 random numbers, either using get_random_bytes or get_random_once:
@@ -139,8 +147,8 @@ get_random_bytes(&key, sizeof(key));
 
 If you're not deriving your key from here, you're doing it wrong.
 
-Using the HalfSipHash functions
-===============================
+Using the hsiphash functions
+============================
 
 There are two variants of the function, one that takes a list of integers, and
 one that takes a buffer::
-- 
2.35.2

