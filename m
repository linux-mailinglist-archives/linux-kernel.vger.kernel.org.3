Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEB65803BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbiGYSFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiGYSFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:05:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF2138BB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 11:05:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86332613B3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 18:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F75C341C6;
        Mon, 25 Jul 2022 18:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658772350;
        bh=chxglXlJohwTOIfvgsfFMrSIax1zhLv/KC55sAhxMXA=;
        h=From:To:Cc:Subject:Date:From;
        b=C5s6FQ8C4iYZRCP0LMl3jvHfIIeZZdY2pkWd+OrxG+FaP8flwjQ6v01AL2HamQ8rT
         t6eye+BEUVoIbZCCaTPAGUZSJDDc9tKWSUMlnK2vxyxAbzqdAQz0Xa5f7GmFY0IdsT
         6uiulK9Py6cUUUFG0ZduHDM0xmEGx/ZyoOmTxMRYAuJ8+qXZRE5otcszlrHM1Ey9z9
         5neezKFGhtfB/MAeALo8AGr9ruPmso12KjkRUGKJ0SggzLM5DhfbXCrI/K4Ha7Zzvz
         NHcosVXzRptcaXpGr8HwRtvfR3atwG8n64G0H4/Q+NdJlPwdDBml83Lqj1WyD7x9dm
         tHVGk0dInTsfA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] ASoC: amd: acp: Fix initialization of ext_intr_stat1 in i2s_irq_handler()
Date:   Mon, 25 Jul 2022 11:05:39 -0700
Message-Id: <20220725180539.1315066-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.1
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

Clang warns:

  ../sound/soc/amd/acp/acp-platform.c:117:19: error: variable 'ext_intr_stat1' is uninitialized when used here [-Werror,-Wuninitialized]
                          if (stream && (ext_intr_stat1 & stream->irq_bit)) {
                                         ^~~~~~~~~~~~~~
  ../sound/soc/amd/acp/acp-platform.c:97:35: note: initialize the variable 'ext_intr_stat1' to silence this warning
          u32 ext_intr_stat, ext_intr_stat1, i;
                                           ^
                                            = 0
  1 error generated.

The variable was not properly renamed, correct it to resolve the
warning.

Fixes: 93f53881473c ("ASoC: amd: acp: Modify local variables name to generic")
Link: https://github.com/ClangBuiltLinux/linux/issues/1675
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 sound/soc/amd/acp/acp-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index 10730d33c3b0..f561d39b33e2 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -100,7 +100,7 @@ static irqreturn_t i2s_irq_handler(int irq, void *data)
 		return IRQ_NONE;
 
 	if (adata->rsrc->no_of_ctrls == 2)
-		ext_intr_stat = readl(ACP_EXTERNAL_INTR_STAT(adata, (rsrc->irqp_used - 1)));
+		ext_intr_stat1 = readl(ACP_EXTERNAL_INTR_STAT(adata, (rsrc->irqp_used - 1)));
 
 	ext_intr_stat = readl(ACP_EXTERNAL_INTR_STAT(adata, rsrc->irqp_used));
 

base-commit: be0aa8d4b0fcb4532bf7973141e911998ab39508
-- 
2.37.1

