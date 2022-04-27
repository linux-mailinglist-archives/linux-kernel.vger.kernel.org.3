Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2F05118F8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbiD0Oj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238351AbiD0Oj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:39:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B213191F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:36:14 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a21so2198942edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oRouwdDNtYlp7s/yLSxEK5Hn8NOK0t/FK/o2wG9MP2A=;
        b=Y7oV4ElV0PHC/nTjshxxiAfhsQbBp6DQOmt6+J9hCSFENXdNBnZeI2ATeP0utuzYNh
         rIGxWQtDg2EN2/nYHXWdaLPOC7WToD1vmPsZTWjYM0+N9dRy8RuUH2Y+34jzIvIBnOmo
         oUf88NXQsQKpyub/A3XOsel+mD4BFBgRotBBs+d474o/EBjx7jBzXu+Eky5bnZlzq7RV
         Xt2Mz9DkwmeHMkELzPET4SoLn+vcNy1FQj4CxS5nloui+2ezRIPFQWyZQKztK99rqSL5
         v+fKsTDYbqk+EdTUFjySy+nRFdVlsfxsNpDHzAoUtpPUVpEWSRVISFEuXgaxYOaYsge4
         1ldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oRouwdDNtYlp7s/yLSxEK5Hn8NOK0t/FK/o2wG9MP2A=;
        b=txS3EuxDMFmodR5Dl25SbvhNFocfTuQrmzIDeJyKDFsr1khj7w9aih8nfamNOuQxxe
         hSLmIZPRon8yXYvJGSAeBsHE/v3PTWxZzS55iXEbvRyNNMi6wbjKdxh1rHUJyFc53lQM
         YqS9AhdNnmM0cWqXjxFMrbt1vvdbj1vDX2TGj724/gyriVoTA2WmFxwm/+T8qiMgTJhF
         ccsnnji0BsCR140Ol/ZEojM7R6rta/cdxmrWNks0v8BPTKJUE3iE89oKNQ0cBW2I2A3C
         UADMMZvvUeQ9rBkH+BYL/459wOy5e507zNbXIAZrtA5UxYLb5uxQukFNdb9uvdE4RFS0
         rykQ==
X-Gm-Message-State: AOAM532pykeuSp19a9tXmiIeCT94oASko52eSw+v6zjJiqlFhA7MnBJG
        K1Ej0kwqLepNVCx65oYPAXiDP8Qq9dahBJ4LpUhL+Q==
X-Google-Smtp-Source: ABdhPJzNg1YWbo0JyTnlr6u2TtzgYsgqVhlCjltot/9sWmL/TDZYT57LuxL7DIW00FwZF6wZz1hGith5c9q02akE37Q=
X-Received: by 2002:a05:6402:d0a:b0:421:10e6:2ecc with SMTP id
 eb10-20020a0564020d0a00b0042110e62eccmr31245843edb.329.1651070172978; Wed, 27
 Apr 2022 07:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220323034405.976643-1-peng.fan@oss.nxp.com> <DU0PR04MB941780AEF9B375294283B75188EA9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <PA4PR04MB941647A5E0E06DD776A1A1F588FA9@PA4PR04MB9416.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB941647A5E0E06DD776A1A1F588FA9@PA4PR04MB9416.eurprd04.prod.outlook.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 27 Apr 2022 08:36:01 -0600
Message-ID: <CANLsYkyqasNA=HxVHhSvi4YMZxPTX_mBhcsqC7iffANTjUPBEQ@mail.gmail.com>
Subject: Re: [PATCH V4 0/2] remoteproc: support self recovery
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 at 02:37, Peng Fan <peng.fan@nxp.com> wrote:
>
> Mathieu, Bjorn
>
> > Subject: RE: [PATCH V4 0/2] remoteproc: support self recovery
>
> Do you have time to give a look? i.MX8QM/QXP remoteproc
> support depends on this feature.

As I have stated before, this feature changes the heart of the
remoteproc core state machine and I want to make sure we get it right.
That in turn will require time that is currently spent reviewing other
patchset on the mailing list.  I suggest you start reviewing patches
if you want things to go faster.  That will help with the backlog,
which will allow me to look at more complex work such as yours.

>
> Thanks,
> Peng.
>
> >
> > > Subject: [PATCH V4 0/2] remoteproc: support self recovery
> >
> > Gentle ping..
> >
> > Thanks
> > Peng.
> >
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > V4:
> > >   Based on Bjorn's comments on V2-2
> > >   Move the rproc_has_feature/rproc_set_feature to
> > > remoteproc_internal.h and  Keep rproc_features still in remoteproc.h,
> > > because we use RPROC_MAX_FEATURES to declare bitmap.
> > >   Update commit log for patch 2/2, and add comments
> > >
> > > V3:
> > >  Resend the wrong labeled patchset
> > >
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatc
> > > hwork.kernel.org%2Fproject%2Flinux-
> > remoteproc%2Flist%2F%3Fseries%3D621
> > >
> > 311&amp;data=04%7C01%7Cpeng.fan%40nxp.com%7C79b37b5586cc4c913129
> > 08da1b
> > >
> > 7ad5a8%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637852511630
> > 263603
> > > %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC
> > JBTiI6I
> > >
> > k1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=5dxwnc716qj%2FQc6TzayLIn
> > %2BiMJ8
> > > oSwksVUIfmw6atVk%3D&amp;reserved=0
> > >
> > >  Write a cover-letter
> > >  To i.MX8QM/QXP, they have a M4 core self-recovery capability without
> > > Linux loading firmware. The self recovery is done by  SCU(System
> > > Control Unit). Current remoteproc framework only support Linux  help
> > > recovery remote processor(stop, loading firmware, start). This
> > > patchset is support remote processor self recovery(attach recovery).
> > >
> > >  In order to avoid introducing a new variable(bool
> > > support_self_recovery), patch 1 introduce a new function,
> > > rproc_has_feature to make code easy to extend, cleaner, such as we
> > > could move "bool has_iommu" to rproc_has_feature(rproc,
> > RPROC_FEAT_IOMMU).
> > >
> > >  Patch 2 is introduce a new function rproc_attach_recovery for  self
> > > recovery, the original logic move to rproc_firmware_recovery meaning
> > > needs linux to help recovery.
> > >
> > >  V2-version 2:
> > >
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatc
> > > hwork.kernel.org%2Fproject%2Flinux-
> > remoteproc%2Flist%2F%3Fseries%3D621
> > >
> > 311&amp;data=04%7C01%7Cpeng.fan%40nxp.com%7C79b37b5586cc4c913129
> > 08da1b
> > >
> > 7ad5a8%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637852511630
> > 263603
> > > %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC
> > JBTiI6I
> > >
> > k1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=5dxwnc716qj%2FQc6TzayLIn
> > %2BiMJ8
> > > oSwksVUIfmw6atVk%3D&amp;reserved=0
> > >  Introduce rproc_has_feature
> > >
> > >  V2-version 1:
> > >
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatc
> > > hwork.kernel.org%2Fproject%2Flinux-
> > remoteproc%2Fpatch%2F20220126085&am
> > >
> > p;data=04%7C01%7Cpeng.fan%40nxp.com%7C79b37b5586cc4c91312908da1b7
> > ad5a8
> > > %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6378525116302636
> > 03%7CUnk
> > >
> > nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> > aWw
> > >
> > iLCJXVCI6Mn0%3D%7C3000&amp;sdata=eMRjdCSvLJrnvtS9QGUQYnr%2BtUPJkS
> > RSryJ
> > > p6%2BvvfNo%3D&amp;reserved=0
> > > 120.3397450-1-peng.fan@oss.nxp.com/
> > >  Nothing change in V2.
> > >  Only move this patch out from
> > >
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatc
> > > hwork.kernel.org%2Fproject%2Flinux-
> > remoteproc%2Flist%2F%3Fseries%3D604
> > >
> > 364&amp;data=04%7C01%7Cpeng.fan%40nxp.com%7C79b37b5586cc4c913129
> > 08da1b
> > >
> > 7ad5a8%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637852511630
> > 263603
> > > %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC
> > JBTiI6I
> > >
> > k1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=eJSTzHgK7eMYgLoENZ1dfZds
> > uj9O6kj
> > > aPyBm61WDXpM%3D&amp;reserved=0
> > >
> > >
> > >
> > > Peng Fan (2):
> > >   remoteproc: introduce rproc features
> > >   remoteproc: support attach recovery after rproc crash
> > >
> > >  drivers/remoteproc/remoteproc_core.c     | 67
> > > +++++++++++++++++-------
> > >  drivers/remoteproc/remoteproc_internal.h | 10 ++++
> > >  include/linux/remoteproc.h               |  7 +++
> > >  3 files changed, 65 insertions(+), 19 deletions(-)
> > >
> > > --
> > > 2.25.1
>
