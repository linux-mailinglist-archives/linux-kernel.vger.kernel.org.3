Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6605A7A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiHaJsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiHaJsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:48:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07D6CC30A;
        Wed, 31 Aug 2022 02:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661939324; x=1693475324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2vtMjEkDfe6C58t0E979hr4mW/Nq5b/VgRWuPFsFMkE=;
  b=jwj0y5+cFi6T2BILPbNvjPEJWtPpkiRycqn3UXKAx3hOF9jf0DmcLPz2
   I8IUjKcmhNwow0RCOXKsW/D1Avwmu9McGZN/MCrhdAN8FJr1rkHFdA7gJ
   b+vGbwmTFEyPiDj5jMhb/Emg4E+UDeQCBQeQFvBx0ExEQ/pfvXcwvUbWs
   BqndZUDQ4icfAgp5814kK1/W0u+j0+zeL3CVUhVSC/q2MLTzM2/EnkEc9
   QfPHIqgEghFMH34U1/EDHpWyzQX8w5fZ9VuEWXqmQVnNKBgTdhFLOfJI1
   RAuMqSlqrwZzxAbSBA+WPekIlCSt0ozmmXrohIlrYKvngN9T4khdeK7cP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="282386245"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="282386245"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 02:48:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="715637851"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 31 Aug 2022 02:48:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 15101174; Wed, 31 Aug 2022 12:48:56 +0300 (EEST)
Date:   Wed, 31 Aug 2022 12:48:56 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 2/3] ACPI: PMIC: Replace open coded be16_to_cpu()
Message-ID: <Yw8uiAv95LbBh2FD@black.fi.intel.com>
References: <20220830171155.42962-1-andriy.shevchenko@linux.intel.com>
 <20220830171155.42962-2-andriy.shevchenko@linux.intel.com>
 <Yw71GqF5x7u16yom@black.fi.intel.com>
 <Yw8rPW39Vif4yVAf@smile.fi.intel.com>
 <8989df1c-8fa7-be27-c2f0-e528604e474a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8989df1c-8fa7-be27-c2f0-e528604e474a@redhat.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:37:21AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 8/31/22 11:34, Andy Shevchenko wrote:
> > On Wed, Aug 31, 2022 at 08:43:54AM +0300, Mika Westerberg wrote:
> >> On Tue, Aug 30, 2022 at 08:11:54PM +0300, Andy Shevchenko wrote:
> >>> -#define VR_MODE_DISABLED        0
> >>> -#define VR_MODE_AUTO            BIT(0)
> >>> -#define VR_MODE_NORMAL          BIT(1)
> >>> -#define VR_MODE_SWITCH          BIT(2)
> >>> -#define VR_MODE_ECO             (BIT(0)|BIT(1))
> >>> +#define PMIC_REG_MASK		GENMASK(11, 0)
> >>> +
> >>> +#define VR_MODE_DISABLED        (0 << 0)
> >>> +#define VR_MODE_AUTO            (1 << 0)
> >>> +#define VR_MODE_NORMAL          (2 << 0)
> >>> +#define VR_MODE_ECO             (3 << 0)
> >>> +#define VR_MODE_SWITCH          (4 << 0)
> >>
> >> IMHO this one is worse than what it was.
> > 
> > I'm not sure why. Here is obvious wrong use of BIT() macro against
> > plain numbers. I can split it into a separate change with an explanation
> > of why it's better. But I think it doesn't worth the churn.
> 
> FWIW I'm with Andy here, the VR_MODE_ECO clearly is trying
> to just say 3, so this is just a plain enum for values 0-4 and
> as such should not use the BIT macros.

Yeah, enum would look better but the << 0 just makes me confused ;-)
