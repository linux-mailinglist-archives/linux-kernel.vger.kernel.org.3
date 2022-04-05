Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C814F47F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350233AbiDEVYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388266AbiDENVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:21:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CF013F2D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:26:17 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bx5so11672526pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 05:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5KL0ee/AppbKXePsSBmnRvStv4NbqnXDS7jHW3F+nXI=;
        b=ScSkyGU1CbBkZQO4h9mDmWafDbdnFEcmpKO7djlTiyfRz+OHcmTLGswUkNvndh7YPG
         U+V6Eu6e2claFWm0DSTQGNfQNMqVWQZQJptXSbCn5zGzTqkVg6vGqA8EnbRq06IpSH6l
         vIuUlaFLymQnDUD4I9wQyU/yV3yeKX+xwS+kP6zryq6M2ex3T7hMyQ1FGFPmYjrt/vk7
         QpFY5EWkUKnHPn7snQf5jK8vw7Zbqg3NRHcAlw0zFQ6WHEKaKl30bQ3ZrkL4H1soW+qG
         UH6gMhOxk48aOD8fiAHKwjwcgm7TN4tsWCWQcZDABXmFlpUmucRj8oQIynVCjPoP3145
         ji6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5KL0ee/AppbKXePsSBmnRvStv4NbqnXDS7jHW3F+nXI=;
        b=eMNSk8Ep5npJJQ3Ys57GA4iUJT29vSZS1f1dmp1IQkCvj5AkbR4oJfDrdgooBpOrLv
         RQEX8+anpyVm0p28kNySovxEpWaiwNGaE0PxHMm7IaJg/FDhs+jIhxvZJd/gDGclEwjz
         jWwIkfj6mW91fsFjt/FWD9HVQWgzN+CQapnkTzo6WSAPjwk7xD998TRsM/kJdXon24kN
         f9qeEmuedzLonwMzNCHjnc8eQEZL6axVnZQ+uE6XNnVTHc4ah/eW5bGUzAmcLtyEnw3Z
         KkMtSNRZIVdk01Akq/NO/zsY9WJnyBFilbzV9CLs+bG3ryHCWSuwvXmwvv49t6TYErh/
         qDoQ==
X-Gm-Message-State: AOAM5307UBgEKRcIKzfw6tj8nfSOrIz5+td3Ir9LEt3rMQkSgE0cD7It
        LxZIxVwteK0CON6AeDvLfMLyUZzLATnaaTLuHDukH8KHpcQqmWd3
X-Google-Smtp-Source: ABdhPJyYwRX37NFd4LyoiPDW3Av80Qpd7HFCd+j7lHda96j0aauhz3Ssn5Iko0ntrWOig3V5bG2sV2Jr+1/qIRHor8c=
X-Received: by 2002:a17:902:b103:b0:156:c7bb:a852 with SMTP id
 q3-20020a170902b10300b00156c7bba852mr3216635plr.29.1649161577166; Tue, 05 Apr
 2022 05:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220301194830.3557578-1-jens.wiklander@linaro.org>
 <20220301194830.3557578-3-jens.wiklander@linaro.org> <CAFA6WYNj_onTOtETKTLTGG6=GYHMDvty90KftLkfEz_v7nZx9w@mail.gmail.com>
 <20220316092705.GB2535470@jade> <CAFA6WYPDxHz45Ev4yqi0rE4W08YnNbrwUg8FMt9y1FnL3f84yw@mail.gmail.com>
 <CAHUa44EqPprBC_M8vuhxpJE8gVuzbYYitgsvHpRLHWp4-vJnfQ@mail.gmail.com>
In-Reply-To: <CAHUa44EqPprBC_M8vuhxpJE8gVuzbYYitgsvHpRLHWp4-vJnfQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 5 Apr 2022 17:56:06 +0530
Message-ID: <CAFA6WYPe2C6Zu0P9NX3X6dGqBs_HSNLYe_1qrW_QiikuKFRoOA@mail.gmail.com>
Subject: Re: [PATCH 2/3] optee: add FF-A capability OPTEE_FFA_SEC_CAP_ARG_OFFSET
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

Apologies for the delay as I was on leave for the past 2 weeks.

On Fri, 18 Mar 2022 at 13:19, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> On Thu, Mar 17, 2022 at 1:17 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > On Wed, 16 Mar 2022 at 14:57, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > >
> > > On Mon, Mar 14, 2022 at 02:33:26PM +0530, Sumit Garg wrote:
> > > > On Wed, 2 Mar 2022 at 01:18, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > > > >
> > > > > Adds the secure capability OPTEE_FFA_SEC_CAP_ARG_OFFSET to indicate that
> > > > > OP-TEE with FF-A can support an argument struct at a non-zero offset into
> > > > > a passed shared memory object.
> > > > >
> > > >
> > > > It isn't clear to me why FF-A ABI requires this capability.
> > > > shm->offset should be honoured by default, if it isn't then it's a
> > > > bug.
> > >
> > > Yes, there was a bug in secure world when using a non-zero offset. So
> > > far the driver has always used a zero offset that's why it hasn't been
> > > caught earlier.
> > >
> > > It's not a serious bug, but it might be quite hard to track down. This
> > > is of course fixed now, but there is a window where it can be triggered.
> >
> > I am not able to find the fix in this [1] OP-TEE OS commit. Could you
> > help me to point it out?
> >
> > [1] https://github.com/OP-TEE/optee_os/commit/89d991352352b80ae90f82228a014bb8cadfb80b
>
> I believe it's this one:
> https://github.com/OP-TEE/optee_os/commit/7267624eef019476f20aee7dba11ff949d005670
>

Which OP-TEE release is affected by this where FF-A functionality is
fully supported?

> >
> > >
> > > So in order to spare FF-A developers this problem I'm making a non-zero
> > > offset an extension guarded by a capability bit. Even though this is an
> > > ABI change it's in practice not since it has been unused and not working
> > > as expected.
> > >
> > > The next commit will start using non-zero offsets if supported, so this
> > > will change to become a problem (if left unchecked) in the window
> > > mentioned above.
> > >
> > > > AFAIK, FF-A is currently still in its early stages so it
> > > > shouldn't be that hard to fix bugs in the ABI.
> > >
> > > Starting from the kernel release (v5.16) where FF-A support in this
> > > driver was merged the ABI is supposed to be stable.
> > >
> >
> > From Linux kernel perspective, there are dedicated stable branches for
> > that purpose in case we want to push a fix for OP-TEE FF-A kernel
> > driver.
>
> The problem isn't in the kernel driver. What I'm doing here is to
> formalize the ABI that the kernel defacto was using. Since we
> obviously didn't test the driver with a non-zero offset before, we
> didn't notice that the offset wasn't used in the right way by the
> secure world.

My understanding of capabilities is to denote new features rather than
bug fixes. So I am still not able to make any sense regarding why we
are abusing capabilities to fix bugs in the ABI. If we find more bugs
in the FF-A ABI in future then we will be stuck adding new
capabilities which aren't scalable and unnecessarily complicates
kernel driver.

IMO, the best way to maintain a stable ABI would be to create a stable
release for OP-TEE as well where ABI fixes can be backported. But
since we don't have that currently, we have to live with cherry
picking ABI fixes if we observe issues with earlier OP-TEE releases.

-Sumit

>
> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > > Thanks,
> > > Jens
> > >
> > > >
> > > > -Sumit
> > > >
> > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > ---
> > > > >  drivers/tee/optee/ffa_abi.c   | 17 +++++++++++++++--
> > > > >  drivers/tee/optee/optee_ffa.h | 12 +++++++++++-
> > > > >  2 files changed, 26 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > > > > index 7686f7020616..cc863aaefcd9 100644
> > > > > --- a/drivers/tee/optee/ffa_abi.c
> > > > > +++ b/drivers/tee/optee/ffa_abi.c
> > > > > @@ -615,12 +615,21 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
> > > > >                 .data0 = OPTEE_FFA_YIELDING_CALL_WITH_ARG,
> > > > >                 .data1 = (u32)shm->sec_world_id,
> > > > >                 .data2 = (u32)(shm->sec_world_id >> 32),
> > > > > -               .data3 = shm->offset,
> > > > > +               .data3 = 0,
> > > > >         };
> > > > >         struct optee_msg_arg *arg;
> > > > >         unsigned int rpc_arg_offs;
> > > > >         struct optee_msg_arg *rpc_arg;
> > > > >
> > > > > +       /*
> > > > > +        * The shared memory object has to start on a page when passed as
> > > > > +        * an argument struct. This is also what the shm pool allocator
> > > > > +        * returns, but check this before calling secure world to catch
> > > > > +        * eventual errors early in case something changes.
> > > > > +        */
> > > > > +       if (shm->offset)
> > > > > +               return -EINVAL;
> > > > > +
> > > > >         arg = tee_shm_get_va(shm, 0);
> > > > >         if (IS_ERR(arg))
> > > > >                 return PTR_ERR(arg);
> > > > > @@ -678,6 +687,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
> > > > >
> > > > >  static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
> > > > >                                     const struct ffa_dev_ops *ops,
> > > > > +                                   u32 *sec_caps,
> > > > >                                     unsigned int *rpc_param_count)
> > > > >  {
> > > > >         struct ffa_send_direct_data data = { OPTEE_FFA_EXCHANGE_CAPABILITIES };
> > > > > @@ -694,6 +704,7 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
> > > > >         }
> > > > >
> > > > >         *rpc_param_count = (u8)data.data1;
> > > > > +       *sec_caps = data.data2;
> > > > >
> > > > >         return true;
> > > > >  }
> > > > > @@ -777,6 +788,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
> > > > >         struct tee_device *teedev;
> > > > >         struct tee_context *ctx;
> > > > >         struct optee *optee;
> > > > > +       u32 sec_caps;
> > > > >         int rc;
> > > > >
> > > > >         ffa_ops = ffa_dev_ops_get(ffa_dev);
> > > > > @@ -788,7 +800,8 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
> > > > >         if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
> > > > >                 return -EINVAL;
> > > > >
> > > > > -       if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &rpc_param_count))
> > > > > +       if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
> > > > > +                                    &rpc_param_count))
> > > > >                 return -EINVAL;
> > > > >
> > > > >         optee = kzalloc(sizeof(*optee), GFP_KERNEL);
> > > > > diff --git a/drivers/tee/optee/optee_ffa.h b/drivers/tee/optee/optee_ffa.h
> > > > > index ee3a03fc392c..97266243deaa 100644
> > > > > --- a/drivers/tee/optee/optee_ffa.h
> > > > > +++ b/drivers/tee/optee/optee_ffa.h
> > > > > @@ -81,8 +81,16 @@
> > > > >   *                   as the second MSG arg struct for
> > > > >   *                   OPTEE_FFA_YIELDING_CALL_WITH_ARG.
> > > > >   *        Bit[31:8]: Reserved (MBZ)
> > > > > - * w5-w7: Note used (MBZ)
> > > > > + * w5:   Bitfield of secure world capabilities OPTEE_FFA_SEC_CAP_* below,
> > > > > + *       unused bits MBZ.
> > > > > + * w6-w7: Not used (MBZ)
> > > > > + */
> > > > > +/*
> > > > > + * Secure world supports giving an offset into the argument shared memory
> > > > > + * object, see also OPTEE_FFA_YIELDING_CALL_WITH_ARG
> > > > >   */
> > > > > +#define OPTEE_FFA_SEC_CAP_ARG_OFFSET   BIT(0)
> > > > > +
> > > > >  #define OPTEE_FFA_EXCHANGE_CAPABILITIES OPTEE_FFA_BLOCKING_CALL(2)
> > > > >
> > > > >  /*
> > > > > @@ -112,6 +120,8 @@
> > > > >   *       OPTEE_MSG_GET_ARG_SIZE(num_params) follows a struct optee_msg_arg
> > > > >   *       for RPC, this struct has reserved space for the number of RPC
> > > > >   *       parameters as returned by OPTEE_FFA_EXCHANGE_CAPABILITIES.
> > > > > + *       MBZ unless the bit OPTEE_FFA_SEC_CAP_ARG_OFFSET is received with
> > > > > + *       OPTEE_FFA_EXCHANGE_CAPABILITIES.
> > > > >   * w7:    Not used (MBZ)
> > > > >   * Resume from RPC. Register usage:
> > > > >   * w3:    Service ID, OPTEE_FFA_YIELDING_CALL_RESUME
> > > > > --
> > > > > 2.31.1
> > > > >
