Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D74E4F394E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378085AbiDELbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244286AbiDEIvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:51:55 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72CAD4C8D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 01:40:41 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id r10so8300894eda.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 01:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=QRQdW4TxY/XkOYOT3oxLG3OIsaxqVCqvMm2visUSAZI=;
        b=R5WyFM3Hb3GT2s4H08DzUIMQiUCuX9Lg5BSB6FtLOqpb9+K0R/+NXBIvm5gKP5c9J3
         9uKEocy6gvBxFpFp3qCT0vApX1ZAxWoy2UjfBaiGsZGlxJO8MBrCopzDmKf7hLQSHfEx
         1t/1TiVB/Zv+FY3jh4d8cFdSJTjj852yReO4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=QRQdW4TxY/XkOYOT3oxLG3OIsaxqVCqvMm2visUSAZI=;
        b=pxM9nim1RMDCMHV2ngZ9qW3oqdOG1IYoFkKaL49+ttdbYROq70IP1ZyxYNOqkXkgpt
         GyE0CVxBKKpvVPexNYbhYQBkUhH53sd1Tueag68dGAl/NkVZmDIqcb5345Ohruhev7UB
         ddomkJ/pPvc0hFrk638nihXG4hracGDvOzDM9jsYCgYsepurjy4DGS3VYb6zpXxGVxfO
         L7XbBxr/31FA09GoKZkFUqvVZ65qM/QosRQFNrLXrShXx0Vk8x6T363HJqvnYln2xrjy
         SRSr1dIM0pBN6hEg0GroKPx8EhzRVsl37liLUoSILVRO1LUK8OXSa+oQQz8Q9eM16hVU
         493Q==
X-Gm-Message-State: AOAM530roTsZnlfIf/03YGfqLbWa0pm50F1sCHK9rViabhG9nwuqwLs/
        rFArVQEaLFmByhQtdSEsSMrFlg==
X-Google-Smtp-Source: ABdhPJxdMNTJdlht0ASSjqOZpmGfUZPUZ3aVJQxSpEJt0tJUibhrkRySvqoqStIMLvI+YtZTojtm1Q==
X-Received: by 2002:a05:6402:31e2:b0:41c:dd5e:3c61 with SMTP id dy2-20020a05640231e200b0041cdd5e3c61mr2342747edb.407.1649148039950;
        Tue, 05 Apr 2022 01:40:39 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d7-20020a170906174700b006e80a7e3111sm568499eje.17.2022.04.05.01.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 01:40:39 -0700 (PDT)
Date:   Tue, 5 Apr 2022 10:40:37 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Zack Rusin <zackr@vmware.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Jones <pjones@redhat.com>
Subject: Re: [PATCH v2 18/19] Revert "fbdev: Prevent probing generic drivers
 if a FB is already registered"
Message-ID: <YkwAhSt9HlbxcuZo@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Zack Rusin <zackr@vmware.com>, Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Jones <pjones@redhat.com>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
 <20220208210824.2238981-19-daniel.vetter@ffwll.ch>
 <4ae20b63-f452-fdb4-ced6-d4968a8d69f0@redhat.com>
 <Ykv/k/WoVemoCJJA@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ykv/k/WoVemoCJJA@phenom.ffwll.local>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 10:36:35AM +0200, Daniel Vetter wrote:
> On Wed, Feb 09, 2022 at 01:19:26AM +0100, Javier Martinez Canillas wrote:
> > On 2/8/22 22:08, Daniel Vetter wrote:
> > > This reverts commit fb561bf9abde49f7e00fdbf9ed2ccf2d86cac8ee.
> > > 
> > > With
> > > 
> > > commit 27599aacbaefcbf2af7b06b0029459bbf682000d
> > > Author: Thomas Zimmermann <tzimmermann@suse.de>
> > > Date:   Tue Jan 25 10:12:18 2022 +0100
> > > 
> > >     fbdev: Hot-unplug firmware fb devices on forced removal
> > > 
> > > this should be fixed properly and we can remove this somewhat hackish
> > > check here (e.g. this won't catch drm drivers if fbdev emulation isn't
> > > enabled).
> > >
> > 
> > Unfortunately this hack can't be reverted yet. Thomas' patch solves the issue
> > of platform devices matched with fbdev drivers to be properly unregistered if
> > a DRM driver attempts to remove all the conflicting framebuffers.
> > 
> > But the problem that fb561bf9abde ("fbdev: Prevent probing generic drivers if
> > a FB is already registered") worked around is different. It happens when the
> > DRM driver is probed before the {efi,simple}fb and other fbdev drivers, the
> > kicking out of conflicting framebuffers already happened and these drivers
> > will be allowed to probe even when a DRM driver is already present.
> > 
> > We need a clearer way to prevent it, but can't revert fb561bf9abde until that.
> 
> Yeah that entire area is a mess still, ideally we'd have something else
> creating the platform devices, and efifb/offb and all these would just
> bind against them.
> 
> Hm one idea that just crossed my mind: Could we have a flag in fb_info for
> fw drivers, and check this in framebuffer_register? Then at least all the
> logic would be in the fbdev core.

Ok coffee just kicked in, how exactly does your scenario work?

This code I'm reverting here is in the platform_dev->probe function.
Thomas' patch removes the platform_dev. How exactly can you still probe
against a platform dev if that platform dev is gone?

Iow, now that I reponder your case after a few weeks I'm no longer sure
things work like you claim.

There is the issue that offb still bidns without a platform_dev, but
that's not affected by this patch here.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
