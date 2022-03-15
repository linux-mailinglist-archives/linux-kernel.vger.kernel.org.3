Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3764D9124
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244827AbiCOAUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiCOAUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:20:21 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921B53B3F8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:19:10 -0700 (PDT)
Received: from localhost.localdomain (unknown [138.197.159.143])
        by gnuweeb.org (Postfix) with ESMTPSA id 986F17E2F9;
        Tue, 15 Mar 2022 00:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647303549;
        bh=YmnblpNsix8T9TQK/9fc5lZTlTPeY19ZiZ1wc0hMFC4=;
        h=From:To:Cc:Subject:Date:From;
        b=Meu929TlhtA0QIVd7+KjNVuM68lkip//sZfWas0NJnHvz/NK+x1dIQ/yOyM+oCHtD
         GDhJn+ur/9YvaZe0R3Pupr2GDEZ/WIJPHg4266ZdvvewI33Cc8OwgfM1/ngyFdjAWx
         hayrKccZl9T3Igs/YsViHngRVruEgzMz+DIGPaiK7wzJazop9hrUyM10YK3fSuby/l
         2s5ABXgFU8MYwNwCjCiCUB7DXZphbHA4RkQHc+na5z1wACUc51UBaQHTR80hbdE1m3
         hZEJE/yKpDTypBQTXFzv+q8U0Rt6tysvJb5qWm5NkGrzz4vfYPYzVqSpft1cQKxUMM
         GsOP08tJhPCSQ==
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gmail.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nugraha <richiisei@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH for-5.18 v2] ASoC: atmel: mchp-pdmc: Fix `-Wpointer-bool-conversion` warning
Date:   Tue, 15 Mar 2022 00:18:48 +0000
Message-Id: <20220315001848.3763534-1-alviro.iskandar@gnuweeb.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function mchp_pdmc_af_put(), Intel's kernel test robot reports the
following warning:

  sound/soc/atmel/mchp-pdmc.c:186:34: warning: address of array \
  'uvalue->value.integer.value' will always evaluate to 'true' \
  [-Wpointer-bool-conversion]

This is because we are using `uvalue->value.integer.value` which its
type is `long value[128];` for conditional expression and that array
will always decay to a non-NULL pointer. Using a non-NULL pointer for
conditional expression will always evaluate to true.

Fix this by changing it to `uvalue->value.integer.value[0]` as that's
what the mchp_pdmc_af_get() function sets.

Cc: Nugraha <richiisei@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202203091430.MLY27Bif-lkp@intel.com
Fixes: 50291652af52 ("ASoC: atmel: mchp-pdmc: add PDMC driver")
Link: https://lore.gnuweeb.org/gwml/20220309065849.96165-1-alviro.iskandar@gnuweeb.org # v1
Reviewed-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
---

  v1 -> v2:
    - Remove mailing list from the CC tags.
    - Append reviewed by tags from Nathan and Codrin.

 sound/soc/atmel/mchp-pdmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/mchp-pdmc.c b/sound/soc/atmel/mchp-pdmc.c
index c44636f6207d..7b87f75c284c 100644
--- a/sound/soc/atmel/mchp-pdmc.c
+++ b/sound/soc/atmel/mchp-pdmc.c
@@ -183,7 +183,7 @@ static int mchp_pdmc_af_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct mchp_pdmc *dd = snd_soc_component_get_drvdata(component);
-	bool af = uvalue->value.integer.value ? true : false;
+	bool af = uvalue->value.integer.value[0] ? true : false;
 
 	if (dd->audio_filter_en == af)
 		return 0;

base-commit: 50291652af5269813baa6024eb0e81b5f0bbb451
-- 
2.27.0

