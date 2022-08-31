Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBCA5A7A50
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiHaJfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiHaJe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:34:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AAD21E3B;
        Wed, 31 Aug 2022 02:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661938499; x=1693474499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=070umHQFjooRmGQhFXHyxmtD9BFsD5IdNnJ+i1kO9sE=;
  b=NAJhfO5RqDhr673AHcICkoscoMu5l6oQnQHM6LmvTKey85H/yinYd5fp
   rANf90K/uOlqHxTtBGlite4obPuMYcL65DBmtCcVpfn4j9eC4Dekavaqk
   Ao72LQWoM/Wgj5IcntD3mDNgamgXcpEpFA+iHPXVZf2D/3R/sIuFInERl
   geB3QFWix8N2WlxJ9QPg5AP835Er5mtRj5R/b/bDcFeskFfITBiVuc4sR
   A7vcRRjaQAfF7iPcI52nLbQDKaB12kmf/LnVb+uyAw3L3c8fDzmLEaw++
   yZspCqZXssBT7PNq1KiiM2h30KAfI6Svd3lAgSO+Fy22dWElBpTuhDO+8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="292987752"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="292987752"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 02:34:58 -0700
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="562981000"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 02:34:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oTK7a-006JYQ-0R;
        Wed, 31 Aug 2022 12:34:54 +0300
Date:   Wed, 31 Aug 2022 12:34:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 2/3] ACPI: PMIC: Replace open coded be16_to_cpu()
Message-ID: <Yw8rPW39Vif4yVAf@smile.fi.intel.com>
References: <20220830171155.42962-1-andriy.shevchenko@linux.intel.com>
 <20220830171155.42962-2-andriy.shevchenko@linux.intel.com>
 <Yw71GqF5x7u16yom@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw71GqF5x7u16yom@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 08:43:54AM +0300, Mika Westerberg wrote:
> On Tue, Aug 30, 2022 at 08:11:54PM +0300, Andy Shevchenko wrote:
> > -#define VR_MODE_DISABLED        0
> > -#define VR_MODE_AUTO            BIT(0)
> > -#define VR_MODE_NORMAL          BIT(1)
> > -#define VR_MODE_SWITCH          BIT(2)
> > -#define VR_MODE_ECO             (BIT(0)|BIT(1))
> > +#define PMIC_REG_MASK		GENMASK(11, 0)
> > +
> > +#define VR_MODE_DISABLED        (0 << 0)
> > +#define VR_MODE_AUTO            (1 << 0)
> > +#define VR_MODE_NORMAL          (2 << 0)
> > +#define VR_MODE_ECO             (3 << 0)
> > +#define VR_MODE_SWITCH          (4 << 0)
> 
> IMHO this one is worse than what it was.

I'm not sure why. Here is obvious wrong use of BIT() macro against
plain numbers. I can split it into a separate change with an explanation
of why it's better. But I think it doesn't worth the churn.

> Anyway, that's just a nitpick. The other parts look good,
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


