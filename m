Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AFB51EE0A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 16:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiEHOa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 10:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiEHOaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 10:30:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164106164;
        Sun,  8 May 2022 07:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652019987; x=1683555987;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r4HJTOfC25H3VcKQz3KRyOmyhRGSiIPaSaWM7GPA5Ss=;
  b=f4w5kiP/wQv8UBIXK34fnSIIIX8FWys4+Y0FONreUoXOoN4UkWHRZXIg
   Y0/BMVOly60fB/OcJkvTdb5HD3CVWNXXmKm8HFzUDYTDRymBQGzXZLb8G
   9qjCcBW3HWKjyTxKYFl93QqFNJCTgRuir9VaYOE4H2AyBi2GNLyBFvR16
   2qB58XH18x0YfuXm4ZPbynDIv2VjHNDW0SNpSCvUEsFS16vVlkeU2hZLz
   wur2XA1X9660SrUcwq+RLSmPfTbLDMrFec/J+9/SOCskd8KAIV0VqZ7t+
   mQGILBSNdqCGUnJoRQvfmOdfS3lUCj6FOgcgplgikgqm8qRcjcy+ZHb+A
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="268488486"
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="268488486"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 07:26:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="737738696"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 07:26:25 -0700
From:   matthew.gerlach@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v4 0/3] Add device tree for Intel n6000
Date:   Sun,  8 May 2022 07:26:21 -0700
Message-Id: <20220508142624.491045-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

This patch set adds a device tree for the Hard Processor System (HPS)
on an Agilex based Intel n6000 board.

Patch 1 defines the device tree binding for the HPS Copy Engine IP
used to copy a bootable image from host memory to HPS DDR.

Patch 2 defines the binding for the Intel n6000 board itself.

Patch 3 adds the device tree for the n6000 board.

Changelog v3 -> v4:
  - move binding yaml from soc to soc/intel

Changelog v2 -> v3:
  - remove unused label
  - move from misc to soc
  - remove 0x from #address-cells/#size-cells values
  - change hps_cp_eng@0 to dma-controller@0
  - remote inaccurate 'items:' tag
  - added Acked-by
  - add unit number to memory node
  - remove spi node with unaccepted compatible value

Changelog v1 -> v2:
  - add dt binding for copy enging
  - add dt binding for n6000 board
  - fix copy engine node name
  - fix compatible field for copy engine
  - remove redundant status field
  - add compatibility field for the board
  - fix SPDX
  - fix how osc1 clock frequency is set

Matthew Gerlach (3):
  dt-bindings: soc: add bindings for Intel HPS Copy Engine
  dt-bindings: intel: add binding for Intel n6000
  arm64: dts: intel: add device tree for n6000

 .../bindings/arm/intel,socfpga.yaml           |  1 +
 .../soc/intel/intel,hps-copy-engine.yaml      | 51 ++++++++++++++
 arch/arm64/boot/dts/intel/Makefile            |  3 +-
 .../boot/dts/intel/socfpga_agilex_n6000.dts   | 66 +++++++++++++++++++
 4 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts

-- 
2.25.1

