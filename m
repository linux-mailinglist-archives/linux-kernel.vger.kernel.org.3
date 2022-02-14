Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012094B4E21
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350727AbiBNLWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:22:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352167AbiBNLVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:21:41 -0500
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFF36584;
        Mon, 14 Feb 2022 02:57:33 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id bj24so2875205vkb.8;
        Mon, 14 Feb 2022 02:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3C7RZsUPH67gE+tnYDZyMgOb/jtRDu7g+Ix4wmjevW8=;
        b=UaBHozIXPe18+KgmQSXZZsLH7SSOP6Unk2JCtECYxGRLVEW5CJ5OYUp/F3dPILiFJs
         sjojXymmPqTInSoW7Yule3Fvk5cEe3lokUhJH3eXho1sLjOA1FWH6XMORuWrXUvO6oIJ
         VReqC/pHF5BvFrh8f3bdG4PGzaczvr8irTtdIdDiRRu4zNNEpTQGkzFU0x7jHUf48GRq
         cvZKYBzx6vNxL88uBGNL56FT8tzuAdVMlnKWZnp93/pn1WJDgWRhbNfJ0GXjXltE3kSS
         sL3Lq0qYUE6IV3n74a8dPUk7gpjHk6ZDMgvOJKMP95QIMhZ9C8kGbovqUPbvVdHjPXcH
         rQKA==
X-Gm-Message-State: AOAM533lXWLhvlN7nS30pj5Qx8vxtU4/Q0G4XbrKpTtL/qIXT0FwFZpQ
        johaid3TCqffMVcRQXQjeG5cz07ISJetAA==
X-Google-Smtp-Source: ABdhPJzwKuNmxyGuDSGVgNeCo3ap3+ytp+2it/27uxcpIZ5Ql2gOJeGlJOFOle9Dq7DeUHBZ0AZ9jg==
X-Received: by 2002:a05:6122:1c5:: with SMTP id h5mr3712385vko.2.1644836252598;
        Mon, 14 Feb 2022 02:57:32 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 2sm738511vkn.35.2022.02.14.02.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 02:57:32 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id j20so4377376vsg.5;
        Mon, 14 Feb 2022 02:57:31 -0800 (PST)
X-Received: by 2002:a05:6102:440d:: with SMTP id df13mr1065090vsb.5.1644836251571;
 Mon, 14 Feb 2022 02:57:31 -0800 (PST)
MIME-Version: 1.0
References: <20220211091927.2988283-1-javierm@redhat.com> <20220211091927.2988283-2-javierm@redhat.com>
 <YgY6OqN+guBlt/ED@smile.fi.intel.com> <4fa465d9-4fac-4199-9a04-d8e09d164308@redhat.com>
 <YgZEuXvJ2ZiOyNS+@smile.fi.intel.com> <7560cd10-0a7c-3fda-da83-9008833e3901@suse.de>
 <87pmnt7gm3.fsf@intel.com> <YgaDj6Wld4b7S6DF@smile.fi.intel.com>
 <f87ce2fa-6b18-f985-eb86-506ce7103db3@suse.de> <YgoxFBGNsrezVxmi@smile.fi.intel.com>
In-Reply-To: <YgoxFBGNsrezVxmi@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Feb 2022 11:57:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVWUDo3v+=+Um_8_ys-a-5HovGTUeYjvkQ91R_JDf0Myg@mail.gmail.com>
Message-ID: <CAMuHMdVWUDo3v+=+Um_8_ys-a-5HovGTUeYjvkQ91R_JDf0Myg@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] drm/format-helper: Add drm_fb_xrgb8888_to_gray8_line()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Feb 14, 2022 at 11:39 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Feb 14, 2022 at 10:03:53AM +0100, Thomas Zimmermann wrote:
> > Am 11.02.22 um 16:41 schrieb Andy Shevchenko:
> > > > IMO *always* prefer a for loop over while or do-while.
> > > >
> > > > The for (i = 0; i < N; i++) is such a strong paradigm in C. You
> > > > instantly know how many times you're going to loop, at a glance. Not so
> > > > with with the alternatives, which should be used sparingly.
> > >
> > > while () {}  _is_ a paradigm, for-loop is syntax sugar on top of it.
> >
> > Naw, that's not true.
>
> In the section 3.5 "Loops - While and For" in "The C Programming
> Language" 2nd by K&R, the authors said:
>
>         The for statement ... is equivalent to ... while..."
>
> They said that for is equivalent to while, and not otherwise.

When I learned C, people told me to prefer while() over for() when
possible, as several compilers are better at optimizing while()-loops
than for()-loops.

During the last 3 decades, optimizers got better, and all the bad
old compilers went the way of the dodo (see also [1])...
But even for a human, it's still less symbols to decode (and verify
all the details about =/</>/<=/>=/++/--/...) for

    while (n--) { ... }

than for

   for (i = 0; i < n; i++) { ... }

[1] https://lwn.net/Articles/871283/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
