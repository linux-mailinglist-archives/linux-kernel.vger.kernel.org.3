Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39885149EA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359549AbiD2MyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344968AbiD2MyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:54:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15C8B3695;
        Fri, 29 Apr 2022 05:51:04 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r13so15258826ejd.5;
        Fri, 29 Apr 2022 05:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rDzxu9MW9GN24hu7QhGn/9ENmvqmJvE90rNpUC/IGqQ=;
        b=AHk9xNI2GrdZ+pjC2XWPm9pf9PeG3cO+US4+NvK09Z0Mymct2lnm7lYFdCTJ5pIzGf
         bOKbRk9rkzPKYQPeA8Mj52SWaVEKwyqNLYpfYVJKTAjPN91ISLakjoNqMopYtv06N1bz
         fGHT+9S4otZtcVxBalgYU4ohFChLt0FEvMeADyRqkhwZsduABGMwCzmnXDfbVRU1ZR3U
         TQODJXQxdb9CF19dSELha6IdD6EBm4f15/Th5FXudHtqXslEAnwI4RpoJ0OaPJVekWs0
         8tGU3y+hgc1EbGnotEV9yev2xV6g9kIsXrLlYakNsVR+NA7HT0mIizbNjTI3AKtzo6Di
         +ydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rDzxu9MW9GN24hu7QhGn/9ENmvqmJvE90rNpUC/IGqQ=;
        b=7kvhDfjD5RX47Ixb3GY3TwBBObJXsI3nh2B4bPfNvke1WpiHVguSqmYcAegU1wNC6M
         Nkas7ZXhP5hnfG77nQzVkBm6PMAShiTQPkgGRJzF3BUBf2dCcoi8K/F9jPDsxuMyXekU
         GxwiBvHc4jK6KE8unqjV51I/mqedKfiJFj7GNjeNtTzdLrCMn1ctVc8srvNVfSnD16+d
         KP0p6lM4ulbRyMjII6re12ZUTO90VswNwRIgKuust1ciVqI5In4pUuZOptW6DDOOXTVt
         3cw9ArFc9rU9uw/dsfeRQyJsXwsR+hSY+c9eTExuUk3aCsngVzMFQbhPS9T0ZWaIrowe
         Kr6Q==
X-Gm-Message-State: AOAM531Ua8UGOGblQ+NaPNtKbd15YPERYpGXYvEwApss7MeKCooJ6GUU
        AMWaq2XUhGLrHTuIEbqHBuk=
X-Google-Smtp-Source: ABdhPJw8abQdctpop9AbAHRH+V0cqVAgRfZ2umYQQQl43FRc1mTpnZEldM/qz76veB92TvRxDzeurA==
X-Received: by 2002:a17:906:5641:b0:6da:8691:3fcc with SMTP id v1-20020a170906564100b006da86913fccmr34926623ejr.50.1651236663092;
        Fri, 29 Apr 2022 05:51:03 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id hf27-20020a1709072c5b00b006f3ef214e33sm615347ejc.153.2022.04.29.05.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:51:02 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3 0/2] Add nvmem support for dynamic partitions
Date:   Fri, 29 Apr 2022 14:48:23 +0200
Message-Id: <20220429124825.21477-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
will automagically fin the OF node and cells will be works based on the
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

v3:
- Fix warning from bot (function not declared as static)
- Updated code to support also node name
- Made partition label optional
v2:
- Simplify this. Drop dynamic-partition
- Fix problem with parser with ko
- Do not pollude mtd_get_of_node
- Fix problem with Documentation

Ansuel Smith (2):
  dt-bindings: mtd: partitions: Document new partition-dynamic nodes
  mtd: core: introduce of support for dynamic partitions

 .../mtd/partitions/partition-dynamic.yaml     | 56 +++++++++++++++++++
 .../mtd/partitions/qcom,smem-part.yaml        |  4 ++
 drivers/mtd/mtdcore.c                         | 56 +++++++++++++++++++
 3 files changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml

-- 
2.34.1

