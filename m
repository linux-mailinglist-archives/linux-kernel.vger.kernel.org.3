Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3CD5A95CA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiIALef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIALe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:34:29 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC17A11519C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:34:26 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1662032063; bh=64K6de8/WYbFY9mQuRbf7StfNJYaBkUUYkjBkby97iE=;
        h=From:To:Cc:Subject:Date;
        b=LJbzIZvXhb5XUcSgRAC6Eu5+ldNP5RqOgTHgRXWJbqEgRO08yUwNmOaJm92Y8GcnE
         X59dRQe1LOpgFJNtPQSlkSyYZbhk8PStP+BUrxFwMvgNetA6uWd53VFbZ3+XiAaQOX
         aLQ9Aomr4d0baGByf/w+uvTLODMhaU+t6whgiWYQ=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        alsa-devel@alsa-project.org,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] ASoC: apple: mca: Unselect COMMON_CLK in Kconfig
Date:   Thu,  1 Sep 2022 13:34:14 +0200
Message-Id: <20220901113415.27449-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MCA driver selects COMMON_CLK, which leads to misconfiguration
on platforms with HAVE_LEGACY_CLK (under compile test). Kconfig catches
the conflict with the following warning:

  WARNING: unmet direct dependencies detected for COMMON_CLK
  Depends on [n]: !HAVE_LEGACY_CLK [=y]
  Selected by [m]:
  - SND_SOC_APPLE_MCA [=m] && SOUND [=m] && !UML && SND [=m] &&
    SND_SOC [=m] && (ARCH_APPLE || COMPILE_TEST [=y])

Eventually the build fails with errors like:

>> drivers/clk/clk.c:867:6: error: redefinition of 'clk_unprepare'
     867 | void clk_unprepare(struct clk *clk)
         |      ^~~~~~~~~~~~~
   In file included from drivers/clk/clk.c:9:
   include/linux/clk.h:303:20: note: previous definition of 'clk_unprepare' with type 'void(struct clk *)'
     303 | static inline void clk_unprepare(struct clk *clk)
         |                    ^~~~~~~~~~~~~

which appears to be because COMMON_CLK is selected but HAVE_CLK_PREPARE
is not. In the end it seems we had no business selecting COMMON_CLK from
an unrelated driver like that, so remove the selection. The linux/clk.h
API is there anyway.

Fixes: 3df5d0d97289 ("ASoC: apple: mca: Start new platform driver")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/apple/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/apple/Kconfig b/sound/soc/apple/Kconfig
index 0ba955657e98..793f7782e0d7 100644
--- a/sound/soc/apple/Kconfig
+++ b/sound/soc/apple/Kconfig
@@ -2,7 +2,6 @@ config SND_SOC_APPLE_MCA
 	tristate "Apple Silicon MCA driver"
 	depends on ARCH_APPLE || COMPILE_TEST
 	select SND_DMAENGINE_PCM
-	select COMMON_CLK
 	default ARCH_APPLE
 	help
 	  This option enables an ASoC platform driver for MCA peripherals found
-- 
2.33.0

