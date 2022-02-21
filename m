Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB634BED41
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 23:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbiBUWcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 17:32:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbiBUWcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 17:32:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DAA26CC;
        Mon, 21 Feb 2022 14:32:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3CE94CE12AF;
        Mon, 21 Feb 2022 22:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B8BC340E9;
        Mon, 21 Feb 2022 22:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645482739;
        bh=oNd55KzMQeaSAd6DDSrw5QGVIEvLaDaOWF9kCKeKBfk=;
        h=From:To:Cc:Subject:Date:From;
        b=Kxbv5uLE79vPeHEeQnCY35iiRvSP+ObqzIC34W8mSBerCaUuYJo8wznyOZC9aQ8F/
         yc9t82oeg1FromwlQUdmz1a1nIS0ls9kq4ikShVk78fQ0brgP7z2Wo1EA74zdwLkb/
         FeNsQ+clzyW+TGSYY3Kj4k+SOZ6P3WvfiLriEuvYJfhT4da1RgWxP9r+AYhDyz1Xxm
         c/NFTQLLOzzFdaK0Ht/SPwUexS3noTc3O1BrXOt+I6OMkqREGHXk/K75Oz1EZ64ku7
         HBZwlA+CeXaQEyQ8+MX+Fq2nsnsi+UuZKAiUgKfyvnOQgM/vzNBCMFwW/Bez8qROMq
         dhfRVlXmBhWjg==
From:   broonie@kernel.org
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: linux-next: manual merge of the pinctrl tree with the irqchip tree
Date:   Mon, 21 Feb 2022 22:32:16 +0000
Message-Id: <20220221223216.3616980-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
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

Hi all,

Today's linux-next merge of the pinctrl tree got a conflict in:

  drivers/pinctrl/pinctrl-starfive.c

between commit:

  0d872ed9e2148 ("pinctrl: starfive: Move PM device over to irq domain")

from the irqchip tree and commit:

  64fd52a4d3ce6 ("pinctrl: starfive: Use a static name for the GPIO irq_chip")

from the pinctrl tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/pinctrl/pinctrl-starfive.c
index 5be9866c2b3c0,0e4ff4c709f87..0000000000000
--- a/drivers/pinctrl/pinctrl-starfive.c
+++ b/drivers/pinctrl/pinctrl-starfive.c
@@@ -1307,8 -1308,8 +1308,6 @@@ static int starfive_probe(struct platfo
  	sfp->gc.base = -1;
  	sfp->gc.ngpio = NR_GPIOS;
  
- 	starfive_irq_chip.name = sfp->gc.label;
 -	starfive_irq_chip.parent_device = dev;
--
  	sfp->gc.irq.chip = &starfive_irq_chip;
  	sfp->gc.irq.parent_handler = starfive_gpio_irq_handler;
  	sfp->gc.irq.num_parents = 1;
