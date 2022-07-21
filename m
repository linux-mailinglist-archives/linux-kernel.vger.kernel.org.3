Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0C857CAA6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 14:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbiGUMbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 08:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiGUMbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 08:31:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C028B14D22
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 05:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658406663; x=1689942663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N8jJH0EXgxJaWS3yPLumTYXLuWOp2q0k0ywttVo4wzs=;
  b=dAiZRSMgYRjwFzU7tjomaKd9wLspKImzOtdQvYQ+efkRRXkGjUglHxFU
   lxRKeQlewxm9LNbjLDNHP4WA7rrc3cTZUNd7G+6jz/XSZjR/e3Qyn4v6B
   rUZAYE6y0wRtTWjzhwXN0iLDmItT6dkx67reOAzD7AT2lAW68wTHT53pE
   vJPQROxCela7HMvohN67IOXIbROrDqLY8tvo4bf3MGj0LTupZ8wWreIdQ
   MAC2XAvV4/8mtg/1MzuYiOSWZOCCBJFX3K+hD3gjvORDx1ITNAJzjlinF
   N1h8VNnl65+7zdAvkpPr4xX0MQb2oPdDSByiUJ+IaKzWHaeZKXLgb/lHS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="351020149"
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="351020149"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 05:31:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="925634142"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2022 05:31:01 -0700
From:   kah.jing.lee@intel.com
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     rafael.j.wysocki@intel.com, tien.sung.ang@intel.com,
        dinh.nguyen@intel.com, Kah Jing Lee <kah.jing.lee@intel.com>
Subject: [PATCH v2 0/3] New driver for Intel(Altera) FPGA System ID softIP
Date:   Thu, 21 Jul 2022 20:30:19 +0800
Message-Id: <20220721123017.416438-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220602122008.3021030-1-kah.jing.lee@intel.com>
References: <20220602122008.3021030-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kah Jing Lee <kah.jing.lee@intel.com>

Hi,

I would like to request review for the new System ID driver for Intel FPGA
platform.

New sysid driver for Altera(Intel) Sysid component is generally part of an
FPGA design. The component can be hotplugged when the FPGA is reconfigured.

There are two basic ways to use the system ID core:
- Verify the system ID before downloading new software to a system. This
method can be used by software development tools, before downloading a
program to a target hardware system, if the program is compiled for
different hardware.

- Check system ID after reset. If a program is running on hardware other
than the expected Platform Designer system, the program may fail to
function altogether. If the program does not crash, it can behave
erroneously in subtle ways that are difficult to debug. To protect against
this case, a program can compare the expected system ID against the
system ID core, and report an error if they do not match.

Documentation link:
https://rocketboards.org/foswiki/Documentation/AgilexSoCGSRD#PR_Files

Feedback from maintainers:
https://lore.kernel.org/lkml/YpmqeHt5Y31ffh5Q@kroah.com/#t

Kah Jing Lee (3):
  drivers: misc: intel_sysid: Add sysid from arch to drivers
  dt-bindings: misc: intel_sysid: Add the system id binding for
    Altera(Intel) FPGA platform
  documentation: misc: intel_sysid: Add the system id sysfs
    documentation for Altera(Intel) FPGA platform

 .../testing/sysfs-devices-platform-soc-sysid  |  27 +++++
 .../bindings/misc/intel,socfpga-sysid.yaml    |  41 +++++++
 drivers/misc/Kconfig                          |   9 ++
 drivers/misc/Makefile                         |   1 +
 drivers/misc/intel_sysid.c                    | 114 ++++++++++++++++++
 5 files changed, 192 insertions(+)
 create mode 100644 Documentation/ABI/testing/
sysfs-devices-platform-soc-sysid
 create mode 100644 Documentation/devicetree/bindings/misc/
intel,socfpga-sysid.yaml
 create mode 100644 drivers/misc/intel_sysid.c

-- 
2.25.1

