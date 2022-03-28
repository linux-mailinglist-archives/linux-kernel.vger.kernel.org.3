Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308AD4E9D68
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244584AbiC1RYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbiC1RYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:24:19 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF3864BD1;
        Mon, 28 Mar 2022 10:22:37 -0700 (PDT)
Received: from grover.. (133-32-185-133.west.xps.vectant.ne.jp [133.32.185.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 22SHLdGZ017332;
        Tue, 29 Mar 2022 02:21:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 22SHLdGZ017332
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648488100;
        bh=UH1VDPx6gdMj3puEVBexYhQw2eBB8T7IsyNihS4F0YM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ov2CdN5oQp5TdxkGzLQIabmizxCidhSCe2jkecUC2Jq9B3bLXl3Amuypl11knvFxH
         zVvOPyiEb2bcuTrKFa0xKgHp5J4TL2xG4JF2p9dpnvwnO/r2Mvx+bISGokVSkRx3tL
         3IOSC8xdtSKS1GdN3z+hoV88w0tZZDT511BP51yCVZCcYuPlm6VoWr0tHdynR+qsc3
         zGAsqzfk8OQvxw/FSRqLy84uc/Bq/Xk26kOn/GCKJzP94mvRRMmpiVsOgINjJ9UEMp
         8qkmwB9JJF/qasA9MuXNQErhk5LtIEBvTSRQgOUEvejeZi92XLgC4HWpg0J8+6W+M6
         62MnpZKhFg3/Q==
X-Nifty-SrcIP: [133.32.185.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 2/2] kbuild: forbid exported headers from including <stdint.h>, <stdbool.h>
Date:   Tue, 29 Mar 2022 02:21:30 +0900
Message-Id: <20220328172130.197319-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220328172130.197319-1-masahiroy@kernel.org>
References: <20220328172130.197319-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some UAPI headers included <stdlib.h>, like this:

  #ifndef __KERNEL__
  #include <stdlib.h>
  #endif

As it turned out, they just included it for no good reason.

After some fixes, now I can compile-test UAPI headers
(CONFIG_UAPI_HEADER_TEST=y) without <stdlib.h> included.

To avoid somebody getting it back again, this commit adds the dummy
header, usr/dummy-include/stdlib.h

I added $(srctree)/usr/dummy-include to the header search paths.
Because it is searched before the system directories, if someone
tries to include <stdlib.h>, they will see the error message.

While I am here, I also replaced $(objtree)/usr/include with $(obj), but
it is just a small refactoring.

If we achieve the situation where none of system headers is included
from exported kernel headers (i.e. kernel headers become self-contained),
we might be able to add -nostdinc, but that is much far from where we
stand now. (see many no-header-test lines in usr/include/Makefile)

As a realistic solution, you can forbid header inclusion individually by
putting a dummy header into usr/dummy-include/.

Currently, no header include <stdbool.h>. I put it as well before somebody
attempts to use it.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 usr/dummy-include/stdbool.h | 7 +++++++
 usr/dummy-include/stdlib.h  | 7 +++++++
 usr/include/Makefile        | 2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 usr/dummy-include/stdbool.h
 create mode 100644 usr/dummy-include/stdlib.h

diff --git a/usr/dummy-include/stdbool.h b/usr/dummy-include/stdbool.h
new file mode 100644
index 000000000000..54ff9e9c90ac
--- /dev/null
+++ b/usr/dummy-include/stdbool.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _STDBOOL_H
+#define _STDBOOL_H
+
+#error "Please do not include <stdbool.h> from exported headers"
+
+#endif /* _STDBOOL_H */
diff --git a/usr/dummy-include/stdlib.h b/usr/dummy-include/stdlib.h
new file mode 100644
index 000000000000..e8c21888e371
--- /dev/null
+++ b/usr/dummy-include/stdlib.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _STDLIB_H
+#define _STDLIB_H
+
+#error "Please do not include <stdlib.h> from exported headers"
+
+#endif /* _STDLIB_H */
diff --git a/usr/include/Makefile b/usr/include/Makefile
index fa9819e022b7..7740777b49f8 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -15,7 +15,7 @@ UAPI_CFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CFLAGS))
 # USERCFLAGS might contain sysroot location for CC.
 UAPI_CFLAGS += $(USERCFLAGS)
 
-override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/usr/include
+override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I $(obj) -I $(srctree)/usr/dummy-include
 
 # The following are excluded for now because they fail to build.
 #
-- 
2.32.0

