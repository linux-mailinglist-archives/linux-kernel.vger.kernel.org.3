Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3A450ACCA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 02:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442940AbiDVAah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 20:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiDVAaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 20:30:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EB32182B;
        Thu, 21 Apr 2022 17:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 248A5B82288;
        Fri, 22 Apr 2022 00:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3318C385A7;
        Fri, 22 Apr 2022 00:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650587261;
        bh=9vtUUihjLkwi14kEWFNZCORgfoe8pGab3THZePAWYw4=;
        h=From:To:Cc:Subject:Date:From;
        b=eTkvm7uAi6Xy/PXcaKXv5r4DYK8U7pxzEIINHkiPD4nDP88ceGLcfog242FW9LnUu
         vG6kj/nOcbD4xsycy5g0q1ZDUsZtJ7PHg5sgl9JvK28kEF6gDJHZyZozvZaTYI9k3+
         VEtIM8zVgvwo61QsDgf8TTVA+2VWllc2JjFXa/q7xKC00jKRS3ExcH2nNMpGn99gUG
         I5x4eAPEdeFwfO5X7l3a3GscJ2iMGVCowy4jpDqbtgkXKgH0ZggNrLR/K7vjnq/GGC
         eafq1XSqmuxGWmoyuRTussDi+O8q4ez3TFHlJLgdxyDRHB0evtcYeup9bx0Q+Nen0f
         1gZ/9Zw+du0Cw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A . Donenfeld " <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v2] siphash: update the hsiphash documentation
Date:   Thu, 21 Apr 2022 17:27:31 -0700
Message-Id: <20220422002731.63801-1-ebiggers@kernel.org>
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

Fix the documentation for the hsiphash functions to avoid conflating the
HalfSipHash algorithm with the hsiphash functions, since these functions
actually implement either HalfSipHash or SipHash, and random.c now uses
HalfSipHash (in a very special way) without the hsiphash functions.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v2: focus the documentation further on the hsiphash functions, so that
    it doesn't need to describe other uses of the HalfSipHash algorithm.

 Documentation/security/siphash.rst | 39 ++++++++++++++++++------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/Documentation/security/siphash.rst b/Documentation/security/siphash.rst
index bd9363025fcbc..d66f0b624131d 100644
--- a/Documentation/security/siphash.rst
+++ b/Documentation/security/siphash.rst
@@ -121,26 +121,33 @@ even scarier, uses an easily brute-forcable 64-bit key (with a 32-bit output)
 instead of SipHash's 128-bit key. However, this may appeal to some
 high-performance `jhash` users.
 
-Danger!
+HalfSipHash support is provided through the "hsiphash" family of functions.
 
-Do not ever use HalfSipHash except for as a hashtable key function, and only
-then when you can be absolutely certain that the outputs will never be
-transmitted out of the kernel. This is only remotely useful over `jhash` as a
-means of mitigating hashtable flooding denial of service attacks.
+**Danger!** Do not ever use the hsiphash functions except for as a hashtable key
+function, and only then when you can be absolutely certain that the outputs will
+never be transmitted out of the kernel. This is only remotely useful over
+`jhash` as a means of mitigating hashtable flooding denial of service attacks.
 
-Generating a HalfSipHash key
-============================
+On 64-bit kernels, the hsiphash functions actually implement SipHash-1-3, a
+reduced-round variant of SipHash, instead of HalfSipHash-1-3. This is because in
+64-bit code, SipHash-1-3 is no slower than HalfSipHash-1-3, and can be faster.
+Note, this does *not* mean that in 64-bit kernels the hsiphash functions are the
+same as the siphash ones, or that they are secure; the hsiphash functions still
+use an insecure reduced-round algorithm and truncate their outputs to 32 bits.
+
+Generating a hsiphash key
+=========================
 
 Keys should always be generated from a cryptographically secure source of
-random numbers, either using get_random_bytes or get_random_once:
+random numbers, either using get_random_bytes or get_random_once::
 
-hsiphash_key_t key;
-get_random_bytes(&key, sizeof(key));
+	hsiphash_key_t key;
+	get_random_bytes(&key, sizeof(key));
 
 If you're not deriving your key from here, you're doing it wrong.
 
-Using the HalfSipHash functions
-===============================
+Using the hsiphash functions
+============================
 
 There are two variants of the function, one that takes a list of integers, and
 one that takes a buffer::
@@ -183,7 +190,7 @@ You may then iterate like usual over the returned hash bucket.
 Performance
 ===========
 
-HalfSipHash is roughly 3 times slower than JenkinsHash. For many replacements,
-this will not be a problem, as the hashtable lookup isn't the bottleneck. And
-in general, this is probably a good sacrifice to make for the security and DoS
-resistance of HalfSipHash.
+hsiphash() is roughly 3 times slower than jhash(). For many replacements, this
+will not be a problem, as the hashtable lookup isn't the bottleneck. And in
+general, this is probably a good sacrifice to make for the security and DoS
+resistance of hsiphash().
-- 
2.35.2

