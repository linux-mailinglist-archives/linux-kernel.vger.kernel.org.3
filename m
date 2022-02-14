Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C794B508F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353619AbiBNMrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:47:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353579AbiBNMrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:47:16 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F38F63A5;
        Mon, 14 Feb 2022 04:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644842829; x=1676378829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=llcPkF1Wcl+sUIHhvXcZinKVWQQ0pJwysOxKsaAofOo=;
  b=JdsTl3r95eHFa421GLIb7JbDp8f5vgw29MRTVtLsbbpO7fkktVeJk1Yw
   /pxx2JhfWduwUTto7jKj0crv3O6Avpfw3v/VnEYQyuZNShuPEh8JpPx9Z
   NbkLRgdyVzMB0thW+cgf+LU94kwkOZKkizV7tn6ja6cgeAY1+Cr/qjnFX
   dOq0rzA42qIWr5lSZc/lwZTIOtPHBvcnZM02i8ozaWRe0r70lnW4f7tsb
   sZ09oWoKpsbNyHEnyqYzv5S4mxjQCYtP3tPn8m2jaQre2tfjHOW9bKIMQ
   BIn3vRbm8J0xXk5eHWQnvZnC0bTbTwLLC2BPLA6p7sxeSTmaxtCL6Dtyo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="250028598"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="250028598"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 04:47:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="680470945"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.151])
  by fmsmga001.fm.intel.com with SMTP; 14 Feb 2022 04:47:04 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 14 Feb 2022 14:47:03 +0200
Date:   Mon, 14 Feb 2022 14:47:03 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v4 1/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_gray8_line()
Message-ID: <YgpPR/lObRWwkjNN@intel.com>
References: <20220211091927.2988283-2-javierm@redhat.com>
 <YgY6OqN+guBlt/ED@smile.fi.intel.com>
 <4fa465d9-4fac-4199-9a04-d8e09d164308@redhat.com>
 <YgZEuXvJ2ZiOyNS+@smile.fi.intel.com>
 <7560cd10-0a7c-3fda-da83-9008833e3901@suse.de>
 <87pmnt7gm3.fsf@intel.com>
 <YgaDj6Wld4b7S6DF@smile.fi.intel.com>
 <f87ce2fa-6b18-f985-eb86-506ce7103db3@suse.de>
 <YgoxFBGNsrezVxmi@smile.fi.intel.com>
 <5ee24960-7843-827a-2c47-b93a4b4798e3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ee24960-7843-827a-2c47-b93a4b4798e3@suse.de>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 01:12:48PM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 14.02.22 um 11:38 schrieb Andy Shevchenko:
> > On Mon, Feb 14, 2022 at 10:03:53AM +0100, Thomas Zimmermann wrote:
> >> Am 11.02.22 um 16:41 schrieb Andy Shevchenko:
> > 
> > ...
> > 
> >>>> IMO *always* prefer a for loop over while or do-while.
> >>>>
> >>>> The for (i = 0; i < N; i++) is such a strong paradigm in C. You
> >>>> instantly know how many times you're going to loop, at a glance. Not so
> >>>> with with the alternatives, which should be used sparingly.
> >>>
> >>> while () {}  _is_ a paradigm, for-loop is syntax sugar on top of it.
> >>
> >> Naw, that's not true.
> > 
> > In the section 3.5 "Loops - While and For" in "The C Programming
> > Language" 2nd by K&R, the authors said:
> 
> Year of publication: 1988 . It's not the most up-to-date reference for C 
> programming.
> 
> > 
> > 	The for statement ... is equivalent to ... while..."
> > 
> > They said that for is equivalent to while, and not otherwise.
> 
> Even leaving readability aside, it's not equivalent. You can declare 
> variables as part of the for statement. (I know it's not the kernel's 
> style.) Also, 'continue' statements are not well-suited in for loops, 
> because it's non-obvious if the loop's update statement is being 
> executed. (It isn't.)

It is.

'continue' is just shorthand for 'goto end_of_loop_body'.

-- 
Ville Syrjälä
Intel
