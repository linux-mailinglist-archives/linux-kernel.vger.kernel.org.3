Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA834B6F35
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbiBOOjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:39:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiBOOjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:39:08 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1048E102405;
        Tue, 15 Feb 2022 06:38:58 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id o10so17481320qkg.0;
        Tue, 15 Feb 2022 06:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0ow2l97FBadE8xYyNQO77wV9BV8c9FeJliZ8Zblp7o=;
        b=OvCv7l+IVLWiIYmrA/eyOyIiGsNr6rEC7SJ7SI0ykniYkMXuIlbJcyiIniSJZegR2Q
         ltJkoPKJSaCAcHmU2ItgB4h4Q2BMMyJpPrb5qq2ol+JxDJQhMIir73svlUhYVpbFqcEI
         tJVivfur2J2rZ4jI/Uqc9oeXE3FMfu6wIDttguFk/9lgOFkcevAPJYhU6Zj7Fx8tZCuW
         ehg5xjdZQpWY7QJ1PPdvodk1qObW598mPzqHm2H6yM7E6tmgab8eRc6qu2hOx6UhhA7v
         NZkXXBD8h4kSdipkJVyWNWpwOCY2NbcsJRpT8LKWTFz26koS2tf+T93JWDH2qnn2Vihr
         UoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0ow2l97FBadE8xYyNQO77wV9BV8c9FeJliZ8Zblp7o=;
        b=NHLfp1sq8rWQ95mAa3gF0P0pcrMGUwx1KbtlLpO8RQHw88vYKWvDjWn+KTVbgLrFPZ
         Npk2ZC3RZVCqxzbkBSu9+2NyVTtTQw77y3lJ1qJARLDNrQMdjO6lWUmxoDZaujYOzCFX
         NVFAmjp1+051S6216rmMYLgqE3tgDx2WMqU22Wdfd/1su3GwtSyUP5crXXtzj3+N2gtN
         6YPuRjNEEmMiKO1zIrV2ZhxHXbwi8Rc0RuGipyYWNzdoZn2xR70l1TxwqeNvweQ3ykFA
         6LVr8wgMa0fK1FVgZWazhkoE0y5AIkI2iegMMiSWerhXlt2nY97FhGYUeuTIVov/TL3U
         V/Fg==
X-Gm-Message-State: AOAM531hrU+eFEfm9z5y3ai05duPqwuBQzzRXwjl6+GeeJEEgFs2HEsW
        31K8EdGNxq2j6gXmlaNBRE4rLuDoVf43w8jT+Ys=
X-Google-Smtp-Source: ABdhPJzqxLfXDw78xLjeX6QcKbH1M0Mn2Y5YmSQ2IiVXkB4upL2T729wSv3PGfvAcUcBZDUXQTcovh+9YqwVs83tlCM=
X-Received: by 2002:a05:620a:4042:: with SMTP id i2mr2065887qko.592.1644935937193;
 Tue, 15 Feb 2022 06:38:57 -0800 (PST)
MIME-Version: 1.0
References: <20220208084234.1684930-1-hsinyi@chromium.org> <CACvgo53u01BK_D0ZssV+gCepjxSz23Nr5Dy1qXeaAoJuu6VCFQ@mail.gmail.com>
 <KW6DNh6IRRgVJx9DfOFBnEqc4a0x-AnDXEbMxwpfEbk8dOn_KGVzAfo-slJWq-4nWW728Uc-OVpFh2w4fDE4-bxfkDuz1hFILRVvbcuXqaw=@emersion.fr>
In-Reply-To: <KW6DNh6IRRgVJx9DfOFBnEqc4a0x-AnDXEbMxwpfEbk8dOn_KGVzAfo-slJWq-4nWW728Uc-OVpFh2w4fDE4-bxfkDuz1hFILRVvbcuXqaw=@emersion.fr>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 15 Feb 2022 14:38:45 +0000
Message-ID: <CACvgo532-pC+7DLFCo=DWTX-OnJEJvSoTmQnt3_qLhiT4cqEMg@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v8 1/3] gpu: drm: separate panel orientation
 property creating and value setting
To:     Simon Ser <contact@emersion.fr>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Harry Wentland <harry.wentland@amd.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        LAKML <linux-arm-kernel@lists.infradead.org>
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

On Tue, 15 Feb 2022 at 13:55, Simon Ser <contact@emersion.fr> wrote:
>
> On Tuesday, February 15th, 2022 at 13:04, Emil Velikov <emil.l.velikov@gmail.com> wrote:
>
> > Greetings everyone,
> >
> > Padron for joining in so late o/
> >
> > On Tue, 8 Feb 2022 at 08:42, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > >
> > > drm_dev_register() sets connector->registration_state to
> > > DRM_CONNECTOR_REGISTERED and dev->registered to true. If
> > > drm_connector_set_panel_orientation() is first called after
> > > drm_dev_register(), it will fail several checks and results in following
> > > warning.
> > >
> > > Add a function to create panel orientation property and set default value
> > > to UNKNOWN, so drivers can call this function to init the property earlier
> > > , and let the panel set the real value later.
> > >
> >
> > The warning illustrates a genuine race condition, where userspace will
> > read the old/invalid property value/state. So this patch masks away
> > the WARNING without addressing the actual issue.
> > Instead can we fix the respective drivers, so that no properties are
> > created after drm_dev_register()?
> >
> > Longer version:
> > As we look into drm_dev_register() it's in charge of creating the
> > dev/sysfs nodes (et al). Note that connectors cannot disappear at
> > runtime.
> > For panel orientation, we are creating an immutable connector
> > properly, meaning that as soon as drm_dev_register() is called we must
> > ensure that the property is available (if applicable) and set to the
> > correct value.
>
> Unfortunately we can't quite do this. To apply the panel orientation quirks we
> need to grab the EDID of the eDP connector, and this happened too late in my
> testing.
>
> What we can do is create the prop early during module load, and update it when
> we read the EDID (at the place where we create it right now). User-space will
> receive a hotplug event after the EDID is read, so will be able to pick up the
> new value if any.

Didn't quite get that, are you saying that a GETPROPERTY for the EDID,
the ioctl blocks or that we get an empty EDID?

The EDID hotplug even thing is neat - sounds like it also signals on
panel orientation, correct?
On such an event, which properties userspace should be re-fetching -
everything or guess randomly?

Looking through the documentation, I cannot see a clear answer :-\

Thanks
Emil
