Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561A6550627
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 18:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbiFRQnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 12:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236690AbiFRQna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 12:43:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87301A1AC;
        Sat, 18 Jun 2022 09:43:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A0E2B80ABD;
        Sat, 18 Jun 2022 16:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A139DC3411F;
        Sat, 18 Jun 2022 16:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655570605;
        bh=XLxsCUvmHdKAGIc4CWlWZtwdR71VaEBXPO7MJuu8wks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NQxAjNrUMfibFqPq05roTlVkKwsOz2wGfsVfjDyuGB2MB4MveC7o2OeSG4s6u8XIB
         43goSMPaJI/SCCH+eNyuDaS8a/Zs38b01BwNTkgfc2I/kdFGZKOdtOBCflOTyfYqJh
         q1sLPJt7gaqWMbU2SRSZAPJwegn+uLySfnOaKw5kdrlkjx2xiJobaxNmSFD6IZFpSE
         PpMIGZKdss9Y0rXOYcfLNL0DbOaUr8BDjjVPktomcOSlpujAzYS6JTeAuY8s6CgTlY
         MDEqJiS4ZWhDFJKNFpdeAsXJ+ChtNHS0E++ch8bZ0ca2709F1tA3EgtJLSzi5bEi6R
         ANzv9apVdLfeg==
Date:   Sat, 18 Jun 2022 17:52:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Aashish Sharma <shraash@google.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-iio@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio:proximity:sx9324: Check ret value of
 device_property_read_u32_array()
Message-ID: <20220618175242.56fd125c@jic23-huawei>
In-Reply-To: <CAPUE2usiMSi-njO5G9wELOdRuL428Vw9BtS4NfbKX1wtVCMaWA@mail.gmail.com>
References: <20220613232224.2466278-1-swboyd@chromium.org>
        <CAPUE2usiMSi-njO5G9wELOdRuL428Vw9BtS4NfbKX1wtVCMaWA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2022 16:25:55 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> On Mon, Jun 13, 2022 at 4:22 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > From: Aashish Sharma <shraash@google.com>
> >
> > 0-day reports:
> >
> > drivers/iio/proximity/sx9324.c:868:3: warning: Value stored
> > to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
> >
> > Put an if condition to break out of switch if ret is non-zero.
> >
> > Signed-off-by: Aashish Sharma <shraash@google.com>
> > Fixes: a8ee3b32f5da ("iio:proximity:sx9324: Add dt_binding support")
> > Reported-by: kernel test robot <lkp@intel.com>
> > [swboyd@chromium.org: Reword commit subject, add fixes tag]
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>  
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> > ---
> >  drivers/iio/proximity/sx9324.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> > index 70c37f664f6d..63fbcaa4cac8 100644
> > --- a/drivers/iio/proximity/sx9324.c
> > +++ b/drivers/iio/proximity/sx9324.c
> > @@ -885,6 +885,9 @@ sx9324_get_default_reg(struct device *dev, int idx,
> >                         break;
> >                 ret = device_property_read_u32_array(dev, prop, pin_defs,
> >                                                      ARRAY_SIZE(pin_defs));
> > +               if (ret)
> > +                       break;
> > +
> >                 for (pin = 0; pin < SX9324_NUM_PINS; pin++)
> >                         raw |= (pin_defs[pin] << (2 * pin)) &
> >                                SX9324_REG_AFE_PH0_PIN_MASK(pin);
> >
> > base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
> > --
> > https://chromeos.dev
> >  

