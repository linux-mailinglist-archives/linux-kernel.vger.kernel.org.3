Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391F4490901
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiAQMsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:48:09 -0500
Received: from mxout70.expurgate.net ([194.37.255.70]:54313 "EHLO
        mxout70.expurgate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiAQMsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:48:02 -0500
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1n9RQM-0002RA-QZ; Mon, 17 Jan 2022 13:47:50 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1n9RQM-0004Sq-0f; Mon, 17 Jan 2022 13:47:50 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id A708424004B;
        Mon, 17 Jan 2022 13:47:49 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 295D0240049;
        Mon, 17 Jan 2022 13:47:49 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id B822320BBE;
        Mon, 17 Jan 2022 13:47:48 +0100 (CET)
From:   Florian Eckert <fe@dev.tdt.de>
To:     pavel@ucw.cz, robh+dt@kernel.org, andy.shevchenko@gmail.com
Cc:     Eckert.Florian@googlemail.com, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] leds: add ktd20xx LED driver support
Date:   Mon, 17 Jan 2022 13:47:39 +0100
Message-ID: <20220117124741.7165-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.dev.tdt.de
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-ID: 151534::1642423670-00005ED7-CD8F2A4E/0/0
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing the KTD2061/58/59/60 RGB LED drivers. The difference in
these are the address numbers on the I2C bus that the device listens to.

Due to the hardware limitation, we can only set 7 colors and the color
black (LED off) for each LED independently and not the full RGB range.

v1: Initial send
v2: Remove variant 1 from source
v3: Changes requested by Andy Shevchenko added. Thanks for reviewing
  - Removing OF dependency
  - Add missing includes
  - Use device_property_read_u32() instead of fwnode_property_read_u32()
  - Use one liner function pattern <test> ? <value-true> : <value-false>
  - Remove switch case call for intensity color selection use BIT()
    instead
  - Remove not needed fwnode_handle_put() in ktd200xx_probe_dt() function
  - Use dev_get_drvdata() instead of i2c_get_clientdata() function call
  - Use sysfs_emit() function call
  - Use kstrtobool() function call
  - Remove not needed comma after last array element
  - Use dev_err_probe() instead of dev_error() in driver probe function
  - Do not use dev_group registration function set .dev_groups directly
    into ktd20xx_driver struct.

Florian Eckert (2):
  leds: ktd20xx: Extension of the KTD20xx family of LED drivers from
    Kinetic
  dt: bindings: KTD20xx: Introduce the ktd20xx family of RGB drivers

 .../bindings/leds/leds-ktd20xx.yaml           | 130 ++++
 MAINTAINERS                                   |   7 +
 drivers/leds/Kconfig                          |  12 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-ktd20xx.c                   | 580 ++++++++++++++++++
 5 files changed, 730 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-ktd20xx.y=
aml
 create mode 100644 drivers/leds/leds-ktd20xx.c

--=20
2.20.1

