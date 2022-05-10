Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803F8522403
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348892AbiEJSap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348854AbiEJSao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:30:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E44E3C;
        Tue, 10 May 2022 11:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652207443; x=1683743443;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AtK4Vp+vfjns4zq9RBk33s4OL+pZBv+NmUoteuD0PHI=;
  b=NMv+QOkFfbIowWQnlXmjlOWTPViXrO65rglfkzitURnS0s3O6wshjop3
   yWPhw94DdPjgudGzZeDAfz9SNXlAnMEsQDpqtl5MN3Fjhagy06RqSZ5zi
   U5FdYPrwb3Ni6J2l80ewEW1Ss3Va94KFOsJRWEl/iXEwUuxit60FRY2Iz
   uFlKUaNUCxpfrJwd8oFP9xANmPU0wS1mg33idtnwIxdUcb8zHuBEx0uoC
   4KBVCmrMv/EAvGpCdG77zds1iO9dsF8c63OnBI/kNcac60OREyB5ElWeb
   SZ+ImrvRSco1seG3sTAvvrYl7X63iIMJdPsaRyRvg+1HdZ4MX8Nxy3oBV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="249998287"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="249998287"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:30:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="738839901"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:30:42 -0700
From:   matthew.gerlach@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v5 0/3] Add device tree for Intel n6000
Date:   Tue, 10 May 2022 11:30:38 -0700
Message-Id: <20220510183041.876583-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Changelog v4 -> v5:
  - add tags from Krzysztof Kozlowski

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

