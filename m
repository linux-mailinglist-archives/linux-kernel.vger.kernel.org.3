Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7471D51436B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 09:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355261AbiD2Hu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 03:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349299AbiD2Hux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:50:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B33B0D2C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 00:47:36 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i19so13815411eja.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 00:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VUCWa3lSIaNzDwHCn+z/F0FVFVoykexDHXhwFfLqcXs=;
        b=Hb9Qr18ymp5oDvIwpneOgr2tAoqL9sBJ7zKZgSyrpcbSV5mYNUK9omsjGB2BUHy+wF
         hvNETRF2PNhs7QD9/wvRRjDcTsr8N9DePY6cH8hHGqe1tUFA4SY2HS0R26d67pVic+WS
         nfGHe2KFkWF9WqSUjRo8/UlNwH/umWyfvVFqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=VUCWa3lSIaNzDwHCn+z/F0FVFVoykexDHXhwFfLqcXs=;
        b=UdzNRye6MErUI1HdJfjjec35C5utX3EOCLJd2hPaW9dNk2vsbjuLB0AB2EnItX9+zO
         ECbwC589dJ/u38qfrVety811l6UGxYsciEtAQGX8kpkRa3Bb/gr4xx7MgnQU3q/eTK8k
         aN/wjLiTWL/jMYx9dE22IPhkZ8GHIwjaJTd9v8iZX1rLDnKo2RoPQ/gEnFyPB4opF2m0
         3AwlagOSyuezzbS8yxR7Rn0GZyuFA0SNlHH+Qz7Ouy7tsOs0qqNQlf6N1WGpF2BKHl97
         s6dAueOwUyor8WfmR4R4xxNmPGEFDvFrAjdJ1lDFaDpbBlYiMms7/hyKbWJcKAPryrWN
         013A==
X-Gm-Message-State: AOAM530y7Y/psfxQr23UHCuYEi1EaFC00W4vkU6PbVGnLr6urE/C3VzT
        KufxajJ84rMM4aTgVJMTrpew/Q==
X-Google-Smtp-Source: ABdhPJx0LzJCI67IHW7p4FMMHHkPQKC/N0VzjjyRtPZ0oOI21KH7mh9tFSrg8s64jQaUV9HW5qz+Kw==
X-Received: by 2002:a17:907:3f8f:b0:6f3:d4a0:e80c with SMTP id hr15-20020a1709073f8f00b006f3d4a0e80cmr8378065ejc.709.1651218453598;
        Fri, 29 Apr 2022 00:47:33 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id hv6-20020a17090760c600b006f3ef214e34sm389502ejc.154.2022.04.29.00.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 00:47:32 -0700 (PDT)
Date:   Fri, 29 Apr 2022 09:47:31 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Miaoqian Lin <linmq006@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Yizhuo Zhai <yzhai003@ucr.edu>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Fix some race conditions that exists between
 fbmem and sysfb
Message-ID: <YmuYE2t51lPIRT8p@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Hans de Goede <hdegoede@redhat.com>, Helge Deller <deller@gmx.de>,
        Johan Hovold <johan@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Miaoqian Lin <linmq006@gmail.com>, Peter Jones <pjones@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Yizhuo Zhai <yzhai003@ucr.edu>,
        Zhen Lei <thunder.leizhen@huawei.com>, linux-doc@vger.kernel.org,
        linux-fbdev@vger.kernel.org
References: <20220420085303.100654-1-javierm@redhat.com>
 <535ebbe4-605c-daf5-1afb-f5225e4bb3a8@suse.de>
 <093d742f-4c87-2ff3-e9fe-153cd734f8e4@suse.de>
 <220929be-91c4-d19c-b04f-312c5f7e9e40@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220929be-91c4-d19c-b04f-312c5f7e9e40@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 11:49:13AM +0200, Javier Martinez Canillas wrote:
> Hello Thomas,
> 
> Thanks for the feedback. It was very useful.
> 
> On 4/25/22 11:15, Thomas Zimmermann wrote:
> > Hi
> > 
> > Am 25.04.22 um 10:54 schrieb Thomas Zimmermann:
> >> Hi
> >>
> >> Am 20.04.22 um 10:52 schrieb Javier Martinez Canillas:
> >>> Hello,
> >>>
> >>> The patches in this series are mostly changes suggested by Daniel Vetter
> >>> to fix some race conditions that exists between the fbdev core (fbmem)
> >>> and sysfb with regard to device registration and removal.
> >>>
> >>> For example, it is currently possible for sysfb to register a platform
> >>> device after a real DRM driver was registered and requested to remove the
> >>> conflicting framebuffers.
> >>>
> >>> A symptom of this issue, was worked around with by commit fb561bf9abde
> >>> ("fbdev: Prevent probing generic drivers if a FB is already registered")
> >>> but that's really a hack and should be reverted.
> >>
> >> As I mentioned on IRC, I think this series should be merged for the 
> >> reasons I give in the other comments.
> >>
> 
> You meant that should *not* get merged, as we discussed over IRC.
> 
> >>>
> >>> This series attempt to fix it more properly and revert the mentioned 
> >>> hack.
> >>> That will also unblock a pending patch to not make the num_registered_fb
> >>> variable visible to drivers anymore, since that's internal to fbdev core.
> >>
> >> Here's as far as I understand the problem:
> >>
> >>   1) build DRM/fbdev and sysfb code into the kernel
> >>   2) during boot, load the DRM/fbdev modules and have them acquire I/O 
> >> ranges
> >>   3) afterwards load sysfb and have it register platform devices for the 
> >> generic framebuffers
> >>   4) these devices now conflict with the already-registered DRM/fbdev 
> >> devices
> >>
> 
> That's correct, yes.
> 
> >> If that is the problem here, let's simply set a sysfb_disable flag in 
> >> sysfb code when the first DRM/fbdev driver first loads. With the flag 
> >> set, sysfb won't create any platform devices. We assume that there are 
> >> now DRM/fbdev drivers for the framebuffers and sysfb won't be needed.
> >>
> >> We can set the flag internally from drm_aperture_detach_drivers() [1] 
> >> and do_remove_conflicting_framebuffers() [2].
> > 
> > And further thinking about it, it would be better to set such a flag 
> > after successfully registering a DRM/fbdev device.  So we know that 
> > there's at least one working display in the system. We don't have to 
> > rely on generic framebuffers after that.
> >
> 
> Exactly, should be done when the device is registered rather than when
> the driver is registered or a call is made to remove the conflicting FB.
> 
> I'll rework this series with only the bits for sysfb_disable() and drop
> the rest. We can go back to the discussion of the remaining parts later
> if that makes sense (I still think that patch 3/5 is a better approach,
> but let's defer that for a different series).

We need to kill sysfb _before_ the driver loads, otherwise you can have
two drivers fighting over each another. And yes that means you might end
up with black screen if the driver load goes wrong, but the two drivers
fighting over each another can also result in black screens. And the
latter isn't fixable any other way (in general at least) than by making
sure the fw stuff is gone before driver load starts in earnest.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
