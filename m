Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEB94B7B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244395AbiBOXMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:12:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238786AbiBOXMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:12:08 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D95F13F53
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:11:56 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id h11so176088ilq.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RS9LJJqmWh2HshOHeCWOhECU3+chlrbjdRDe3zN6X9M=;
        b=H3bimkVRJOknA0aIROgu2Emj9m+d2cHFSVAZdO3VDMB9C2wmDyi0GpYAphtkdW5T9l
         t2vyE2yOlh0+55slm821IvlxRGaKvbnhxFvzX4eRbrxX7KE9aJqBlZqzyLfQbcaGAcB5
         i8Toqhd012JS44MZovroT1JLm5LHghliYvR6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RS9LJJqmWh2HshOHeCWOhECU3+chlrbjdRDe3zN6X9M=;
        b=us80kALiUh37C15lmoylpnaKCjpQEcTsUV89ZpraxuS4ubqeDUgiyeLP10bvKHIsWd
         O0oRss3a7HVkA9qJ2uwS1IkjGuNEHt0RjxwYnND2aFKFQ4s5U8OFHNeYvTzda74iuUGX
         5VWrlSHWjG7O7tIMRY4V91rBpO6K4hhw/2bWQ5Bdk+pcDPWEF9VLZVm5Kvlexq5JJTxM
         mnFLH7Vjc1yaw1CY9JXI/sJc9l8WalydhffXQ+NcU3DFqbKCq/b2k1tq1G+pqOaHbCH8
         0L+UUVXbJcAVKG3MsEFO/CCrOqJWDliQBWbDGfO8gzPJnpzV9sydCl7cTwywOoj/MP4Y
         ZFpg==
X-Gm-Message-State: AOAM5334iAFu6rm1GGsS6nRS00Zu8NnyNEVTBBMSwa50ARm2KEaXVNi8
        L2G5SYrRuJXTBEstJYRqu9nX351GgixWlQ==
X-Google-Smtp-Source: ABdhPJxLVaIpJLGSQ6C1m3N2IqJn3iGoUKr++u44ETurWC2ZkyNHQztQZ5xc0MIIGTwUdr3sbzAe0A==
X-Received: by 2002:a05:6e02:1788:b0:2be:ffc9:8bb2 with SMTP id y8-20020a056e02178800b002beffc98bb2mr22130ilu.294.1644966715424;
        Tue, 15 Feb 2022 15:11:55 -0800 (PST)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id x1sm22589255ilc.34.2022.02.15.15.11.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 15:11:53 -0800 (PST)
Received: by mail-il1-f177.google.com with SMTP id d7so177703ilf.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:11:53 -0800 (PST)
X-Received: by 2002:a05:6e02:12ef:b0:2be:2c34:17b2 with SMTP id
 l15-20020a056e0212ef00b002be2c3417b2mr39472iln.120.1644966712975; Tue, 15 Feb
 2022 15:11:52 -0800 (PST)
MIME-Version: 1.0
References: <20220205001342.3155839-1-dianders@chromium.org>
 <20220204161245.v2.2.Ib0bd5346135cbb0b63006b69b61d4c8af6484740@changeid>
 <5d60473d-be8f-e2dc-2ce9-bc0b9056e4b4@redhat.com> <e6670fd7-1f75-56f7-b668-20db9902cac6@intel.com>
In-Reply-To: <e6670fd7-1f75-56f7-b668-20db9902cac6@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 15 Feb 2022 15:11:41 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Ut3N9syXbN7i939mNsx3h7-u9cU9j6=XFkz9vrh0Vseg@mail.gmail.com>
Message-ID: <CAD=FV=Ut3N9syXbN7i939mNsx3h7-u9cU9j6=XFkz9vrh0Vseg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm: Plumb debugfs_init through to panels
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Robert Foss <robert.foss@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>, jjsu@chromium.org,
        lschyi@chromium.org, Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 15, 2022 at 2:20 PM Andrzej Hajda <andrzej.hajda@intel.com> wrote:
>
> On 15.02.2022 23:09, Javier Martinez Canillas wrote:
> > Hello Doug,
> >
> > On 2/5/22 01:13, Douglas Anderson wrote:
> >
> > [snip]
> >
> >> +static void panel_bridge_debugfs_init(struct drm_bridge *bridge,
> >> +                                  struct dentry *root)
> >> +{
> >> +    struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
> >> +    struct drm_panel *panel = panel_bridge->panel;
> >> +
> >> +    root = debugfs_create_dir("panel", root);
> > This could return a ERR_PTR(-errno) if the function doesn't succeed.
> >
> > I noticed that most kernel code doesn't check the return value though...
> >
> >> +    if (panel->funcs->debugfs_init)
> > Probably if (!(IS_ERR(root) && panel->funcs->debugfs_init) ?
> >
> >> +            panel->funcs->debugfs_init(panel, root);
> >> +}
> > [snip]
> >
> >> @@ -436,6 +436,9 @@ void drm_debugfs_connector_add(struct drm_connector *connector)
> >>      /* vrr range */
> >>      debugfs_create_file("vrr_range", S_IRUGO, root, connector,
> >>                          &vrr_range_fops);
> > Same here, wonder if the return value should be checked.

My plan (confirmed with Javier over IRC) is to land my patches and we
can address as needed with follow-up patches.

I actually wrote said follow-up patches and they were ready to go, but
when I was trying to come up with the right "Fixes" tag I found commit
b792e64021ec ("drm: no need to check return value of debugfs_create
functions"). So what's being requested is nearly the opposite of what
Greg did there.

I thought about perhaps only checking for directories but even that
type of check was removed by Greg's patch. Further checking shows that
start_creating() actually has:

if (IS_ERR(parent))
  return parent;

...so I guess that explains why it's fine to skip the check even for parents?

Sure enough I confirmed that if I pass `ERR_PTR(-EINVAL)` as the root
for `panel->funcs->debugfs_init()` that nothing bad seems to happen...


> I've seen sometimes that file/dir was already created with the same
> name, reporting error in such case will be helpful.

It sure looks like start_creating() already handles that type of
reporting... Sure enough, I tried to create the "force" file twice,
adding no error checking myself, and I see:

debugfs: File 'force' in directory 'eDP-1' already present!
debugfs: File 'force' in directory 'DP-1' already present!


So tl;dr is that I'm going to land the patches and now am _not_
planning on doing followup patches. However, if I'm confused about any
of the above then please let me know and I'll dig more / can send
follow-up patches.

-Doug
