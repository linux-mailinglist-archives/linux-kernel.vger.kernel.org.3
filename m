Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B7F4A86D6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiBCOqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:46:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:37909 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351282AbiBCOqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643899606; x=1675435606;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G1NEaO4YfV+ndngmjLH9H1KfbSPd0dgTl8bo+81+nzU=;
  b=kuMXRLy42m+amXIIullowRFx9hzSQRmtexgGFvHp4/qqE3eC9kT+Ud18
   c9Ixo3eh4RXw04dwznRQ1ben1p9/hfKy+Ta4rDuGVaYpeDhsqNWJGDXXT
   y7cWxUqILflAsM/fSC2iIyQF+7Lwfz5GC/Qfc29+5a2WmrJtNwgqoeXZ3
   tyQyQIxX/YlsOwHsFxrnTudKvZ6PTm0dZYEdfhM+Ja4ToDpBgzNy9I9Fq
   5rATs2TES7v043tbW6n2PKCs30KtMWtrZCEdOhAXTPaArwU7vRwQpUDSt
   GSkwhI2IrR+onens0BzxTLg5HoZwhntdQ/oPZ37WlPAVe9aeU5fUDTmfD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="308882989"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="308882989"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 06:46:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="676788140"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Feb 2022 06:46:43 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jameson Thies <jthies@google.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] usb: typec: Separate sysfs directory for all USB PD objects
Date:   Thu,  3 Feb 2022 17:46:54 +0300
Message-Id: <20220203144657.16527-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ideally after this there should be no need to add any new USB Power
Delivery specific attribute files directly to the USB Type-C devices
in sysfs. They now have their own directory.

The idea of the series is that any device (so not just USB Type-C
connectors and the partners attached to them) that supports USB Power
Delivery can have this separate sub-directory "usb_power_delivery" in
sysfs, and that sub-directory will have all the USB Power Delivery
objects and all the other USB Power Delivery details.

There are already ways that allow us to read the USB Power Delivery
capabilities from potentially any USB PD capable USB device attached
to the bus - one way is defined in the USB Type-C Bridge
Specification.

Initially the Capability Messages (i.e. PDOs) are exposed.

This is an example (tree view) of the capabilities that the ports on a
normal x86 system advertise to the partner. First you have the message
directory (source_capabilities and sink_capabilities), and that will
have a sub-directory for each PDO that capability message has. The PDO
sub-directories are named by their type. The number in front of the
name is the object position of the PDO:

/sys/class/typec/port0/usb_power_delivery
|-- revision
|-- sink_capabilities/
|   |-- 1:fixed_supply/
|   |   |-- dual_role_data
|   |   |-- dual_role_power
|   |   |-- fast_role_swap_current
|   |   |-- operational_current
|   |   |-- unchunked_extended_messages_supported
|   |   |-- unconstrained_power
|   |   |-- usb_communication_capable
|   |   |-- usb_suspend_supported
|   |   `-- voltage
|   |-- 2:variable_supply/
|   |   |-- maximum_voltage
|   |   |-- minimum_voltage
|   |   `-- operational_current
|   `-- 3:battery/
|       |-- maximum_voltage
|       |-- minimum_voltage
|       `-- operational_power
`-- source_capabilities/
    `-- 1:fixed_supply/
        |-- dual_role_data
        |-- dual_role_power
        |-- maximum_current
        |-- unchunked_extended_messages_supported
        |-- unconstrained_power
        |-- usb_communication_capable
        |-- usb_suspend_supported
        `-- voltage

And these are the capabilities of my Thunderbolt3 dock:

/sys/class/typec/port0-partner/usb_power_delivery
|-- revision
|-- sink_capabilities/
|   `-- 1:fixed_supply/
|       |-- dual_role_data
|       |-- dual_role_power
|       |-- fast_role_swap_current
|       |-- operational_current
|       |-- unchunked_extended_messages_supported
|       |-- unconstrained_power
|       |-- usb_communication_capable
|       |-- usb_suspend_supported
|       `-- voltage
`-- source_capabilities/
    |-- 1:fixed_supply/
    |   |-- dual_role_data
    |   |-- dual_role_power
    |   |-- maximum_current
    |   |-- unchunked_extended_messages_supported
    |   |-- unconstrained_power
    |   |-- usb_communication_capable
    |   |-- usb_suspend_supported
    |   `-- voltage
    |-- 2:fixed_supply/
    |   |-- maximum_current
    |   `-- voltage
    |-- 3:fixed_supply/
    |   |-- maximum_current
    |   `-- voltage
    |-- 4:fixed_supply/
    |   |-- maximum_current
    |   `-- voltage
    `-- 5:fixed_supply/
        |-- maximum_current
        `-- voltage

thanks,

Heikki Krogerus (3):
  usb: typec: Separate USB Power Delivery from USB Type-C
  usb: typec: Functions for USB PD capabilities registration
  usb: typec: ucsi: Register USB Power Delivery Capabilities

 Documentation/ABI/testing/sysfs-class-typec   |  22 +
 .../testing/sysfs-devices-usb_power_delivery  | 273 ++++++++
 drivers/usb/typec/Makefile                    |   2 +-
 drivers/usb/typec/class.c                     | 328 +++++++++
 drivers/usb/typec/class.h                     |   8 +
 drivers/usb/typec/pd.c                        | 651 ++++++++++++++++++
 drivers/usb/typec/pd.h                        |  39 ++
 drivers/usb/typec/ucsi/ucsi.c                 | 128 +++-
 drivers/usb/typec/ucsi/ucsi.h                 |   8 +
 include/linux/usb/pd.h                        |  30 +
 include/linux/usb/typec.h                     |  25 +
 11 files changed, 1502 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-usb_power_delivery
 create mode 100644 drivers/usb/typec/pd.c
 create mode 100644 drivers/usb/typec/pd.h

-- 
2.34.1

