Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059A053CB95
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 16:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245114AbiFCOeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 10:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244009AbiFCOeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 10:34:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C551A5045E;
        Fri,  3 Jun 2022 07:34:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52E86616F9;
        Fri,  3 Jun 2022 14:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDC3C385A9;
        Fri,  3 Jun 2022 14:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654266857;
        bh=3nAELPzfAqOQmMeq44MqN+8FRP1GoZ6OQ7z/q+8F6nE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XH0DMFMPOaK4wqwPXozOLeoRU+BC9lC/4jjMf8Ss8jxwAImkqjIqfZy5jOSObMEw3
         MktfV//vAQ0NbofATGFbRO5O8D3bJG/J06Ainax6o3NAaAEHHLonj5OCDp7DuODnbs
         1VKxKZ6rChwetbrDOF80MsnQZsG4gGnYnjBOzPzn8GTeEZVj8iX1sTgZRx61sjsFbU
         IIGG/yCeqP9fDpRIlgv3PPVT5oT9gPYI/gfSE1Nkac3pTOl74HzozkA3u4dSRyoXsw
         fi76rV1bOrhDcp1TwwVq62G5W0QVSQA5aCuCW+7nEwufMxI3m3AkvRCIdacVXBk6bf
         SFGf3+R3I32Pw==
Date:   Fri, 3 Jun 2022 20:04:10 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Add support for unprotected spare data page
Message-ID: <20220603143410.GA26696@thinkpad>
References: <20220519190112.6344-1-ansuelsmth@gmail.com>
 <20220603154934.521c57ab@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220603154934.521c57ab@xps-13>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 03:49:34PM +0200, Miquel Raynal wrote:
> Hi,
> 
> ansuelsmth@gmail.com wrote on Thu, 19 May 2022 21:01:10 +0200:
> 
> > Some background about this.
> > On original qsdk ipq8064 based firmware there was a big separation from
> > boot partition and user partition. With boot partition we refer to
> > partition used to init the router (bootloader, spm firmware and other
> > internal stuff) With user partition we refer to linux partition and data
> > partition not used to init the router.
> > When someone had to write to these boot partition a special mode was
> > needed, to switch the nand driver to this special configuration.
> > 
> > Upstream version of the nandc driver totally dropped this and the result
> > is that if someone try to read data from these partition a CRC warning
> > is printed and if someone try to write that (if for example someone
> > wants to replace the bootloader) result is a broken system as the data
> > is badly written.
> > 
> > This series comes to fix this.
> > 
> > A user can declare offset and size of these special partition using the
> > qcom,boot-pages binding.
> > 
> > An initial implementation of this assumed that the boot-pages started
> > from the start of the nand but we discover that some device have backup
> > of these special partition and we can have situation where we have this
> > partition scheme
> > - APPSBL (require special mode)
> > - APPSBLENV (doesn't require special mode)
> > - ART
> > - APPSBLBK (back of APPSBL require special mode)
> > - APPSBLENVBK (back of APPSBLENV doesn't require special mode)
> > With this configuration we need to declare sparse boot page and we can't
> > assume boot-pages always starts from the start of the nand.
> > 
> > A user can use this form to declare sparse boot pages
> > qcom,boot-pages = <0x0 0x0c80000 0x0c80000 0x0500000>;
> > 
> > The driver internally will parse this array, convert it to nand pages
> > and check internally on every read/write if this special configuration
> > should used for that page or the normal one.
> > 
> > The reason for all of this is that qcom FOR SOME REASON, disable ECC for
> > spare data only for these boot partition and we need to reflect this
> > special configuration to mute these warning and to permit actually
> > writing to these pages.
> 
> Manivannan, any feedback on this?
> 

Sorry for the delay. I will check internally on some of the unknown
implementations mentioned and provide my comments.

Thanks,
Mani

> > 
> > v4:
> > - Fix wrong compatible set for boot-pages (ipq8074 instead of ipq806x)
> > v3:
> > - Fix typo in Docmunetation commit desription
> > - Add items description for uint32-matrix
> > v2:
> > - Add fixes from Krzysztof in Documentation
> > 
> > Ansuel Smith (2):
> >   mtd: nand: raw: qcom_nandc: add support for unprotected spare data
> >     pages
> >   dt-bindings: mtd: qcom_nandc: document qcom,boot-pages binding
> > 
> >  .../devicetree/bindings/mtd/qcom,nandc.yaml   |  26 +++
> >  drivers/mtd/nand/raw/qcom_nandc.c             | 148 +++++++++++++++++-
> >  2 files changed, 169 insertions(+), 5 deletions(-)
> > 
> 
> Thanks,
> Miquèl

-- 
மணிவண்ணன் சதாசிவம்
