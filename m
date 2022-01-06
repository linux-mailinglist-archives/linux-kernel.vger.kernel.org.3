Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBB1486468
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 13:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbiAFMeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 07:34:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59330 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238831AbiAFMeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 07:34:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 562A0B820FE;
        Thu,  6 Jan 2022 12:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E0EC36AE3;
        Thu,  6 Jan 2022 12:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641472449;
        bh=H3/oyDBBgWPKLO8CaUCJpearAqZDBAp1Vt3uxT0jstA=;
        h=From:To:Cc:Subject:Date:From;
        b=WpOhmVExFRd9TtS76TLmyEeCT3clh/SAM6IMNIjPcbxI8h2MqHrBQQNHvKcB5Vr3w
         AoA+qaCOoDSeGN3YO0rc4kNEgmvP05OEmr1LHaxjMzc07oiTU4ysV8LZ33eALV/DF2
         RnEOxOx4wm7fULhd+Jfj6SxrIjmtX+ZMEa1RIpUlEFjyjf0HdjoUdJH5rFMWrLDhWj
         XeY5fH4HNhgw2M574lWisouMFBJHn1IANjunRTPI9Zzrq4AZesFNYRWp2lL9ZcDB0K
         dYkoWAgLa2a45o6uViqHD83RlE7A5rz2/LGLMtMsVECxkHF3059CSP+3x298CZnX2c
         PhkG+YH9TgwjQ==
From:   SeongJae Park <sj@kernel.org>
To:     ojeda@kernel.org
Cc:     alex.gaynor@gmail.com, wedsonaf@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH] init/Kconfig: Specify the interpreter for rust-version.sh
Date:   Thu,  6 Jan 2022 12:33:57 +0000
Message-Id: <20220106123357.16220-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some common tools like 'diff' don't support permissions of the files.
Due to that, 'rust-version.sh' in some trees including '-mm' result in
having no execution permission, and therefore build fails like below:

    $ make O=../linux.out/ olddefconfig
    make[1]: Entering directory 'linux.out'
      GEN     Makefile
    sh: 1: linux/scripts/rust-version.sh: Permission denied
    init/Kconfig:71: syntax error
    init/Kconfig:70: invalid statement
    linux/scripts/kconfig/Makefile:77: recipe for target 'olddefconfig' failed
    make[2]: *** [olddefconfig] Error 1
    linux/Makefile:666: recipe for target 'olddefconfig' failed
    make[1]: *** [olddefconfig] Error 2
    make[1]: Leaving directory 'linux.out'
    Makefile:226: recipe for target '__sub-make' failed
    make: *** [__sub-make] Error 2

It's not a big deal, but not so fun.  This commit fixes the issue by
specifying the interpreter for 'rust-version.sh' in the Kconfig file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index cd23faa163d1..97ab35692d46 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -67,7 +67,7 @@ config HAS_RUST
 config RUSTC_VERSION
 	depends on HAS_RUST
 	int
-	default $(shell,$(srctree)/scripts/rust-version.sh $(RUSTC))
+	default $(shell,/bin/sh $(srctree)/scripts/rust-version.sh $(RUSTC))
 
 config CC_CAN_LINK
 	bool
-- 
2.17.1

