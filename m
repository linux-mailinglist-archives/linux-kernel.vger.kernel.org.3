Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A199B4B2319
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348888AbiBKK3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:29:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236403AbiBKK3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:29:12 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08177E88;
        Fri, 11 Feb 2022 02:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644575352; x=1676111352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mL2EGWEJ1+X7al0OFxqCBnHU+Yoy9youEb4rP8YJwsg=;
  b=C1mfq1VUiSC3KKYcgEfUhuQ/k6gJj5V6sIVLfLAfrlJV/OYMCX+ohegy
   7lsgejYa4wMEIZ5BEzu8ga6WtFaFt8R6RUXIEdAgCJNSmIlD3mM0uvSRS
   kNGxsZTkOEtj+db+ATSEK9ytJaAfC4bJdzy8UWmIOqHJ483E4/oScB5X5
   goSO3pitixktLe3CQp8SU+tCFkED/Rfhp+n6UPMiW1RavvQnJd+1tv4or
   9D+x+tUqq+KG2YUTBQ7KVGhqV4Tn17I6voXAagi66x2hm+Ak5nJ8LwOGD
   Tra8ZdLMAiyQ62x0sWaOTUIxkvONm4KGuWBcpaVwfaaqyQqQ4cAKrkPMp
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="312990544"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="312990544"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 02:29:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="586307272"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 02:29:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nIT9u-003PIr-EB;
        Fri, 11 Feb 2022 12:28:10 +0200
Date:   Fri, 11 Feb 2022 12:28:10 +0200
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
Subject: Re: [PATCH v4 1/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_gray8_line()
Message-ID: <YgY6OqN+guBlt/ED@smile.fi.intel.com>
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-2-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211091927.2988283-2-javierm@redhat.com>
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

On Fri, Feb 11, 2022 at 10:19:22AM +0100, Javier Martinez Canillas wrote:
> Pull the per-line conversion logic into a separate helper function.
> 
> This will allow to do line-by-line conversion in other helpers that
> convert to a gray8 format.

...

> +static void drm_fb_xrgb8888_to_gray8_line(u8 *dst, const u32 *src, unsigned int pixels)
> +{
> +	unsigned int x;
> +
> +	for (x = 0; x < pixels; x++) {
> +		u8 r = (*src & 0x00ff0000) >> 16;
> +		u8 g = (*src & 0x0000ff00) >> 8;
> +		u8 b =  *src & 0x000000ff;
> +
> +		/* ITU BT.601: Y = 0.299 R + 0.587 G + 0.114 B */
> +		*dst++ = (3 * r + 6 * g + b) / 10;
> +		src++;
> +	}

Can be done as

	while (pixels--) {
		...
	}

or

	do {
		...
	} while (--pixels);

> +}


-- 
With Best Regards,
Andy Shevchenko


