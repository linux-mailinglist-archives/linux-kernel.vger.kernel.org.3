Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427DA49DD5B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiA0JJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:09:02 -0500
Received: from mxout70.expurgate.net ([194.37.255.70]:47671 "EHLO
        mxout70.expurgate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238225AbiA0JI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:08:59 -0500
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1nD0lv-00081x-CS; Thu, 27 Jan 2022 10:08:51 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1nD0lu-00071D-Hx; Thu, 27 Jan 2022 10:08:50 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id C789E240049;
        Thu, 27 Jan 2022 10:08:49 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 4AC9D240040;
        Thu, 27 Jan 2022 10:08:49 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id CB3F723F59;
        Thu, 27 Jan 2022 10:08:48 +0100 (CET)
From:   Florian Eckert <fe@dev.tdt.de>
To:     pavel@ucw.cz, robh+dt@kernel.org, andy.shevchenko@gmail.com
Cc:     Eckert.Florian@googlemail.com, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 0/2] leds: add ktd20xx LED driver support
Date:   Thu, 27 Jan 2022 10:08:39 +0100
Message-ID: <20220127090841.396-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.dev.tdt.de
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate-ID: 151534::1643274531-0000321A-DA8EF093/0/0
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1: Initial send
v2: Remove variant 1 from source
v3: Changes requested by Andy Shevchenko added. Thanks for reviewing
  - Removing OF dependency
  - Add missing includes
  - Use device_property_read_u32() instead of fwnode_property_read_u32()
  - Use one liner function pattern <test> ? <value-true> : <value-false>
  - Remove switch case call for intensity color selection use BIT()
    instead
  - Remove not needed fwnode_handle_put() in ktd200xx_probe_dt()
    function
  - Use dev_get_drvdata() instead of i2c_get_clientdata() function call
  - Use sysfs_emit() function call
  - Use kstrtobool() function call
  - Remove not needed comma after last array element
  - Use dev_err_probe() instead of dev_error() in driver probe function
  - Do not use dev_group registration function set .dev_groups directly
    into ktd20xx_driver struct.
v4: Changes requested by Andy Shevchenko. Thanks again for your review
  - Fix Author indentation
  - Reduce logging noise
  - Use 'if' standard pattern
  - Use set_bit function to make code cleaner
  - Use meaningful jump labels
  - Updating the logging output to better match the source code
  - Remove duplicate dev pointer usage. This is not necessary as the
    information can be used directly from the client structure
  - Do not hide return value from kstrbool function
  - Do not use mutex_destroy function in devm mananged structs
v5: Changes requested by Andy Shevchenko. Thanks again for your review
so I could learn a lot about good coding style.
  - Update file header
  - Add missing comma to last array element
  - Fix spelling
  - Replace not needed atomic bit set function set_bit() with __set_bit()
  - Use more meaningful goto jump labels
  - Use return statement and not goto jump labels where possible
  - Use probe_new function
  - Use dev_dbg() function instead of dev_info() function in probe

Florian Eckert (2):
  leds: ktd20xx: Extension of the KTD20xx family of LED drivers from
    Kinetic
  dt: bindings: KTD20xx: Introduce the ktd20xx family of RGB drivers

 .../bindings/leds/leds-ktd20xx.yaml           | 130 ++++
 MAINTAINERS                                   |   7 +
 drivers/leds/Kconfig                          |  12 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-ktd20xx.c                   | 572 ++++++++++++++++++
 5 files changed, 722 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-ktd20xx.y=
aml
 create mode 100644 drivers/leds/leds-ktd20xx.c

--=20
2.20.1

