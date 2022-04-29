Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803FB5149F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359591AbiD2Mzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359589AbiD2Mzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:55:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0465CAB99;
        Fri, 29 Apr 2022 05:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651236737; x=1682772737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UpTl+EI4OxATNhRZbN10QD6jlbsYNUk1LadQPcxzoLY=;
  b=RXcr6uLjesZG//Qr/oLKTJBOa+JmA30eSCeeSs5FuYcSdypFBaQ7dMER
   ABbarL1uT5FSA8PvI0B3wB1SwK7woS94OuRIJvK5vOEc01qegX8kPb+Vw
   huBvnXIayXBpQZ12NP/zt+vLlrBH5oV61JIWEaD/6x3RwyDTqQ9L1XLP8
   sWmfg0A7UBQQuiurwbPu+6U40cj+OPjCCOjtK148+vkKPyk7zdc3OJQOD
   3fCzOyPhLAKOur/UmNNuGDDIcyZ08GpbaiWFNS2B5bds58EsoRiQUxNHg
   nMafyHwVUV+h0gHFDH1ZoUv9xjcTqGfJKhJKYsBMeQB5qLUH6hXKNwSqv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="329577821"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="329577821"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 05:52:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="542495249"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 05:52:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nkQ6T-009iHu-By;
        Fri, 29 Apr 2022 15:52:09 +0300
Date:   Fri, 29 Apr 2022 15:52:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] pinctrl: nuvoton: Fix irq_of_parse_and_map()
 return value
Message-ID: <Ymvfeea1QXqSoq76@smile.fi.intel.com>
References: <20220423094142.33013-1-krzysztof.kozlowski@linaro.org>
 <20220423094142.33013-2-krzysztof.kozlowski@linaro.org>
 <CACRpkdY8LJ5xMW0eDsL-ycrqV8io2zXJrT6RfZj=KxaE9rvcvA@mail.gmail.com>
 <064f5758-a3ae-d116-fe72-9f52b4cbea78@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <064f5758-a3ae-d116-fe72-9f52b4cbea78@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 08:03:19AM +0200, Krzysztof Kozlowski wrote:
> On 29/04/2022 00:52, Linus Walleij wrote:
> > On Sat, Apr 23, 2022 at 11:41 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > 
> >> The irq_of_parse_and_map() returns 0 on failure, not a negative ERRNO.
> >>
> >> Fixes: 3b588e43ee5c ("pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driver")
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> Changes since v1:
> >> 1. Correct the return value passed further.
> > 
> > This doesn't apply to my tree neither for fixes or devel, can you rebase it?
> > I'd like to queue it on devel for non-urgent fixes.
> 
> Sure, I will rebase. The issue was because of Andy's commit
> https://lore.kernel.org/all/20220401103604.8705-9-andriy.shevchenko@linux.intel.com/
> which was in next but not in your tree.
> 
> Including such development branches in next, bypassing maintainer, makes
> it difficult for everyone else to develop patches... :(

I'm about to send PR with my stuff to Linus and Bart, but I have difficulties
right now with the signing tag. I hope I figure out sooner than later.

-- 
With Best Regards,
Andy Shevchenko


