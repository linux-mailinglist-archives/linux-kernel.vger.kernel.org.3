Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C92C4FA801
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241874AbiDINKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiDINKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:10:08 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93C521A0DB;
        Sat,  9 Apr 2022 06:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649509674;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Tqhjs3rR9qRggXom5EEFvaE9wCoEVeLmHGqhMiGQer4=;
    b=Lqih0w4ly158jloi3ZVANxbjOt8Idz07du0fIIPKREFn9jDO9wkC7mdVTfIhy8aAzu
    shiob/tXXbzS/Tf24rW0/JkjZPTctTAI6Le1nS9poiKBS4cAdbz/5On3qI8ix2LRBGtx
    oVVtTxFiSKCO8OcogtCjdYzaOGnJ62T94839dho0gpjkuEpBLJLL/mGc4wIUxZIeoakt
    aJSzqLV9aEOwf8AIkUJjnjeFeI2DN8Ir4DPpo7doDDIM6raInqGG1W/P48YN/ETQV3Qe
    EsVXsvDp6mhNckq7SXrDaH6GzIu3cRkaC8Zl9IzF0zLm8isnuomsKmAb2BSaUUw/XWd7
    aa9A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDepmg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy39D7suUQ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 9 Apr 2022 15:07:54 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 10/18] MIPS: DTS: jz4780: fix uart dmas as reported by
 dtbscheck
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <a7a46736-e917-7274-1593-147ed36a2a68@linaro.org>
Date:   Sat, 9 Apr 2022 15:07:53 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <86044652-7B23-4F4D-B60F-C413F3C7BEF1@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
 <00ec9d965cac78b252e14444deed8c93f5116bca.1649443080.git.hns@goldelico.com>
 <a7a46736-e917-7274-1593-147ed36a2a68@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 09.04.2022 um 13:18 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>=20
> On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10030000: 'dmas' is a =
required property
>> 	=46rom schema: =
Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10030000: 'dma-names' is =
a required property
>> 	=46rom schema: =
Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10031000: 'dmas' is a =
required property
>> 	=46rom schema: =
Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10031000: 'dma-names' is =
a required property
>> 	=46rom schema: =
Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10032000: 'dmas' is a =
required property
>> 	=46rom schema: =
Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10032000: 'dma-names' is =
a required property
>> 	=46rom schema: =
Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10033000: 'dmas' is a =
required property
>> 	=46rom schema: =
Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10033000: 'dma-names' is =
a required property
>> 	=46rom schema: =
Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10034000: 'dmas' is a =
required property
>> 	=46rom schema: =
Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10034000: 'dma-names' is =
a required property
>> 	=46rom schema: =
Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>> arch/mips/boot/dts/ingenic/ci20.dtb: i2c@10050000: 'dmas' is a =
required property
>=20
> All these warnings are the same two warnings...

See my earlier explanation that without them you can't verify by just =
reading commit message
and diff that all existing warnings have been addressed.

