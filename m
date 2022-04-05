Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B1A4F4791
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346111AbiDEVNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452275AbiDEPyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:54:43 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FB35DA5C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:51:25 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id m16so394280plx.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 07:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OsZEVUiyucd4CYGdE5Jlk2g05A03JnAtUb1TW+w00Y8=;
        b=ZtZ3MWw6qYP1UXbPhTnFFPU4FMyRUR75rvtlA0XsnG8VXZ9kykQ2L/1YEIjgP8sAqQ
         gTyFSo9uQuL8STDwE0L2tZjjOCyzDys3UkfaF63WrJurTASlg/Mnkn2KpWuC19l5r4ft
         ICDH0q1bmntaqL0Rr/q5+7FiMw59na+Tvuf9vgKER4nHqdPmqz5dymdcUNr1cOVgogDK
         wogdpdajhDrdzWQNHfB3s/9MEFy5f1rCxK/6AREnrVWoQs4rWsYnRrmST/mIQTB7VNM1
         dxWIfLSzOumZ1E18MVuoP6PIUTsOlCCpxb/RjdNRPp6T1E/LdlrLHZhsWqGbfnauroCH
         mJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OsZEVUiyucd4CYGdE5Jlk2g05A03JnAtUb1TW+w00Y8=;
        b=W1L1T8UtpcF94/u89wgKvb3kwsYYpmoT7v7AM9GcHst9FzHvfVZtSXok46U/HTW7fz
         4sH3vYS4nQQ2BSlJvFXJv/KWx+dN8fTQvXSPP/oLCfHUSyzPgzklRIoob3o9SNrE0R/3
         cfP9v5gBlKifGHOtROocZoPvp9EmSZ1w+/kp+FAHfpvNAyOPTqnV2rWWmuBzr0HeC8ZW
         7ya3I7PoQZ+KpHNyGwLaBnCgutVP3rDxa4sYDZWVykMgtXMZybT8H5N2xmmYR1rPExkV
         Z02MBtRCvrcNTVmD19v4yKhp6+Md/9+OuZ19v0VrLOWfLbUYSZDiEXL2Kk4AEau1/pRo
         SrCw==
X-Gm-Message-State: AOAM530MVTIpxRHiCzcWvgxQVifzl2aakTucXRxrf/Pwn1a6lWbd6opm
        Q1/kVs/IVw3vbwL60MlbgJk+QOtBk/9zNBRv9ERcWvssxZen+Q==
X-Google-Smtp-Source: ABdhPJzJ3xWVvsHccdtjtejgSrIjpMZp9nKP8bgIeNLryT5WFEFjD0HQ4Fnmr5Q1Ixpb4UQE/otj6aSRA+yxd28w0e0=
X-Received: by 2002:a17:90b:4c92:b0:1c7:a9a3:6274 with SMTP id
 my18-20020a17090b4c9200b001c7a9a36274mr4546564pjb.148.1649170284601; Tue, 05
 Apr 2022 07:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220301194830.3557578-1-jens.wiklander@linaro.org>
 <20220301194830.3557578-3-jens.wiklander@linaro.org> <CAFA6WYNj_onTOtETKTLTGG6=GYHMDvty90KftLkfEz_v7nZx9w@mail.gmail.com>
 <20220316092705.GB2535470@jade> <CAFA6WYPDxHz45Ev4yqi0rE4W08YnNbrwUg8FMt9y1FnL3f84yw@mail.gmail.com>
 <CAHUa44EqPprBC_M8vuhxpJE8gVuzbYYitgsvHpRLHWp4-vJnfQ@mail.gmail.com> <CAFA6WYPe2C6Zu0P9NX3X6dGqBs_HSNLYe_1qrW_QiikuKFRoOA@mail.gmail.com>
In-Reply-To: <CAFA6WYPe2C6Zu0P9NX3X6dGqBs_HSNLYe_1qrW_QiikuKFRoOA@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 5 Apr 2022 16:51:13 +0200
Message-ID: <CAHUa44Fr+q6AxAPrYfb4wV3+ZdkX4zd+u8SOv6XoAXsWOB0aZg@mail.gmail.com>
Subject: Re: [PATCH 2/3] optee: add FF-A capability OPTEE_FFA_SEC_CAP_ARG_OFFSET
To:     Sumit Garg <sumit.garg@linaro.org>
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

Hi Sumit,

On Tue, Apr 5, 2022 at 2:26 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Jens,
>
> Apologies for the delay as I was on leave for the past 2 weeks.

No worries, quite understandable.

>
> On Fri, 18 Mar 2022 at 13:19, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > On Thu, Mar 17, 2022 at 1:17 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > On Wed, 16 Mar 2022 at 14:57, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > > >
> > > > On Mon, Mar 14, 2022 at 02:33:26PM +0530, Sumit Garg wrote:
> > > > > On Wed, 2 Mar 2022 at 01:18, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > > > > >
> > > > > > Adds the secure capability OPTEE_FFA_SEC_CAP_ARG_OFFSET to indicate that
> > > > > > OP-TEE with FF-A can support an argument struct at a non-zero offset into
> > > > > > a passed shared memory object.
> > > > > >
> > > > >
> > > > > It isn't clear to me why FF-A ABI requires this capability.
> > > > > shm->offset should be honoured by default, if it isn't then it's a
> > > > > bug.
> > > >
> > > > Yes, there was a bug in secure world when using a non-zero offset. So
> > > > far the driver has always used a zero offset that's why it hasn't been
> > > > caught earlier.
> > > >
> > > > It's not a serious bug, but it might be quite hard to track down. This
> > > > is of course fixed now, but there is a window where it can be triggered.
> > >
> > > I am not able to find the fix in this [1] OP-TEE OS commit. Could you
> > > help me to point it out?
> > >
> > > [1] https://github.com/OP-TEE/optee_os/commit/89d991352352b80ae90f82228a014bb8cadfb80b
> >
> > I believe it's this one:
> > https://github.com/OP-TEE/optee_os/commit/7267624eef019476f20aee7dba11ff949d005670
> >
>
> Which OP-TEE release is affected by this where FF-A functionality is
> fully supported?

3.10.0 to 3.15.0, I'm note sure where to draw the line for fully
supported. But it would be a pity to break 3.14.0 and 3.15.0.

>
> > >
> > > >
> > > > So in order to spare FF-A developers this problem I'm making a non-zero
> > > > offset an extension guarded by a capability bit. Even though this is an
> > > > ABI change it's in practice not since it has been unused and not working
> > > > as expected.
> > > >
> > > > The next commit will start using non-zero offsets if supported, so this
> > > > will change to become a problem (if left unchecked) in the window
> > > > mentioned above.
> > > >
> > > > > AFAIK, FF-A is currently still in its early stages so it
> > > > > shouldn't be that hard to fix bugs in the ABI.
> > > >
> > > > Starting from the kernel release (v5.16) where FF-A support in this
> > > > driver was merged the ABI is supposed to be stable.
> > > >
> > >
> > > From Linux kernel perspective, there are dedicated stable branches for
> > > that purpose in case we want to push a fix for OP-TEE FF-A kernel
> > > driver.
> >
> > The problem isn't in the kernel driver. What I'm doing here is to
> > formalize the ABI that the kernel defacto was using. Since we
> > obviously didn't test the driver with a non-zero offset before, we
> > didn't notice that the offset wasn't used in the right way by the
> > secure world.
>
> My understanding of capabilities is to denote new features rather than
> bug fixes.

If you take the pragmatic approach to this it could be seen as a new
feature, this part of the ABI wasn't used before and had obviously not
been tested either. The only place where it did exist before was in a
comment.

> So I am still not able to make any sense regarding why we
> are abusing capabilities to fix bugs in the ABI. If we find more bugs
> in the FF-A ABI in future then we will be stuck adding new
> capabilities which aren't scalable and unnecessarily complicates
> kernel driver.

This is a balance act, in this case I believe it's worth it. It
doesn't leave any strange artefacts in the ABI.

Others are using OP-TEE for FF-A development without knowing too many
details of how this part works. So breakage here could cause a bit of
trouble for those developers and also give the impression that we
don't care if we break things.

>
> IMO, the best way to maintain a stable ABI would be to create a stable
> release for OP-TEE as well where ABI fixes can be backported.

I disagree, breakage is breakage.

> But
> since we don't have that currently, we have to live with cherry
> picking ABI fixes if we observe issues with earlier OP-TEE releases.

We have so far had zero requests to keep stable branches. I don't
think they would have helped in this case anyway.

Cheers,
Jens

>
> -Sumit
>
> >
> > Cheers,
> > Jens
> >
> > >
> > > -Sumit
> > >
> > > > Thanks,
> > > > Jens
> > > >
> > > > >
> > > > > -Sumit
> > > > >
> > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > ---
> > > > > >  drivers/tee/optee/ffa_abi.c   | 17 +++++++++++++++--
> > > > > >  drivers/tee/optee/optee_ffa.h | 12 +++++++++++-
> > > > > >  2 files changed, 26 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > > > > > index 7686f7020616..cc863aaefcd9 100644
> > > > > > --- a/drivers/tee/optee/ffa_abi.c
> > > > > > +++ b/drivers/tee/optee/ffa_abi.c
> > > > > > @@ -615,12 +615,21 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
> > > > > >                 .data0 = OPTEE_FFA_YIELDING_CALL_WITH_ARG,
> > > > > >                 .data1 = (u32)shm->sec_world_id,
> > > > > >                 .data2 = (u32)(shm->sec_world_id >> 32),
> > > > > > -               .data3 = shm->offset,
> > > > > > +               .data3 = 0,
> > > > > >         };
> > > > > >         struct optee_msg_arg *arg;
> > > > > >         unsigned int rpc_arg_offs;
> > > > > >         struct optee_msg_arg *rpc_arg;
> > > > > >
> > > > > > +       /*
> > > > > > +        * The shared memory object has to start on a page when passed as
> > > > > > +        * an argument struct. This is also what the shm pool allocator
> > > > > > +        * returns, but check this before calling secure world to catch
> > > > > > +        * eventual errors early in case something changes.
> > > > > > +        */
> > > > > > +       if (shm->offset)
> > > > > > +               return -EINVAL;
> > > > > > +
> > > > > >         arg = tee_shm_get_va(shm, 0);
> > > > > >         if (IS_ERR(arg))
> > > > > >                 return PTR_ERR(arg);
> > > > > > @@ -678,6 +687,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
> > > > > >
> > > > > >  static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
> > > > > >                                     const struct ffa_dev_ops *ops,
> > > > > > +                                   u32 *sec_caps,
> > > > > >                                     unsigned int *rpc_param_count)
> > > > > >  {
> > > > > >         struct ffa_send_direct_data data = { OPTEE_FFA_EXCHANGE_CAPABILITIES };
> > > > > > @@ -694,6 +704,7 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
> > > > > >         }
> > > > > >
> > > > > >         *rpc_param_count = (u8)data.data1;
> > > > > > +       *sec_caps = data.data2;
> > > > > >
> > > > > >         return true;
> > > > > >  }
> > > > > > @@ -777,6 +788,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
> > > > > >         struct tee_device *teedev;
> > > > > >         struct tee_context *ctx;
> > > > > >         struct optee *optee;
> > > > > > +       u32 sec_caps;
> > > > > >         int rc;
> > > > > >
> > > > > >         ffa_ops = ffa_dev_ops_get(ffa_dev);
> > > > > > @@ -788,7 +800,8 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
> > > > > >         if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
> > > > > >                 return -EINVAL;
> > > > > >
> > > > > > -       if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &rpc_param_count))
> > > > > > +       if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
> > > > > > +                                    &rpc_param_count))
> > > > > >                 return -EINVAL;
> > > > > >
> > > > > >         optee = kzalloc(sizeof(*optee), GFP_KERNEL);
> > > > > > diff --git a/drivers/tee/optee/optee_ffa.h b/drivers/tee/optee/optee_ffa.h
> > > > > > index ee3a03fc392c..97266243deaa 100644
> > > > > > --- a/drivers/tee/optee/optee_ffa.h
> > > > > > +++ b/drivers/tee/optee/optee_ffa.h
> > > > > > @@ -81,8 +81,16 @@
> > > > > >   *                   as the second MSG arg struct for
> > > > > >   *                   OPTEE_FFA_YIELDING_CALL_WITH_ARG.
> > > > > >   *        Bit[31:8]: Reserved (MBZ)
> > > > > > - * w5-w7: Note used (MBZ)
> > > > > > + * w5:   Bitfield of secure world capabilities OPTEE_FFA_SEC_CAP_* below,
> > > > > > + *       unused bits MBZ.
> > > > > > + * w6-w7: Not used (MBZ)
> > > > > > + */
> > > > > > +/*
> > > > > > + * Secure world supports giving an offset into the argument shared memory
> > > > > > + * object, see also OPTEE_FFA_YIELDING_CALL_WITH_ARG
> > > > > >   */
> > > > > > +#define OPTEE_FFA_SEC_CAP_ARG_OFFSET   BIT(0)
> > > > > > +
> > > > > >  #define OPTEE_FFA_EXCHANGE_CAPABILITIES OPTEE_FFA_BLOCKING_CALL(2)
> > > > > >
> > > > > >  /*
> > > > > > @@ -112,6 +120,8 @@
> > > > > >   *       OPTEE_MSG_GET_ARG_SIZE(num_params) follows a struct optee_msg_arg
> > > > > >   *       for RPC, this struct has reserved space for the number of RPC
> > > > > >   *       parameters as returned by OPTEE_FFA_EXCHANGE_CAPABILITIES.
> > > > > > + *       MBZ unless the bit OPTEE_FFA_SEC_CAP_ARG_OFFSET is received with
> > > > > > + *       OPTEE_FFA_EXCHANGE_CAPABILITIES.
> > > > > >   * w7:    Not used (MBZ)
> > > > > >   * Resume from RPC. Register usage:
> > > > > >   * w3:    Service ID, OPTEE_FFA_YIELDING_CALL_RESUME
> > > > > > --
> > > > > > 2.31.1
> > > > > >
