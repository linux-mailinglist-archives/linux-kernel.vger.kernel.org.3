Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269954C0584
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbiBVXsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbiBVXsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:48:09 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B8D4C434
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:47:42 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p15so47586693ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X0F77fbIU1LkyDEiRwNiDPK4+9RtifiKKhYt8ZyZykg=;
        b=OtP7IFPifLHaL18s430w4QMwCl8fqgUQZF6vITBFV0Y2ISfFMWayXI1UbC79Swbr2q
         Y9zB2Loo9QWTHv3XZEzrZbb6fTeRpW+NDy5LYOzubMU09FjBJzlWv470tLJLosmvvlH8
         oaWdtvbT3xjZun9F1YAretW7g5VOMCyfIEbF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0F77fbIU1LkyDEiRwNiDPK4+9RtifiKKhYt8ZyZykg=;
        b=07DWLx9FN+XZ0Z9dP95zRWnjWUbeKIOcfixC0QC2+Q9FDDmKZNCNoMxi/Md71+x4mF
         2t5vINhHIhGxjwicx8l1r04bTW4KYeRDLoruXmoIL/kcmZKIgWNeLaBZCPfWBtavVIpB
         7SkKents+tqH2YwJ1Kx718t/T5Ga/nwOZaEO+8w6VS/tVtXm7ykrUXrgXdrlhFRcM6yK
         qWau78osD42c/GdLzfHwl7z8P63wjGNfrrU8dBw08lYimdHJrDT4MPJmxKSA/Ja4WuaF
         uUpRIt7ub1ShIeNXkqIEtMuOM4yuF0tY5SACi8MM01cuTcv9gJGZsY26LzNdulUKsj6h
         NkiA==
X-Gm-Message-State: AOAM533Fi/jS8UsdDrjCnYCXrhK43q1dtg2OMC0KrC+fb/jor2+BCq5d
        7Yqv2t+etI/nVDzSDwp5nJPMQIY6u2xCaVCU6I8=
X-Google-Smtp-Source: ABdhPJxVxUgHxB4FrJ9NuBcuw/yfK8qC98BMLCjViGyeSql67IyW1gmltWe8pAR1FFPL1/us8Qvwvw==
X-Received: by 2002:a17:906:2608:b0:6ce:60fa:12ad with SMTP id h8-20020a170906260800b006ce60fa12admr21651076ejc.231.1645573661182;
        Tue, 22 Feb 2022 15:47:41 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id ek21sm10044025edb.27.2022.02.22.15.47.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 15:47:40 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id d3so20798480wrf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:47:39 -0800 (PST)
X-Received: by 2002:a5d:64ea:0:b0:1ea:8148:6b97 with SMTP id
 g10-20020a5d64ea000000b001ea81486b97mr4917201wri.679.1645573659282; Tue, 22
 Feb 2022 15:47:39 -0800 (PST)
MIME-Version: 1.0
References: <20220205001342.3155839-1-dianders@chromium.org>
 <20220204161245.v2.2.Ib0bd5346135cbb0b63006b69b61d4c8af6484740@changeid>
 <5d60473d-be8f-e2dc-2ce9-bc0b9056e4b4@redhat.com> <e6670fd7-1f75-56f7-b668-20db9902cac6@intel.com>
 <CAD=FV=Ut3N9syXbN7i939mNsx3h7-u9cU9j6=XFkz9vrh0Vseg@mail.gmail.com>
 <87ee435fjs.fsf@intel.com> <ce339fc7-b6bf-b19a-be10-54ee86487b96@redhat.com>
In-Reply-To: <ce339fc7-b6bf-b19a-be10-54ee86487b96@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Feb 2022 15:47:26 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VRa5DKUpGru9_0sOUXB1y_BZ2rd6uwToRYnx6a_TNRcw@mail.gmail.com>
Message-ID: <CAD=FV=VRa5DKUpGru9_0sOUXB1y_BZ2rd6uwToRYnx6a_TNRcw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm: Plumb debugfs_init through to panels
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        LKML <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>, lschyi@chromium.org,
        Sam Ravnborg <sam@ravnborg.org>, jjsu@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 16, 2022 at 1:36 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> On 2/16/22 10:25, Jani Nikula wrote:
>
> [snip]
>
> >>
> >> I actually wrote said follow-up patches and they were ready to go, but
> >> when I was trying to come up with the right "Fixes" tag I found commit
> >> b792e64021ec ("drm: no need to check return value of debugfs_create
> >> functions"). So what's being requested is nearly the opposite of what
> >> Greg did there.
> >>
> >> I thought about perhaps only checking for directories but even that
> >> type of check was removed by Greg's patch. Further checking shows that
> >> start_creating() actually has:
> >>
> >> if (IS_ERR(parent))
> >>   return parent;
> >>
> >> ...so I guess that explains why it's fine to skip the check even for parents?
> >>
> >> Sure enough I confirmed that if I pass `ERR_PTR(-EINVAL)` as the root
> >> for `panel->funcs->debugfs_init()` that nothing bad seems to happen...
> >
> > Yeah, the idea is that you don't need to check for debugfs function
> > return values and you can safely pass error pointers to debugfs
> > functions. The worst that can happen is you don't get the debugfs, but
> > hey, it's debugfs so you shouldn't fail anything else because of that
> > anyway.
> >
>
> Thanks a lot Doug and Jani for the explanations. That makes sense and it
> explains why most code I looked was not checking for the return value.
>
> I guess we should write something about this in the debugfs functions
> kernel doc so it's mentioned explicitly and people don't have to guess.

For anyone interested, I've taken Javier's suggestion and tried to
update the docs:

https://lore.kernel.org/r/20220222154555.1.I26d364db7a007f8995e8f0dac978673bc8e9f5e2@changeid
