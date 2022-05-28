Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0F7536C7A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 13:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbiE1LJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 07:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiE1LJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 07:09:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AC9201A0;
        Sat, 28 May 2022 04:09:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D89A60DDD;
        Sat, 28 May 2022 11:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A38CC34100;
        Sat, 28 May 2022 11:09:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lPzlkdhB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653736182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=izQRZXBrrgVPYreeMxjNooSE8gWHxKL6jmIqcXOidA4=;
        b=lPzlkdhBDz88X3eko3eT2hJaidAdx2VFBc0jCwUTVdjT/YrAB927BU6yMKQQvKuGenMx7n
        jNymODsB08EPIIuYV6mlSdSkQFL9yxT/TcLMvid9M/sLTcCYECvJDbPuJm0KzdBlH0QI/H
        5w7ARQNXYoXzzjuW24z0rqye7YALAlk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1364098c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 28 May 2022 11:09:42 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] Revert "crypto: poly1305 - cleanup stray CRYPTO_LIB_POLY1305_RSIZE"
Date:   Sat, 28 May 2022 13:09:18 +0200
Message-Id: <20220528110918.256550-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9pS1ODLqJ8rw0hzH5+ZrUW8pwC2nkeD4mLVG4swp8BnQQ@mail.gmail.com>
References: <CAHmME9pS1ODLqJ8rw0hzH5+ZrUW8pwC2nkeD4mLVG4swp8BnQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 8bdc2a190105e862dfe7a4033f2fd385b7e58ae8.

It got merged a bit prematurely and shortly after the kernel test
robot and Sudip pointed out build failures.

We could attempt to fix this by listing the dependencies piecemeal, but
it's not as obvious as it looks: drivers like caam use this macro in
headers even if there's no .o compiled in that makes use of it. So
actually fixing this might require a bit more of a comprehensive
approach, rather than whack-a-mole with hunting down which drivers use
which headers which use this macro.

Therefore, this commit just reverts the change, and maybe the problem
can be visited on the next rainy day.

Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Fixes: 8bdc2a190105 ("crypto: poly1305 - cleanup stray CRYPTO_LIB_POLY1305_RSIZE")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 lib/crypto/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index a143ddf9279a..9856e291f414 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -85,7 +85,6 @@ config CRYPTO_LIB_POLY1305_RSIZE
 	default 11 if X86_64
 	default 9 if ARM || ARM64
 	default 1
-	depends on CRYPTO_LIB_POLY1305
 
 config CRYPTO_ARCH_HAVE_LIB_POLY1305
 	tristate
-- 
2.35.1

