Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3878A4BA0CB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240845AbiBQNOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:14:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240817AbiBQNNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:13:51 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B14F2AFE9A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:13:32 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id r20so8266903ljj.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pdlNEpbYE3AKZ4++IrQq+erVwdFLOX7YrQql8ZPAing=;
        b=diluvxs/p/mDwX2wAUYQSiDQnxJujdPkx+IxZgFACL8A7mgOPrUjzGgnge3fLEh6/C
         rIxTy+DI2rse2zra/YRAxuOOULUoyonrRTvf/qeJfcSXgXWilzcRWUluD/Siru9Zkt+h
         5viN31OFq6CIdv1TJjsfa1BEsfRV3VGLfnh44Bi0qRXeLBezDpeD1f/j1uqs3gUzR3OI
         XSUrMFZXPazlUapXQDeEjkUs0Fye1/Zcw38lZiHlXSYhyLb+LfzBa2GZoSMQWoFWbZ3Q
         CPVnm2YMUxwV8TqL86wjL4cncqnQ7/oohvs+kYZxa8zJ7Yt8GaB3MPIwIIdzc4B7YKH5
         N38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pdlNEpbYE3AKZ4++IrQq+erVwdFLOX7YrQql8ZPAing=;
        b=pnmXsgFWCf7+z1yOEnNDxoNdu9Y2vkBA7fVNpZmZZ2Yhx9v8o7OAnNOGCto2V+gmf4
         aY2wpSJMtr5EmZRcyYKAZbAcv5AVK7GTWpNNgOoRHWSqgey5cbpiHGKYpFz3vHOuxVMZ
         9Wfbwxoha1zKcp2DxvHqkMhqDDD3u6rzNYZb527rpg8XGO6bsc/wsV5xDfl70stezqAu
         K5DiyOmeUOefgpQtIxts7gn8TfM3XePV/DLTnp5x7yk976KpkqHX6C7LE2V98L1DYd1w
         lQDFywH+4yjIZ/J/F0VBk055WlwW77DZT4vXrEYnRVfoXTOCPI9hIUIY0Gr9/jX8iyAx
         sNGA==
X-Gm-Message-State: AOAM533mXU1Bpzh2bbfy3wpEhJJkKvwZ1WGDBd+QZXZszwgM7WItGidc
        +FF7CsyLXTRTsD7mLACoIppU7wcDasdxu+PKf1Ra7A==
X-Google-Smtp-Source: ABdhPJwHbTeXogZyYR1sNuEfn18kJ05zYRCC7JuJLH6m5k7uhKBnDRk+3nhVg2/rZfeazilHULJve593HVImXgDT45U=
X-Received: by 2002:a05:651c:50f:b0:239:3332:2a1e with SMTP id
 o15-20020a05651c050f00b0023933322a1emr2216225ljp.16.1645103610821; Thu, 17
 Feb 2022 05:13:30 -0800 (PST)
MIME-Version: 1.0
References: <20220130210210.549877-1-daniel.lezcano@linaro.org>
 <20220130210210.549877-4-daniel.lezcano@linaro.org> <CAPDyKFp5X7JuhXWSb--FUVwF=r-wtnPW0My9=oG14vHaPxSZFQ@mail.gmail.com>
 <0e7bf391-08f1-88b3-14c2-8bbf45ad7491@linaro.org>
In-Reply-To: <0e7bf391-08f1-88b3-14c2-8bbf45ad7491@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Feb 2022 14:12:54 +0100
Message-ID: <CAPDyKFq1sbLYn+uWmNB-X_tWz0vsLoUY-fyVa2634sZ-nz=ipA@mail.gmail.com>
Subject: Re: [PATCH v1 4/7] powercap/dtpm: Destroy hierarchy function
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, heiko@sntech.de, lukasz.luba@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Wed, 16 Feb 2022 at 20:25, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 16/02/2022 17:31, Ulf Hansson wrote:
> > On Sun, 30 Jan 2022 at 22:02, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> The hierarchy creation function exits but without a destroy hierarchy
> >> function. Due to that, the modules creating the hierarchy can not be
> >> unloaded properly because they don't have an exit callback.
> >>
> >> Provide the dtpm_destroy_hierarchy() function to remove the previously
> >> created hierarchy.
> >>
> >> The function relies on all the release mechanisms implemented by the
> >> underlying powercap framework.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>   drivers/powercap/dtpm.c | 43 +++++++++++++++++++++++++++++++++++++++++
> >>   include/linux/dtpm.h    |  3 +++
> >>   2 files changed, 46 insertions(+)
> >>
> >> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> >> index 7bddd25a6767..d9d74f981118 100644
> >> --- a/drivers/powercap/dtpm.c
> >> +++ b/drivers/powercap/dtpm.c
> >> @@ -617,3 +617,46 @@ int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
> >>          return ret;
> >>   }
> >>   EXPORT_SYMBOL_GPL(dtpm_create_hierarchy);
> >> +
> >> +static void __dtpm_destroy_hierarchy(struct dtpm *dtpm)
> >> +{
> >> +       struct dtpm *child, *aux;
> >> +
> >> +       list_for_each_entry_safe(child, aux, &dtpm->children, sibling)
> >> +               __dtpm_destroy_hierarchy(child);
> >> +
> >> +       /*
> >> +        * At this point, we know all children were removed from the
> >> +        * recursive call before
> >> +        */
> >> +       dtpm_unregister(dtpm);
> >> +}
> >> +
> >> +void dtpm_destroy_hierarchy(void)
> >> +{
> >> +       int i;
> >> +
> >> +       mutex_lock(&dtpm_lock);
> >> +
> >> +       if (!pct)
> >
> > As I kind of indicated in one of the earlier replies, it looks like
> > dtpm_lock is being used to protect the global "pct". What else?
>
> The root node pointer and the lists describing the hierarchy
>
> > Rather than doing it like this, couldn't you instead let
> > dtpm_create_hiearchy() return a handle/cookie for a "dtpm hierarchy".
> > This handle then needs to be passed to dtpm_destroy_hierarchy().
> >
> > In this way, the "pct" doesn't need to be protected and you wouldn't
> > need the global "pct" at all. Although, maybe there would be other
> > problems with this?
>
> The only problem I see with this approach is the dtpm framework is
> designed to be a singleton, no other instance of the hierarchy can exists.

Right. So, it's not likely that we need to change this in future then,
I assume!?

>
> By allowing returning a pointer or whatever, that implies multiple
> controller can be created.

Yes.

>
> In addition that would mean duplicating a global variable for each
> module to store the pointer at init time in order to reuse it at exit time.

Yes, that seems unnecessary. At least as long as the dtpm framework
remains to be a singleton.

Kind regards
Uffe
