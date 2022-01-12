Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD68448CEEE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 00:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbiALXJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 18:09:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:5928 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235388AbiALXJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 18:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642028955; x=1673564955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zSmYRU8FIGX3cJZGcSG6CFzwqnaKQim/SWuh0EbKmk4=;
  b=IJSXFFTzi7GwHQX8CKbBpIe3b7sKSQfP73SDJe9K0Bgk4MWfwCQs0RWV
   Ww0aPTopw4B0FbTvIMiqMDw0FRW0XGAlyTokR/Gu7siaU/M8LL8hkj59m
   L3ESPIw8lcvcMLwDWS/iQzwf0HSWk6LkJvStulhbL2Rp38WfdLBB1TBta
   eGW7K1OAGZ4aiFjFTc6K6gZ0IpB/TL1boCDUEQY1drniY64dP+IEtfNy8
   TBT5WpHNd9dPBwauMPQ5QWp7DYF+10QaUoRVWxKfiIB9iuHQ8wwSLmMjX
   SC9+FT1GG5Fuh6Gmy+9GS59jL7hZl3HZSUD2KvOAXQA6DbSDfqw4Cg79e
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="224564667"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="224564667"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:09:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="576736956"
Received: from kstefans-mobl.ger.corp.intel.com (HELO localhost) ([10.249.154.174])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:09:05 -0800
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>,
        Dave Hansen <dave.hansen@intel.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>
Subject: [PATCH v5 13/13] docs: Add PECI documentation
Date:   Thu, 13 Jan 2022 00:02:47 +0100
Message-Id: <20220112230247.982212-14-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220112230247.982212-1-iwona.winiarska@intel.com>
References: <20220112230247.982212-1-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a brief overview of PECI and PECI wire interface.
The documentation also contains kernel-doc for PECI subsystem internals
and PECI CPU Driver API.

Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 Documentation/index.rst      |  1 +
 Documentation/peci/index.rst | 16 +++++++++++
 Documentation/peci/peci.rst  | 51 ++++++++++++++++++++++++++++++++++++
 MAINTAINERS                  |  1 +
 4 files changed, 69 insertions(+)
 create mode 100644 Documentation/peci/index.rst
 create mode 100644 Documentation/peci/peci.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 54ce34fd6fbd..7671f2cd474f 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -137,6 +137,7 @@ needed).
    misc-devices/index
    scheduler/index
    mhi/index
+   peci/index
 
 Architecture-agnostic documentation
 -----------------------------------
diff --git a/Documentation/peci/index.rst b/Documentation/peci/index.rst
new file mode 100644
index 000000000000..989de10416e7
--- /dev/null
+++ b/Documentation/peci/index.rst
@@ -0,0 +1,16 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+====================
+Linux PECI Subsystem
+====================
+
+.. toctree::
+
+   peci
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/peci/peci.rst b/Documentation/peci/peci.rst
new file mode 100644
index 000000000000..331b1ec00e22
--- /dev/null
+++ b/Documentation/peci/peci.rst
@@ -0,0 +1,51 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+========
+Overview
+========
+
+The Platform Environment Control Interface (PECI) is a communication
+interface between Intel processor and management controllers
+(e.g. Baseboard Management Controller, BMC).
+PECI provides services that allow the management controller to
+configure, monitor and debug platform by accessing various registers.
+It defines a dedicated command protocol, where the management
+controller is acting as a PECI originator and the processor - as
+a PECI responder.
+PECI can be used in both single processor and multiple-processor based
+systems.
+
+NOTE:
+Intel PECI specification is not released as a dedicated document,
+instead it is a part of External Design Specification (EDS) for given
+Intel CPU. External Design Specifications are usually not publicly
+available.
+
+PECI Wire
+---------
+
+PECI Wire interface uses a single wire for self-clocking and data
+transfer. It does not require any additional control lines - the
+physical layer is a self-clocked one-wire bus signal that begins each
+bit with a driven, rising edge from an idle near zero volts. The
+duration of the signal driven high allows to determine whether the bit
+value is logic '0' or logic '1'. PECI Wire also includes variable data
+rate established with every message.
+
+For PECI Wire, each processor package will utilize unique, fixed
+addresses within a defined range and that address should
+have a fixed relationship with the processor socket ID - if one of the
+processors is removed, it does not affect addresses of remaining
+processors.
+
+PECI subsystem internals
+------------------------
+
+.. kernel-doc:: include/linux/peci.h
+.. kernel-doc:: drivers/peci/internal.h
+.. kernel-doc:: drivers/peci/core.c
+.. kernel-doc:: drivers/peci/request.c
+
+PECI CPU Driver API
+-------------------
+.. kernel-doc:: drivers/peci/cpu.c
diff --git a/MAINTAINERS b/MAINTAINERS
index 6ae398baffc8..908ebdf5ffff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14943,6 +14943,7 @@ M:	Iwona Winiarska <iwona.winiarska@intel.com>
 L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/peci/
+F:	Documentation/peci/
 F:	drivers/peci/
 F:	include/linux/peci-cpu.h
 F:	include/linux/peci.h
-- 
2.31.1

