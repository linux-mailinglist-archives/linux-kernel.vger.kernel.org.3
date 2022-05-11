Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B95A522C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiEKGqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242315AbiEKGq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:46:27 -0400
Received: from smtp2.math.uni-bielefeld.de (smtp2.math.uni-bielefeld.de [129.70.45.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0F533A37;
        Tue, 10 May 2022 23:46:22 -0700 (PDT)
Received: from math.uni-bielefeld.de (kvm01.math.uni-bielefeld.de [129.70.45.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by smtp2.math.uni-bielefeld.de (Postfix) with ESMTPSA id 8825060283;
        Wed, 11 May 2022 08:46:18 +0200 (CEST)
Date:   Wed, 11 May 2022 08:46:17 +0200
From:   Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "H . Nikolaus Schaller" <hns@goldelico.com>,
        Huijin Park <huijin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: core: Restore (almost) the busy polling for
 MMC_SEND_OP_COND
Message-ID: <20220511064617.GA28982@math.uni-bielefeld.de>
References: <20220304105656.149281-1-ulf.hansson@linaro.org>
 <CAPDyKFr1PzSaiKqB4ZoqTS_8bGsEH=aB3ARhxyGu+cYeRqeBew@mail.gmail.com>
 <20220504054652.GA7851@math.uni-bielefeld.de>
 <CAPDyKFrBVyYx+BybGR2P8paS6qA=V2EHAXH+vPUc9JzxoXn6+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrBVyYx+BybGR2P8paS6qA=V2EHAXH+vPUc9JzxoXn6+g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ulf Hansson wrote on Wed  4/05/22 11:08:
> On Wed, 4 May 2022 at 07:46, Jean Rene Dawin
> <jdawin@math.uni-bielefeld.de> wrote:
> >
> > Ulf Hansson wrote on Mon  7/03/22 13:17:
> > > On Fri, 4 Mar 2022 at 11:57, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > Commit 76bfc7ccc2fa ("mmc: core: adjust polling interval for CMD1"),
> > > > significantly decreased the polling period from ~10-12ms into just a couple
> > > > of us. The purpose was to decrease the total time spent in the busy polling
> > > > loop, but unfortunate it has lead to problems, that causes eMMC cards to
> > > > never gets out busy and thus fails to be initialized.
> > > >
> > > > To fix the problem, but also to try to keep some of the new improved
> > > > behaviour, let's start by using a polling period of 1-2ms, which then
> > > > increases for each loop, according to common polling loop in
> > > > __mmc_poll_for_busy().
> > > >
> > > > Reported-by: Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
> > > > Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> > > > Cc: Huijin Park <huijin.park@samsung.com>
> > > > Fixes: 76bfc7ccc2fa ("mmc: core: adjust polling interval for CMD1")
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >
> > > > Jean Rene and H. Nikolaus, if this doesn't work, please try extending the
> > > > the MMC_OP_COND_PERIOD_US a bit, to so see if we can find a value that always
> > > > works.
> > > >
> > > > Kind regards
> > > > Uffe
> >
> > >
> > > Applied for fixes and by adding two tested-by tags from you, thanks!
> > >
> > > Kind regards
> > > Uffe
> >
> > Hi,
> >
> > with the current value of MMC_OP_COND_PERIOD_US = 1ms I still see
> >
> > mmc1: Card stuck being busy! __mmc_poll_for_busy
> > mmc1: error -110 doing runtime resume
> >
> > regularly. The same with 2ms. Setting it to 4ms makes the messages go
> > away. Would it be ok to increase MMC_OP_COND_PERIOD_US to 4ms?
> 
> It doesn't look like we have a very good alternative - unless the
> problem is tied to a particular type of eMMC card, is it? (If so, we
> can add a card-quirk).
> 
> The only other option I see, would then be to add a generic DT
> property for eMMCs, that allows us to specify the OP_COND polling
> period for it. See
> Documentation/devicetree/bindings/mmc/mmc-card.yaml.
> 
> Kind regards
> Uffe

Hi,

I tested 2 beaglebones now - one with Micron eMMC and the other with Kingston.
With the Kingston chip I don't get the errors. So it seems to be card specific.

Grepping for mmc in dmesg gives the following.

Beaglebone with Micron eMMC:

  sdhci-omap 481d8000.mmc: supply pbias not found, using dummy regulator
  sdhci-omap 481d8000.mmc: supply vqmmc not found, using dummy regulator
  mmc1: SDHCI controller on 481d8000.mmc [481d8000.mmc] using External DMA
  mmc1: new high speed MMC card at address 0001
  mmcblk1: mmc1:0001 MMC04G 3.66 GiB
   mmcblk1: p1
  mmcblk1boot0: mmc1:0001 MMC04G 1.00 MiB
  mmcblk1boot1: mmc1:0001 MMC04G 1.00 MiB
  mmcblk1rpmb: mmc1:0001 MMC04G 128 KiB, chardev (247:0)
  sdhci-omap 48060000.mmc: Got CD GPIO
  sdhci-omap 48060000.mmc: supply pbias not found, using dummy regulator
  sdhci-omap 48060000.mmc: supply vqmmc not found, using dummy regulator
  mmc0: SDHCI controller on 48060000.mmc [48060000.mmc] using External DMA


Beaglebone with Kingston eMMC:

  sdhci-omap 481d8000.mmc: supply pbias not found, using dummy regulator
  sdhci-omap 481d8000.mmc: supply vqmmc not found, using dummy regulator
  mmc1: SDHCI controller on 481d8000.mmc [481d8000.mmc] using External DMA
  mmc1: new high speed MMC card at address 0001
  mmcblk1: mmc1:0001 M62704 3.56 GiB
   mmcblk1: p1
  mmcblk1boot0: mmc1:0001 M62704 2.00 MiB
  mmcblk1boot1: mmc1:0001 M62704 2.00 MiB
  mmcblk1rpmb: mmc1:0001 M62704 512 KiB, chardev (247:0)
  sdhci-omap 48060000.mmc: Got CD GPIO
  sdhci-omap 48060000.mmc: supply pbias not found, using dummy regulator
  sdhci-omap 48060000.mmc: supply vqmmc not found, using dummy regulator
  mmc0: SDHCI controller on 48060000.mmc [48060000.mmc] using External DMA

Is this enough information to identify the mmc card?

Regards,
Jean Rene
