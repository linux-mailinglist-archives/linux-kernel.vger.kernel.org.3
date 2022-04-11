Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BFE4FB473
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245242AbiDKHUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbiDKHUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:20:10 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6DE21260;
        Mon, 11 Apr 2022 00:17:56 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EA8DA1BF209;
        Mon, 11 Apr 2022 07:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649661475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D9HxmNH+wJTJwEE9weq82YmxGUP8sTv4/gZsbkYd/po=;
        b=eUK4j613W9p5rbtFtbqoBW6fzrINyPazW0/xq15eOENxAZ4v3OJTIAr9VdbwjG2g1U8Vfw
        WkzEuOPFR/+96ne8arHo7UNOsm7ki1S0qPNSTbme1/8q2KfrPCCs3Q1nPs9AfY5kWZpcZE
        AAovSUS5TJR93Nem25GRQs3t8luz9hHNOvJDASk4ga/6z4QFMILWxUqQKzds30J7SH/PGx
        4q5wWE4MhaYCQGCJ6XtDZGaVxO5ataCd4Lcq94+80Gr5Rq9UsBGU/uAiZNDsPPwf4cqGd5
        ioUrOAZq6oQRqrmZQi2Qves+YU7YlrnA491bo7cU1sJd32fDlSkU7StW1wQbSw==
Date:   Mon, 11 Apr 2022 09:17:49 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
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
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NAND FLASH SUBSYSTEM" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v4 1/5] mtd: nand: make mtk_ecc.c a separated module
Message-ID: <20220411091749.63e0aad9@xps13>
In-Reply-To: <CAJsYDV+SkL0yCroidGz4yzKbdj5Yx37a0DW9RLftKsceSFGnnw@mail.gmail.com>
References: <20220407150652.21885-1-gch981213@gmail.com>
        <20220407150652.21885-2-gch981213@gmail.com>
        <20220408083214.1473e88a@xps13>
        <YlAqSQ5w3y39aOy+@sirena.org.uk>
        <CAJsYDV+SkL0yCroidGz4yzKbdj5Yx37a0DW9RLftKsceSFGnnw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

gch981213@gmail.com wrote on Sat, 9 Apr 2022 19:08:57 +0800:

> Hi Mark!
>=20
> On Fri, Apr 8, 2022 at 8:28 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Fri, Apr 08, 2022 at 08:32:14AM +0200, Miquel Raynal wrote:
> > =20
> > > Otherwise on the MTD side the series looks good (besides the two
> > > comments you already received). =20
> >
> > What's the plan for merging then? =20
>=20
> I just tested this driver on a different chip and found out it's buggy
> there. I'm still debugging.
> Please wait for v5 of this series. Sorry.

We need to merge this series in an immutable branch. Perhaps as the big
"part" is the SPI controller driver, it should preferably go through
spi, but I'm fine either ways, let me know what you prefer.

Thanks,
Miqu=C3=A8l
