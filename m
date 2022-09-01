Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3510C5A92B7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbiIAJGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbiIAJGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:06:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37501BE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:04:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6504DD6E;
        Thu,  1 Sep 2022 02:04:49 -0700 (PDT)
Received: from bogus (unknown [10.57.46.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41D933F766;
        Thu,  1 Sep 2022 02:04:41 -0700 (PDT)
Date:   Thu, 1 Sep 2022 10:04:16 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: Re: [PATCH 4/9] firmware: arm_ffa: Add support for querying FF-A
 features
Message-ID: <20220901090416.25riofko2m5mrlnt@bogus>
References: <20220830100700.344594-1-sudeep.holla@arm.com>
 <20220830100700.344594-5-sudeep.holla@arm.com>
 <CAHUa44HL5g-b+oGpYg=jne1MPNJSGLYbeW8_nx7a40=26ehQ1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHUa44HL5g-b+oGpYg=jne1MPNJSGLYbeW8_nx7a40=26ehQ1A@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:56:41AM +0200, Jens Wiklander wrote:
> On Tue, Aug 30, 2022 at 12:07 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > Add support for FFA_FEATURES to discover properties supported at the
> > FF-A interface. This interface can be used to query:
> >  - If an FF-A interface is implemented by the component at the higher EL,
> >  - If an implemented FF-A interface also implements any optional features
> >    described in its interface definition, and
> >  - Any implementation details exported by an implemented FF-A interface
> >    as described in its interface definition.
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/arm_ffa/driver.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> > index 04e7cbb1b9aa..de94073f4109 100644
> > --- a/drivers/firmware/arm_ffa/driver.c
> > +++ b/drivers/firmware/arm_ffa/driver.c
> > @@ -571,6 +571,29 @@ static int ffa_memory_reclaim(u64 g_handle, u32 flags)
> >         return 0;
> >  }
> >
> > +static int ffa_features(u32 func_feat_id, u32 input_props, u32 *if_props)
> > +{
> > +       ffa_value_t id;
> > +
> > +       if (!ARM_SMCCC_IS_FAST_CALL(func_feat_id) && input_props) {
> > +               pr_err("%s: Invalid Parameters: %x, %x", __func__,
> > +                      func_feat_id, input_props);
> > +               return ffa_to_linux_errno(FFA_RET_INVALID_PARAMETERS);
> > +       }
> > +
> > +       invoke_ffa_fn((ffa_value_t){
> > +               .a0 = FFA_FEATURES, .a1 = func_feat_id, .a2 = input_props,
> > +               }, &id);
> > +
> > +       if (id.a0 == FFA_ERROR)
> > +               return ffa_to_linux_errno((int)id.a2);
> > +
> > +       if (if_props)
> > +               *if_props = id.a2;
>
> w3 (id.a3) also contains a value when querying for
> FFA_MEM_RETRIEVE_REQ. I see that in "[PATCH 5/9] firmware: arm_ffa:
> Use FFA_FEATURES to detect if native versions are supported" you're
> using this function with if_props = NULL. So I guess that at the
> moment we have more than needed, but in case you need to add another
> parameter to this function you'll need to update all the call sites
> too.
>

Right, I clearly missed to observe that. I am fine either way. Do you
have any preference ? As long as the callers are with this driver, it
shouldn't be much of an issue to change all, but happy to update to
accommodate w3 as well in v2.

--
Regards,
Sudeep
