Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D00B5240B0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349127AbiEKXSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348900AbiEKXSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:18:30 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC18817334C;
        Wed, 11 May 2022 16:18:18 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 57648BB4;
        Thu, 12 May 2022 02:19:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 57648BB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1652311145;
        bh=ckfaK5irrS7Tron+bv7kr4WMcSYdpEv5KvtAmATvlro=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=MnneyUcN2UNKynVPlCvSxFcNAiGO7bkZy1zl1OdjFk7lBl91lL9ty4sGcfNB2TX+5
         SK0iEHSa7/PTAWUFg2e+7NyMOdIfBXi68sewfFb8JlwFYG1uA5xbocH0QbL2A87Yhr
         6SLRspRXgknzwAyDMtOn3Jb5Txi6MBxSqrsgeInM=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 12 May 2022 02:18:17 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 04/23] dt-bindings: ata: sata: Extend number of SATA ports
Date:   Thu, 12 May 2022 02:17:51 +0300
Message-ID: <20220511231810.4928-5-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The denoted in the description upper limit only concerns the Port
Multipliers, but not the actual SATA ports. It's an external device
attached to a SATA port in order to access more than one SATA-drive. So
when it's attached to a SATA port it just extends the port capability
while the number of actual SATA ports stays the same. For instance on AHCI
controllers the number of actual ports is determined by the CAP.NP field
and the PI (Ports Implemented) register. AFAICS in general the maximum
number of SATA ports depends on the particular controller implementation.
Generic AHCI controller can't have more than 32 ports (since CAP.NP is of
5 bits wide and PI register is 32-bits size), while DWC AHCI SATA
controller can't be configured with more than 8 ports activated. So let's
discard the SATA ports reg-property restrictions and just make sure that
it consists of a single reg-item.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Add comma and replace "channel" with "SATA port" in the reg property
  description (@Damien).
---
 Documentation/devicetree/bindings/ata/sata-common.yaml | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/sata-common.yaml b/Documentation/devicetree/bindings/ata/sata-common.yaml
index 7ac77b1c5850..9c9c621761ca 100644
--- a/Documentation/devicetree/bindings/ata/sata-common.yaml
+++ b/Documentation/devicetree/bindings/ata/sata-common.yaml
@@ -41,11 +41,10 @@ patternProperties:
     properties:
       reg:
         minimum: 0
-        maximum: 14
         description:
-          The ID number of the drive port SATA can potentially use a port
-          multiplier making it possible to connect up to 15 disks to a single
-          SATA port.
+          The ID number of the SATA port. Aside with being directly used,
+          each port can have a Port Multiplier attached thus allowing to
+          access more than one drive by means of a single SATA port.
 
 additionalProperties: true
 
-- 
2.35.1

