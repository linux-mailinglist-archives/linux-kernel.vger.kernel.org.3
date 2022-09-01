Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5845A95C5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiIALc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiIALcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:32:24 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E09115194
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:32:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id t129so17191095pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 04:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=K3i/UnosIGJmKHVXhTeIIT/EaYH6kdVXUlLCkIMVqnU=;
        b=pzclts0pBjC1mJuS2/XVUv7o720uiS/bdOOt0wDqSm8l97sMFWum+pj8X0+qaJhipv
         MivWx7XNY9lDogeh0ZO/hPmFuet9doSXc2a4PUwyQ3mJ6itcVnIyD8vtdLLIs+NpNm9W
         xCCT00fJANCHQlPpvDd/xnSwT/oxFMMbJ3GcXV1JOat4/wA56ASdQqEckSJ05oCE+IjV
         8SUTrpyu1UwSj/dOCkfXLF3/yuw3nWSox1YaqG3OsxWce1tYpKhT24rKhq3D9uMEpDBF
         3M08rGLx8auZQXaIH8xBLQg8a4XcDQewHx2UeyzgY5CzihDrUqOFAQBXbsbcyB+rpUWi
         IzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=K3i/UnosIGJmKHVXhTeIIT/EaYH6kdVXUlLCkIMVqnU=;
        b=qjx69PVNgjB/aZMyoZDNrSLRVU1bWztRVU+CLcxJLAH3kiSMXuzcMW4NvR2X4Glmop
         mitTjKWySBgp+U2AuzysKquKBXEdyIuvUD8op+4JuNH1WJ1rJQtfxZYGnujpkVtVThBc
         tguZIo9NphAV+YpAfRYj6mI+Fpx21whHiW2U2xCssbsWd+jYVQIDaoKdfXkvMOh9Kv1+
         7F88zNOhlELoEurMN33Ld/enb5KYq1LJBHHWtgSagwWkCE5xt7wzMHkAEjsLivProF2D
         YvsG7XrLURVslyEnu7DrWLOwrzkMt3UX2dGjCQRLP+hkRlyIrsJCZyQ4M72B56nubsyA
         RwGQ==
X-Gm-Message-State: ACgBeo1tZ8AAO7vPAAo/6TrXu4/qGYFqFo3zI6RqHc7cqQPL/6aDN5od
        oMAfM4uNkhjwGsp9bCMJs4LBXkZ/Qo9b9d8GFISsyJOrsmI=
X-Google-Smtp-Source: AA6agR7cggWLq6Teq4ickfIqTGCbUEH378WddiLgRvIIekyZtZ/i5myX/SljLHlUEJUVxA2ygg3O6ddkALMFrlS4iv8=
X-Received: by 2002:a63:5809:0:b0:42a:3145:507d with SMTP id
 m9-20020a635809000000b0042a3145507dmr25265572pgb.428.1662031941547; Thu, 01
 Sep 2022 04:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220830100700.344594-1-sudeep.holla@arm.com> <20220830100700.344594-5-sudeep.holla@arm.com>
 <CAHUa44HL5g-b+oGpYg=jne1MPNJSGLYbeW8_nx7a40=26ehQ1A@mail.gmail.com> <20220901090416.25riofko2m5mrlnt@bogus>
In-Reply-To: <20220901090416.25riofko2m5mrlnt@bogus>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 1 Sep 2022 13:32:10 +0200
Message-ID: <CAHUa44GdfJgzbfowY1ZMEZyM8B_hh4h-bYxsZ3h9mtgfj=bYSw@mail.gmail.com>
Subject: Re: [PATCH 4/9] firmware: arm_ffa: Add support for querying FF-A features
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
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

On Thu, Sep 1, 2022 at 11:04 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Sep 01, 2022 at 09:56:41AM +0200, Jens Wiklander wrote:
> > On Tue, Aug 30, 2022 at 12:07 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > Add support for FFA_FEATURES to discover properties supported at the
> > > FF-A interface. This interface can be used to query:
> > >  - If an FF-A interface is implemented by the component at the higher EL,
> > >  - If an implemented FF-A interface also implements any optional features
> > >    described in its interface definition, and
> > >  - Any implementation details exported by an implemented FF-A interface
> > >    as described in its interface definition.
> > >
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  drivers/firmware/arm_ffa/driver.c | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > >
> > > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> > > index 04e7cbb1b9aa..de94073f4109 100644
> > > --- a/drivers/firmware/arm_ffa/driver.c
> > > +++ b/drivers/firmware/arm_ffa/driver.c
> > > @@ -571,6 +571,29 @@ static int ffa_memory_reclaim(u64 g_handle, u32 flags)
> > >         return 0;
> > >  }
> > >
> > > +static int ffa_features(u32 func_feat_id, u32 input_props, u32 *if_props)
> > > +{
> > > +       ffa_value_t id;
> > > +
> > > +       if (!ARM_SMCCC_IS_FAST_CALL(func_feat_id) && input_props) {
> > > +               pr_err("%s: Invalid Parameters: %x, %x", __func__,
> > > +                      func_feat_id, input_props);
> > > +               return ffa_to_linux_errno(FFA_RET_INVALID_PARAMETERS);
> > > +       }
> > > +
> > > +       invoke_ffa_fn((ffa_value_t){
> > > +               .a0 = FFA_FEATURES, .a1 = func_feat_id, .a2 = input_props,
> > > +               }, &id);
> > > +
> > > +       if (id.a0 == FFA_ERROR)
> > > +               return ffa_to_linux_errno((int)id.a2);
> > > +
> > > +       if (if_props)
> > > +               *if_props = id.a2;
> >
> > w3 (id.a3) also contains a value when querying for
> > FFA_MEM_RETRIEVE_REQ. I see that in "[PATCH 5/9] firmware: arm_ffa:
> > Use FFA_FEATURES to detect if native versions are supported" you're
> > using this function with if_props = NULL. So I guess that at the
> > moment we have more than needed, but in case you need to add another
> > parameter to this function you'll need to update all the call sites
> > too.
> >
>
> Right, I clearly missed to observe that. I am fine either way. Do you
> have any preference ? As long as the callers are with this driver, it
> shouldn't be much of an issue to change all, but happy to update to
> accommodate w3 as well in v2.

Either way is fine, it was more of an observation.

Cheers,
Jens
