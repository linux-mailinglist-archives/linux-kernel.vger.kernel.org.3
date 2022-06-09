Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C97544C60
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343553AbiFIMos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343783AbiFIMoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:44:23 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F5152B0C;
        Thu,  9 Jun 2022 05:44:21 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 85FE840008;
        Thu,  9 Jun 2022 12:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654778660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=punjJeFPlmRDX9hAGHT1aIOyQoqMIzoy0YlqW9TJhb4=;
        b=GUIeGMCJ/TpP5lolE/xpASVDI30ycU3EKxyOyBXRY8SxkfGoHAOmoPxM/4WlL5LfUvnGoz
        pPbC/daIZfrRJECTdHXkfTJq5kGE+APPmEq00Hsx0Wundptu5og1SAU/L5LxV0qtVrcNHL
        1fKYEvEfbtOWlUSufANRJKzt83xCHTdjB/RtyH1NcHA+/5mMZwaMAoLXfEVpqi8Ag0PHwV
        GNg76ZZkBi6b1GwZ3cMEWY7Vnq7rY/ichOxSKAecQu6FVAzvZlNFZL6k5YHSKL1mX8o2g5
        OtmH0I58JTaJBfz+sILr7KG6laP1kUsR5GfMXu5BT3yk9O/ikGqMD9FOtsS81g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] mtd: rawnand: meson: Fix a potential double free issue
Date:   Thu,  9 Jun 2022 14:44:18 +0200
Message-Id: <20220609124418.209251-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To:  <ec15c358b8063f7c50ff4cd628cf0d2e14e43f49.1653064877.git.christophe.jaillet@wanadoo.fr>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ec0da06337751b18f6dee06b6526e0f0d6e80369'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-20 at 16:41:40 UTC, Christophe JAILLET wrote:
> When meson_nfc_nand_chip_cleanup() is called, it will call:
> 	meson_nfc_free_buffer(&meson_chip->nand);
> 	nand_cleanup(&meson_chip->nand);
> 
> nand_cleanup() in turn will call nand_detach() which calls the
> .detach_chip() which is here meson_nand_detach_chip().
> 
> meson_nand_detach_chip() already calls meson_nfc_free_buffer(), so we
> could double free some memory.
> 
> Fix it by removing the unneeded explicit call to meson_nfc_free_buffer().
> 
> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Acked-by: Liang Yang <liang.yang@amlogic.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
