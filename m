Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1DD46AE28
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 00:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377746AbhLFXFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 18:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376941AbhLFXF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:05:29 -0500
X-Greylist: delayed 930 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Dec 2021 15:02:00 PST
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64882C061746;
        Mon,  6 Dec 2021 15:02:00 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-184-96.tukw.qwest.net [174.21.184.96])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 1052D5B1;
        Mon,  6 Dec 2021 15:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1638831720;
        bh=4dR9lnkIOeqXCHslk6FCmGQHLEGScu+LVOdAQOP7gjk=;
        h=From:To:Cc:Subject:Date:From;
        b=VRaN+AHAEKHneN0mOl2+mKZXNUeUjBBkahSZESWdvXV0SZb/wValXYiZnvsXJNfWP
         Q0PffsXQqbosY5L3EtgrwcycCGW4K5AyroiEZONp0qZevCAFoFj0qd+vYwU9pRPQy7
         HLm9g4d5D1zXnOUW9pGZBZHrDPghtFmga7JW3Ac8=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Zev Weiss <zev@bewilderbeest.net>
Subject: [PATCH v2 0/2] hwmon: Add driver for Delta AHE-50DC fan control module
Date:   Mon,  6 Dec 2021 15:01:51 -0800
Message-Id: <20211206230153.16891-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

These patches add a hwmon driver for the integrated fan control module
in the Delta AHE-50DC Open19 power shelf.  I don't know of a datasheet
any proper documentation for it; the register layout information came
from an existing GPL driver [0] in a code release from LinkedIn.

(Re-sending a v2 after noticing an embarrassing oversight I missed
before sending v1.)


Thanks,
Zev Weiss

Changes since v1 [1]:
 - fixed invalid name warning from __hwmon_device_register()

[0] https://github.com/linkedin/o19-bmc-firmware/blob/master/meta-openbmc/meta-linkedin/meta-deltapower/recipes-kernel/fancontrol-mod/files/fancontrol.c

Zev Weiss (2):
  hwmon: add Delta AHE-50DC fan control module driver
  dt-bindings: add Delta AHE-50DC fan control module

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/delta-ahe50dc-fan.c             | 265 ++++++++++++++++++
 5 files changed, 285 insertions(+)
 create mode 100644 drivers/hwmon/delta-ahe50dc-fan.c

-- 
2.34.1

