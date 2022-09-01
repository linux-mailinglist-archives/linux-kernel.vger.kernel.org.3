Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0515A9295
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiIAI70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbiIAI6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:58:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07B1B130A14
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:58:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFC80D6E;
        Thu,  1 Sep 2022 01:58:29 -0700 (PDT)
Received: from bogus (unknown [10.57.46.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89F223F766;
        Thu,  1 Sep 2022 01:58:21 -0700 (PDT)
Date:   Thu, 1 Sep 2022 09:57:56 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: Re: [PATCH 7/9] firmware: arm_ffa: Add v1.1 get_partition_info
 support
Message-ID: <20220901085756.ymk3rd7zjqvjpaj6@bogus>
References: <20220830100700.344594-1-sudeep.holla@arm.com>
 <20220830100700.344594-8-sudeep.holla@arm.com>
 <CAHUa44Fmr=vDLbST5qwTDOtSZJq4RYqO+Y4Pij64VeBU-0BgrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHUa44Fmr=vDLbST5qwTDOtSZJq4RYqO+Y4Pij64VeBU-0BgrQ@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:43:58AM +0200, Jens Wiklander wrote:
> On Tue, Aug 30, 2022 at 12:07 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > FF-A v1.1 adds support to discovery the UUIDs of the partitions that was
> > missing in v1.0 and which the driver workarounds by using UUIDs supplied
> > by the ffa_drivers.
> >
> > Add the v1.1 get_partition_info support and disable the workaround if
> > the detected FF-A version is greater than v1.0.
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/arm_ffa/driver.c | 39 ++++++++++++++++++++++++-------
> >  include/linux/arm_ffa.h           |  1 +
> >  2 files changed, 32 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> > index 5c8484b05c50..6822241168d6 100644
> > --- a/drivers/firmware/arm_ffa/driver.c
> > +++ b/drivers/firmware/arm_ffa/driver.c
> > @@ -264,18 +264,24 @@ static int ffa_rxtx_unmap(u16 vm_id)
> >         return 0;
> >  }
> >
> > +#define PARTITION_INFO_GET_RETURN_COUNT_ONLY   BIT(0)
> > +
> >  /* buffer must be sizeof(struct ffa_partition_info) * num_partitions */
> >  static int
> >  __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
> >                          struct ffa_partition_info *buffer, int num_partitions)
> >  {
> > -       int count;
> > +       int idx, count, flags = 0, size;
> >         ffa_value_t partition_info;
> >
> > +       if (!buffer || !num_partitions) /* Just get the count for now */
> > +               flags = PARTITION_INFO_GET_RETURN_COUNT_ONLY;
> > +
> >         mutex_lock(&drv_info->rx_lock);
> >         invoke_ffa_fn((ffa_value_t){
> >                       .a0 = FFA_PARTITION_INFO_GET,
> >                       .a1 = uuid0, .a2 = uuid1, .a3 = uuid2, .a4 = uuid3,
> > +                     .a5 = flags,
> >                       }, &partition_info);
> >
> >         if (partition_info.a0 == FFA_ERROR) {
> > @@ -285,8 +291,15 @@ __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
> >
> >         count = partition_info.a2;
> >
> > +       if (drv_info->version > FFA_VERSION_1_0)
> > +               size = partition_info.a3;
> 
> What happens if this value is larger than sizeof(struct ffa_partition_info)?
> 

Right, I had the check for both 0 size and size > struct size. I removed
both at once instead of just dropping 0 size. I assume 0 size is non
compliant or do you prefer to keep that check as well.

Thanks a lot for the reviews.

-- 
Regards,
Sudeep
