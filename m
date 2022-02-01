Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354724A617F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbiBAQmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241161AbiBAQmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:42:12 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42647C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 08:42:12 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id i19so16490209qvx.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 08:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=otyEMvVogZiC/qLnQYtuKjXRtrkndEx9vzMbrLjZjDE=;
        b=dj13jx2a1MprLlYA1kB5O4aC7dmPTtNC2m9oAj0hEzL5g88I3AgHJKZvwGSvQ9UlPq
         mVttKA/nLeBtVoFjgpVG+TOJ/et/3WIez8o/W1sYKBuWfUbAMWgHnQmN0ZsVlASNY60O
         qvTpr126c84fdzOSOJUgfbEp8s1K7AAbqrdKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otyEMvVogZiC/qLnQYtuKjXRtrkndEx9vzMbrLjZjDE=;
        b=rpj66Suxp0LJpsvBj0EEk7VvI/PCmFGr+gG7dK10C7ea1qtBqx8bzYiYBmEqc87/Dj
         1xAC6AogC3vtwTfr8ReuqCC7GFt+B3tInD4em20HPJC6JNgIQX4hV2OnD7kxV2hkdfT8
         O6JJ6UeFFFGpdKy6RO4l+3/hHxVmJFzrymZRjhi2vF+rdaRpqf2xZLGZgGPGZ7f7/kek
         6CEWiWE2HecvWJs30YGde2HX2HsaffTHWZ2ReHKCRYo8FiwgQ9u0rR6auh+Rp75r+2Qj
         CZERVkIU8oRTJxqYwlcrYSvWLa38W86mgkyk0HWEmrwJV7lJA1Q/bU1rWhZnRGEqblR4
         7rkA==
X-Gm-Message-State: AOAM531D1WFxb5lPW1THxcYMBgB6zFjRSWyVC1yrB4eJiZAkH2JoKFVD
        zBMczAWvvUMFQ6KeTkiKo9rNq5bOvk+2Hg==
X-Google-Smtp-Source: ABdhPJxGFZ91cf3hIofpn+tTr8utUv0q8+uof1aUv0y5ZBzXiyCGafwauxL0sv1hUdVs3c+eYMrssg==
X-Received: by 2002:ad4:5969:: with SMTP id eq9mr23536306qvb.73.1643733731141;
        Tue, 01 Feb 2022 08:42:11 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id l12sm8623162qtk.25.2022.02.01.08.42.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 08:42:10 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id i62so52651323ybg.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 08:42:10 -0800 (PST)
X-Received: by 2002:a25:c58f:: with SMTP id v137mr37662763ybe.609.1643733730084;
 Tue, 01 Feb 2022 08:42:10 -0800 (PST)
MIME-Version: 1.0
References: <20220125135406.1.I62322abf81dbc1a1b72392a093be0c767da9bf51@changeid>
 <e89dbc7b-b3ae-c334-b704-f5633725c29f@redhat.com> <CAD=FV=U8VGnRXv8MgofKzZF22_x0_X3M+AMfyPQ1u=yTXnFBQA@mail.gmail.com>
 <6fdcfbcf-0546-6b4f-b50f-cf2382ad746f@redhat.com>
In-Reply-To: <6fdcfbcf-0546-6b4f-b50f-cf2382ad746f@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Feb 2022 08:41:58 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U3YHt=+cr8c39zMxFWMeo4Pr=R3BBPMKanpySPhsYh9w@mail.gmail.com>
Message-ID: <CAD=FV=U3YHt=+cr8c39zMxFWMeo4Pr=R3BBPMKanpySPhsYh9w@mail.gmail.com>
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

On Wed, Jan 26, 2022 at 12:25 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> On 1/26/22 00:25, Doug Anderson wrote:
> > On Tue, Jan 25, 2022 at 2:55 PM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
>
> [snip]
>
> >> Should this new sysfs entry be documented in Documentation/ABI/ ?
> >
> > I'm not sure what the policy is here. I actually don't know that I'm
> > too worried about this being an ABI. For the purposes of our tests
> > then if something about this file changed (path changed or something
> > like that) it wouldn't be a huge deal. Presumably the test itself
> > would just "fail" in this case and that would clue us in that the ABI
> > changed and we could adapt to whatever new way was needed to discover
> > this.
> >
> > That being said, if the policy is that everything in sysfs is supposed
> > to be ABI then I can add documentation for this...
> >
>
> I also don't know the policy, hence the question. But in any case, I
> think that it could even be done as a follow-up if is needed.

Sounds good. Since it's been pretty silent and I had your review I
pushed this to drm-misc-next. If there are comments or someone has an
opinion documenting this as a stable ABI then please yell.

363c4c3811db drm/panel-edp: Allow querying the detected panel via sysfs
