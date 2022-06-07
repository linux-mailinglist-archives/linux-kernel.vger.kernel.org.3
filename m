Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D97753F8EB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbiFGI5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238829AbiFGI5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:57:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4225F5F;
        Tue,  7 Jun 2022 01:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 439D5CE1F23;
        Tue,  7 Jun 2022 08:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D838FC385A5;
        Tue,  7 Jun 2022 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654592241;
        bh=SriLGMk1BgEmrua1TDVNzRa6fB3h+Ll26QQJcP+HNDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJWYGHBtNQdx0J7qIEpwO6vhrp/Tl0F1SJcNDkxO9NAzOwXogsbigd5F9Ks+5mvst
         w1N5QtCnQKPDf2XFar2s3BHWAm1ASs6B2KVSVZbkaQsVjYNFXxNoNEuoLTQdh6Dgob
         clk5qzOieQL4/SJFTnA51YM+Zgg+jgL5ZRZRp6oUGUTB9G4LEXFGDqZlDCgIkuWLAh
         QplGjg5ZcDCLz6lrZN1kx0Tz98WU4D+oehvvI0J0/uiI3wJScLbnRpR+V3GcSx2rwO
         YeESgAFTlpckJtqzydfeRjfeU5d77BJITMMOjQhNhgS1z6oJs1NEoOUfK9KczpYN0G
         sUbOHW80AG+0Q==
Date:   Tue, 7 Jun 2022 14:27:14 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Add support for unprotected spare data page
Message-ID: <20220607085714.GA5410@thinkpad>
References: <20220519190112.6344-1-ansuelsmth@gmail.com>
 <20220603151806.GB26696@thinkpad>
 <629a2806.1c69fb81.591ea.6012@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <629a2806.1c69fb81.591ea.6012@mx.google.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 05:25:56PM +0200, Ansuel Smith wrote:
> On Fri, Jun 03, 2022 at 08:48:06PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, May 19, 2022 at 09:01:10PM +0200, Ansuel Smith wrote:
> > > Some background about this.
> > > On original qsdk ipq8064 based firmware there was a big separation from
> > > boot partition and user partition. With boot partition we refer to
> > > partition used to init the router (bootloader, spm firmware and other
> > > internal stuff) With user partition we refer to linux partition and data
> > > partition not used to init the router.
> > > When someone had to write to these boot partition a special mode was
> > > needed, to switch the nand driver to this special configuration.
> > > 
> > > Upstream version of the nandc driver totally dropped this and the result
> > > is that if someone try to read data from these partition a CRC warning
> > > is printed and if someone try to write that (if for example someone
> > > wants to replace the bootloader) result is a broken system as the data
> > > is badly written.
> > > 
> > 
> > Can you please point me to the downstream/vendor driver that has this
> > implementation?
> > 
> > Thanks,
> > Mani
> >
> 
> Actually found the repo...This is the link [1].
> 
> My implementation is a variant of this since originally they used a
> sysfs entry to swap the ecc configuration.
> 
> [1] https://github.com/marxfang/ipq807x-spf100-cs/blob/master/qsdk/qca/src/linux-4.4/drivers/mtd/nand/qcom_nandc.c
> 

Thanks for the link! After talking internally to Qcom folks, I confirmed
that this quirk is only needed on IPQ8064 based platforms.

More in the driver patch...

Thanks,
Mani

> > > This series comes to fix this.
> > > 
> > > A user can declare offset and size of these special partition using the
> > > qcom,boot-pages binding.
> > > 
> > > An initial implementation of this assumed that the boot-pages started
> > > from the start of the nand but we discover that some device have backup
> > > of these special partition and we can have situation where we have this
> > > partition scheme
> > > - APPSBL (require special mode)
> > > - APPSBLENV (doesn't require special mode)
> > > - ART
> > > - APPSBLBK (back of APPSBL require special mode)
> > > - APPSBLENVBK (back of APPSBLENV doesn't require special mode)
> > > With this configuration we need to declare sparse boot page and we can't
> > > assume boot-pages always starts from the start of the nand.
> > > 
> > > A user can use this form to declare sparse boot pages
> > > qcom,boot-pages = <0x0 0x0c80000 0x0c80000 0x0500000>;
> > > 
> > > The driver internally will parse this array, convert it to nand pages
> > > and check internally on every read/write if this special configuration
> > > should used for that page or the normal one.
> > > 
> > > The reason for all of this is that qcom FOR SOME REASON, disable ECC for
> > > spare data only for these boot partition and we need to reflect this
> > > special configuration to mute these warning and to permit actually
> > > writing to these pages.
> > > 
> > > v4:
> > > - Fix wrong compatible set for boot-pages (ipq8074 instead of ipq806x)
> > > v3:
> > > - Fix typo in Docmunetation commit desription
> > > - Add items description for uint32-matrix
> > > v2:
> > > - Add fixes from Krzysztof in Documentation
> > > 
> > > Ansuel Smith (2):
> > >   mtd: nand: raw: qcom_nandc: add support for unprotected spare data
> > >     pages
> > >   dt-bindings: mtd: qcom_nandc: document qcom,boot-pages binding
> > > 
> > >  .../devicetree/bindings/mtd/qcom,nandc.yaml   |  26 +++
> > >  drivers/mtd/nand/raw/qcom_nandc.c             | 148 +++++++++++++++++-
> > >  2 files changed, 169 insertions(+), 5 deletions(-)
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்
> 
> -- 
> 	Ansuel

-- 
மணிவண்ணன் சதாசிவம்
