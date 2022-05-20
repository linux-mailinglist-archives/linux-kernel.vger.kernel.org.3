Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A45A52EE39
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350308AbiETOcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350303AbiETOcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:32:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D88612A5;
        Fri, 20 May 2022 07:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653057132; x=1684593132;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D+iRVt6FwtOPu5ZojACS+sJ1AtQ3Zo6GoLK4yiVBZC4=;
  b=Bg5FsdWODh01AaTOPGIDviUTwUgx3Y5tKZVvpXBgGn04d0l6QzVjnxov
   +XStU1RPy38Dc95PJ/gbIdXFNZiEOtpK780hw6PjCyIF4lr54H0nCbzrk
   Ofgj/cLweRqKej+51yjZjlehANmcY1NyOGvQk396wJWWDJFaqadiIxOx6
   ZsT8j7nmaxvuptAXo0y1R8V2eQz7jyUsLhKSZVYiqlAAJiVfyyGMKYExR
   NdtK4VuO4eUER8hY+gr5Zl34fa1TODJeYGC/Bok56cQFZ6DR9qdt0vBaU
   tKeA0pht2iHYugRAVCajJSXHMORJVs59HSf/o+K8eaMvJ7DAG1Y2FvB47
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="271439338"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="271439338"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 07:32:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="662286642"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 07:32:09 -0700
From:   matthew.gerlach@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v6 0/3] Add device tree for Intel n6000
Date:   Fri, 20 May 2022 07:32:05 -0700
Message-Id: <20220520143208.1160506-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Changelog v5 -> v6:
  - move copy engine binding from soc/intel to dma directory
  - remove unnecessary parent device tree node from copy engine example

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
 .../bindings/dma/intel,hps-copy-engine.yaml   | 41 ++++++++++++
 arch/arm64/boot/dts/intel/Makefile            |  3 +-
 .../boot/dts/intel/socfpga_agilex_n6000.dts   | 66 +++++++++++++++++++
 4 files changed, 110 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dma/intel,hps-copy-engine.yaml
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts

-- 
2.25.1

