Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF6553CAE3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244807AbiFCNtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243775AbiFCNtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:49:39 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC7A60D2;
        Fri,  3 Jun 2022 06:49:38 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 667701BF208;
        Fri,  3 Jun 2022 13:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654264177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HiUwik3EhO3JFdFLVKOMNj1TCjCKUI8ClkdISKetXBM=;
        b=ZitsYbiDmmu0QEQK0tHpWRWxB7TnWCpnSoq+I8d/Yfc1w3sKzRu52h9LAQSX3QtsiTl4yW
        RfP1AIS5Ni/6TnYd7o6XZy49Wk9HcVTkBZok3zncudqlUJjpTvUK8vsRz5wd78QethutFq
        dLa2BLrsBHb76V05calbgIZQ+t1d+Sm+1DnUiM7ciXsMY9MspfTQEWNbecXprMnwd58/0e
        bFqsUzOchOw+jNW5/N7uS90b5+5eAS08VeFMLT1865QackX9G017RfeWTnGGNBruv/P2Em
        rBcOeXkxqak6EQ1TyuwG9i+rdzOUtSDsbGRL7k7K330Sl8Hf27EEHsXQfIwv3A==
Date:   Fri, 3 Jun 2022 15:49:34 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Add support for unprotected spare data page
Message-ID: <20220603154934.521c57ab@xps-13>
In-Reply-To: <20220519190112.6344-1-ansuelsmth@gmail.com>
References: <20220519190112.6344-1-ansuelsmth@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ansuelsmth@gmail.com wrote on Thu, 19 May 2022 21:01:10 +0200:

> Some background about this.
> On original qsdk ipq8064 based firmware there was a big separation from
> boot partition and user partition. With boot partition we refer to
> partition used to init the router (bootloader, spm firmware and other
> internal stuff) With user partition we refer to linux partition and data
> partition not used to init the router.
> When someone had to write to these boot partition a special mode was
> needed, to switch the nand driver to this special configuration.
>=20
> Upstream version of the nandc driver totally dropped this and the result
> is that if someone try to read data from these partition a CRC warning
> is printed and if someone try to write that (if for example someone
> wants to replace the bootloader) result is a broken system as the data
> is badly written.
>=20
> This series comes to fix this.
>=20
> A user can declare offset and size of these special partition using the
> qcom,boot-pages binding.
>=20
> An initial implementation of this assumed that the boot-pages started
> from the start of the nand but we discover that some device have backup
> of these special partition and we can have situation where we have this
> partition scheme
> - APPSBL (require special mode)
> - APPSBLENV (doesn't require special mode)
> - ART
> - APPSBLBK (back of APPSBL require special mode)
> - APPSBLENVBK (back of APPSBLENV doesn't require special mode)
> With this configuration we need to declare sparse boot page and we can't
> assume boot-pages always starts from the start of the nand.
>=20
> A user can use this form to declare sparse boot pages
> qcom,boot-pages =3D <0x0 0x0c80000 0x0c80000 0x0500000>;
>=20
> The driver internally will parse this array, convert it to nand pages
> and check internally on every read/write if this special configuration
> should used for that page or the normal one.
>=20
> The reason for all of this is that qcom FOR SOME REASON, disable ECC for
> spare data only for these boot partition and we need to reflect this
> special configuration to mute these warning and to permit actually
> writing to these pages.

Manivannan, any feedback on this?

>=20
> v4:
> - Fix wrong compatible set for boot-pages (ipq8074 instead of ipq806x)
> v3:
> - Fix typo in Docmunetation commit desription
> - Add items description for uint32-matrix
> v2:
> - Add fixes from Krzysztof in Documentation
>=20
> Ansuel Smith (2):
>   mtd: nand: raw: qcom_nandc: add support for unprotected spare data
>     pages
>   dt-bindings: mtd: qcom_nandc: document qcom,boot-pages binding
>=20
>  .../devicetree/bindings/mtd/qcom,nandc.yaml   |  26 +++
>  drivers/mtd/nand/raw/qcom_nandc.c             | 148 +++++++++++++++++-
>  2 files changed, 169 insertions(+), 5 deletions(-)
>=20

Thanks,
Miqu=C3=A8l
