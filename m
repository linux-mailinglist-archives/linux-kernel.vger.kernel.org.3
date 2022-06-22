Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F177553FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 03:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354547AbiFVBLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 21:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349006AbiFVBLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 21:11:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B103151F;
        Tue, 21 Jun 2022 18:11:01 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so10159774wms.5;
        Tue, 21 Jun 2022 18:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uugx3RS7oxGS2ZFarjyKn4uAaMCIluxrPYwER0fWx5o=;
        b=oPQXlZOy+TuQD3tx2ScCNgB2s8o+82kcA9dOz7cdnIIeyPvsZfR0tQWEwCtYxs0jH/
         gszJ6osfTkHDh5QSPvT4sbxI99sTGTxlhbAkuUO/iDnHpLTQ6/FmXnAN1PgboTi6NQjE
         Xi/UtwXIBMS6TyptJLqjNzXKPDR94rhY+FjXw1qyRCuco0WrBy6IHx29XqdJLnzA8e45
         oftYmXCB+W5pqlCGSwZFy0QvWWBnunSp8tk91szpTFHN4H+3+Ptn7Rgao0CSPPqKxthF
         yw0gMHUG+K4/3IWd+iyh8s8Qutq7b4/Sq2BIPIYQaVmWs1P7wvr2Wl5Ab5JH0kbQJIZR
         rtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uugx3RS7oxGS2ZFarjyKn4uAaMCIluxrPYwER0fWx5o=;
        b=AC3rXr7ROZ7Hg3q+Hh3+KWk+Kf5XXcFppuwvS1aDO3G/aRWDU8Arl3nTLr8sPBY11C
         qhK41PjoX47TW4v90ZUWkoGSAmwgzGahphRbJacdvgj4j+6cFIP2tVFej7X8/1JJQa/+
         3+9KXroaFfzJcRWs/AQCILsdkBY+7kn+CFwsT5P8gareYKNiLsPmPb9OfB1IEo2h6bxe
         EKegY46vZLyihD818J0qJx4bRwsyqjGdemd0YUrDGQkOUR8W4wzgTwTvSh5x8BxUL6cD
         Ji9ao3IX/5DxUOj9I/0zXGAbY7q8hWQ0qqDjz61S4FfBA5gdSp+i65O25PhBq7Mg6jTE
         V4xg==
X-Gm-Message-State: AJIora8mt2T8gS6JMzv7cfeHdgPP9+1ww0Igi9qA5brH5LEqw4bMI9Cg
        IPkF0KwX2tG/qVGaKLX4FUVb4uHNWhI=
X-Google-Smtp-Source: AGRyM1trL93S5hxPBvcmQwe6wXBXySM33gUM2C7+uBdjW4tLcfv1R2G0sZJFnhghWaWR2AVO0GmpoQ==
X-Received: by 2002:a05:600c:190b:b0:39c:7704:74a4 with SMTP id j11-20020a05600c190b00b0039c770474a4mr900241wmq.92.1655860259728;
        Tue, 21 Jun 2022 18:10:59 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id x13-20020adfdd8d000000b0021b81855c1csm16560086wrl.27.2022.06.21.18.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 18:10:58 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        =?UTF-8?q?=EF=BF=BDecki?= <rafal@milecki.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3] Add nvmem support for dynamic partitions
Date:   Wed, 22 Jun 2022 03:06:25 +0200
Message-Id: <20220622010628.30414-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This very small series comes to fix the very annyoing problem of
partitions declared by parser at runtime NOT supporting nvmem cells
definition.

The current implementation is very generic. The idea is to provide an of
node if defined for everyone and not strictly limit this to nvmem stuff.
But still the actual change is done only for nvmem-cells mtd. (just to
make sure) This can totally change by removing the compatible check.

The idea here is that a user can still use these dynamic parsers
instead of declaring a fixed-partition and also declare how nvmem-cells
are defined for the partition.
This live with the assumption that dynamic partition have always the
same name and they are known. (this is the case for smem-part partition
that would require a bootloader reflash to change and for parsers like
cmdlinepart where the name is always the same.)
With this assumption, it's easy to fix this problem. Just introduce a
new partition node that will declare just these special partition.
Mtdcore then will check if these special declaration are present and
connect the dynamic partition with the OF node present in the dts. Nvmem
will automagically find the OF node and cells will be works based on the
data provided by the parser.

The initial idea was to create a special nvmem driver with a special
compatible where a user would declare the mtd partition name and this
driver would search it and register the nvmem cells but that became
difficult really fast, mtd notifier system is problematic for this kind
of stuff. So here is the better implementation. A variant of this is
already tested on openwrt where we have devices that use cmdlinepart.
(that current variant have defined in the dts the exact copy of
cmdlinepart in the fixed-partition scheme and we patched the cmdlinepart
parser to scan this fixed-partition node (that is ignored as cmdlinepart
have priority) and connect the dynamic partition with the dts node)

I provided an example of this in the documentation commit.
In short it's needed to add to the partitions where the compatible parser
is declared, a partition with just the label declared (instead of the reg).
Then declare some nvmem-cells and it will all work at runtime.
Mtdcore will check if a node with the same label is present and assign an
OF node to the MTD.

I currently tested this on my device that have smem-part and the
gmac driver use nvmem to get the mac-address. This works correctly and
the same address is provided.

v6:
- Fix Sob tag
- Add review tag by Rob
- Reintroduce name support for partition
- Make the "partition-" prefix mandatory
v5:
- Simplify Documentation and move it generic partition.yaml
- Split commit and move smem example to dedicated commit.
v4:
- Make it simple. No suffix. Make label mandatory again.
- Update Documentation with new implementation.
- Rename files to a better and correct name
v3:
- Fix warning from bot (function not declared as static)
- Updated code to support also node name
- Made partition label optional
v2:
- Simplify this. Drop dynamic-partition
- Fix problem with parser with ko
- Do not pollude mtd_get_of_node
- Fix problem with Documentation

Christian Marangi (3):
  dt-bindings: mtd: partitions: support label/name only partition
  dt-bindings: mtd: partitions: add additional example for
    qcom,smem-part
  mtd: core: introduce of support for dynamic partitions

 .../bindings/mtd/partitions/partition.yaml    | 20 +++++-
 .../mtd/partitions/qcom,smem-part.yaml        | 27 ++++++++
 drivers/mtd/mtdcore.c                         | 61 +++++++++++++++++++
 3 files changed, 106 insertions(+), 2 deletions(-)

-- 
2.36.1

