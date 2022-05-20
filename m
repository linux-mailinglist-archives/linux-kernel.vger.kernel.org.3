Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E3752E138
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344028AbiETAeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiETAeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:34:20 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97E2F74B4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:34:19 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-d39f741ba0so8653901fac.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=e9ljUUDHH/JyJI4aQ9kIel1eQTZZ1jPr0AhJXun2ykU=;
        b=gXlvnDGCdBwNwVpzUu6dPjZu7hjujZnhRYw5U+bmqIlSChZfw/OgFYiEYX1UOjmt8C
         EMmWLvNQR/CWX+kboCzZbsmEQVjW13Wm37nBkgZh8w8r9I4I3mDLxrAmUh7cttqcGqvX
         VJ54e9ZT9WGzRe6fqS26MvM4QLCTL9Eal9+FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=e9ljUUDHH/JyJI4aQ9kIel1eQTZZ1jPr0AhJXun2ykU=;
        b=UNFxACQAiUnU7WK3Bd9RCMbDPThF+LjRSc3lPUoX63YvvvczwHBEBSaetEiX2gLf7K
         y8MgUeY7ZwPYH0I1okSW9WMBjW8BKfPCXLbfWPlgDsFr5ewnso4DxmsBt2TpTZJ9h4EF
         /PFQgRbNXwkrO+S/qevpDlCkgVBekJm0aNR4Y2ya4bLtzuRImi0QkibAZrpXomsnOy04
         d8HJc8oV/JbOw3SmuwRYCIZC9DVcwp4HRWvtu0qhPZyhu0Dtjxl6FGAhTbYk9wNrTCSx
         mOTLV7K5fZidrQpqvIV4nG9+M8ojoPYwkoH5lVpwv0ZzCC3FEAOLEUYs3Ce7joDP0G80
         g2ow==
X-Gm-Message-State: AOAM532/ZJBR66tvk1kl26zeuvkB0IGASaA2YfEYAFdWDC1VsQN8GiE/
        YEHTzFK9p2xJ/MJgxrS2G7sAFVJVQJxYGf+TXhmIKA==
X-Google-Smtp-Source: ABdhPJz7GCry66MK6mS2X/Oob/iO+dMt3elWph3akDsxT5xS/EtFSj9XGQ/M4XZ3r6HgPrufR7ngXa2CnDPqZiOI8Bk=
X-Received: by 2002:a05:6870:240d:b0:f1:b878:e97c with SMTP id
 n13-20020a056870240d00b000f1b878e97cmr4014027oap.193.1653006859019; Thu, 19
 May 2022 17:34:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 May 2022 17:34:18 -0700
MIME-Version: 1.0
In-Reply-To: <CAD=FV=W6Z1TG4vQcDDeNsGkjZVAR8=A1L1pDfo1rDFCh84H4Rg@mail.gmail.com>
References: <20220418171757.2282651-1-dianders@chromium.org>
 <20220418101725.v3.1.Icf57bb12233a47727013c6ab69eebf803e22ebc1@changeid>
 <CAE-0n51iNXN4oOP-wAqrm9U6qC84fQ+qMUBu0BODXjsCDk+H=w@mail.gmail.com> <CAD=FV=W6Z1TG4vQcDDeNsGkjZVAR8=A1L1pDfo1rDFCh84H4Rg@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 19 May 2022 17:34:18 -0700
Message-ID: <CAE-0n50RXmaUsu5F9syJT-ZXzX8WacpJDFnhb1xQaou1Pxizng@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/dp: Add wait_hpd_asserted() callback to struct drm_dp_aux
To:     Doug Anderson <dianders@chromium.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2022-05-12 16:24:13)
> On Wed, May 11, 2022 at 6:58 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > Quoting Douglas Anderson (2022-04-18 10:17:54)
> > > diff --git a/include/drm/dp/drm_dp_helper.h b/include/drm/dp/drm_dp_helper.h
> > > index 53d1e722f4de..0940c415db8c 100644
> > > --- a/include/drm/dp/drm_dp_helper.h
> > > +++ b/include/drm/dp/drm_dp_helper.h
> > > @@ -2035,6 +2035,32 @@ struct drm_dp_aux {
> > >         ssize_t (*transfer)(struct drm_dp_aux *aux,
> > >                             struct drm_dp_aux_msg *msg);
> > >
> > > +       /**
> > > +        * @wait_hpd_asserted: wait for HPD to be asserted
> > > +        *
> > > +        * This is mainly useful for eDP panels drivers to wait for an eDP
> > > +        * panel to finish powering on. This is an optional function.
> >
> > Is there any use for the opposite direction? For example, does anything
> > care that HPD is deasserted?
>
> Not that I'm aware of. Originally I was planning to have it so that a
> timeout of "0" meant to just poll without sleeping at all, but it
> ended up making the code a lot more complicated because everywhere
> else we had the "readx" semantics where 0 meant wait forever. It
> didn't seem worth it. I can go back to that behavior if need be.
>

Got it.

>
> > > +        *
> > > +        * This function will efficiently wait for up to `wait_us` microseconds
> > > +        * for HPD to be asserted and might sleep.
> > > +        *
> > > +        * This function returns 0 if HPD was asserted or -ETIMEDOUT if time
> > > +        * expired and HPD wasn't asserted. This function should not print
> > > +        * timeout errors to the log.
> > > +        *
> > > +        * The semantics of this function are designed to match the
> > > +        * readx_poll_timeout() function. That means a `wait_us` of 0 means
> > > +        * to wait forever. If you want to do a quick poll you could pass 1
> > > +        * for `wait_us`.
> >
> > It would also make sense to have a drm_dp_wait_hpd_asserted() API
> >
> >   int drm_dp_wait_hpd_asserted(struct drm_dp_aux *aux, unsigned long wait_us);
> >
> > and then this aux function could be implemented in various ways. The API
> > could poll if the aux can only read immediate state of HPD, or it could
> > sleep (is sleeping allowed? that isn't clear) and wake up the process
> > once HPD goes high. Or if this op isn't implemented maybe there's a
> > fixed timeout member that is non-zero which means "sleep this long".
> > Either way, making each drm_dp_aux implement that logic seems error
> > prone vs. having the drm_dp_aux implement some function for
> >
> >         get_immediate_hpd(struct drm_dp_aux *aux)
>
> There's a reason why I changed the API to "wait" from "get". If you
> can think of a good place to document this, I'm all ears.
>
> The basic problem is ps8640 (my nemesis, apparently). On ps8640,
> because of the black box firmware blob that's on it, we have a crazy
> long delay in its runtime resume (300ms). So what happens with ps8640
> is that if we make the API "get_immediate_hpd()" it wasn't so
> immediate. Even with autosuspend, that first "get" could take 300 ms,
> which really screwed with everyone else who was waiting with a 200 ms
> timeout.
>
> Now, in theory, one could argue that the fact that ps8640 had a 300 ms
> sleep would mean that the very first "get" of the panel would already
> show HPD high. I don't know why that wasn't the case, but ps8640 is an
> annoying black box.
>
> In general, though, the DP controller might need some amount of time
> to power itself back up and configure itself. Even though the ps8640
> case is extreme, it wouldn't be totally extreme to assume that an AUX
> controller might take 20 ms or 50 ms to power up. That could still
> throw timings off. Implementing the API as a "wait" style API gets
> around this problem. Now the DP controller can take as long as it
> needs to power itself up and it can then wait with the requested
> timeout.

To clarify, are you saying that the 'wait' passed in will be added to
whatever time it takes for the driver to runtime resume to check HPD
status? Or is the driver supposed to subtract any time to power up from the
'wait' passed in and then poll or wait for an irq about HPD?

Would it be incorrect to somehow have the pm_runtime_get_sync() call in
the mythical wrapper API with a ktime_get() before and after and then
subtract that from the 'wait' time and call "get_immediate_hpd()"?

It would help me understand further if the 'wait' is described as a
maximum time we're willing to wait or a minimum time we're willing to
wait for hpd to be asserted. Usually a timeout is the maximum we're
willing to wait so I think you're saying the wait is the maximum time
after we know the drm_dp_aux is fully powered up and ready to check the
state.
