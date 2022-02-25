Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6424C50C6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 22:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbiBYVgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 16:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiBYVgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 16:36:23 -0500
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com [91.221.196.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9C81BE0C5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:35:49 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx1.smtp.larsendata.com (Halon) with ESMTPS
        id e5c00027-9682-11ec-9faa-0050568c148b;
        Fri, 25 Feb 2022 21:35:48 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 90DCF194B1C;
        Fri, 25 Feb 2022 22:35:50 +0100 (CET)
Date:   Fri, 25 Feb 2022 22:35:42 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        freedreno <freedreno@lists.freedesktop.org>
Subject: Re: [Freedreno] [PATCH 1/3] drm: Extend DEFINE_DRM_GEM_FOPS() for
 optional fops
Message-ID: <YhlLrujgN2Ovv5JW@ravnborg.org>
References: <20220225202614.225197-1-robdclark@gmail.com>
 <Yhk92RwhBqAAHcuT@intel.com>
 <CAF6AEGtiGA3TOtAvud66TOz_=ODHACS5jfsYPVQFvex-+1xBBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGtiGA3TOtAvud66TOz_=ODHACS5jfsYPVQFvex-+1xBBA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> > > diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> > > index 35e7f44c2a75..987e78b18244 100644
> > > --- a/include/drm/drm_gem.h
> > > +++ b/include/drm/drm_gem.h
> > > @@ -327,7 +327,7 @@ struct drm_gem_object {
> > >   * non-static version of this you're probably doing it wrong and will break the
> > >   * THIS_MODULE reference by accident.
> > >   */
> > > -#define DEFINE_DRM_GEM_FOPS(name) \
> > > +#define DEFINE_DRM_GEM_FOPS(name, ...) \
> > >       static const struct file_operations name = {\
> > >               .owner          = THIS_MODULE,\
> > >               .open           = drm_open,\
> > > @@ -338,6 +338,7 @@ struct drm_gem_object {
> > >               .read           = drm_read,\
> > >               .llseek         = noop_llseek,\
> > >               .mmap           = drm_gem_mmap,\
> > > +             ##__VA_ARGS__\
> > >       }
> >
> > Would it not be less convoluted to make the macro only provide
> > the initializers? So you'd get something like:
> >
> > static const struct file_operations foo = {
> >         DRM_GEM_FOPS,
> >         .my_stuff = whatever,
> > };
> >
> 
> Hmm, I like my color of the bikeshed, but I guess it is a matter of opinion ;-)
Or less surprise. Most similar macros provides initializers only.

Try "git grep DRM_.*OPS  | grep define" in include/drm
and take a look at the hits.

	Sam
