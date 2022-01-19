Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25685493E58
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356153AbiASQbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349278AbiASQbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:31:53 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195B0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 08:31:53 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n8so6140066wmk.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 08:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=JHPXrS2qN/gp4DPge+yQw/YJAFIsbcJAD04stx8TMDs=;
        b=duEaok0g/cyzPt5DW/HxLShjizs52YJm2C4Q4iDkbmzB8h1PxYgV6wHdI+2KA6SxWQ
         TEiMhtAZxmTKUJ+BatE/p38O0+59EWYhDQVdBuHi2mtSLrzkHWonA/lNiipQ7dlskxhd
         e7UlyY8dHWgUTf2iM8+Zc7by/KEWzDKid8qFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=JHPXrS2qN/gp4DPge+yQw/YJAFIsbcJAD04stx8TMDs=;
        b=bIN+jv6iYcbICp28BAyrYW7rqVD8F7EdqC8GJEMRPk2cVGI8Cf3sA4jKiXGzV005Dt
         KYpsW42vtfkl7N9qjofTunJ4fos94Zq6MgHmJw+ps/bweV8frAfcLR90Uy22VPdXhJll
         JMF5PC2xu8AYzO/wHwfpqEhvf/zPybSmZWDfigaRmMANjPpBkFQ4g5D9uHfw1r9hXU9K
         4fSoq55SDETnvsAMNWcvx4cH2ZzN0TZwZVuC7csPIHGARxcSvWkAUw7Gl0qOVTmoJHQ4
         9YNFqDy7lkmb2bHcyI0xrj6hNUYgNJCR6A3XwOieYUzYDCPyhz2EfHYYRQNAT0FupXPS
         PGFw==
X-Gm-Message-State: AOAM533Y004qnUvna25Urq1AudQWOlloaUI0U6sh84rWIpL3NdnKf2j1
        HYCQY6LDOLwqJMrD5s6Qok0rzA==
X-Google-Smtp-Source: ABdhPJxVXF24cz+9MngO0pmY2tmMrC8kRICutqpk0t8GupJtxIbwSe4uni7zW2JT6qBcKAQx7C4Zzw==
X-Received: by 2002:a7b:c0d3:: with SMTP id s19mr4333862wmh.66.1642609911708;
        Wed, 19 Jan 2022 08:31:51 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p4sm5625581wmq.40.2022.01.19.08.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 08:31:51 -0800 (PST)
Date:   Wed, 19 Jan 2022 17:31:49 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>,
        Sven Schnelle <svens@stackframe.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Claudio Suarez <cssk@net-c.es>,
        Gerd Hoffmann <kraxel@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 2/2] Revert "fbcon: Disable accelerated scrolling"
Message-ID: <Yeg89V9X+aNz3H1j@phenom.ffwll.local>
Mail-Followup-To: Jani Nikula <jani.nikula@linux.intel.com>,
        Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Claudio Suarez <cssk@net-c.es>, Gerd Hoffmann <kraxel@redhat.com>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Ravnborg <sam@ravnborg.org>
References: <Yef0j8+DBbwC7Kjv@kroah.com>
 <Yef15k2GtC40aJEu@kroah.com>
 <CAMuHMdVWFJEDwjf-htZ_D1484efmuPnz_L-qhcTeUE-GVpvZXA@mail.gmail.com>
 <4d8950c7-5f51-ca2b-4c93-741c7805a214@gmx.de>
 <CAHk-=wikFKjwdUBWCLCu=iL3rFq4BDDF0aBGdXC6ay74yJb+5Q@mail.gmail.com>
 <CAKMK7uEb53iu_HxYSnFZ59j=vXQdMvTWT7xosEo85XkAwzDMnA@mail.gmail.com>
 <8735ljkboo.fsf@x1.stackframe.org>
 <CAKMK7uHHF22+MBz5D2kBv07X2BR76UDi2-JP7eO-f=nm-pymcw@mail.gmail.com>
 <40d39363-bae8-93f2-71c6-7d5531f144bf@gmx.de>
 <87ilufbt58.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilufbt58.fsf@intel.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 06:13:39PM +0200, Jani Nikula wrote:
> On Wed, 19 Jan 2022, Helge Deller <deller@gmx.de> wrote:
> > On 1/19/22 16:42, Daniel Vetter wrote:
> >> If otoh you get the maintainership first to be able to cram in reverts
> >> without discussions, then it's very backwards.
> > I'm working on the Linux kernel since at least 23 years and am a maintainer of parts of it.
> > I know that and would never push something which is controversal without discussions.
> 
> I think the entire MAINTAINERS change was controversial and rushed to
> Linus without discussion over a weekend.

Yeah just looking at the size of the thread is pretty clear indiciation
that this went wrong real good.

And I said that you need to clean this up in my very first reply. None of
this should have been a surprise, but somehow it all happened.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
