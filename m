Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CFB49397C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 12:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354045AbiASL2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 06:28:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46618 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354091AbiASL2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 06:28:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3CAE61614;
        Wed, 19 Jan 2022 11:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFEAC004E1;
        Wed, 19 Jan 2022 11:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642591722;
        bh=ElyrY3LbS7t4UWyA3nEHAeLrBudEAMV1SNh2zYYZMrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H7ai/Do/xvZplRjwZrYAwLWE9d8RCzy+GFByCvkrfR12p/+GV42ByU1IoWfxknEpz
         wq1w32l6Ql0XBE+SlcWGIWuoJXsji6cLhoWNUyJiDxPyQlsbcpyXggteoogyGNHxSi
         +TmBym1WCkDUreD+U6s0isHLdqZjv3AqzxyeVfbo=
Date:   Wed, 19 Jan 2022 12:28:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, Sven Schnelle <svens@stackframe.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Ravnborg <sam@ravnborg.org>, Claudio Suarez <cssk@net-c.es>
Subject: Re: [PATCH 2/2] Revert "fbcon: Disable accelerated scrolling"
Message-ID: <Yef15k2GtC40aJEu@kroah.com>
References: <20220119110839.33187-1-deller@gmx.de>
 <20220119110839.33187-3-deller@gmx.de>
 <Yef0j8+DBbwC7Kjv@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yef0j8+DBbwC7Kjv@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 12:22:55PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 19, 2022 at 12:08:39PM +0100, Helge Deller wrote:
> > This reverts commit 39aead8373b3c20bb5965c024dfb51a94e526151.
> > 
> > Revert this patch.  This patch started to introduce the regression that
> > all hardware acceleration of more than 35 existing fbdev drivers were
> > bypassed and thus fbcon console output for those was dramatically slowed
> > down by factor of 10 and more.
> > 
> > Reverting this commit has no impact on DRM, since none of the DRM drivers are
> > tagged with the acceleration flags FBINFO_HWACCEL_COPYAREA,
> > FBINFO_HWACCEL_FILLRECT or others.
> > 
> > Signed-off-by: Helge Deller <deller@gmx.de>
> > Cc: stable@vger.kernel.org # v5.16
> 
> Why just 5.16?  This commit came in on 5.11 and was backported to
> 5.10.5.
> 
> As for "why", I think there was a number of private bugs that were
> reported in this code, which is why it was removed.  I do not think it
> can be safely added back in without addressing them first.  Let me go
> dig through my email to see if I can find them...

Ah, no, that was just the soft scrollback code I was thinking of, which
was a different revert and is still gone, thankfully :)

This one was just removed because Daniel noticed that only 3 drivers
used this (nouveau, omapdrm, and gma600), so this shouldn't have caused
any regressions in any other drivers like you are reporting here.

So perhaps this regression is caused by something else?

thanks,

greg k-h
