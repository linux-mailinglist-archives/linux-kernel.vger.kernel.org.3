Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F7A4F111E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbiDDIpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiDDIpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:45:09 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A043AA55
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:43:13 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E743FE0006;
        Mon,  4 Apr 2022 08:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649061791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M0NzH/HJyQRA7JlgyykSLC9DM46fl6l8PCLhNaZ3vcc=;
        b=jZF818wUKjfz+K5hrYSg9ySnJtZQ8Xb/TfxgsB5Ttp0WLRiuRbcYGsHsItXtbJo6GsKF17
        Jkv8p14dEwBqiDWt68Er5GrsTqWB7TC5VFyeCXnLB/b3WMkN4aaJqFOslm79BPhVpLStfO
        2slDUf1LV+puUm0QLb7p49oXL3RfxGeskvZ2zjV/TnCd06HdVngpflTbJzU7e51SnPLqGM
        oRukwRc3FPTzH9B9xkYt2u9ftnxCTocwVzp/6rY4m0hH0AyDgzfImGyd9oRuk9s5/UkTMb
        /r4LVFZ/Lh5USgOUMXFHkhOfo68ebzBCdf5W0FP01SHJ5gVUJUURACAhseJ62A==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chuanhong Guo <gch981213@gmail.com>, linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Yu Kuai <yukuai3@huawei.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        RogerCC Lin <rogercc.lin@mediatek.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] mtd: rawnand: fix ecc parameters for mt7622
Date:   Mon,  4 Apr 2022 10:43:06 +0200
Message-Id: <20220404084306.1055176-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220402160315.919094-1-gch981213@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'9fe4e0d3cbfe90152137963cc024ecb63db6e8e6'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-04-02 at 16:03:13 UTC, Chuanhong Guo wrote:
> According to the datasheet, mt7622 only has 5 ECC capabilities instead
> of 7, and the decoding error register is arranged  as follows:
> +------+---------+---------+---------+---------+
> | Bits |  19:15  |  14:10  |   9:5   |   4:0   |
> +------+---------+---------+---------+---------+
> | Name | ERRNUM3 | ERRNUM2 | ERRNUM1 | ERRNUM0 |
> +------+---------+---------+---------+---------+
> This means err_mask should be 0x1f instead of 0x3f and the number of
> bits shifted in mtk_ecc_get_stats should be 5 instead of 8.
> 
> This commit introduces err_shift for the difference in this register
> and fix other existing parameters.
> 
> Public MT7622 reference manual can be found on [0] and the info this
> commit is based on is from page 656 and page 660.
> 
> [0]: https://wiki.banana-pi.org/Banana_Pi_BPI-R64#Documents
> 
> Fixes: 98dea8d71931 ("mtd: nand: mtk: Support MT7622 NAND flash controller.")
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
