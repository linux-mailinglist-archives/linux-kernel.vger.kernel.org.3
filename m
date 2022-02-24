Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E098A4C2F79
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbiBXPWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbiBXPV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:21:59 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EC61B45C0;
        Thu, 24 Feb 2022 07:21:07 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id qx21so5033785ejb.13;
        Thu, 24 Feb 2022 07:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rDzxu9MW9GN24hu7QhGn/9ENmvqmJvE90rNpUC/IGqQ=;
        b=bWWYO56F/YxJD6tFUzcbwEeRTUFYyqTUDIbxPJO4lr3luSN1Cne8aYy0Xx0UW6tpIR
         yfMYwMBkG6FAUZfqzJkHQWf22s4ZnleKvyz061lLL66lNMjJTby8zn+6hZfF4LTYCDsV
         sNaWQ69fKfCy/JhnKGFWRcyQyYX3bjPuDgSzNOMTX0847BGcCSz5wpK4UDe63/8LIKgv
         620nro2b+yuRs+K203y1qole6Bni4830elQZ0NvO5x2ke4tdWIeuIhiI5DoriIXtxUyz
         n2RTvIP4PHKHit5jEKKxx5Q72qdzNu+Qbp8Zm+Qnh+KSrRw4Kgmd/rbeWncAnoXUf26A
         dH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rDzxu9MW9GN24hu7QhGn/9ENmvqmJvE90rNpUC/IGqQ=;
        b=eRDHyKtAa+PXH5q0nWSLjq0EHt2AsIrz3bGJoNNBGwcaB6oCQqvAeqzl7PoXewBzIi
         k2wsG/B3As2XpLbOOqaMj/6cO/xj1Y0Q5GzJgG78VZ9uXT5BcCUcxKcrF4001LRUBB6k
         3tQ5dbKicCn5jyIlhgY0lugtiv9zT+7IUo1ceBtDPW3Yqo1C/u9mF6La9yFxvtKxhv6O
         xJu9/+j1KXgD8i6MgvqtllJBOFqWkylwCD4vfkhnP9T422oMT57/AAG/LN27WZei3tB6
         p2IysP4MFt4clMVucCoP+enIyDF39U0XgGHq23ru5WlFMbE3jaQElRQs3jJfu1O6axzb
         q6Pw==
X-Gm-Message-State: AOAM530EonnxgolNfgAhS29XWTy4qdOcGrB4fh4H/NCnym6Mm3rLsu+U
        8/dACXnGs2C231JbA11JVl2uyB0CmmY=
X-Google-Smtp-Source: ABdhPJzP10VTxduFkk4DgmEETaIvYLFpyRV0di6RWo1xpAOTL+1JJ7XKY2ja82kfIWDpYIYkl1C+oA==
X-Received: by 2002:a17:906:1e94:b0:6cc:4382:f12e with SMTP id e20-20020a1709061e9400b006cc4382f12emr2663115ejj.482.1645716063617;
        Thu, 24 Feb 2022 07:21:03 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.108.128])
        by smtp.googlemail.com with ESMTPSA id x12sm1501980edv.57.2022.02.24.07.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:21:03 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC RFT PATCH v3 0/2] Add nvmem support for dynamic partitions
Date:   Thu, 24 Feb 2022 16:20:41 +0100
Message-Id: <20220224152043.27777-1-ansuelsmth@gmail.com>
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

