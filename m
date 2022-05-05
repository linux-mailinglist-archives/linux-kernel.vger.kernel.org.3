Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122C551BEE6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359589AbiEEMPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244504AbiEEMPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:15:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C709B6412
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 05:11:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bv19so8332944ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 05:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=N08Sho3YmOzZV4Xmv5ubYbgs6HE2xL/dzKMzdTYL8gA=;
        b=iWDokVh+M+PJFJ4WXspIWRIr4xZBwoG5kib0tP8dS8ZnRJkbDIW9+ZVzIN8uQ6TuBY
         PkUxBRJ9j/Ko3VCKffcIo1diKYGul7Av4a273Hf7+ApnJcM872uaXA50YZoUmfwhuo0U
         /WjIA5wjPYH/gD0rGarI+Mm1TBf+hDrr/JtHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=N08Sho3YmOzZV4Xmv5ubYbgs6HE2xL/dzKMzdTYL8gA=;
        b=SCLWH9O1stmQrKJyyyh75Js/olDLbrZRr+B0WGXedx5av/ft63aY5q5/xukXB2+7p9
         SL9/W8Dd5QjXjJFne4Y0vrVa++HDd/I9h+NtltWAxsNr3u2PkD2T2GWRtD+eympo+wF0
         R2gg7SlblyAQOWIA8d6KgAVCt86qTKE+p5sRzKPtEC5EJ7zswVPRZeIBHksRZJagrOmG
         hrKw+ikwCY/j8PYGNhhAxs7OPnWP6SYN9lXAzVAuD2rb1RmrGNuu3dbdAGaUQuO05ORR
         UgPxwcnxDlCQ5KYYzVfay+CxSVxeCa5A8hlus+JHPeDRlWQsOm4wPcV7oMKJ7PaPn8EU
         n2Mg==
X-Gm-Message-State: AOAM531nNwMkR43qvTY/wGE8vZxYd3MdcQnXs9d5IG3WJ60iSyQNkHJp
        KclQPMoPq9P23nwHZxBAG3cgjA==
X-Google-Smtp-Source: ABdhPJwq3J4tX4uCUfKvT72QVZzU32c80ZumjeVZ0kKs7MA8Ur8AGGK7TytwyRYTa7mQmaP6Et++tA==
X-Received: by 2002:a17:906:c156:b0:6f3:9e3c:5cc8 with SMTP id dp22-20020a170906c15600b006f39e3c5cc8mr25652607ejc.17.1651752692375;
        Thu, 05 May 2022 05:11:32 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a13-20020aa7c80d000000b0042617ba63d6sm715903edt.96.2022.05.05.05.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 05:11:31 -0700 (PDT)
Date:   Thu, 5 May 2022 14:11:30 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 3/3] drm: Allow simpledrm to setup its emulated FB as
 firmware provided
Message-ID: <YnO+8hZ0ozPaZUEj@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org
References: <20220503071540.471667-1-javierm@redhat.com>
 <20220503071540.471667-4-javierm@redhat.com>
 <YnJcaaDcIsJKhSwQ@phenom.ffwll.local>
 <bfb03d40-a023-12a9-9554-1b6e6c474134@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfb03d40-a023-12a9-9554-1b6e6c474134@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 01:32:37PM +0200, Javier Martinez Canillas wrote:
> On 5/4/22 12:58, Daniel Vetter wrote:
> > On Tue, May 03, 2022 at 09:15:40AM +0200, Javier Martinez Canillas wrote:
> >> Indicate to fbdev subsystem that the registered framebuffer is provided by
> >> the system firmware, so that it can handle accordingly. For example, would
> >> unregister the FB devices if asked to remove the conflicting framebuffers.
> >>
> >> Add a new DRM_FB_FW field to drm_fbdev_generic_setup() options parameter.
> >> Drivers can use this to indicate the FB helper initialization that the FB
> >> registered is provided by the firmware, so it can be configured as such.
> >>
> >> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> >> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> >> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >> ---
> >>
> >> Changes in v3:
> >> - Drop the firmware local variable (Laurent Pinchart).
> >> - Use DRM_FB_OPTION() since DRM_FB_SET_OPTION() got renamed (kernel test robot).
> > 
> > Just for the record what I brought up on irc already:
> > 
> > FBINFO_MISC_FIRMWARE is purely an internal flag with no uapi impact, and
> > it's only to control whether we nuke this from
> > remove_conflicting_framebuffer or not. Since simpledrm only ever binds
> > against sysfb I think it'd be cleaner to only rely on that, and relegate
> 
> That's not actually true. The OF subsystem also registers "simple-framebuffer"
> devices when there are Device Tree nodes that contain a "simple-framebuffer"
> compatible string. In that case these pdev will also bind against simpledrm.

TIL.

> > that entire FBINFO_MISC_FIRMWARE misc hack to the fbdev dungeons and let
> > it quietly wither away there.
> >
> > Also I'm not a huge fan of these midlayer flags in general :-)
> 
> And while I agree with you that these midlayer flags are horrible, that is
> what any other fbdev that makes use of a firmware-provided framebuffer set,
> so simpledrm emulated fbdev shouldn't be the exception IMO.

So we discussed this a pile more on irc, and at least my take is that
people who run simpledrm but want to combine that with fbdev drivers and
expect it to all work nicely we can probably ignore. At least until all
this sysfb stuff is nicely unified, and at that point we shouldn't need
special flags anymore.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
