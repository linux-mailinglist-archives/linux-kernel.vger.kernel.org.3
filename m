Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5949495B59
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379332AbiAUH5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:57:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379232AbiAUH4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:56:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642751795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m2Ho/lCZKO10EzmqqcIcm9qmBssIoEL4oIglAIQFltM=;
        b=NkUymEuQfICVF0n6My8trFNrxc1UYZmm2CcebWHGKCjguESu7csN5XnwTJ/WWtIFUgmpYR
        GCKXWRRkCDnH1N53D49jqHYnzDjxmJpCllho7F/ST4Y/cTOqT0EOm6/5cn84jCa4mDDRv6
        fkKka2+B9+jSx6P+Bo4vy6NxrOvAswE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-qmajEbmeOGKJKS2Wspa7_w-1; Fri, 21 Jan 2022 02:56:30 -0500
X-MC-Unique: qmajEbmeOGKJKS2Wspa7_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 088D084DA42;
        Fri, 21 Jan 2022 07:56:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 22F6970D21;
        Fri, 21 Jan 2022 07:56:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A8B8F180060F; Fri, 21 Jan 2022 08:20:06 +0100 (CET)
Date:   Fri, 21 Jan 2022 08:20:06 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Helge Deller <deller@gmx.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, Sven Schnelle <svens@stackframe.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Ravnborg <sam@ravnborg.org>, Claudio Suarez <cssk@net-c.es>
Subject: Re: [PATCH 2/2] Revert "fbcon: Disable accelerated scrolling"
Message-ID: <20220121072006.ylw2hdl7jbkbwnre@sirius.home.kraxel.org>
References: <20220119110839.33187-1-deller@gmx.de>
 <20220119110839.33187-3-deller@gmx.de>
 <YelyGDNDTn1Aq/hm@phenom.ffwll.local>
 <6c000477-002b-d125-b945-2c4831bad8a5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c000477-002b-d125-b945-2c4831bad8a5@gmx.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > So if this really has to come back then I think the pragmatic approach is
> > to do it behind a CONFIG_FBCON_ACCEL, default n, and with a huge warning
> > that enabling that shouldn't be done for any distro which only enables
> > firmware and drm fbdev drivers.
> 
> Thanks for coming back on this, but quite frankly I don't understand
> that request. How should that warning look like, something along:
> "BE WARNED: The framebuffer text console on your non-DRM supported
> graphic card will then run faster and smoother if you enable this option."
> That doesn't make sense. People and distros would want to enable that.

Nope.  Most distros want disable fbdev drivers rather sooner than later.
The fbdev drivers enabled in the fedora kernel today:

	CONFIG_FB_VGA16=m
	CONFIG_FB_VESA=y
	CONFIG_FB_EFI=y
	CONFIG_FB_SSD1307=m

CONFIG_FB_VESA + CONFIG_FB_EFI will go away soon, with simpledrm taking
over their role.

> And if a distro *just* has firmware and drm fbdev drivers enabled,
> none of the non-DRM graphic cards would be loaded anyway and this code
> wouldn't be executed anyway.

Yes, exactly.  That's why there is no point in compiling that code.

take care,
  Gerd

