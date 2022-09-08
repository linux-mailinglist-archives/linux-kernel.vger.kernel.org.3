Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED405B19E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiIHKZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiIHKZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:25:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0E5D76747
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 03:25:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E5C514BF;
        Thu,  8 Sep 2022 03:25:53 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E6063F71A;
        Thu,  8 Sep 2022 03:25:45 -0700 (PDT)
Date:   Thu, 8 Sep 2022 11:25:42 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: Re: [PATCH v3 09/10] firmware: arm_ffa: Set up 32bit execution mode
 flag using partiion property
Message-ID: <20220908102542.a3g22ecjepodtmud@bogus>
References: <20220907145240.1683088-1-sudeep.holla@arm.com>
 <20220907145240.1683088-10-sudeep.holla@arm.com>
 <CAHUa44ETVSsfpnUHWU=cuwZqpQbEUeUVetJMkxyCMrCFt5rM9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHUa44ETVSsfpnUHWU=cuwZqpQbEUeUVetJMkxyCMrCFt5rM9g@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 12:08:00PM +0200, Jens Wiklander wrote:
> On Wed, Sep 7, 2022 at 4:53 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > FF-A v1.1 adds a flag in the partition properties to indicate if the
> > partition runs in the AArch32 or AArch64 execution state. Use the same
> > to set-up the 32-bit execution flag mode in the ffa_dev automatically
> > and ignore any requests to do the same from the ffa_driver.
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/arm_ffa/driver.c | 13 ++++++++++++-
> >  include/linux/arm_ffa.h           |  2 ++
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> > index 42bc22220c69..34e12a2a98fe 100644
> > --- a/drivers/firmware/arm_ffa/driver.c
> > +++ b/drivers/firmware/arm_ffa/driver.c
> > @@ -648,11 +648,19 @@ static int ffa_partition_info_get(const char *uuid_str,
> >         return 0;
> >  }
> >
> > -static void ffa_mode_32bit_set(struct ffa_device *dev)
> > +static void _ffa_mode_32bit_set(struct ffa_device *dev)
> >  {
> >         dev->mode_32bit = true;
> >  }
> >
> > +static void ffa_mode_32bit_set(struct ffa_device *dev)
> > +{
> > +       if (drv_info->version > FFA_VERSION_1_0)
> > +               return;
> > +
> > +       _ffa_mode_32bit_set(dev);
> > +}
> > +
> >  static int ffa_sync_send_receive(struct ffa_device *dev,
> >                                  struct ffa_send_direct_data *data)
> >  {
> > @@ -744,6 +752,9 @@ static void ffa_setup_partitions(void)
> >                                __func__, tpbuf->id);
> >                         continue;
> >                 }
> > +
> > +               if (!(tpbuf->properties & FFA_PARTITION_AARCH64_EXEC))
> > +                       _ffa_mode_32bit_set(ffa_dev);
> 
> For FF-A 1.0 it looks like we change the dev->mode_32bit default value
> from false to true. Or am I missing something?
>

You are right, was trying to avoid additional check on version but we
need that to keep the behaviour unchanged. I will add the check. Thanks
again for spotting this.

-- 
Regards,
Sudeep
