Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8694F8F26
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiDHGea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiDHGe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:34:26 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129272F3D0B;
        Thu,  7 Apr 2022 23:32:21 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 11A44FF809;
        Fri,  8 Apr 2022 06:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649399540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jFdqjPdj+EvQat/TUNxFw2X8022yUvS5IZjp3j3BFUg=;
        b=HZtCP6Wv6ySD0icGoZTFTcn9erdtWYbltosDs4PvpCpMxgvVbqxZOwGFCPXs4mP+geopHC
        66AjK7hhyS1PIKCZp/d9CLLG6qvXnzHpWvG/W1xns6Osq3u/ZiQNfre7ORWJVDqAZD2Uzy
        UUHHGAtbF/kvSL3lOHzfxyfKcyfBpema+mbmt09dFRGPRoHbGgTMpVifC5sHvUmHz6XRdy
        AID1g+5ccBsNVpM1YKUBuraZYKkMTQwGdRuB4XBDelrdRtMJtmiddDu/t+Qtx9dTcW+vfJ
        we59+GvY1I4OGG4lSHaWC6lQVhXZa9wOPNovYUVcOnciymWg04dGqDNlPHXLtA==
Date:   Fri, 8 Apr 2022 08:32:14 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pratyush Yadav <p.yadav@ti.com>, Yu Kuai <yukuai3@huawei.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list),
        linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM)
Subject: Re: [PATCH v4 1/5] mtd: nand: make mtk_ecc.c a separated module
Message-ID: <20220408083214.1473e88a@xps13>
In-Reply-To: <20220407150652.21885-2-gch981213@gmail.com>
References: <20220407150652.21885-1-gch981213@gmail.com>
        <20220407150652.21885-2-gch981213@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuanhong,

gch981213@gmail.com wrote on Thu,  7 Apr 2022 23:06:48 +0800:

> this code will be used in mediatek snfi spi-mem controller with
> pipelined ECC engine.
>=20
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
>=20
> Change since v1:
>   actually make it a module instead of a part of nandcore.o
>     (ECC_MXIC probablly needs a similar fix.)

Please do not hesitate to propose something about it.

Otherwise on the MTD side the series looks good (besides the two
comments you already received).

I don't know if something changed regarding the comments style in the
spi subsystem, but using // everywhere looks strange, it's usually
reserved for the SPDX tag, but I'll let Mark comment on it.

Otherwise, MTD patches 1 and 3 look fine.

Thanks,
Miqu=C3=A8l
