Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7BF5A8773
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiHaUTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiHaUS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:18:59 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8779F14F3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 13:18:58 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id i5-20020a17090a2a0500b001fd8708ffdfso374725pjd.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 13:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=PSp2/fCmK/hRUtlQD1BiQphhei94+qnRCH+0FidZ1zw=;
        b=f8sz/I3hUQu4tiGhEbhXBwcKiu3wj+iZEtjROVtx8TWnrHqobITYy9Mn/qjL19/jdh
         WnjalXzzcjYqICVXaChJ6vBcSNcug2hOx4d7fgIMUqJfRTBAWG96VhfiVy6I1Df4eWLl
         zAkM/O4HdRLftXhkFuQYhqcCiIYj0Dmf2iyE8RumWhgbKgZVg6zVlndjOe9Ah6IeiEnX
         6bMJZdtSSOIiUXcXleQ9M4chDfHthe5klJC0aUydwFfjv78uj9XLHt1BfEAi/vMxUY9O
         dV3fvLEyPOBffLYElbzrpTdBVzyKLKDC+YpdvMnLzTurCowI9uAz48+oZY349kbA7qjX
         gKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=PSp2/fCmK/hRUtlQD1BiQphhei94+qnRCH+0FidZ1zw=;
        b=lXxIulib/XIvZF3C+DOcoeOsVTfpqlmHcDdORgKUZ8UU/kMTIvmhRxCPryWSLyh9wq
         UIDLLAqd32jcE9MmK7jMxX33z/NSY80XuN21cTLrN8Zz0rSQl0UUS49wLJjts9TiWqnA
         0NNiJ/38Ynz7Xfs5HrvTP5EbCi2hb5oU1OOhHvTVKK/ng7qNjjwe2LTM01Iv2W+F++aP
         A0vuusUxRp1zWVUCHspiO0ibOr3ZNy8xcM4UGrjzcRgKsIQ5ayRf0WETBpb/GYhb6TJk
         OUgn9/3yGY5T/IVQ4NnA5IS27XsVd4gWfL6dMbTpF2l6N5Sp3hdphhUGgffEsLY05hzg
         1g8g==
X-Gm-Message-State: ACgBeo1sq/xiQo9UjAAJyHndkF4N72aZGGQxaKwzWNFjL2lP9yHf0b5j
        t5VcBBl8YrMbjK95kWzIk6nqnDtkR7xDR27RTNTrlw==
X-Google-Smtp-Source: AA6agR6VnuCxmthA4BAwAtlPYstZif8e+PGgcnE5gw9L5XABrzBF+RLZdpDqBVTUtKfwyZGa6wyzdBoSM7nNF2+3df4=
X-Received: by 2002:a17:90a:8689:b0:1fd:9ab8:bec2 with SMTP id
 p9-20020a17090a868900b001fd9ab8bec2mr4998101pjn.155.1661977138318; Wed, 31
 Aug 2022 13:18:58 -0700 (PDT)
MIME-Version: 1.0
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 31 Aug 2022 13:18:46 -0700
Message-ID: <CAJ+vNU1F3sYuSX9HEpVEPb-NzFEaKnuc_5mznTHOLFmCkCu_Lg@mail.gmail.com>
Subject: cn9130-crb PCI support
To:     kostap@marvell.com
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        vladimir.vid@sartura.hr, luka.kovacic@sartura.hr,
        linux-phy@lists.infradead.org,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        mw@semihalf.com, jaz@semihalf.com, nadavh@marvell.com,
        stefanc@marvell.com, bpeled@marvell.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin,

In commit 5c0ee54723f3 ("arm64: dts: add support for Marvell
cn9130-crb platform") which added support for the cn9130-crb where are
the PCI RESET# and CLKREQ# pins configured and specified?

As PCIE_PERST# is connected to CP_MPP[52] on the board I expected to
either see something like:
cp0_pci_pins: cp0-pci-pins-0 {
     marvell,pins = "mpp52";
     marvell,function = "pci";
};

or:
&cp0_pcie0 {
    gpios-reset = <&cp0_gpio2 20 GPIO_ACTIVE_LOW>;
};

I don't see any support in the PCIe driver (marvell,armada8k-pcie,
snps,dw-pcie) that support gpios-reset.

I'm working on support for another cn9130 board and am unclear how to
configure the pinctrl for PERST# as well as CLKREQ3. Any pointers
would be greatly appreciated.

Best Regards,

Tim
