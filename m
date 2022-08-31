Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEAE5A7D40
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiHaM10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHaM1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:27:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C44A8D11EB
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:27:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51F6EED1;
        Wed, 31 Aug 2022 05:27:29 -0700 (PDT)
Received: from bogus (unknown [10.57.44.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E4933F766;
        Wed, 31 Aug 2022 05:27:21 -0700 (PDT)
Date:   Wed, 31 Aug 2022 13:26:56 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: Re: [PATCH 6/9] firmware: arm_ffa: Make memory apis ffa_device
 independent
Message-ID: <20220831122656.255o7a7yio5uuik2@bogus>
References: <20220830100700.344594-1-sudeep.holla@arm.com>
 <20220830100700.344594-7-sudeep.holla@arm.com>
 <CAFA6WYOcHGRwkt6PKFEm9did=hO-e1eukK_1M-NWT=79jMS9WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYOcHGRwkt6PKFEm9did=hO-e1eukK_1M-NWT=79jMS9WQ@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 04:16:09PM +0530, Sumit Garg wrote:
> Hi Sudeep,
> 
> On Tue, 30 Aug 2022 at 15:39, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > There is a requirement to make memory APIs independent of the ffa_device.
> > One of the use-case is to have a common memory driver that manages the
> > memory for all the ffa_devices. That commom memory driver won't be a
> 
> s/commom/common/
> 
> > ffa_driver or won't have any ffa_device associated with it. So having
> > these memory APIs accessible without a ffa_device is needed and should
> > be possible as most of these are handled by the partition manager(SPM
> > or hypervisor).
> >
> > Drop the ffa_device argument to the memory APIs and make them ffa_device
> > independent.
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/arm_ffa/driver.c | 6 ++----
> >  drivers/tee/optee/ffa_abi.c       | 2 +-
> >  include/linux/arm_ffa.h           | 6 ++----
> >  3 files changed, 5 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> > index 5f02b670e964..5c8484b05c50 100644
> > --- a/drivers/firmware/arm_ffa/driver.c
> > +++ b/drivers/firmware/arm_ffa/driver.c
> > @@ -640,8 +640,7 @@ static int ffa_sync_send_receive(struct ffa_device *dev,
> >                                        dev->mode_32bit, data);
> >  }
> >
> > -static int
> > -ffa_memory_share(struct ffa_device *dev, struct ffa_mem_ops_args *args)
> > +static int ffa_memory_share(struct ffa_mem_ops_args *args)
> >  {
> >         if (drv_info->mem_ops_native)
> >                 return ffa_memory_ops(FFA_FN_NATIVE(MEM_SHARE), args);
> > @@ -649,8 +648,7 @@ ffa_memory_share(struct ffa_device *dev, struct ffa_mem_ops_args *args)
> >         return ffa_memory_ops(FFA_MEM_SHARE, args);
> >  }
> >
> > -static int
> > -ffa_memory_lend(struct ffa_device *dev, struct ffa_mem_ops_args *args)
> > +static int ffa_memory_lend(struct ffa_mem_ops_args *args)
> >  {
> >         /* Note that upon a successful MEM_LEND request the caller
> >          * must ensure that the memory region specified is not accessed
> > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > index 4c3b5d0008dd..7ec0a2f9a63b 100644
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -294,7 +294,7 @@ static int optee_ffa_shm_register(struct tee_context *ctx, struct tee_shm *shm,
> >         if (rc)
> >                 return rc;
> >         args.sg = sgt.sgl;
> > -       rc = ffa_ops->memory_share(ffa_dev, &args);
> > +       rc = ffa_ops->memory_share(&args);
> >         sg_free_table(&sgt);
> >         if (rc)
> >                 return rc;
> > diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
> > index 556f50f27fb1..eafab07c9f58 100644
> > --- a/include/linux/arm_ffa.h
> > +++ b/include/linux/arm_ffa.h
> > @@ -262,10 +262,8 @@ struct ffa_dev_ops {
> >         int (*sync_send_receive)(struct ffa_device *dev,
> >                                  struct ffa_send_direct_data *data);
> >         int (*memory_reclaim)(u64 g_handle, u32 flags);
> > -       int (*memory_share)(struct ffa_device *dev,
> > -                           struct ffa_mem_ops_args *args);
> > -       int (*memory_lend)(struct ffa_device *dev,
> > -                          struct ffa_mem_ops_args *args);
> > +       int (*memory_share)(struct ffa_mem_ops_args *args);
> > +       int (*memory_lend)(struct ffa_mem_ops_args *args);
> >  };
> >
> 
> Since these are included under "struct ffa_dev_ops", wouldn't it be
> better to rename the struct (ffa_ops?) as well?
>

Makes sense, I just avoided churn. But now I think there is some churn
anyways, so I am happy to rename.

-- 
Regards,
Sudeep
