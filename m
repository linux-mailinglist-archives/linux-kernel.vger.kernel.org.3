Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AD9513126
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243478AbiD1KVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244110AbiD1KUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:20:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E927E41FA4;
        Thu, 28 Apr 2022 03:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651140734; x=1682676734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DN8nmFYcb38IeRXfm3ZKJ3F7KWzA3y9zzhKp5ZnLg5s=;
  b=V+S/0rfa6bHAlfhdOxrjpTcTheq203+QLXAL5ciLxQpCnqw+KgsqwgoE
   hdcR7fhxIgE/Fsm8cm1eY07am1znNbTCAyfnkG6UTugNyKDRrOIqAAP8K
   RUC5iamRP9jakRf/oLefBJlG5OM9K3NspvflEHLdlvfscKTtuhe63S8vZ
   0Lm49kEPZAs3ETOkStujWaz7B53AXNn40tgt6rNWIfBxrXO6+2aNZjV9t
   Si1a364zAdl7PBDz7manQ5AvaotyijnfPNjUAeHeEgB3343Y7baFaZCJT
   bja8me5+aBlRjRi9/ld1UjP1IVhhCDVyXizQnnxirdy1nm440zSPE1xnM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="265082134"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="265082134"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 03:12:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="731348066"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 03:12:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nk185-009FHA-7N;
        Thu, 28 Apr 2022 13:12:09 +0300
Date:   Thu, 28 Apr 2022 13:12:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/4] platform: allow ATOM PMC code to be optional
Message-ID: <YmpoeJtFNSyCq1QL@smile.fi.intel.com>
References: <20220428062430.31010-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428062430.31010-1-paul.gortmaker@windriver.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 02:24:26AM -0400, Paul Gortmaker wrote:
> A few months back I was doing a test build for "defconfig-like" COTS
> hardware and happened to notice some pmc-atom stuff being built.  Fine,
> I thought - the defconfig isn't minimal - we all know that - what Kconfig
> do I use to turn that off?  Well, imagine my surprise when I found out
> you couldn't turn it [Atom Power Management Controller] code off!

Turning it off on BayTrail and CherryTrail devices will be devastating
to the users' experience. And plenty of cheap tablets are exactly made
on that SoCs.

> Normally we all agree to not use "default y" unless unavoidable, but
> somehow this was added as "def_bool y" which is even worse ; you can
> see the Kconfig setting but there is *no* way you can turn it off.
> 
> After investigating, I found no reason why the atom code couldn't be
> opt-out with just minor changes that the original addition overlooked.
> 
> And so this series addreses that.  I tried to be sensitive to not
> break any existing configs in the process, but the defconfig will
> now intentionally be different and exclude this atom specific code.
> 
> Using a defconfig on today's linux-next, here is the delta summary:
> 
> $ ./scripts/bloat-o-meter -c ../pmc-atom-pre/vmlinux ../pmc-atom-post/vmlinux|grep add/remove
> add/remove: 0/410 grow/shrink: 0/7 up/down: 0/-47659 (-47659)
> add/remove: 0/105 grow/shrink: 0/1 up/down: 0/-6848 (-6848)
> add/remove: 0/56 grow/shrink: 0/1 up/down: 0/-10155 (-10155)
> 
> $ ./scripts/bloat-o-meter -c ../pmc-atom-pre/vmlinux ../pmc-atom-post/vmlinux|grep Total
> Total: Before=13626994, After=13579335, chg -0.35%
> Total: Before=3572137, After=3565289, chg -0.19%
> Total: Before=1235335, After=1225180, chg -0.82%
> 
> It is hard to reclaim anything against the inevitable growth in
> footprint, so I'd say we should be glad to take whatever we can.
> 
> Boot tested defconfig on today's linux-next on older non-atom COTS.

I believe this needs an extensive test done by Hans who possesses a lot of
problematic devices that require that module to be present.

Note to all your patches, please, use --cc option instead of putting noisy
lines in the each of the commit messages. For myself I created a "smart"
script [1] to avoid bothering with that. Feel free to use, modify, send PRs
back to improve.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko


