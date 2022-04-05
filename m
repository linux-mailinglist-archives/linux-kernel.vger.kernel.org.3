Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1F74F4F7C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838375AbiDFAvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389856AbiDENeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:34:23 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03813139CFF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:40:39 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x16so6614743pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 05:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O295TERmSEiaGSry+lZK0X4S0zzObJ9nsqJalatHIYY=;
        b=wQhhHT/dndRHehjWR0VTXVsOIvA69O68tzmCRZtiDsz0+K46Qamk6rxhSLDNvvDTbq
         CFOYMoEVX6O2RTz/Tw/vImGPpcOB2VcyOAWwg4SsHyI7glC2h3kpJEkNXalSwqX1aKW4
         GVRl5QuM6zGAjG1svYmaaDhXDzOJQ0TAMY0Xtbfztus+PxxI+THRla2wzhoJ+q2DQUnv
         5G91nJ90nRVHrXe02Lu1/BOg+sF9+6knfXeVGFUhJXtj1sWTbsq+HKO7j/PaG5wUr6cR
         ni1XTC+MotHUalcvYqHpG7kyiE1so1EywotH78ArGKzvy+P7sjq/HXo1svjVBLJepwcn
         ddKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O295TERmSEiaGSry+lZK0X4S0zzObJ9nsqJalatHIYY=;
        b=zTNiZAMvQC64xhpyorJPKzW9mCIGaAKBXgmn5yuI9Vi003ICDzpAwuEnNK6QBL9JZu
         HYF1NrVM6DGIg7r5EGLaOXIySZ3Um89Jym2fxnvjKxsVYoDEdlZGfB4+zPZZH0/q/5E8
         uKn0d0JEilaKgUpYAFInBRiNkqx5mLelDozh6bTRbJaHt5HNTfKOGIjR5Oo8kmSXI8Os
         LNKTxhRPtK6ggh/jgzsVymoyYyYRVh9pRxXLlmpeEkGpNBvPlgaPORshj9u2tHcb0UhX
         PoAkIthsSnqLRBC4+N3p39NhmEGerFSkfTCWCmUFMEPQddL4AssRyNhrnskh7s61HfjO
         Be5A==
X-Gm-Message-State: AOAM533ldmfAsP1fWwCnFQOArAU6HmDWUrAcT90IL5W7uesuUDYgNE3P
        2OfsxlpeYpqYmgOkoAW40ix0hQheFd3pAqajfbNNKInX6ch9bg==
X-Google-Smtp-Source: ABdhPJzbnZLCfSgkkNCJW8qRE5/beGJQzRShJdfHTNwkxTokTCDOlphjbFdSBSX/ZblitCeb9Qbkbh3shl27e9UhBnI=
X-Received: by 2002:a65:6a97:0:b0:398:ae2:d207 with SMTP id
 q23-20020a656a97000000b003980ae2d207mr2635655pgu.197.1649162438404; Tue, 05
 Apr 2022 05:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220301194830.3557578-1-jens.wiklander@linaro.org>
 <20220301194830.3557578-2-jens.wiklander@linaro.org> <CAFA6WYMzwbX5OUgpxptAxy-uphTU4rMVJOxkzFHb+oYD0SN-sQ@mail.gmail.com>
 <20220316081728.GA2535470@jade> <CAFA6WYPYE1Ggs+6GB5Z9aMVcFjrS8mOm4LbggBocti+Yvz8idA@mail.gmail.com>
 <CAHUa44G8brKgzV9DdriHD+aN_=k5K9gECvurk+hmK0y-NqF+rA@mail.gmail.com>
In-Reply-To: <CAHUa44G8brKgzV9DdriHD+aN_=k5K9gECvurk+hmK0y-NqF+rA@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 5 Apr 2022 18:10:27 +0530
Message-ID: <CAFA6WYMCfev_xsB7y57n-G05-vi4kKWQ=RwQFyM4dPzeASog5w@mail.gmail.com>
Subject: Re: [PATCH 1/3] optee: add OPTEE_SMC_CALL_WITH_RPC_ARG
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

On Fri, 18 Mar 2022 at 12:59, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> On Thu, Mar 17, 2022 at 12:40 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > On Wed, 16 Mar 2022 at 13:47, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> [snip]
> > > > > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> > > > > index d44a6ae994f8..378741a459b6 100644
> > > > > --- a/drivers/tee/optee/optee_smc.h
> > > > > +++ b/drivers/tee/optee/optee_smc.h
> > > > > @@ -107,14 +107,22 @@ struct optee_smc_call_get_os_revision_result {
> > > > >  /*
> > > > >   * Call with struct optee_msg_arg as argument
> > > > >   *
> > > > > - * When calling this function normal world has a few responsibilities:
> > > > > + * When called with OPTEE_SMC_CALL_WITH_RPC_ARG or
> > > > > + * OPTEE_SMC_CALL_WITH_REGD_ARG in a0 there is one RPC struct optee_msg_arg
> > > > > + * following after the first struct optee_msg_arg. The RPC struct
> > > > > + * optee_msg_arg has reserved space for the number of RPC parameters as
> > > > > + * returned by OPTEE_SMC_EXCHANGE_CAPABILITIES.
> > > > > + *
> > > > > + * When calling these functions normal world has a few responsibilities:
> > > > >   * 1. It must be able to handle eventual RPCs
> > > > >   * 2. Non-secure interrupts should not be masked
> > > > >   * 3. If asynchronous notifications has been negotiated successfully, then
> > > > > - *    asynchronous notifications should be unmasked during this call.
> > > > > + *    the interrupt for asynchronous notifications should be unmasked
> > > > > + *    during this call.
> > > > >   *
> > > > > - * Call register usage:
> > > > > - * a0  SMC Function ID, OPTEE_SMC*CALL_WITH_ARG
> > > > > + * Call register usage, OPTEE_SMC_CALL_WITH_ARG and
> > > > > + * OPTEE_SMC_CALL_WITH_RPC_ARG:
> > > > > + * a0  SMC Function ID, OPTEE_SMC_CALL_WITH_ARG or OPTEE_SMC_CALL_WITH_RPC_ARG
> > > > >   * a1  Upper 32 bits of a 64-bit physical pointer to a struct optee_msg_arg
> > > > >   * a2  Lower 32 bits of a 64-bit physical pointer to a struct optee_msg_arg
> > > > >   * a3  Cache settings, not used if physical pointer is in a predefined shared
> > > > > @@ -122,6 +130,15 @@ struct optee_smc_call_get_os_revision_result {
> > > > >   * a4-6        Not used
> > > > >   * a7  Hypervisor Client ID register
> > > > >   *
> > > > > + * Call register usage, OPTEE_SMC_CALL_WITH_REGD_ARG:
> > > >
> > > > Although I didn't see any reference to OPTEE_SMC_CALL_WITH_REGD_ARG in
> > > > the commit message, but do we really need to introduce it? Wouldn't it
> > > > be possible to just pass additional "shared memory cookie" value as
> > > > part of "Not used" (a4-6) arguments?
> > >
> > > I'll update the commit message to mention OPTEE_SMC_CALL_WITH_REGD_ARG
> > > too. I think it's more clear with a separate ID for this, less risk of
> > > confusion.
> >
> > IMO, it would unnecessarily complicate and introduce ambiguity in the
> > ABI as after this patch we will have:
> >
> > CALL_WITH_ARG: Standard arguments *without* pre-allocated RPC arguments buffer
> > CALL_WITH_RPC_ARG: Standard arguments *with* pre-allocated RPC arguments buffer
> > CALL_WITH_REGD_ARG: Registered arguments but *not* explicit whether
> > RPC arguments buffer is there or not.
>
> CALL_WITH_REGD_ARG is quite explicit in the description above (in the patch):
>  * When called with OPTEE_SMC_CALL_WITH_RPC_ARG or
>  * OPTEE_SMC_CALL_WITH_REGD_ARG in a0 there is one RPC struct optee_msg_arg
>  * following after the first struct optee_msg_arg. The RPC struct
>  * optee_msg_arg has reserved space for the number of RPC parameters as
>  * returned by OPTEE_SMC_EXCHANGE_CAPABILITIES.
>
> I chose to use two new SMC IDs to have one clear purpose for each.
>
> I preferred the name OPTEE_SMC_CALL_WITH_REGD_ARG instead of
> OPTEE_SMC_CALL_WITH_REGD_RPC_ARG since I thought the former was long
> enough.
>
> >
> > If we keep the ABI simplified to say we only support two types of
> > invocation irrespective of whether the arguments are allocated from
> > statically shared memory or dynamically shared memory:
> >
> > CALL_WITH_ARG: Standard arguments *without* pre-allocated RPC arguments buffer
> > CALL_WITH_RPC_ARG: Standard arguments *with* pre-allocated RPC arguments buffer
>
> That's only simple on the surface. When looking into the details of
> CALL_WITH_RPC_ARG you'd need a more complicated register usage since
> the function would be doing two different things.
>
> >
> > > How would the callee know if it's the cookie or the physical
> > > address it should use?  Whatever we do, we're extenting the ABI.
> > >
> >
> > Isn't it possible for OP-TEE to determine if it's a valid cookie or
> > not which will be passed into currently unused arguments?
>
> Actually, we need three registers, one to pass the offset in too.

Okay, fair enough I am fine with your preferred approach in this patch.

-Sumit

>
> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > > >
> > > > > + * a0  SMC Function ID, OPTEE_SMC_CALL_WITH_REGD_ARG
> > > > > + * a1  Upper 32 bits of a 64-bit shared memory cookie
> > > > > + * a2  Lower 32 bits of a 64-bit shared memory cookie
> > > > > + * a3  Offset of the struct optee_msg_arg in the shared memory with the
> > > > > + *     supplied cookie
> > > > > + * a4-6        Not used
> > > > > + * a7  Hypervisor Client ID register
> > > > > + *
> > > > >   * Normal return register usage:
> > > > >   * a0  Return value, OPTEE_SMC_RETURN_*
> > > > >   * a1-3        Not used
> > > > > @@ -154,6 +171,10 @@ struct optee_smc_call_get_os_revision_result {
> > > > >  #define OPTEE_SMC_FUNCID_CALL_WITH_ARG OPTEE_MSG_FUNCID_CALL_WITH_ARG
> > > > >  #define OPTEE_SMC_CALL_WITH_ARG \
> > > > >         OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_ARG)
> > > > > +#define OPTEE_SMC_CALL_WITH_RPC_ARG \
> > > > > +       OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG)
> > > > > +#define OPTEE_SMC_CALL_WITH_REGD_ARG \
> > > > > +       OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG)
> > > > >
