Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C47B489499
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242668AbiAJJA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242664AbiAJI7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:59:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD91C06173F;
        Mon, 10 Jan 2022 00:59:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82275611DE;
        Mon, 10 Jan 2022 08:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7DEC36AED;
        Mon, 10 Jan 2022 08:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641805194;
        bh=D9e71CZd9yBY1wgr0WN43xn6xQSym6Q0DjGYoPqsfCk=;
        h=From:To:Cc:Subject:Date:From;
        b=gQW0hvtIj+lNAbd8rSX06xXBAwDll8i1+b/MJpcHVyu6y8ZyyWdbtzEumaBIlj2gP
         IKYpOO9fQyZrybXsm9rvwk9pIwrzlJ1AsSy9r7C1H3uBYdb/1Msw4McJQHjpEw/rfS
         b2zIGttqlbOU9PpDedZDxlx3S2R5Wqb7PJXOHqiYFcivHj1q81W4Kdw3SvaM+YR5oc
         TSatpkHgNUKewdJ41Nc0qFUa9H71yPIYefoMoXRE1VVNyYw3apsYXrHHJuMyGhjHQz
         XBO+8/BA1Zr/is2kdvbND3UfmFJLrurH+ieJacT0KJxjq3IkvwBxXvCwja5p42opar
         2xmTaYQxXdjsA==
From:   SeongJae Park <sj@kernel.org>
To:     ojeda@kernel.org
Cc:     alex.gaynor@gmail.com, wedsonaf@google.com,
        akpm@linux-foundation.org, wei.liu@kernel.org,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 for-rust-for-linux] init/Kconfig: Specify the interpreter for rust-version.sh
Date:   Mon, 10 Jan 2022 08:59:52 +0000
Message-Id: <20220110085952.6137-1-sj@kernel.org>
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

It's not a big deal, but not so fun.  This commit works around the issue
by specifying the interpreter for 'rust-version.sh' in the Kconfig file.
The ugly work around wouldn't be needed once 'rust-version.sh' file is
merged in the mainline with the execution permission.

Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
---
Changes from v1
(https://lore.kernel.org/all/20220106123357.16220-1-sj@kernel.org/)
- Collect 'Reviewed-by:' from Wei Liu
- Specify that this is temporal workaround and when it can be reverted
  (Miguel Ojeda)

 init/Kconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index cd23faa163d1..d3707b9f222c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -67,7 +67,13 @@ config HAS_RUST
 config RUSTC_VERSION
 	depends on HAS_RUST
 	int
-	default $(shell,$(srctree)/scripts/rust-version.sh $(RUSTC))
+	# Because some common tools like 'diff' don't support permissions of
+	# the files, 'rust-version.sh' in some trees that managed with such
+	# tools result in having no execution permission.  As a temporal work
+	# around, we specify the interpreter ('/bin/sh').  It will be unneeded
+	# once 'rust-version.sh' is merged in the mainline with its execution
+	# permission.
+	default $(shell,/bin/sh $(srctree)/scripts/rust-version.sh $(RUSTC))
 
 config CC_CAN_LINK
 	bool
-- 
2.17.1

