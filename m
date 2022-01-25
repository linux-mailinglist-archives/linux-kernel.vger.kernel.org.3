Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC8449BF82
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 00:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbiAYX0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 18:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbiAYX0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 18:26:05 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056AEC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 15:26:05 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id 9so10020734iou.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 15:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eNJKYs46VCGzLPV+OfVxf1Midd4P2ThRQiu4nw0IrtY=;
        b=R1/UM4avx7+OxXjRSkasjRNLcoEThEMjSr1UTSNm2f/yVyt4fYcbXY6UdGSRzfaNMk
         yrF4YWEeW+98KE7jhKn2fdcMuiaBpnwFeVtKwSKPYO0dDdqi1Tv2A70qCv/c/dcFjNSY
         1C/CrhAzqK9wSAlSBkZwYY+8BBCFBlGw1wED0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eNJKYs46VCGzLPV+OfVxf1Midd4P2ThRQiu4nw0IrtY=;
        b=fpy3e+z06xE1tSB/xFpYDK7z4uGBMnUIHv5tqBrXJsm2uG+0dsS9JTSnPSgz421Wej
         BDPkSovaWHFueIjhqWw3OXK1iQ25MX8fUjKz831empfZeukUlBrUPk8VC8UrpmS8GfBA
         yQszO29ZqUe0DGTFvjqi2iBNxwXuh2WIv8GMbKeCmKAxL3mhay74qURTjE2Xs17Fm7OT
         Mm2/Emk9IFgGkaAOUG6mE4U8aEhydvae1BFm4skMOr67fqk+s85lQSj2YG+7rsm99xLo
         i+p3rHNubMtws0en4XtaZaxNrgyHKnC35DGUrFo/TJn+17GIrJL8DCFCTti4SjGRFAjV
         oDow==
X-Gm-Message-State: AOAM532pheNeMNFBavjpy4FgFqc2FRf+U8tmoxdMvakbWM0JzbqweQwJ
        qAmV9bXqxRSPUO2yDwTZ85YKxj77vgrL5g==
X-Google-Smtp-Source: ABdhPJxjuiRD1XXGtmrVySWRKKaFWNIeErWju8uM+HLaeZvQ9BpLEKaZHuXXQ9oZIqjLtofAf1ji8w==
X-Received: by 2002:a05:6602:2ccf:: with SMTP id j15mr12182601iow.9.1643153164340;
        Tue, 25 Jan 2022 15:26:04 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id w4sm9633958ilq.56.2022.01.25.15.26.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 15:26:03 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id h7so7700281iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 15:26:03 -0800 (PST)
X-Received: by 2002:a05:6602:2d81:: with SMTP id k1mr2426978iow.98.1643153163354;
 Tue, 25 Jan 2022 15:26:03 -0800 (PST)
MIME-Version: 1.0
References: <20220125135406.1.I62322abf81dbc1a1b72392a093be0c767da9bf51@changeid>
 <e89dbc7b-b3ae-c334-b704-f5633725c29f@redhat.com>
In-Reply-To: <e89dbc7b-b3ae-c334-b704-f5633725c29f@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Jan 2022 15:25:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U8VGnRXv8MgofKzZF22_x0_X3M+AMfyPQ1u=yTXnFBQA@mail.gmail.com>
Message-ID: <CAD=FV=U8VGnRXv8MgofKzZF22_x0_X3M+AMfyPQ1u=yTXnFBQA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Allow querying the detected panel via sysfs
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>, jjsu@chromium.org,
        lschyi@chromium.org, Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 25, 2022 at 2:55 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Hello Doug,
>
> On 1/25/22 22:54, Douglas Anderson wrote:
> > Recently we added generic "edp-panel"s probed by EDID. To support
> > panels in this way we look at the panel ID in the EDID and look up the
> > panel in a table that has power sequence timings. If we find a panel
> > that's not in the table we will still attempt to use it but we'll use
> > conservative timings. While it's likely that these conservative
> > timings will work for most nearly all panels, the performance of
> > turning the panel off and on suffers.
> >
> > We'd like to be able to reliably detect the case that we're using the
> > hardcoded timings without relying on parsing dmesg. This allows us to
> > implement tests that ensure that no devices get shipped that are
> > relying on the conservative timings.
> >
> > Let's add a new sysfs entry to panel devices. It will have one of:
> > * UNKNOWN - We tried to detect a panel but it wasn't in our table.
> > * HARDCODED - We're not using generic "edp-panel" probed by EDID.
> > * A panel name - This is the name of the panel from our table.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
>
> Patch looks good to me.
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks!


> Should this new sysfs entry be documented in Documentation/ABI/ ?

I'm not sure what the policy is here. I actually don't know that I'm
too worried about this being an ABI. For the purposes of our tests
then if something about this file changed (path changed or something
like that) it wouldn't be a huge deal. Presumably the test itself
would just "fail" in this case and that would clue us in that the ABI
changed and we could adapt to whatever new way was needed to discover
this.

That being said, if the policy is that everything in sysfs is supposed
to be ABI then I can add documentation for this...

-Doug
