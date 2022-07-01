Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A21D563494
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiGANpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiGANpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:45:09 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CC624095;
        Fri,  1 Jul 2022 06:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1656683074; bh=/XIhNMsHfQVnHoWDZvZkTtokLC+p1iZNKAj10GG4dFs=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=CXeaETQDvzvpSjUh5ZX355D1eVfYDPYzgACJBgCKdoTJPon5TcN8k/T/oUdjosoFq
         +gXzt8pUD/wmK01WjfmjU8YwwKFZF5BApHR1YK8+h5/Iz/pBEGHAKc8BaSSFVsH5Mn
         K9h3f6lhJyllyr87/6hNZd0Hdxbr4+n1KQvFRjcI=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via [213.182.55.207]
        Fri,  1 Jul 2022 15:44:34 +0200 (CEST)
X-EA-Auth: lcIWkkblNbzzBCcQkHdR0O3Z4YAtjsrC42K4XxJM9tCOSbHzQ+RnVhXuiGmbEj4DqKkTBMDLwoeOrv1+uKiuCKJoIB3Z146gp51fEw3Liqw=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH v2 0/6] leds: Fix/Add is31fl319{0,1,3} support
Date:   Fri,  1 Jul 2022 15:44:07 +0200
Message-Id: <20220701134415.4017794-1-vincent.knecht@mailoo.org>
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

Changes since v2:
- keep original bindings license and maintainer/owner (Rob)
- squash bindings patches 2 & 4 (Krzysztof)

Changes since v1:
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

- only in the last patch, adds is31fl319{0,1,3} specific values
  so those chips can work.

Tested on msm8916-alcatel-idol347, which probably has an
si-en,sn3190 or si-en,sn3191 (only one white led indicator).

Vincent Knecht (6):
  dt-bindings: leds: Convert is31fl319x to dtschema
  dt-bindings: leds: is31fl319x: Document variants specificities
  leds: is31fl319x: Add missing si-en compatibles
  leds: is31fl319x: Use non-wildcard names for vars, structs and defines
  leds: is31fl319x: Move chipset-specific values in chipdef struct
  leds: is31fl319x: Add support for is31fl319{0,1,3} chips

 .../bindings/leds/issi,is31fl319x.yaml        | 193 +++++++++
 .../bindings/leds/leds-is31fl319x.txt         |  61 ---
 drivers/leds/leds-is31fl319x.c                | 406 +++++++++++++-----
 3 files changed, 488 insertions(+), 172 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-is31fl319x.txt

-- 
2.35.3



