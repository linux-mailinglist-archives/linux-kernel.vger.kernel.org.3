Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540935A8AC5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiIABdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiIABc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:32:56 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEAC155A65;
        Wed, 31 Aug 2022 18:32:53 -0700 (PDT)
Received: from coburn.home.jannau.net (p54acc2ba.dip0.t-ipconnect.de [84.172.194.186])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 4A6BC26EF47;
        Thu,  1 Sep 2022 03:25:20 +0200 (CEST)
From:   Janne Grunau <j@jannau.net>
To:     iommu@lists.linux.dev
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Joerg Roedel <joro@8bytes.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>,
        devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] iommu: M1 Pro/Max DART support
Date:   Thu,  1 Sep 2022 03:25:14 +0200
Message-Id: <20220901012519.7167-1-j@jannau.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hej,

this is the next attempt adding support for the DART found in Apple's
M1 Pro/Max/Ultra. This adds a separate io-pgtable implementation for
DART. As already mentioned in v2 the pte format is not fully compatible
with io-pgtable-arm. Especially the 2nd least significant bit is used
and is not available to tag tables/pages.
io-pgtable-dart.c is copied from io-pgtable-arm.c and support for
unused features is removed. Support for 4k IO pages is left for A7 to
A11 SoCs as there's work underway to run Linux on them.

The incompatibilities between both Apple DART pte seems manageable in
their own io-pgtable implementation. A short list of the known
differences:

 - the physical addresses are shifted left by 4 bits and and have 2 more
   bits inside the PTE entries
 - the read/write protection flags are at a different position
 - the subpage protection feature is now mandatory. For Linux we can
   just configure it to always allow access to the entire page.
 - BIT(1) tags "uncached" mappings (used for the display controller)

There is second type of DART (t8110) present on M1 Pro/Max SoCs which
uses the same PTE format as t6000.

Changes in v4:
- split dart and io-pgtable-dart build to allow building dart as module
- add missing "SELECT IOMMU_IO_PGTABLE"
- made map/unmap_pages/iova_to_phys inon-recursive
- replace pgd concatenation with multiple table handling
- simplified config and page size checks
- collected Robin's Ack

Changes in v3:
- move APPLE_DART to its own io-pgtable implementation, copied from
  io-pgtable-arm and simplified

Changes in v2:
- added Rob's Acked-by:
- add APPLE_DART2 io-pgtable format

Janne Grunau (1):
  iommu/io-pgtable: Move Apple DART support to its own file

Sven Peter (4):
  dt-bindings: iommu: dart: add t6000 compatible
  iommu/io-pgtable: Add DART subpage protection support
  iommu/io-pgtable-dart: Add DART PTE support for t6000
  iommu: dart: Support t6000 variant

 .../devicetree/bindings/iommu/apple,dart.yaml |   4 +-
 MAINTAINERS                                   |   1 +
 drivers/iommu/Kconfig                         |  13 +-
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/apple-dart.c                    |  24 +-
 drivers/iommu/io-pgtable-arm.c                |  63 ---
 drivers/iommu/io-pgtable-dart.c               | 471 ++++++++++++++++++
 drivers/iommu/io-pgtable.c                    |   3 +
 include/linux/io-pgtable.h                    |   1 +
 9 files changed, 513 insertions(+), 68 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-dart.c

-- 
2.35.1

