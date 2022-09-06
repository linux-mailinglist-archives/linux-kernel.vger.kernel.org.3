Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD845AF57D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiIFUJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiIFUJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:09:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C24658E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:04:28 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so8093088wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 13:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date;
        bh=nLFlBHZY1lvIxs+wDFQOuCeDs8kLFFZtfH1W2GDdEPo=;
        b=UqsTLgVjQLipDQfZb/x0qe5JDHCOxqku0e19QU0dYlou2/J8OVBZJeRDxNXiMt97Fh
         3E5z3Ckh+fTAiNAZ88UqDkC8Rxqq2be8e1Xcs8X8S+5QiUwgVbbGmxhGgJ8jaABZOpvw
         +SV8IhftYfLCmHJyD8EeqxTHO2IpFsS+Y4e0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nLFlBHZY1lvIxs+wDFQOuCeDs8kLFFZtfH1W2GDdEPo=;
        b=W2mlYGTbtBmTh1J3CEpKjJ3oNPvKrhxQvPu1t18n4fwSbnkjAezUeN5kwejAtQaf+y
         MBW/a+UwQIVl+eVoC99EseCZXx36ikfuxEBZ1cFTQTcTRaQRQjgqEODSBVSJEOtWnqT+
         pY7JVffjVky5D1V9MS+pYxYaWoUqcO5tSY2f8YcxugyzBBUOezZ/x0ouBbJa05zst2pL
         +/bdAlx7L/ORs/qaY4QBSkf/hGYcOb37Y+HRdFPj7VVSDfxumdShArC358xIU9YZGgxE
         AHILVvMJ38tHbiRUTKN4jCvGFD7orv/jgcIu8AjAkMXWgXKnFOJi4ENcma7F2LuW3/jp
         LKCQ==
X-Gm-Message-State: ACgBeo2t5CGR3IrSbgI6p4MlMjsvQ9hUN8jfqgB6GCAoPFUJwfrWvuD5
        HwaWe9TtWWCJNYVjXhrMn0bwnnlJ6+Gafw==
X-Google-Smtp-Source: AA6agR4Ex0Q2u9orVMhIMp0RV1p91dVmN3st8TBkHWlsBcXFUjkX8mk1vLkzR/Iodys0dLHtL7HtSw==
X-Received: by 2002:a05:600c:1c95:b0:3a5:c28a:df3e with SMTP id k21-20020a05600c1c9500b003a5c28adf3emr54685wms.40.1662494084388;
        Tue, 06 Sep 2022 12:54:44 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c465600b003a839b9ba0asm20868743wmo.40.2022.09.06.12.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 12:54:43 -0700 (PDT)
Date:   Tue, 6 Sep 2022 21:54:41 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrey Strachuk <strochuk@ispras.ru>,
        ldv-project@linuxtesting.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, Helge Deller <deller@gmx.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [ldv-project] [PATCH v2] drm/fb-helper: add virtual screen size
 check to drm_fb_helper_check_var()
Message-ID: <YxelgRXMMxbJmlAH@phenom.ffwll.local>
Mail-Followup-To: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrey Strachuk <strochuk@ispras.ru>, ldv-project@linuxtesting.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, Helge Deller <deller@gmx.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
References: <20220811144850.215377-1-strochuk@ispras.ru>
 <CAMuHMdXSnHJpy=27pkAfQC0v+tkpx7Q4Ze1=nvTmy+aMBeVPFg@mail.gmail.com>
 <da72ac1b-57ef-18c5-98c7-f6f1a4c11b8d@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da72ac1b-57ef-18c5-98c7-f6f1a4c11b8d@ispras.ru>
X-Operating-System: Linux phenom 5.18.0-4-amd64 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 11:59:00PM +0300, Alexey Khoroshilov wrote:
> For v2 I would suggest to update description to something like this:
> 
> Make sure that virtual screen size is not less than physical screen one.
> 
> and comment to:
>     /* make sure that virtual resolution >= physical resolution */

Did this land somewhere? If not please resend with r-b tags and
everything.

Thanks, Daniel

> 
> --
> Alexey
> 
> 
> On 11.08.2022 17:54, Geert Uytterhoeven wrote:
> > Hi Andrey,
> > 
> > On Thu, Aug 11, 2022 at 4:49 PM Andrey Strachuk <strochuk@ispras.ru> wrote:
> >> Add virtual screen size check to drm_fb_helper_check_var() in
> >> order to validate userspace input.
> >>
> >> Found by Linux Verification Center (linuxtesting.org) with syzkaller.
> >>
> >> Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
> > 
> > Thanks for the update!
> > 
> >> Fixes: 785b93ef8c30 ("drm/kms: move driver specific fb common code to helper functions (v2)")
> > 
> > I'd drop the Fixes tag completely, as the bug was present in the
> > intel and radeon drivers before. But probably it doesn't matter, as no one
> > is gonna backport this to v2.6.31 and earlier ;-)
> > 
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > 
> > Gr{oetje,eeting}s,
> > 
> >                         Geert
> > 
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> > 
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds
> > 
> > _______________________________________________
> > ldv-project mailing list
> > ldv-project@linuxtesting.org
> > http://linuxtesting.org/cgi-bin/mailman/listinfo/ldv-project
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
