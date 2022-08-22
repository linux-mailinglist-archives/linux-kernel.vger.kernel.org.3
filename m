Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A621F59C65A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbiHVSb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237705AbiHVSbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:31:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05C8167E8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:31:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8077F612D8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 18:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378F9C433D6;
        Mon, 22 Aug 2022 18:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661193068;
        bh=xXLp8vcpSHFXcg8Thw4aqS7oAXd1A4ff7T8kKAEapI8=;
        h=From:To:Cc:Subject:Date:From;
        b=BJqqyAHDoivLbBiMTx6xaDsVTE0XnbDmqovaLOU1mOvJ22j85rhVQgGVWxN7+bozo
         b9izsqjngBTe+tmQYon6HJMNUsEOZDAbKq9HdQuJrcyJM9XjFKFwEMHnx4ftqrT9fn
         hnTp7UCjOyu68bd1yjnrXAab0XBDOjohSaGNC9N0DbXP5wue/CK21Bw/hu/Eww5neC
         scniUIrRbM6wIdtvmTHIDNApbUBu1lMxpFYKzGOi+CseTrV46rjCcbrxsP49tG7mpm
         wUBm/GCHACYjoerh1kXVKVtv0pkmmWe2kWp9O/Zwipx4PdM404UcGvH27nhci/CCBz
         YJKw1xxP7Nd4Q==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matt Flax <flatmax@flatmax.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ASoC: codes: src4xxx: Avoid clang -Wsometimes-uninitialized in src4xxx_hw_params()
Date:   Mon, 22 Aug 2022 11:31:01 -0700
Message-Id: <20220822183101.1115095-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

  sound/soc/codecs/src4xxx.c:280:3: error: variable 'd' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
                  default:
                  ^~~~~~~
  sound/soc/codecs/src4xxx.c:298:59: note: uninitialized use occurs here
                  ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_11, d);
                                                                          ^
  sound/soc/codecs/src4xxx.c:223:20: note: initialize the variable 'd' to silence this warning
          int val, pj, jd, d;
                            ^
                            = 0
  sound/soc/codecs/src4xxx.c:280:3: error: variable 'jd' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
                  default:
                  ^~~~~~~
  sound/soc/codecs/src4xxx.c:293:59: note: uninitialized use occurs here
                  ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_10, jd);
                                                                          ^~
  sound/soc/codecs/src4xxx.c:223:17: note: initialize the variable 'jd' to silence this warning
          int val, pj, jd, d;
                        ^
                          = 0
  sound/soc/codecs/src4xxx.c:280:3: error: variable 'pj' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
                  default:
                  ^~~~~~~
  sound/soc/codecs/src4xxx.c:288:59: note: uninitialized use occurs here
                  ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_0F, pj);
                                                                          ^~
  sound/soc/codecs/src4xxx.c:223:13: note: initialize the variable 'pj' to silence this warning
          int val, pj, jd, d;
                    ^
                      = 0
  3 errors generated.

According to the comment in the default case, other parts of the chip
are still functional without these values so just return 0 in the
default case to avoid using these variables uninitialized.

Link: https://github.com/ClangBuiltLinux/linux/issues/1691
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 sound/soc/codecs/src4xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/src4xxx.c b/sound/soc/codecs/src4xxx.c
index a8f143057b41..cf45caa4bf7f 100644
--- a/sound/soc/codecs/src4xxx.c
+++ b/sound/soc/codecs/src4xxx.c
@@ -283,7 +283,7 @@ static int src4xxx_hw_params(struct snd_pcm_substream *substream,
 			 */
 			dev_info(component->dev,
 				"Couldn't set the RCV PLL as this master clock rate is unknown\n");
-			break;
+			return 0;
 		}
 		ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_0F, pj);
 		if (ret < 0)

base-commit: 94f072748337424c9cf92cd018532a34db3a5516
-- 
2.37.2

