Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2475B0248
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiIGLBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIGLBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:01:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E77CFA00C3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:01:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6967106F;
        Wed,  7 Sep 2022 04:01:53 -0700 (PDT)
Received: from bogus (unknown [10.57.45.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A05D43F7B4;
        Wed,  7 Sep 2022 04:01:45 -0700 (PDT)
Date:   Wed, 7 Sep 2022 12:01:42 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: Re: [PATCH v2 09/10] firmware: arm_ffa: Set up 32bit execution mode
 flag using partiion property
Message-ID: <20220907110142.go33wifjqz7byji6@bogus>
References: <20220902124032.788488-1-sudeep.holla@arm.com>
 <20220902124032.788488-10-sudeep.holla@arm.com>
 <CAHUa44Gq+7_XT2+ccAMxC=ZFh4vV=YuUGLGx0MMYrZ1wne83bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHUa44Gq+7_XT2+ccAMxC=ZFh4vV=YuUGLGx0MMYrZ1wne83bw@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 11:01:27AM +0200, Jens Wiklander wrote:
> On Fri, Sep 2, 2022 at 2:40 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
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
> > index dd6ab2f81580..dbbe15592173 100644
> > --- a/drivers/firmware/arm_ffa/driver.c
> > +++ b/drivers/firmware/arm_ffa/driver.c
> > @@ -647,11 +647,19 @@ static int ffa_partition_info_get(const char *uuid_str,
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
> > @@ -743,6 +751,9 @@ static void ffa_setup_partitions(void)
> >                                __func__, tpbuf->id);
> >                         continue;
> >                 }
> > +
> > +               if (tpbuf->properties & FFA_PARTITION_AARCH64_EXEC)
> 
> Shouldn't this be !(tpbuf->properties & FFA_PARTITION_AARCH64_EXEC)?
> 
> Before this, we used 64-bit calling convention by default for FF-A
> v1.0. I suppose we would like to keep that behaviour.
> 

Correct, it is stupid mistake on my part. I did notice this but somehow
messed up not to add the change I made to test with OPTEE. Thanks for
noticing this.

-- 
Regards,
Sudeep
