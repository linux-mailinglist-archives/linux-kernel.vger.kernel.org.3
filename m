Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F996518D64
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242107AbiECTtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237504AbiECTtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:49:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474E01EC69;
        Tue,  3 May 2022 12:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651607160; x=1683143160;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AzhBhxOhbCgOB3+iQ2HWZ9hfSjIgWo+A1YlkKhyilzw=;
  b=PWg2/8mu8FSl5jkaVUdwvZ4tM7KrRdpmG5IXY1nVWrSypcqXu0uHr7Rl
   DUbC1cs71YGX398+gonOZfF4/JOCLSeITU+Wtjb/k94gcdpYslVOhRybq
   TdA1ykgc8iAa9Cs1eTv9Y8s0j3SYEL5FOikxFxdYgAEqcUVNWMvyKLS7v
   5LrTF/X7ZpcgradWie25mB5w9g9kdO1N5aWWrwH/yrqrHxBt+S2mZ9vaO
   wAaygTPd1aE05q0VmVK6ilBTnfJiNOf02gw7sxZF/1Ua+E2aslh9uf0PC
   A9cDebHUH8WQ5ERVranC6ZJaRXAkrcxOQ2wm7E5pEPZQo8SrOZwlHWulh
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="248114158"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="248114158"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 12:45:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="584345937"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 12:45:59 -0700
From:   matthew.gerlach@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v2 0/3] Add device tree for Intel n6000
Date:   Tue,  3 May 2022 12:45:43 -0700
Message-Id: <20220503194546.1287679-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
  dt-bindings: misc: add bindings for Intel HPS Copy Engine
  dt-bindings: intel: add binding for Intel n6000
  arm64: dts: intel: add device tree for n6000

 .../bindings/arm/intel,socfpga.yaml           |  1 +
 .../bindings/misc/intel,hps-copy-engine.yaml  | 48 ++++++++++++
 arch/arm64/boot/dts/intel/Makefile            |  3 +-
 .../boot/dts/intel/socfpga_agilex_n6000.dts   | 76 +++++++++++++++++++
 4 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/misc/intel,hps-copy-engine.yaml
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts

-- 
2.25.1

