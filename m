Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666A7470681
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbhLJRBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:01:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58642 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhLJRBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:01:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1DE1B82885;
        Fri, 10 Dec 2021 16:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03CEC00446;
        Fri, 10 Dec 2021 16:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639155445;
        bh=jET+YLDQ2r1VmsaDyAomjk4pSNQ9+dFdxLKsYrjuJcU=;
        h=From:To:Cc:Subject:Date:From;
        b=UmhIYrIMDeDK7n1lLWFTjsNiyMfC0BgwO4+Oe1AD7IiL8Nd/8YdaaAUdKes9hfmAX
         LtqRQBKnniX7w9m3KbUcxgOlxMF6cx01+0uKbCTS/RTUQviDyWHF30XWJ9uDSbtkGh
         Y41Whl+tzeDeGfC9HgMTsh0am4kj/b97aemcI0+p8A3l99+GJsGLaQ42JNBPgYUDco
         /BDrGrWdJFXg1tA7w23/ysFLNeXb4KIma4vYfmlbRvI0oRYz960LJeo5YCk8TVAaju
         FjncMM0+oMhqY1eeruK7XKiKF7AGewpcTkY15Av5lZM2cxphfWnfyAH5e/Mxi/ZySw
         QQuH23PHwd+Yg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2] soc/tegra: fuse: Fix bitwise vs. logical OR warning
Date:   Fri, 10 Dec 2021 09:55:29 -0700
Message-Id: <20211210165528.3232292-1-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new warning in clang points out two instances where boolean
expressions are being used with a bitwise OR instead of logical OR:

drivers/soc/tegra/fuse/speedo-tegra20.c:72:9: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
                reg = tegra_fuse_read_spare(i) |
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
                                               ||
drivers/soc/tegra/fuse/speedo-tegra20.c:72:9: note: cast one or both operands to int to silence this warning
drivers/soc/tegra/fuse/speedo-tegra20.c:87:9: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
                reg = tegra_fuse_read_spare(i) |
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
                                               ||
drivers/soc/tegra/fuse/speedo-tegra20.c:87:9: note: cast one or both operands to int to silence this warning
2 warnings generated.

The motivation for the warning is that logical operations short circuit
while bitwise operations do not.

In this instance, tegra_fuse_read_spare() is not semantically returning
a boolean, it is returning a bit value. Use u32 for its return type so
that it can be used with either bitwise or boolean operators without any
warnings.

Fixes: 25cd5a391478 ("ARM: tegra: Add speedo-based process identification")
Link: https://github.com/ClangBuiltLinux/linux/issues/1488
Suggested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

v1 -> v2: https://lore.kernel.org/r/20211021214500.2388146-1-nathan@kernel.org/

* Change return type of tegra_fuse_read_spare(), instead of changing
  bitwise OR to logical OR in tegra20_init_speedo_data() (Michał).

It would be nice to get this fixed sooner rather than later, as ARCH=arm
allmodconfig is broken due to -Werror.

 drivers/soc/tegra/fuse/fuse-tegra.c | 2 +-
 drivers/soc/tegra/fuse/fuse.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index f2151815db58..e714ed3b61bc 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -320,7 +320,7 @@ static struct platform_driver tegra_fuse_driver = {
 };
 builtin_platform_driver(tegra_fuse_driver);
 
-bool __init tegra_fuse_read_spare(unsigned int spare)
+u32 __init tegra_fuse_read_spare(unsigned int spare)
 {
 	unsigned int offset = fuse->soc->info->spare + spare * 4;
 
diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.h
index de58feba0435..ecff0c08e959 100644
--- a/drivers/soc/tegra/fuse/fuse.h
+++ b/drivers/soc/tegra/fuse/fuse.h
@@ -65,7 +65,7 @@ struct tegra_fuse {
 void tegra_init_revision(void);
 void tegra_init_apbmisc(void);
 
-bool __init tegra_fuse_read_spare(unsigned int spare);
+u32 __init tegra_fuse_read_spare(unsigned int spare);
 u32 __init tegra_fuse_read_early(unsigned int offset);
 
 u8 tegra_get_major_rev(void);

base-commit: 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1
-- 
2.34.1

