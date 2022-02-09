Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EC84AF510
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbiBIPVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbiBIPVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:21:08 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E53C061355;
        Wed,  9 Feb 2022 07:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644420071; x=1675956071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1qF9ZzEYHSVAbbuXXq6Cc2EQ1ZCdoWN2hl6SvPjqJd0=;
  b=HFa5AO8I0O9MQaHYOArgmR6l+Wwn4ebgbVz9tfS51VD7kjdJhVtDUMUR
   wHJyA+vospkkyCRzdJA9qel1+no1dRtbw1m4igU38d0jY2AWA9ZC0u/jc
   n/T6jAu2hyDWdKiyA6OmDpW4PV3MkH5iAqok6GVaoHDM5PTrn2+Ex2S4N
   TyQmXabLODlD6IoCp0ym3mmQjOTMV7dW5DoMyn/P7x621Srw66ZfZCea2
   5C8RBL1ThMj4C2GYUfdykCCeS9LoiYsJ0DLL4bgaO9AbD6TnvOe9TvIjH
   Sgi6UDG0vufdxl2AQllr5MV25zadElER6aCXp/JN77s5aS3NfQ88LBKrr
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="236631481"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="236631481"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 07:20:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="701284968"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 07:20:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nHol4-002ebE-4m;
        Wed, 09 Feb 2022 17:19:50 +0200
Date:   Wed, 9 Feb 2022 17:19:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Subject: Re: [PATCH v3 5/7] (WIP) drm/solomon: Add SSD130X OLED displays SPI
 support
Message-ID: <YgPbleB+LAQ5ZXyB@smile.fi.intel.com>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209091204.2513437-1-javierm@redhat.com>
 <CAMuHMdWSDBjpYJv6JtgvyaKiFKh_eqbvH78TR6VBtpDeFJvqFQ@mail.gmail.com>
 <e6efb2fd-300e-5282-1f2e-a68130d0b45a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6efb2fd-300e-5282-1f2e-a68130d0b45a@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 02:04:17PM +0100, Javier Martinez Canillas wrote:
> On 2/9/22 13:25, Geert Uytterhoeven wrote:
> > On Wed, Feb 9, 2022 at 10:12 AM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:

> Yes, I know. Didn't feel like it, because the patch is a WIP anyways
> (I haven't tested it but was included just for illustration purposes).
> 
> If someone confirms that works then I will include a proper DT binding
> in the next revision.

In a few weeks I hope I can do this.

But you know Linux is almost always broken (*) on the certain embedded device
if nobody keep an eye each rc cycle. It might take time to return it in shape
first.

*) Speaking out of my own experience with device(s) that I possess.

-- 
With Best Regards,
Andy Shevchenko


