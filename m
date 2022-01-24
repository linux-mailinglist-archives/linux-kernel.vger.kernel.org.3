Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C0849A811
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1316199AbiAYCz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3412585AbiAYAhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:37:16 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A48C04A2EB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:20:00 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z22so58939962edd.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=eEy59pkxkuOQH3FeW+pSfh3uQlALKWQv5HMjnvMU5rg=;
        b=DQwAVK1iR3fLgmXYXEfL7+7cLKX03sBRjER8fTgucQYkrJNUWacuLJM2YnsodGggbU
         e21TjvZqBRoT9nS5oWjuI8nC5b0SGohIAKgtlU6LYkBfEqrrL0UYlIscsJh+fv1aMMod
         AiiwUTWTxp3o67D2YG91nlfEAi6w57aHkyTfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=eEy59pkxkuOQH3FeW+pSfh3uQlALKWQv5HMjnvMU5rg=;
        b=iVCrkG+oYTxuobhNjjIeP3UUatzwNnvZw3MjDXoLC9QRCxqRVBGoIO0QMRB8yUKv8g
         8HLVpAukyMK8sgDcYeIE5hnByIHOIzaNsqgdxd5cSqyVJlHSLQN4I+eLXmE9G+P+ANj0
         u1NpK/3vHWZ8oic+gr3xNSLVtXi4iNLQonPWdHWqUgRBS2H8hr9wMCTbtpiZvxuAJl1k
         QT278wHbQVomtSEfKxkBA43wcBUaNGM4vc2YO/PJVJZbDaTXwENXigTd4kk4mpeOaaXy
         43C5NkBaOHH+OeoYbAP2kMvp1fEcq3HrfUVodSfDygm6ypLRtUKggh3lUWaSKNuX59oJ
         spxA==
X-Gm-Message-State: AOAM533lVTbY1Gl42Jn/AOEw90K4Qm8wFZ4/GM2MDIrX05D+hbTMpf1Q
        BOR+r7y1qL0IRLS1wxXFe9VSbg==
X-Google-Smtp-Source: ABdhPJyTlhbl2apt+k2wVRRqmfZTzbLvqudlvHMLRnIH7f9F66oC+tM4Wg6VWcmjXE8/cwmhAEcyxw==
X-Received: by 2002:aa7:d55a:: with SMTP id u26mr17368585edr.265.1643062798593;
        Mon, 24 Jan 2022 14:19:58 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w22sm5362604ejj.64.2022.01.24.14.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 14:19:58 -0800 (PST)
Date:   Mon, 24 Jan 2022 23:19:56 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Schnelle <svens@stackframe.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Claudio Suarez <cssk@net-c.es>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 0/2] Fix regression introduced by disabling
 accelerated scrolling in fbcon
Message-ID: <Ye8mDFcWSiXoRJbD@phenom.ffwll.local>
Mail-Followup-To: Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Schnelle <svens@stackframe.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Claudio Suarez <cssk@net-c.es>, Gerd Hoffmann <kraxel@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220124210319.325512-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124210319.325512-1-deller@gmx.de>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:03:17PM +0100, Helge Deller wrote:
> This series reverts two patches which disabled scrolling acceleration in
> fbcon/fbdev. Those patches introduced a regression for fbdev-supported graphic
> cards because of the performance penalty by doing screen scrolling by software
> instead of using existing 2D hardware acceleration.
> 
> This series has been discussed on linux-fbdev, dri-devel and linux-kernel
> mailing lists. The consensus is that they will be reverted, but in addition
> it's being worked on to find a solution which allows to disable parts of the
> classic fbdev hardware acceleration code which isn't needed in DRM-only
> configurations.

That's not my take at least.

> The patchset is planned to be kept in fbdev's for-next git branch and later
> pushed into kernel v5.18 if no issues are found until then.

Neither this. I don't think we've resovled maintainership of fbdev core
code and fbcon yet. That is the part that drm folks very much still
maintained, as a quick git shortlog will show.

Maintaining these parts outside of drm trees just doesn't make sense,
since none of the other graphics relevant development happens outside of
drm.
-Daniel

> 
> Helge
> 
> ---
> Changes in v2 compared to v1:
> - adjusted the stable tags (one v5.10+, the other v5.16+)
> - moved the analysis and reasoning why those should be reverted into
>   the commit message. That simplifies to analyze later why they were
>   reverted.
> - resorted the To an Cc mail recipient lists
> 
> Helge Deller (2):
>   Revert "fbdev: Garbage collect fbdev scrolling acceleration, part 1
>     (from TODO list)"
>   Revert "fbcon: Disable accelerated scrolling"
> 
>  Documentation/gpu/todo.rst              |  24 --
>  drivers/video/fbdev/core/bitblit.c      |  16 +
>  drivers/video/fbdev/core/fbcon.c        | 540 +++++++++++++++++++++++-
>  drivers/video/fbdev/core/fbcon.h        |  59 +++
>  drivers/video/fbdev/core/fbcon_ccw.c    |  28 +-
>  drivers/video/fbdev/core/fbcon_cw.c     |  28 +-
>  drivers/video/fbdev/core/fbcon_rotate.h |   9 +
>  drivers/video/fbdev/core/fbcon_ud.c     |  37 +-
>  drivers/video/fbdev/core/tileblit.c     |  16 +
>  drivers/video/fbdev/skeletonfb.c        |  12 +-
>  include/linux/fb.h                      |   2 +-
>  11 files changed, 703 insertions(+), 68 deletions(-)
> 
> -- 
> 2.31.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
