Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5627C598961
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345120AbiHRQyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345117AbiHRQyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:54:02 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5D682768
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 09:53:57 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1660841633; bh=UNExzyKi9/UuVlXmQ0/fkVUBcJ7BQOxDg9rg7qwczx8=;
        h=From:To:Cc:Subject:Date;
        b=pQ1pBQ1RoVCQQBsbxtiv2jZAzlNx/1fuy5Xzfi3uG/ZsePDUPS2bYmKHul2wvpBmr
         Y1mRlXgQglfBYg7DlbBCFzMhQfEasklu0JmM9yVDyBg0y1qdrSOw1WYQvwea7xMcqC
         J0bT/6eTC4EsMmNaTFDt4rQdX7EUMTRfBbfbfNVY=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH] ASoC: Change handling of unimplemented set_bclk_ratio
Date:   Thu, 18 Aug 2022 18:53:36 +0200
Message-Id: <20220818165336.76403-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a 'set_bclk_ratio' call is attempted on a DAI not implementing the
method, make it an -ENOSUPP error instead of -EINVAL. Assume the DAI can
still be okay with the ratio, just does not care to register a handler.

No current in-tree users of snd_soc_dai_set_bclk_ratio seem to inspect
the return value, but -ENOSUPP disables an error print from within the
common soc_dai_ret return filter. With the new behavior a machine
driver can do a blanket 'set_bclk_ratio' on all DAIs on a bus, some of
which may care about the ratio, some of which may not.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/soc-dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index d530e8c2b77b..49752af0e205 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -124,7 +124,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_pll);
  */
 int snd_soc_dai_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
 {
-	int ret = -EINVAL;
+	int ret = -ENOTSUPP;
 
 	if (dai->driver->ops &&
 	    dai->driver->ops->set_bclk_ratio)
-- 
2.33.0

