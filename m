Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74094B2979
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349579AbiBKP4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:56:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240763AbiBKP4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:56:42 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8786CD47;
        Fri, 11 Feb 2022 07:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644595000; x=1676131000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G2nMVmGnVC61HKINS0KX3x16eUy0vrSIWj0awqxztAE=;
  b=b17rTmxjYNqltc0do0gi8nXEMgsVcCjUrnYD9OZdUlxFLigVeTZwPhNX
   tZbBe+dqjBFw5IIBGlaanojkKjqiTKzk5kG61Vc5DWro3CvZ3x5lD57pq
   06jj8BkJw2b/KZhfnCfzrW9CoOkbiBTwO9vwbaiZ6TiOdQA4nC7CLkPnH
   td6IWTxZCDewh7K9QLU6+R9D9UL3Cv2Ki4ajcBtB9LrvzMHEL8qMhDiZu
   NlqkuG6a8SW/JqlXcXQ/eTDdgkqfa9KiqZ+aTausgQ7LY+P/1gkcio7NQ
   UsC6/fmhbqU1ZrIYPYgOdWUonHhAOOZAnyRpe/04E/eUPVdRdu6K5xzxo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="313035650"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="313035650"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 07:56:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="634130120"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 07:56:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nIYGm-003UpL-57;
        Fri, 11 Feb 2022 17:55:36 +0200
Date:   Fri, 11 Feb 2022 17:55:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v4 2/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_mono_reversed()
Message-ID: <YgaG98O12Fg7WmQJ@smile.fi.intel.com>
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-3-javierm@redhat.com>
 <YgZEPo0ERFRloDyA@smile.fi.intel.com>
 <00616642-1c95-9258-ab6e-b08116b36d21@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00616642-1c95-9258-ab6e-b08116b36d21@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 12:50:04PM +0100, Javier Martinez Canillas wrote:
> On 2/11/22 12:10, Andy Shevchenko wrote:

...

> >> +	for (xb = 0; xb < pixels; xb++) {
> >> +		unsigned int start = 0, end = 8;
> >> +		u8 byte = 0x00;
> > 
> >> +		if (xb == 0 && start_offset)
> >> +			start = start_offset;
> > 
> > This is invariant to the loop, can be moved out.
> > 
> >> +		if (xb == pixels - 1 && end_len)
> >> +			end = end_len;
> > 
> > Ditto. However it may require to factor out the following loop to a helper.
> 
> Not sure I'm following, it's not invariant since it depends on the
> loop iterator value. It only applies to the first and last pixels.

It's. You simply does it at the last iteration which may be perfectly done
outside of the main (aligned) loop.

...

> >> +		dst_pitch = DIV_ROUND_UP(linepixels, 8);
> > 
> > round_up() ?
> 
> But it's not a round up operation but a div and round up.

Indeed.

...

> >> +	WARN_ONCE(dst_pitch % 8 != 0, "dst_pitch is not a multiple of 8\n");
> > 
> > 
> > I would move this to the if conditional, i.e.
> > 
> > 	if (dst_pitch)
> > 		WARN_ONCE(dst_pitch % 8 != 0, "dst_pitch is not a multiple of 8\n");
> > 	else
> > 		dst_pitch = round_up(linepixels, 8);
> 
> No, because we always need to div and round up. The warning is just printed to
> let know that the dst pitch is not a multiple of 8 as it should be. So callers
> could be fixed.

Okay, you expect that linepixels to be multiple of 64? Otherwise I didn't get
what's going on with this warning.

...

> >> +	start_offset = clip->x1 % 8;
> >> +	end_len = clip->x2 % 8;
> > 
> > ALIGN() ?
> 
> But we don't want to align here but to know what's the start and end if is
> not aligned since that would mean converting to mono in the middle of a byte.

Indeed. Somehow I missed that it's a complimentary to ALIGN().

-- 
With Best Regards,
Andy Shevchenko


