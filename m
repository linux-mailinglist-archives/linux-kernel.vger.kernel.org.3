Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69835128BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 03:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbiD1Bas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiD1Bao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:30:44 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D556D1B9;
        Wed, 27 Apr 2022 18:27:30 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-163-222.tukw.qwest.net [174.21.163.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id EFB171B3;
        Wed, 27 Apr 2022 18:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1651109250;
        bh=A1Z73Wico87e026F2N4Y7a2Kb+H2CHDRz2kb7e46jU4=;
        h=From:To:Cc:Subject:Date:From;
        b=DPXv6L82Dify6oPeSv02IxzMqu3IqbenHRyjyVcaV8L/a1rJktzBHDxbX1V+D42yw
         bkTvGM5X57skuUnxpVeE8H8C0AtQiKOmzHNrRTUITsuw1bYQXiwhublcc59H+FyFNc
         J98XX6PXdFNtdMRh8h2As4wApB9RN7RoRlCUuDsI=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>, Renze Nicolai <renze@rnplus.nl>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v5 0/2] hwmon: (nct6775) Add i2c driver
Date:   Wed, 27 Apr 2022 18:27:05 -0700
Message-Id: <20220428012707.24921-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series contains the remaining two outstanding patches adding i2c
support to the nct6775 hwmon driver.

Changes since v4 [0]:
 - Added missing type $ref to nuvoton,tsi-channel-mask property in DT
   binding [Krzysztof, Rob's bot]
 - Added 'F:' line for nuvoton,nct6775.yaml DT binding file to
   MAINTAINERS

The first patch adds a DT binding for the Nuvoton Super I/O chips
supported by the nct6775 driver; the second adds an i2c hwmon driver
wrapped around the new nct6775-core module.

(Since the preparatory work for this that comprised the bulk of the
previous iterations of the series is now in Guenter's hwmon-next tree
this is a somewhat abridged cover letter; see [0] for additional
background info if needed.)

[0] https://lore.kernel.org/linux-hwmon/20220427010154.29749-1-zev@bewilderbeest.net/

Zev Weiss (2):
  dt-bindings: hwmon: Add nuvoton,nct6775
  hwmon: (nct6775) Add i2c driver

 .../bindings/hwmon/nuvoton,nct6775.yaml       |  57 +++++
 MAINTAINERS                                   |   7 +
 drivers/hwmon/Kconfig                         |  17 ++
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/nct6775-i2c.c                   | 195 ++++++++++++++++++
 5 files changed, 277 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
 create mode 100644 drivers/hwmon/nct6775-i2c.c

-- 
2.36.0

