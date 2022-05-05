Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE1951B89C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343603AbiEEHVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiEEHVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:21:02 -0400
Received: from smtp2.math.uni-bielefeld.de (smtp2.math.uni-bielefeld.de [129.70.45.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D313DDCA;
        Thu,  5 May 2022 00:17:22 -0700 (PDT)
Received: from math.uni-bielefeld.de (kvm01.math.uni-bielefeld.de [129.70.45.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by smtp2.math.uni-bielefeld.de (Postfix) with ESMTPSA id 7447B60327;
        Thu,  5 May 2022 09:17:19 +0200 (CEST)
Date:   Thu, 5 May 2022 09:17:18 +0200
From:   Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "H . Nikolaus Schaller" <hns@goldelico.com>,
        Huijin Park <huijin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: core: Restore (almost) the busy polling for
 MMC_SEND_OP_COND
Message-ID: <20220505071718.GA4520@math.uni-bielefeld.de>
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

Hi,

ok, I will test with another beaglebone which has a different emmc chip.

Regards,
Jean Rene
