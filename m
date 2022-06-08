Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC9A5438DB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245447AbiFHQ04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245420AbiFHQ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:26:46 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B8E21831
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:26:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso4629364wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=PlENWwzlCM90o/vUAucZ/2PTf41RpbELMXSIvxOkRsg=;
        b=kUamzuMZKjBGedJ41D2CVba2W72DHDvLXgAu+IRALCFkrP3w078R1o53D+vRCSe01F
         rNkY2vVwnVV2VRLzYbzS3O+P9k5lDvVgJ5mKk0zXBbWb6hvTVl/V8nJzd0Lu6k2UhewB
         bsL613wbo/x5NaZd+K7hm5wT4WUp6zMhwLUQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=PlENWwzlCM90o/vUAucZ/2PTf41RpbELMXSIvxOkRsg=;
        b=UWFVTmYGLfZKhqGBiDXrA3ojtWzD/O21fEs/2DD0kbWkqrHW/KiiemqGKdvrNaEXx9
         66rEHil8Gy6dYzzasf52op7NxD3tAL6pM1TVFz7F4AXR9StBVbUzYq1ocMFZTSryUWdX
         D/o65BnDK7cU8CCnJqz+/c8q28KTv1yuckX9FHGC7kql9FOHtK0tyHrVJUpSJ4VcPgaA
         ZLPRn+pT8c2ZaC7eTPgw/Hdb775qLCrWJElzaVnix3fDdQN7VnWm8uwwmjbGDE5mHzRE
         PuwuTNTdQWSJkyAIiH33U4p5vVgH6MMyz4xqwnWMGo165RlRQQEMJF95Ji5vt4yoR1yM
         4Nng==
X-Gm-Message-State: AOAM531fWgIglIgeggw7xiNwp1FOZXi3xApkvfJbeFp/pzs8RDkv+jFv
        ReifChttqDYBf5gAn3zYzsImBA==
X-Google-Smtp-Source: ABdhPJyf8Brmkv7/K+wwJLIHpp3flqMDoBonSFPbtVBOY+CiA4pt1qQf2htU+BvHHGfYnZWx/UoWTA==
X-Received: by 2002:a05:600c:a42:b0:393:d831:bf05 with SMTP id c2-20020a05600c0a4200b00393d831bf05mr33885940wmq.187.1654705597681;
        Wed, 08 Jun 2022 09:26:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id e7-20020adff347000000b0020ff4b8efc6sm21701293wrp.80.2022.06.08.09.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 09:26:36 -0700 (PDT)
Date:   Wed, 8 Jun 2022 18:26:34 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] video: fbdev: Convert from PCI to generic power
 management
Message-ID: <YqDNuhopLfpHkTS7@phenom.ffwll.local>
Mail-Followup-To: Bjorn Helgaas <helgaas@kernel.org>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20220607231112.354165-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607231112.354165-1-helgaas@kernel.org>
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

On Tue, Jun 07, 2022 at 06:11:10PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> PCI-specific power management (pci_driver.suspend and pci_driver.resume) is
> deprecated.  If drivers implement power management, they should use the
> generic power management framework, not the PCI-specific hooks.
> 
> No fbdev drivers actually implement PCI power management, but there are a
> cirrusfb has some commented-out references to it and skeletonfb has
> examples of it.  Remove these.

Is this holding up some cleanup on your side and so would be easier to
merge these through the pci tree? If so

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

for merging through your tree. Otherwise I guess Helge will get around to
pile them up for 5.20 (or 6.0) eventually.

Cheers, Daniel
> 
> Bjorn Helgaas (2):
>   video: fbdev: cirrusfb: Remove useless reference to PCI power
>     management
>   video: fbdev: skeletonfb: Convert to generic power management
> 
>  drivers/video/fbdev/cirrusfb.c   |  6 ------
>  drivers/video/fbdev/skeletonfb.c | 13 +++++++------
>  2 files changed, 7 insertions(+), 12 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
