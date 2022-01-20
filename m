Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6EF495566
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 21:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377648AbiATU0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 15:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbiATU0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 15:26:21 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2FCC061574;
        Thu, 20 Jan 2022 12:26:21 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o7-20020a05600c510700b00347e10f66d1so7850192wms.0;
        Thu, 20 Jan 2022 12:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UKMBCT6uefz4F0EnrrHNFruysGqn813NuCy3BVSBJy8=;
        b=oaOboOEzXdyt7184bP/qpyy5y4XslPheUaKT+HdPPw+XpnXpLTS4W4ncK/9lxDjfTv
         frFmqn0lZuSZSWVzSt4Mp5hXMyifFx6QGr9unt5RYGDWD/kkojjaRudZNDo5jzMRIlsw
         NGLmldivINsJ/+Z23sLOouNIQDSgVs7gsLpEcSKRxJL05VqSfeYj415ZDt1iIoV6xS0/
         q4GI2KCWWJrr95vqD36eaL/M73jZ0N6pfjvUjhczepa52AZ99PfP+WmESbJnSSu2zDfr
         NJ27qlMOuF5n9TS1zEz0Fi8TWNEmgcryPsbBuOQFSAH62jj/tZsCQ5VoYwc2FeQPXDPR
         QHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UKMBCT6uefz4F0EnrrHNFruysGqn813NuCy3BVSBJy8=;
        b=Yv9xZD4HLXr2oH9VZeziM0JIThk3aJK6/P7R4AZmMORM5MDoqF3Q/jGyy3MbPc8R0N
         +I6jKPhDxuRpiyT7jvqZQJvzlBrwm60w+JxNky2+W/EduHMWK4Di/OB4gC1nQIqYz3EK
         TTmWUIqZruaFeyfu2gBquQJ38GSDOZcc7gHF76YIGMuwCOOMYJMw+3x8iwIioJdVSdK3
         jUmLimQf4mzE2tEM5OSInbkpqMP3HUGpK4QXtzPjTUOxp9w3rF/fokAbdILqwlY9eGdB
         c9bNns5JVl/nbrANEC1j4HdJn6znjDqImc61G32X9gyo5AYjZo0I7YxGhoGtMbfvuGbA
         bzDQ==
X-Gm-Message-State: AOAM531yiofDlO5S24WxAv5R7ZatXVEby+a1ngu3r60LhiS/6sywOgpc
        gp2k8b4wp726iRfHPEPut8o=
X-Google-Smtp-Source: ABdhPJx6xaxLeSbnTVAitX4F6ySfZBpR8G8aEO0rVX1YbrMZhqMfm0gVQp8Vl3IN9rTgYlL2V9MMTQ==
X-Received: by 2002:a5d:64cf:: with SMTP id f15mr688260wri.483.1642710379720;
        Thu, 20 Jan 2022 12:26:19 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id n11sm862919wms.3.2022.01.20.12.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 12:26:19 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] Add nvmem support for dynamic partitions
Date:   Thu, 20 Jan 2022 21:26:13 +0100
Message-Id: <20220120202615.28076-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This very small series comes to fix the very annyoing problem of
partitions declared by parser at runtime NOT supporting nvmem cells
definition.

The current implementation is very generic. The idea is to provide an of
node if defined for everyone and not strictly limit this to nvmem stuff.
But still the actual change is done only for nvmem-cells mtd. (just to
make sure) This can totally change and be limited to restore the old
mtd_get_of_node and add a function just to fix the problem with nvmem.

The idea here is that a user can still use these dynamic parsers
instead of declaring a fixed-partition and also declare how nvmem-cells
are defined for the partition.
This live with the assumption that dynamic partition have always the
same name and they are known. (this is the case for smem partition that
would require a bootloader reflash to change and for parsers like
cmdlinepart where the name is always the same.)
With this assumption, it's easy to fix this problem. Just introduce a
new partition node that will declare just these special partition.
Mtdcore then will check if these special declaration are present and
connect the dynamic partition with the of node present in the dts. Nvmem
will automagically fin the ofnode and cells will be works based on the
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
In short the dynamic-partitions node is defined at the same level of the
partitions node. The partition in the "dynamic-partitions" node require
to have the same label of the dynamic-partition that will be created at
runtime and then a user can use the usual nvmem-cells way to declare
nvmem cells. Only the needed partition has to be declared, all the other
dynamic-partitions can be ignored.

I currently tested this on my device that have smem and the
gmac driver use nvmem to get the mac-address. This works correctly and
the same address is provided.

I hope we find a solution to this problem as currently we are trying to
transition to nvmem and we found this limitation. This seems to be a
good solution that doesn't looks to be too much of an hack.

Ansuel Smith (2):
  dt-bindings: mtd: partitions: Document new dynamic-partitions node
  mtd: core: introduce of support for dynamic partitions

 .../mtd/partitions/dynamic-partitions.yaml    | 59 +++++++++++++++++++
 drivers/mtd/mtdcore.c                         | 45 ++++++++++++++
 include/linux/mtd/mtd.h                       |  6 +-
 3 files changed, 105 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml

-- 
2.33.1

