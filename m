Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AC051CCB5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386765AbiEEXaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbiEEX3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:29:53 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C0E606F8;
        Thu,  5 May 2022 16:26:12 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-163-222.tukw.qwest.net [174.21.163.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 03B2E82;
        Thu,  5 May 2022 16:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1651793169;
        bh=/Xk4DKaWHUitl1juhvwHhfIvdU91KEzdlhHggT1WDy4=;
        h=From:To:Cc:Subject:Date:From;
        b=JpaK6KYJJ/EgkoQcbkRGEs7Nr3zdqZ9VL0Ibo+U5Ayu00YuiDfkbMFsjvwXmUhTOe
         6VtDNd8pCKi32gCvZYn6KOdJv70Nz6kzUkWmTfBjG+s5iPvnceWR2EKP7wCpD7+Vo+
         jiuXANOBDLN02Eu6nm+jCVKZAMXzXgcK2YgJ5p0o=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Zev Weiss <zev@bewilderbeest.net>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] extcon: Add extcon-regulator driver
Date:   Thu,  5 May 2022 16:25:55 -0700
Message-Id: <20220505232557.10936-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a restructured v2 of a series adding support for
regulator-supplied power output connectors.

Changes since v1 [0, 1]:
 - Dropped regulator-external-output DT property [Mark]
 - Moved DT binding to connector/regulator-connector.yaml [Krzysztof]
 - Dropped EXTERNAL_GET type and other regulator-core changes

This driver aims to support hardware where a regulator supplies a
power output connector, such as a power outlet on a DC power
distribution unit (PDU).  (The specific system I'm targeting at the
moment is the Delta AHE-50DC Open19 power shelf [2], for which I'm
working on a port of OpenBMC.)

Patch 1 adds the regulator-connector DT binding, with a single
property specifying the regulator supplying the connector's output
power, and patch 2 adds an extcon driver (extcon-regulator).  The
driver currently doesn't actually do much extcon-wise, because the
AHE-50DC hardware is quite minimal and doesn't really offer much for
it to do, but if other similar devices in the future do have
additional functionality to support (such as a presence-detection
mechanism) the driver can be extended to add that.


Thanks,
Zev

[0] https://lore.kernel.org/openbmc/20220504065041.6718-1-zev@bewilderbeest.net/
[1] https://lore.kernel.org/openbmc/20220504065252.6955-1-zev@bewilderbeest.net/
[2] https://www.open19.org/marketplace/delta-16kw-power-shelf/

Zev Weiss (2):
  dt-bindings: connector: Add regulator-connector binding
  extcon: Add extcon-regulator driver

 .../ABI/testing/sysfs-driver-extcon-regulator |   8 ++
 .../connector/regulator-connector.yaml        |  38 +++++
 MAINTAINERS                                   |   8 ++
 drivers/extcon/Kconfig                        |   8 ++
 drivers/extcon/Makefile                       |   1 +
 drivers/extcon/extcon-regulator.c             | 133 ++++++++++++++++++
 6 files changed, 196 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-extcon-regulator
 create mode 100644 Documentation/devicetree/bindings/connector/regulator-connector.yaml
 create mode 100644 drivers/extcon/extcon-regulator.c

-- 
2.36.0

