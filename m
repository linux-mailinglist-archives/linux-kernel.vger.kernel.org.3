Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97484A491C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379317AbiAaOOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:14:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:15656 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346623AbiAaOOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:14:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643638447; x=1675174447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u2/KL+QczLeO5HW7c5Ow6qXPV61IYgm4mFoJmsrc6Pk=;
  b=Vr5oMS7JT33lYcvuyj5IVHJGCiwrNOSIpwCdaT7VtOWutQyKwm24hdl1
   YFQlH13tn2o/g8HvDl3x9e1ylZeJRXibHS3XlaWuguiZw7cLAAaqKWtlw
   aXmxQ8vy3o5GW7MXwZc6M55xEB6PQQ8MHgfKl78aq6WMBsg6iN3b/Abny
   Zq9WtY66KqdfSwCp0syc8+t7z8Rmld4ZVC28Bm63LDL06vZ7ntjjHK4Zd
   gme+kuRHfyXD5zLBkTCKi5hDtZ90OiO3F0TlCVktpGFW2UEi43dP0RYdo
   DCWM3BYaVLMHY3DoCsSeSbZaV3bv62hesd5O0NKk/ffdqKVXZGfLqACyZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="246300424"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="246300424"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 06:07:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="522665965"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 06:07:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nEXJq-00GtM0-Jq;
        Mon, 31 Jan 2022 16:06:10 +0200
Date:   Mon, 31 Jan 2022 16:06:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v1 1/4] fbtft: Unorphan the driver
Message-ID: <Yffs0nuG3ElH1bNE@smile.fi.intel.com>
References: <YfFIpBb7lL4ukWjm@smile.fi.intel.com>
 <b8eb7111-43aa-cc8a-a1bc-f08e0f2987ed@redhat.com>
 <YfFV4EJosayH+e6C@smile.fi.intel.com>
 <YfFWPmG2D093gz4N@smile.fi.intel.com>
 <6e74d4cc-655a-e38e-0856-a59e4e6deb36@redhat.com>
 <c423a2f0-e7be-3884-3568-7629c7e9104e@redhat.com>
 <YffJujbpUGUqpIk/@smile.fi.intel.com>
 <5a3fffc8-b2d8-6ac3-809e-e8e71b66a8ea@redhat.com>
 <YffiwCiFnqF1X1pD@smile.fi.intel.com>
 <29ab99fb-d906-907b-e922-251ac72b25ef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29ab99fb-d906-907b-e922-251ac72b25ef@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 02:55:21PM +0100, Javier Martinez Canillas wrote:
> On 1/31/22 14:23, Andy Shevchenko wrote:
> > On Mon, Jan 31, 2022 at 01:08:32PM +0100, Javier Martinez Canillas wrote:

...

> > The tricky part is the PRP0001
> > ACPI PNP ID that allows to reuse it on ACPI-based platforms.
> 
> Oh, I wasn't aware about PRP0001. I've read about it at:
> 
> https://www.kernel.org/doc/Documentation/acpi/enumeration.txt

Yep!

The idea is that new drivers for discrete (and sometimes even on-SoC)
components should be platform-agnostic (means no strict OF / ACPI
dependencies), so anybody can prototype devices on either of the
platforms.

As a matter of fact IIO subsystem is leading in this by cleaning up
most of the drivers towards that goal.

OF/ACPI explicit dependency makes sense when we 100+% sure that
IP in question won't ever appear on the other type of platform
(which I believe is very rare nowadays for most of the components).

-- 
With Best Regards,
Andy Shevchenko


