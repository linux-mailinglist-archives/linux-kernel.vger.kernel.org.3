Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D804C3ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbiBYBRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiBYBRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:17:36 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE65570931
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:17:04 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id bx9-20020a17090af48900b001bc64ee7d3cso3450109pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N4Y8/f5h2c+8qmPFONzyrb+xWyQQ0xn3lzmmRXMaZ0c=;
        b=ZaCIcK/AmAgJW8ORzlH2l0M239cWbI0Yy9USxUhedpS+8F5aQlItAz/eNqUI/SxeqG
         6KewFCiWWDIzWWNjGm470yCRsMILiy4B1zeIccNO7G3ceF6tE4uZ4hoftfdCh1dcwIWy
         zKZOlNiOKExtdZ2mSm924KsAmV5cGENaAN1UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N4Y8/f5h2c+8qmPFONzyrb+xWyQQ0xn3lzmmRXMaZ0c=;
        b=GS4HgRmjG1zT5Mj4/PGUKTYzF9l9PcTFNQUmbFsX+ZAhLfwAtZmCNYf0NTVUESj1Yq
         U08qMcGENbX5+zy+GNcTrxvWdniiJsFmyu/7InwFK7qyoveG+V4gkoPDRH9jw778YQws
         FXjCNMroRXJWnwcyN29tA17cBWpwZnME49wh+Oorc+D6RVXF7ueV1gwmLMHQXJBXtajv
         s5VEgP+z2zY4b+XJ7WSF5Hkak6vlvPuZzpNnDRL2QypdqXDyQhlCYjp3hyVdltYlBio8
         XtrI4QcXJNXt1D/AhJYLuUhMFyylwzTQxElGMJdQdjlTSPM9De7ZPa1oxjHv9cw5Ysr4
         LBQw==
X-Gm-Message-State: AOAM531C+s+4RRuS2wAakgCjRXvmuKhD/Krkx9mAcH3WpkEWcFtxopIm
        nwbodG4lyD4rx61ro2VcrmttnA==
X-Google-Smtp-Source: ABdhPJxUSI6d5OVKHvIHPJlIQ1IS0ljtDIF332/NI8MGgqJDszVUoVyDKrcpaQleuuGzbWYXWI3d8Q==
X-Received: by 2002:a17:902:760e:b0:14f:d760:51d0 with SMTP id k14-20020a170902760e00b0014fd76051d0mr5089535pll.5.1645751824444;
        Thu, 24 Feb 2022 17:17:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q93-20020a17090a4fe600b001b9ba2a1dc3sm7262773pjh.25.2022.02.24.17.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 17:17:04 -0800 (PST)
Date:   Thu, 24 Feb 2022 17:17:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib: stackinit: Convert to KUnit
Message-ID: <202202241714.DC112086@keescook>
References: <20220224055145.1853657-1-keescook@chromium.org>
 <CAGS_qxrRi0zvGnoi-Ne=wp8xkuFKPzNj9d57eq=51gg5gwX=eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS_qxrRi0zvGnoi-Ne=wp8xkuFKPzNj9d57eq=51gg5gwX=eA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 11:43:40AM -0800, Daniel Latypov wrote:
> On Wed, Feb 23, 2022 at 9:51 PM Kees Cook <keescook@chromium.org> wrote:
> >
> 
> <snip>
> 
> 
> >  /* Userspace headers. */
> > +#define _GNU_SOURCE
> >  #include <stdio.h>
> >  #include <stdint.h>
> > +#include <stdlib.h>
> >  #include <string.h>
> >  #include <stdbool.h>
> >  #include <errno.h>
> >  #include <sys/types.h>
> >
> >  /* Linux kernel-ism stubs for stand-alone userspace build. */
> 
> This is neat and esp. so that it works.
> But may I ask, what's the value of using this vs UML?

Mainly it's been for giving a single stand-alone file for testing to
compiler devs, packagers, and distro maintainers instead of asking them
to pull down the entire kernel, etc, etc. :)

> Given this has changed into mainly just a KUnit-compatibility layer,
> it feels like it can maybe live as a standalone file, if there's ever
> interest in doing this for other tests.

That's a terrifying and lovely idea!

> It feels like something that will never quite be "supported", but I
> find it neat enough I'd have fun sending some patches to make it more
> realistic.

Right, and as you found, I took some short-cuts that were specific to
how this code used KUnit. :P

I'll ponder this and go through your other suggestions. Thanks!

-Kees

-- 
Kees Cook
