Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAFF4E9B89
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239179AbiC1PsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbiC1Pp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:45:57 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 803C04A3DA;
        Mon, 28 Mar 2022 08:44:14 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 7701A1E28CC;
        Thu, 24 Mar 2022 03:16:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 7701A1E28CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648080991;
        bh=Ddarqz6yWl3CNiiSUFlRYWuLT76Gegs6a6rX6o/tQTU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=DsGtPsZ0PtgFswFzvF4WBp+8tnGceNwgCeD6PPfjilb3WZBbl0bRB/+7LxTz1WVqq
         wCKDnnpa+j0R/nZwxybfESVQtkwex5+JXRbFsDxe1KxAW3Dhgg6S862E/Y+JrnRPdO
         FRQi15xa/d+j0UALFNLpLYeuy8GN8cYvq8Ep+EJI=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 03:16:31 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 01/21] dt-bindings: ata: sata: Extend number of SATA ports
Date:   Thu, 24 Mar 2022 03:16:08 +0300
Message-ID: <20220324001628.13028-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 Documentation/devicetree/bindings/ata/sata-common.yaml | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/sata-common.yaml b/Documentation/devicetree/bindings/ata/sata-common.yaml
index 7ac77b1c5850..c619f0ae72fb 100644
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
+          The ID number of the SATA port. Aside with being directly used
+          each port can have a Port Multiplier attached thus allowing to
+          access more than one drive by means of a single channel.
 
 additionalProperties: true
 
-- 
2.35.1

