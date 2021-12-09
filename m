Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF9646E75D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbhLILSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:18:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53758 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236469AbhLILSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:18:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 461EDB82453;
        Thu,  9 Dec 2021 11:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AA3C004DD;
        Thu,  9 Dec 2021 11:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639048514;
        bh=5aaehfQCI+dbM2sQSzjE+odxWb0lMx6FIQFJTzmnlYw=;
        h=From:To:Cc:Subject:Date:From;
        b=Tp+/EW+Pm7RLI/X0tILg5x3sBdCc9esnGazO1Yd1o8ZqHnXjSaUYW5bBbBvrm1Gtg
         os+13GHOUw8+Mjj1sDEuKZDbqZnrIW/S4NcnfSSFt5rNnaBwU8PbBkG8P+PrGpl8Em
         thi1KvhwaOmpgh6mFajyRWsbv8Q3b3lOgqZujXmmldjnzc7kP/ocOZLPMGmWVJPlKl
         udp03C41oiJnUpfJPVSe6ODLM1Xz4c3EUwWXerCOV8g7XOLVy1ZJVYGsRJPgTSTX+s
         yCbnTNPhM3W7i5WIihJaJdTE2OLcdUrnzFD3btiEUQRJoa2HrubX0tUuAw8PCb+7C6
         mEuOGPZH+DkgA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: renesas: cpg-mssr: fix R-Car S4-8 link failure
Date:   Thu,  9 Dec 2021 11:03:37 +0100
Message-Id: <20211209111506.217637-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Without CONFIG_CLK_RCAR_GEN4_CPG, this driver fails to link:

x86_64-linux-ld: drivers/clk/renesas/r8a779a0-cpg-mssr.o:(.init.rodata+0x70): undefined reference to `rcar_gen4_cpg_clk_register'

Fixes: 95d3d41f958f ("clk: renesas: cpg-mssr: Add support for R-Car S4-8")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/renesas/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 0927fa963ca6..b937041faab0 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -151,6 +151,7 @@ config CLK_R8A77995
 config CLK_R8A779A0
 	bool "R-Car V3U clock support" if COMPILE_TEST
 	select CLK_RCAR_CPG_LIB
+	select CLK_RCAR_GEN4_CPG
 	select CLK_RENESAS_CPG_MSSR
 
 config CLK_R8A779F0
-- 
2.29.2

