Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFA2519F24
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349378AbiEDMZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbiEDMZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:25:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9EA2F038;
        Wed,  4 May 2022 05:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651666915; x=1683202915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FX28G2dRJvDF+aaInWBzjFS4ellS21zQ+6eIjm4E/Wk=;
  b=DXhCgbkJBCJVgpTva6Z/eFLpL9Vryx4tr8Z6N9RCVIIxHBNfa9sXghcj
   epp0fDMFFy1f/pTxytUNNYLuMOctQG7cAUq5A6sllpRrnMgJsJDzvWxvc
   n+hvDxTZRYnKRMtk+tg3vlGfaplZjkDMT8HJurW+9ez6G0kUr3akUZ2U7
   JVDvXMBGxhymwYm2PKi6t3w0anPGd1d+1XI/9s6zl9HF5krUOK4zXFhei
   voD6VqQ5TguS+alYw7laPFIqBlNGLDy/uZ780sU92Ei9dAKPZMynmgv1i
   AZJIH/2l/9SBHbVFe3rd93tdP8zv+UxjILqHbL/zuHt4irutQlSO19V5C
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="354187329"
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="354187329"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 05:21:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="599510653"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.51])
  by orsmga001.jf.intel.com with SMTP; 04 May 2022 05:21:49 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 04 May 2022 15:21:48 +0300
Date:   Wed, 4 May 2022 15:21:48 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Document that power requirements for DP AUX
 transfers
Message-ID: <YnJv3B/85hTz54SC@intel.com>
References: <20220503162033.1.Ia8651894026707e4fa61267da944ff739610d180@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220503162033.1.Ia8651894026707e4fa61267da944ff739610d180@changeid>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 04:21:08PM -0700, Douglas Anderson wrote:
> When doing DP AUX transfers there are two actors that need to be
> powered in order for the DP AUX transfer to work: the DP source and
> the DP sync. Commit bacbab58f09d ("drm: Mention the power state
> requirement on side-channel operations") added some documentation
> saying that the DP source is required to power itself up (if needed)
> to do AUX transfers. However, that commit doesn't talk anything about
> the DP sink.
> 
> For full fledged DP the sink isn't really a problem. It's expected
> that if an external DP monitor isn't plugged in that attempting to do
> AUX transfers won't work. It's also expected that if a DP monitor is
> plugged in (and thus asserting HPD) that it AUX transfers will work.
> 
> When we're looking at eDP, however, things are less obvious. Let's add
> some documentation about expectations. Here's what we'll say:
> 
> 1. We don't expect the DP AUX transfer function to power on an eDP
> panel. If an eDP panel is physically connected but powered off then it
> makes sense for the transfer to fail.

I don't agree with this. I think the panel should just get powred up
for AUX transfers. Otherwise you can't trust that eg. the /dev/aux
stuff is actually usable.

-- 
Ville Syrjälä
Intel
