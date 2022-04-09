Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D2C4FA7F2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbiDINFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbiDINFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:05:30 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F19A2E75B8;
        Sat,  9 Apr 2022 06:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649509393;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=rwP1PfSTltvcRR6mih3jkGO1WnpeEa3IZvGppCpeSaE=;
    b=EEa+Smrb/wPpNcugEK1ZmgSV0Dbx1u+WOarVLqlFwHIdEacolVC/YkyZGYZYOMabqy
    A/DEkdY8KUyUOsVEEOAHmY/rYg9Ml8dFmsyH3EqtWwqFIhT17NZvnBupq6MIL7nFrJ3M
    uOGOC21GrbI4jhs8b+WO/oYq7vRL4TjndZ45d688f64lvmoCNn9mxJ2D0myML9OwZrfF
    CBL4RJhyUezc/VsMZfT3/pcrWGMWw7lq1ij4nz3putFTHmgCbgsei7LODsveNG9cCCQ7
    eE3SnpdcTGZAZEuHrgDW4VA2x+bUSdBzSl/tG1q6KfOuAaEf/9g9i6WiMGd43udIDaXw
    Oofg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDepmg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy39D3DuU0
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 9 Apr 2022 15:03:13 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 03/18] MIPS: DTS: jz4780: fix tcu timer as reported by
 dtbscheck
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <e5ea96d8-f8c9-b925-04ee-81e80e30a5d0@linaro.org>
Date:   Sat, 9 Apr 2022 15:03:12 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A023438A-B8A8-4F91-BA25-7BE9A76C6730@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
 <c48277625f0ab5afc86d89deb1b87537e9c592f6.1649443080.git.hns@goldelico.com>
 <e5ea96d8-f8c9-b925-04ee-81e80e30a5d0@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 09.04.2022 um 13:11 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>=20
> On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
>> arch/mips/boot/dts/ingenic/ci20.dtb: timer@10002000: compatible: =
'oneOf' conditional failed, one must be fixed:
>> 	['ingenic,jz4780-tcu', 'ingenic,jz4770-tcu', 'simple-mfd'] is =
too long
>> 	'ingenic,jz4780-tcu' is not one of ['ingenic,jz4740-tcu', =
'ingenic,jz4725b-tcu', 'ingenic,jz4760-tcu', 'ingenic,x1000-tcu']
>> 	'simple-mfd' was expected
>> 	'ingenic,jz4760-tcu' was expected
>=20
> Trim it a bit...
>=20
>> 	=46rom schema: =
Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
>=20
> You need to explain this. You're changing the effective compatible of
> the device and doing so based only on schema warning does not look
> enough. Please write real reason instead of this fat warning, e.g. =
that
> both devices are actually compatible and this has no real effect =
except
> schema checks.

both use jz4740_soc_info / jz4770_soc_info and there is no =
ingenic,jz4780-tcu...
So it doesn't change function, just makes it fit to the bindings.

We could solve it differently add ingenic,jz4780-tcu to bindings and the
driver compatible table.=
