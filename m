Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E945E50E0B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbiDYMwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiDYMwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:52:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62976FB3A8;
        Mon, 25 Apr 2022 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650890989; x=1682426989;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IQAaH6AfCWrFMKcxYIvjsJFZxL3TSSAFCIkxYVb1JK0=;
  b=Fw2uT0xNLT2Yff/dyxoYTzybs14CLR/oIxqsL0HHhrRWO6n6k73wMVVN
   6yasPlXVzndj/KGCgsnqYXvYE0yiAmnTeSCYgWdcJKq/Hxlum5EOPqtQR
   ct7HRiX95rTkf+MfGzhOEKpyEUCBQoVMgBObabcMVnB7BUe1QucsAnmsy
   h18RF9f4DNfiNYWZorlftieD4F8VHaET6720auZl6DHTy4/lYy9GmIGSf
   dIX/Lw/C1PYxNNtdKoGlWhhC1F2nEcHsdxPw0MAsO5F5xi4kncmTnsSNj
   EvZymFKFOQDz4RRqstwz/uQReA8dIxFz2lf+agZ05HX5VZEp5pfoncDWV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="264086893"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208,217";a="264086893"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 05:49:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208,217";a="704544204"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Apr 2022 05:49:46 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jameson Thies <jthies@google.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Won Chung <wonchung@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] usb: typec: Separate USB PD from USB Type-C
Date:   Mon, 25 Apr 2022 15:49:43 +0300
Message-Id: <20220425124946.13064-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now everything is a device. There are now other changes.


v2 cover letter:

In this version the USB Power Delivery support is now completely
separated into its own little subsystem. The USB Power Delivery
objects are not devices, but they are also no longer tied to any
device by default. This change makes it possible to share the USB PD
objects between multiple devices on top of being able to select the
objects that we want the device to use.

The USB Power Delivery objects are now placed under
/sys/kernel/usb_power_delivery directory. As an example:

        /sys/kernel/usb_power_delivery/pd0

So now that pd0 can be linked to a device, or devices, that want (or
can) use it to negotiate the USB PD contract with. An example where
two devices share the PD:

        /sys/class/typec/port0/usb_power_delivery -> ../../../../../../../kernel/usb_power_delivery/pd0
        /sys/class/typec/port1/usb_power_delivery -> ../../../../../../../kernel/usb_power_delivery/pd0

I did not change the directory hierarchy at all, because I'm assuming
that it is not a problem anymore:

        pd0/<message>/<object>/<field>

On top of that change, I also switched to tcpm.c from ucsi.c as
the first user of this thing.


v1 cover letter:

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


Heikki Krogerus (3):
  usb: typec: Separate USB Power Delivery from USB Type-C
  usb: typec: USB Power Deliver helpers for ports and partners
  usb: typec: tcpm: Register USB Power Delivery Capabilities

 Documentation/ABI/testing/sysfs-class-typec   |   8 +
 .../testing/sysfs-class-usb_power_delivery    | 240 ++++++
 drivers/usb/typec/Makefile                    |   2 +-
 drivers/usb/typec/class.c                     | 148 ++++
 drivers/usb/typec/class.h                     |   4 +
 drivers/usb/typec/pd.c                        | 721 ++++++++++++++++++
 drivers/usb/typec/pd.h                        |  30 +
 drivers/usb/typec/tcpm/tcpm.c                 | 142 +++-
 include/linux/usb/pd.h                        |  35 +
 include/linux/usb/typec.h                     |  22 +
 10 files changed, 1350 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-usb_power_delivery
 create mode 100644 drivers/usb/typec/pd.c
 create mode 100644 drivers/usb/typec/pd.h

-- 
2.35.1

