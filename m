Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6560048C3A3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 13:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353014AbiALMAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 07:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240123AbiALMAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 07:00:48 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8429C061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 04:00:47 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x22so7176722lfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 04:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=muSscxPEf2XddsrQqYWou18NFugYkAP4ss7xaHOt1ns=;
        b=eJOV/bNTs42nTK8cUwzEhsUDtxjY26cDP+LEKWup31jP9laDjsmdz6QwoiZeUExLDj
         7uiZ0S+G0G4zI2MomAFVh3epp+00UfPvup0TXXALpcA9GwMibU28YD+LBR/wOWhB3TpZ
         wZ9qvbjmzPFotdrRInJKnLg7GRtli5WX3BtQPt4FBAqcQSgK68P+cXtPSvHqmf/Y8Rwd
         aCk2XqZnCi615c1/RYyZtAtB3eQ5JXOoyJbZlLQlI72pb92TE0JYjZ4wajLbGiy4xuVq
         wGKzXoS1P+FHXctsQtxcicIi0prElWS29n3LXr/6+hbO2/STcxfIi/Qkw2rP8+Cv4M8y
         Bk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=muSscxPEf2XddsrQqYWou18NFugYkAP4ss7xaHOt1ns=;
        b=BFQTCArWc0Qa0KoDcAsiAtAFUkmZdRj8yiWp5eGgSCfNTo+wBVRfnb06JhsZoCmRit
         0ugPjzw0kyglmmiZGQ9cDEh+CB5kxkEPLj6h+oq58AwX7R5dXD5PEeUytCHl9Tu8HeK5
         6ScW98DBzFof3475/BOJ5ka4yPxECvL2XSnpTAiVUDygSqT0ZfMRDB3t2YwW7LIKVO9a
         jQum2j9o6LdVziSgUA9rJBrvCkpclRRV0tExCSq5ujjgpdKyDgARxhZ9Gru55sbopPPj
         KuU6kon1LoXhvOV09NJPhFactSCJLp3jieKR4NsbhaP9z3lAdYoNyWj0qeV5iQBKAAtq
         IQbg==
X-Gm-Message-State: AOAM531pw5jcO1Rrv8FiO3ZSZ7BADq/b5NZ9PPahuTdCPTFNOuvsjZH2
        X1uTycy5Ah1IqgpT+p5uxkWvnmOus32hHdBs08Ta8Q==
X-Google-Smtp-Source: ABdhPJwAVDJu/y3n6NXObZ5H0mAFc4JwWpFDykmljO3TvL1LW3QDz1rdQjjEXdhPUtGhjh1spFVVBPLM/jca1O3tCXY=
X-Received: by 2002:a05:6512:400f:: with SMTP id br15mr5186699lfb.233.1641988846017;
 Wed, 12 Jan 2022 04:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
 <20211218130014.4037640-3-daniel.lezcano@linaro.org> <CAPDyKFrLTsUxG8JHdK33h2BT8pxeHk6kiU-4uGrvxUhcQKg3Sw@mail.gmail.com>
 <8fcc0ef8-b0c7-da73-434f-31c88896aed5@linaro.org> <CAPDyKFqzxnfh0kow5mzoApFMQpKOAv=e1b7Cy9H-iEh99Wmagw@mail.gmail.com>
 <cbc70ea7-39b4-b5e8-b5c0-45fb436f53eb@linaro.org> <CAPDyKFoFpEjakaeb1JvYg47qoagGnzwyh2T1SpHQiwB3sFgkoA@mail.gmail.com>
 <aad4eb52-67b0-a486-53c6-755de3dee6be@linaro.org>
In-Reply-To: <aad4eb52-67b0-a486-53c6-755de3dee6be@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Jan 2022 13:00:09 +0100
Message-ID: <CAPDyKFrYTbVRUcYT8DMbdz4HXTbOz-xHsvUiAtmCGYdPNuOUOg@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] powercap/drivers/dtpm: Add hierarchy creation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, robh@kernel.org,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 at 18:52, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 11/01/2022 09:28, Ulf Hansson wrote:
> > On Mon, 10 Jan 2022 at 16:55, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 07/01/2022 16:54, Ulf Hansson wrote:
> >>> [...]
> >>>
> >>>>>> +static int dtpm_for_each_child(const struct dtpm_node *hierarchy,
> >>>>>> +                              const struct dtpm_node *it, struct dtpm *parent)
> >>>>>> +{
> >>>>>> +       struct dtpm *dtpm;
> >>>>>> +       int i, ret;
> >>>>>> +
> >>>>>> +       for (i = 0; hierarchy[i].name; i++) {
> >>>>>> +
> >>>>>> +               if (hierarchy[i].parent != it)
> >>>>>> +                       continue;
> >>>>>> +
> >>>>>> +               dtpm = dtpm_node_callback[hierarchy[i].type](&hierarchy[i], parent);
> >>>>>> +               if (!dtpm || IS_ERR(dtpm))
> >>>>>> +                       continue;
> >>>>>> +
> >>>>>> +               ret = dtpm_for_each_child(hierarchy, &hierarchy[i], dtpm);
> >>>>>
> >>>>> Why do you need to recursively call dtpm_for_each_child() here?
> >>>>>
> >>>>> Is there a restriction on how the dtpm core code manages adding
> >>>>> children/parents?
> >>>>
> >>>> [ ... ]
> >>>>
> >>>> The recursive call is needed given the structure of the tree in an array
> >>>> in order to connect with the parent.
> >>>
> >>> Right, I believe I understand what you are trying to do here, but I am
> >>> not sure if this is the best approach to do this. Maybe it is.
> >>>
> >>> The problem is that we are also allocating memory for a dtpm and we
> >>> call dtpm_register() on it in this execution path - and this memory
> >>> doesn't get freed up nor unregistered, if any of the later recursive
> >>> calls to dtpm_for_each_child() fails.
> >>>
> >>> The point is, it looks like it can get rather messy with the recursive
> >>> calls to cope with the error path. Maybe it's easier to store the
> >>> allocated dtpms in a list somewhere and use this to also find a
> >>> reference of a parent?
> >>
> >> I think it is better to continue the construction with other nodes even
> >> some of them failed to create, it should be a non critical issue. As an
> >> analogy, if one thermal zone fails to create, the other thermal zones
> >> are not removed.
> >
> > Well, what if it fails because its "consumer part" is waiting for some
> > resource to become available?
> >
> > Maybe the devfreq driver/subsystem isn't available yet and causes
> > -EPROBE_DEFER, for example. Perhaps this isn't the way the dtpm
> > registration works currently, but sure it's worth considering when
> > going forward, no?
>
> It should be solved by the fact that the DTPM description is a module
> and loaded after the system booted. The module loading ordering is
> solved by userspace.

Ideally, yes. However, drivers/subsystems in the kernel should respect
-EPROBE_DEFER. It's good practice to do that.

>
> I agree, we could improve that but it is way too complex to be addressed
> in a single series and should be part of a specific change IMO.

It's not my call to make, but I don't agree, sorry.

In my opinion, plain error handling to avoid leaking memory isn't
something that should be addressed later. At least if the problems are
already spotted during review.

>
> > In any case, papering over the error seems quite scary to me. I would
> > much prefer if we instead could propagate the error code correctly to
> > the caller of dtpm_create_hierarchy(), to allow it to retry if
> > necessary.
>
> It is really something we should be able to address later.
>

[...]

Kind regards
Uffe
