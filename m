Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CA94BD06A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 18:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243054AbiBTRkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 12:40:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbiBTRkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 12:40:03 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0004A92B;
        Sun, 20 Feb 2022 09:39:41 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bg10so27365932ejb.4;
        Sun, 20 Feb 2022 09:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TPH3FD4ePxH+PTr049+CngqXpJgQNQebbqg3r/4ZGH4=;
        b=FUKpDsiXx/uq7vGjNWd8gYCoMWWuhg/1Lhk0bOT/1SN8JBm9AiQCzKZYAah0onvFOc
         965b/llGxgPteDOTmdbPVwdGIh6lx0XqZkSzTOa7+3z9itE25CO/P87JilBqfAgnpbvU
         jDKlUfoSUnIaWuaaZ6Dxgn0uaJVqzoLLib0TGZ5pkUaxFF9F+OyMVRSpac4JL0iWPr95
         O/DkDM7q3V1RsGj3pee7QFQkm+HYmRC+2qdBSOUhZvadSL03MmIWW9hklNEdYt3myiGF
         ATNQCIxIFjHUZlcBZ9TKLkVAJ38S7GquPAonl1n7nWOFNb2GBiJfzyKCECEEoBKS2Ctf
         2oAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TPH3FD4ePxH+PTr049+CngqXpJgQNQebbqg3r/4ZGH4=;
        b=NFgwwfZOEesnRLncPo9QfgO9PJIEN/bdoqxLiXFCKM9NGMi2SvyO3wWdRyteOqbaKh
         Cgvh71mPWOywP9+wgVyZKshgK8oRNPyziFUZdVp0c0r4XWiEeEcB0xolqDNJKjMGeiQ+
         x8ypNfH2FmaH1fR9iEQqgOA4wXaVyqqFv6Wea0SuGLdIidHCH2Gs2VlWlNF3IxnZA2L+
         3taxADaNjBiMAbx/tVSaQ40aZyeGWF4caSeO24T/9X/DkrVqpvSllUwlTmp5nfv5NbEk
         sPjV2PK1uGDig5CExacSm7bYdjJH4dm1vcwpzxuYze3B245kcLlyUAYvEe1JYcnktepi
         pd+g==
X-Gm-Message-State: AOAM533ErY3vsAF9G5Xgtv6fWhFP0xNryLtMubD5Z5fkpyMpDlE6Gfe+
        08tL6zpjZfs7oZ0sQdh1ixI=
X-Google-Smtp-Source: ABdhPJwByoxP5Jigs1/wk6k5yda/H0Lk4B08+KX3sL1E7wL8WAVtaFlPOto610G7lthB48q7YKNqpQ==
X-Received: by 2002:a17:907:7845:b0:6cd:f2f4:cf00 with SMTP id lb5-20020a170907784500b006cdf2f4cf00mr13059766ejc.388.1645378779238;
        Sun, 20 Feb 2022 09:39:39 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id i5sm4416721ejo.188.2022.02.20.09.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:39:38 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC RFT PATCH v2 0/2] Add nvmem support for dynamic partitions
Date:   Sun, 20 Feb 2022 18:39:03 +0100
Message-Id: <20220220173905.14165-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
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

I hope we find a solutio to this problem as currently we are trying to
transition to nvmem and we found this limitation. This seems to be a
good solution that doesn't looks to be too much of an hack.n

v2:
- Simplify this. Drop dynamic-partition
- Fix problem with parser with ko
- Do not pollude mtd_get_of_node
- Fix problem with Documentation

Ansuel Smith (2):
  dt-bindings: mtd: partitions: Document new partition-dynamic nodes
  mtd: core: introduce of support for dynamic partitions

 .../mtd/partitions/partition-dynamic.yaml     | 54 +++++++++++++++++++
 drivers/mtd/mtdcore.c                         | 45 ++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml

-- 
2.34.1

