Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D026848559E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241259AbiAEPQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:16:15 -0500
Received: from aposti.net ([89.234.176.197]:42226 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237011AbiAEPQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:16:08 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, list@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 0/2] hwmon: Add "label" attribute v2
Date:   Wed,  5 Jan 2022 15:15:49 +0000
Message-Id: <20220105151551.20285-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean, Guenter,

A V2 of my patchset which allows specifying a hwmon device's label from
Device Tree. When the "label" device property is present, its value is
exported to the userspace via the "label" sysfs attribute.

This is useful for userspace to be able to identify an individual device
when multiple individual chips are present in the system.

Note that this mechanism already exists in IIO.

Patch [1/2] documents the ABI change.
Patch [2/2] adds the change to the core drivers/hwmon/hwmon.c file.

Changes from v1:
- The label is cached into the hwmon_device structure
- hwmon_dev_name_is_visible() renamed to hwmon_dev_attr_is_visible()
- Add missing <linux/property.h> include
- The DT binding documentation of the "label" property has been dropped,
  and the "label" property is now supported directly in dtschema.

Cheers,
-Paul


Paul Cercueil (2):
  ABI: hwmon: Document "label" sysfs attribute
  hwmon: Add "label" attribute

 Documentation/ABI/testing/sysfs-class-hwmon |  8 +++++
 Documentation/hwmon/sysfs-interface.rst     |  4 +++
 drivers/hwmon/hwmon.c                       | 34 +++++++++++++++++++--
 3 files changed, 43 insertions(+), 3 deletions(-)

-- 
2.34.1

