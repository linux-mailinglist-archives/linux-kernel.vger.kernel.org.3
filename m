Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E705716B9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiGLKJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiGLKJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:09:26 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD06833A22;
        Tue, 12 Jul 2022 03:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1657620535; bh=SJje1dcWCv/G8FpBckYdZrcvEa/vz+8nzhfkgvQz4vA=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=WOi1t895EE6OkJH/S8lHwdFiJZPqwQ+EGmcD2pBlhADcMmGoBOONSIDyAcJKdIK+O
         vZqgTKsuXXQ3sblbdZc6WAuqE5LcU4vs9zZTN+N+TrDt91mB0WogjBW9a9tWFMyytc
         e0nwwZEjZp+3MgYb0gU6SN5Ty32y9/AuIPQfI+3M=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via [213.182.55.207]
        Tue, 12 Jul 2022 12:08:55 +0200 (CEST)
X-EA-Auth: Lakzq13SKui5FfDufYWDeNSfEIECaxJ6n+eBDRF27oEEL78YZNvjGq0P7tqY24Pz1f4tfRG71KDJLGd9kZ+vDSsBlN38KK595l0gppqhmNA=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        hns@goldelico.com
Subject: [PATCH v5 00/12] leds: Fix/Add is31fl319{0,1,3} support
Date:   Tue, 12 Jul 2022 12:08:26 +0200
Message-Id: <20220712100841.1538395-1-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.35.3
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

v5:
- added and tested Andy' series which converts driver to use
  device properties, dev_err_probe, devm_add_action_or_reset
  and simple i2c probe_new:
  https://lore.kernel.org/linux-leds/20220711213524.3587-1-andriy.shevchenko@linux.intel.com/

v4:
- took Andy's comments into account
- add patch 7 for cleanup and formatting fixes

v3:
- pick up Rob's R-b for patches 1 and 2
- reinstate bindings docs license and maintainer
  changes with Nikolaus agreement
- took Andy's comments on patch 4 into account

v2:
- keep original bindings license and maintainer/owner (Rob)
- squash bindings patches 2 & 4 (Krzysztof)

v1-resend:
- no change, resending after configuring git to accomodate
  for smtp provider limit of 5 emails per batch
- just change cover-letter to mention si-en chip for idol347


The is31fl3190, is31fl3191 and is31fl3193 chips (1 or 3 PWM channels)
cannot be handled the same as is31fl3196 and is31fl3199,
if only because the register map is different.
Also:
- the software shutdown bit is reversed
- and additional field needs to be set to enable all channels
- the led-max-microamp current values and setting are not the same

Datasheets:
https://lumissil.com/assets/pdf/core/IS31FL3190_DS.pdf
https://lumissil.com/assets/pdf/core/IS31FL3191_DS.pdf
https://lumissil.com/assets/pdf/core/IS31FL3193_DS.pdf
https://lumissil.com/assets/pdf/core/IS31FL3196_DS.pdf
https://lumissil.com/assets/pdf/core/IS31FL3199_DS.pdf

This series:

- converts dt-bindings to dtschema, adding all si-en compatibles
  for convenience and consistency, and adding constraints on
  supported values for eg. reg address and led-max-microamp

- changes vars, structs and defines to not use 319X suffix
  but 3190 for 319{0,1,3} and 3196 for 319{6,9}

- adds fields in chipdef struct for chip-specific values

- only in patch 6, adds is31fl319{0,1,3} specific values
  so those chips can work.

- patch 7 cleanups parts non touched in previous patches

- patches 8 to 12 are Andy's to modernize the driver

Tested on msm8916-alcatel-idol347, which probably has an
si-en,sn3190 or si-en,sn3191 (only one white led indicator).

Andy Shevchenko (5):
  leds: is31fl319x: Make use of device properties
  leds: is31fl319x: Make use of dev_err_probe()
  leds: is31fl319x: Fix devm vs. non-devm ordering
  leds: is31fl319x: use simple i2c probe function
  leds: is31fl319x: sort header inclusion alphabetically

Vincent Knecht (7):
  dt-bindings: leds: Convert is31fl319x to dtschema
  dt-bindings: leds: is31fl319x: Document variants specificities
  leds: is31fl319x: Add missing si-en compatibles
  leds: is31fl319x: Use non-wildcard names for vars, structs and defines
  leds: is31fl319x: Move chipset-specific values in chipdef struct
  leds: is31fl319x: Add support for is31fl319{0,1,3} chips
  leds: is31fl319x: Cleanup formatting and dev_dbg calls

 .../bindings/leds/issi,is31fl319x.yaml        | 193 +++++++
 .../bindings/leds/leds-is31fl319x.txt         |  61 --
 drivers/leds/Kconfig                          |   2 +-
 drivers/leds/leds-is31fl319x.c                | 533 +++++++++++-------
 4 files changed, 537 insertions(+), 252 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-is31fl319x.txt

-- 
2.35.3



