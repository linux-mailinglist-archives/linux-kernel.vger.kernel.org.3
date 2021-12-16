Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4D647753F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238224AbhLPPBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:01:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:18774 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232565AbhLPPBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639666900; x=1671202900;
  h=from:to:cc:subject:date:message-id;
  bh=mjCvYYPweWor1hTfJAHZ7Ke1fpQNjdFPojo+gum/cvc=;
  b=VGoGFQZDlhZ4woRAt14FRYTlvw+xRiRLL8cOYXRtPCtTaF/rXdYg4LBq
   2S5xsl1/hGBtzghljN+I7YmHnNKMFKkkQm0klUcl/9P0/RUrXzp3YDrJg
   o8rLym819ST+n96tKWzgebmpuMDg/pW35v6SyRcgQqrSjTYJ3BqYXImi5
   MgtlN//eOkwF89MusBsFvGhd5RJeroXvpIPKyIS5ATueacHsbpj1VFX1J
   oL23mTLDCsid/YcyfPhay+d69TvIn/raUS0535khwGuFkcS1EmGFy0AgU
   ptpW+RNKsm7O5QkyQM0di8c4CpZP3u24/XLDyng0dr8CMtC7bkaLc9jHB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="226796781"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="226796781"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 07:01:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="519282679"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga008.jf.intel.com with ESMTP; 16 Dec 2021 07:01:01 -0800
From:   lakshmi.sowjanya.d@intel.com
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        bgolaszewski@baylibre.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, tamal.saha@intel.com,
        pandith.n@intel.com, kenchappa.demakkanavar@intel.com,
        lakshmi.sowjanya.d@intel.com
Subject: [PATCH v3 0/2] Add pinctrl support for Intel Thunder Bay SoC
Date:   Thu, 16 Dec 2021 20:30:58 +0530
Message-Id: <20211216150100.21171-1-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

Hi,

This patch set enables the support for the integrated pin controller in
the Intel Thunder Bay SoC.

Patch 1 holds the relevant Device Tree bindings documentation and an
entry in MAINTAINERS file.
Patch 2 holds the implementation of pinctrl driver.

Keem Bay and Thunder Bay platforms doesn't provide identical feature set
and register interfaces. There is no successor platform after Keem Bay
and Thunder Bay. So, having a uniform framework for different IP will
not give much advantage in this case and we prefer to have this
implementation for Thunder Bay platform as a separate driver.

Added reference to pincfg-node.yaml in the patternProperties.

Please help to review this patch set.

Thanks,
Sowjanya

Changes from v1:
 - Removed hw specific configurations.
 - Add set_config.
 - Removed gpiochip_add_pin_range and added the same in device tree.
 - Add gpio-ranges property in yaml file.

Changes from v2:
 - Add ref to pincfg-node.yaml in thunderbay.yaml file.

Lakshmi Sowjanya D (2):
  dt-bindings: pinctrl: Add bindings for Intel Thunderbay pinctrl driver
  pinctrl: Add Intel Thunder Bay pinctrl driver

 .../pinctrl/intel,pinctrl-thunderbay.yaml     |  122 ++
 MAINTAINERS                                   |    5 +
 drivers/pinctrl/Kconfig                       |   19 +
 drivers/pinctrl/Makefile                      |    1 +
 drivers/pinctrl/pinctrl-thunderbay.c          | 1322 +++++++++++++++++
 5 files changed, 1469 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/intel,pinctrl-thunderbay.yaml
 create mode 100644 drivers/pinctrl/pinctrl-thunderbay.c

-- 
2.17.1

