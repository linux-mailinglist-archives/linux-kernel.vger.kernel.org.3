Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7BF5B0251
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiIGLEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiIGLEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:04:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61C5013F00
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:04:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F0E61042;
        Wed,  7 Sep 2022 04:04:44 -0700 (PDT)
Received: from bogus (unknown [10.57.45.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 581903F7B4;
        Wed,  7 Sep 2022 04:04:36 -0700 (PDT)
Date:   Wed, 7 Sep 2022 12:04:33 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: Re: [PATCH v2 08/10] firmware: arm_ffa: Add v1.1 get_partition_info
 support
Message-ID: <20220907110433.rnuhlrtjm32w63qz@bogus>
References: <20220902124032.788488-1-sudeep.holla@arm.com>
 <20220902124032.788488-9-sudeep.holla@arm.com>
 <CAHUa44FR7PN99CK6Qq4tSoKWm7uEgctJOLEW5F3jhZhSV19QXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHUa44FR7PN99CK6Qq4tSoKWm7uEgctJOLEW5F3jhZhSV19QXg@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 10:38:05AM +0200, Jens Wiklander wrote:
> On Fri, Sep 2, 2022 at 2:40 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
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
> >  drivers/firmware/arm_ffa/driver.c | 42 +++++++++++++++++++++++++------
> >  include/linux/arm_ffa.h           |  1 +
> >  2 files changed, 35 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> > index 2532e0f16cc9..dd6ab2f81580 100644
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
> > @@ -285,8 +291,18 @@ __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
> >
> >         count = partition_info.a2;
> >
> > +       if (drv_info->version > FFA_VERSION_1_0) {
> > +               size = partition_info.a3;
> > +               if (size > sizeof(*buffer))
> > +                       size = sizeof(*buffer);
> 
> Below when calculating the address in the source buffer with
> "drv_info->rx_buffer + idx * size" you should use the size from
> partition_info.a3 even if it's larger than sizeof(*buffer). The amount
> of bytes to copy looks correct though. Does that make sense?
>

Good spot, I missed to see that. It makes complete sense. I will fix it.

-- 
Regards,
Sudeep
