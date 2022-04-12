Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911654FEAE4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiDLXVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiDLXUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:20:51 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B1FBC84F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:59:30 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id p65so649381ybp.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67uj+ODJKAoJfsGq0mgokodnfsfzexhVZc4yfZMP5Vs=;
        b=DTX7npfLpY1BrJWiBCCqdFbeD0T+a+0TC8CBYj5GRcgXhHG+cylx7+9ln8680oh++G
         YRVt2bJ9Qijviugbq6DuYFrZ4t2beqmfbvhW+kfrETtfLH3aaTcFSJvrgYWXX6SqRTDQ
         VNNkHYWZ6NBjUNRSoxJbZ1gSlb7tEFaNnhD0YBIjtRhZa2RU2/3bzfqMVBaxPcBLlp4q
         gYh9k4YdvFwWTHX1I8ZNdHkeRiGhgbfO541bjtwNVus961Yw11Ll62cNkZuc1ban6Q5N
         eIkuz8dbBg4WSz4613JSdmX6AWpOcglf82YmMCGKSy85JHaT4+uo897j4dYsagZhos+2
         WMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67uj+ODJKAoJfsGq0mgokodnfsfzexhVZc4yfZMP5Vs=;
        b=cARaL7vK87GNR8Abv/EUvhG52KGgGytTLiZQkfXCOImjt8G6nYWzpXuXtZNuG2Qf8Z
         sDLVI8R1Sl3PDlYpjjgq1xhParPRsIK4MRw+nNEl27IxCb5dgHoBEUOJpFes9H/x3kNc
         39B6zqePgAEtNI2F7t7aQOlBBRhWi1/0N7Q2KodEWmDEA5wXJPAY2L7DreBAP6gFiGB9
         u5aRwydxvjfGtwFBDVObWXjTg6ID8UMvWLX8bNGBGdf9PIzi28a8z6qOFyPWFoGBDZM9
         Q+NRPHGtGw3eFH/8sYAmnbmEJMbK/wG5dKNrFNqcp1TgFkt2bSi1JJR/mC9KUOga9FrT
         EjTQ==
X-Gm-Message-State: AOAM530UsoVfTLRT7z8QUK2+ChfeNw1KhbE4mt65dT07KVXqtivkMXXw
        BegQ0V4S2u6kH9/aaNgp/L1eIPS/EJwWmLKaago=
X-Google-Smtp-Source: ABdhPJxA3TnyYl5vFu8RdrtHkJRQMKjG5mMTUlovdrThCqA4a3Mhh048V8dAtXy5cq7W9qaIvtdd+JKskmCRu3d7AV0=
X-Received: by 2002:a25:ccc9:0:b0:641:2b90:4765 with SMTP id
 l192-20020a25ccc9000000b006412b904765mr11645877ybf.44.1649804369431; Tue, 12
 Apr 2022 15:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220411221536.283312-1-dmitry.osipenko@collabora.com>
 <064d8958-a288-64e1-b2a4-c2302a456d5b@amd.com> <a04733af-5ff1-a1b4-527d-68b28a037231@collabora.com>
 <f6de2b9a-005f-d1f5-9818-cfbee2bdddc5@amd.com>
In-Reply-To: <f6de2b9a-005f-d1f5-9818-cfbee2bdddc5@amd.com>
From:   Erico Nunes <nunes.erico@gmail.com>
Date:   Wed, 13 Apr 2022 00:59:17 +0200
Message-ID: <CAK4VdL3VOtVGi36SY0TEL4P2jW33dM4TOmFXYmewE7cGNhY4Zw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/scheduler: Don't kill jobs in interrupt context
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Qiang Yu <yuq825@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 9:41 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
>
> On 2022-04-12 14:20, Dmitry Osipenko wrote:
> > On 4/12/22 19:51, Andrey Grodzovsky wrote:
> >> On 2022-04-11 18:15, Dmitry Osipenko wrote:
> >>> Interrupt context can't sleep. Drivers like Panfrost and MSM are taking
> >>> mutex when job is released, and thus, that code can sleep. This results
> >>> into "BUG: scheduling while atomic" if locks are contented while job is
> >>> freed. There is no good reason for releasing scheduler's jobs in IRQ
> >>> context, hence use normal context to fix the trouble.
> >>
> >> I am not sure this is the beast Idea to leave job's sw fence signalling
> >> to be
> >> executed in system_wq context which is prone to delays of executing
> >> various work items from around the system. Seems better to me to leave the
> >> fence signaling within the IRQ context and offload only the job freeing or,
> >> maybe handle rescheduling to thread context within drivers implemention
> >> of .free_job cb. Not really sure which is the better.
> > We're talking here about killing jobs when driver destroys context,
> > which doesn't feel like it needs to be a fast path. I could move the
> > signalling into drm_sched_entity_kill_jobs_cb() and use unbound wq, but
> > do we really need this for a slow path?
>
>
> You can't move the signaling back to drm_sched_entity_kill_jobs_cb
> since this will bring back the lockdep splat that 'drm/sched: Avoid
> lockdep spalt on killing a processes'
> was fixing.
>
> I see your point and i guess we can go this way too. Another way would
> be to add to
> panfrost and msm job a  work_item and reschedule to thread context from
> within their
> .free_job callbacks but that probably to cumbersome to be justified here.

FWIW since this mentioned individual drivers, commit 'drm/sched: Avoid
lockdep spalt on killing a processes' also introduced problems for
lima.
There were some occurrences in our CI
https://gitlab.freedesktop.org/mesa/mesa/-/jobs/20980982/raw .
Later I found it also reproducible on normal usage when just closing
applications, so it may be affecting users too.

I tested this patch and looks like it fixes things for lima.

Thanks

Erico
