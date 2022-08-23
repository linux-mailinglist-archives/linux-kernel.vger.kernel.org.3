Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7638359E864
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343808AbiHWRC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344373AbiHWRBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:01:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B926F14E28B;
        Tue, 23 Aug 2022 06:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661261540; x=1692797540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1aOsMh80PzrLjsTarZiUZuyjeuDjpjzALcnTmx6xWUY=;
  b=BjdHkLywf+7BUoBr+1n2o0goTRFna2l8wGUavK1bLmgO13FL9qHYQ/W2
   aO8iTdt/9LPngGVzsljY13ogmVSzUfJeSa3GzlluMRQX4Dm982jI6MU6d
   Lcq45g6mGuhotMzC2vOD99ZFaVx6D5K0uFi+CA9ircc9e+S4O0KglZS7M
   gOJtcPOyx3AjVW1h16+/ZYWZHv2azvL9IKFtC5Rf4oEWuePmI6/LRqSob
   ybljlmczHQA8LhG+zDwzlXkj9uSXUsonP8JRojevP2DEUj6mKw7gsuz7U
   LAcHQdUY54zUaMuGzIhtuAAeF2+N/7DFE6kACZ87+cJ5Kn1OWzWdFDbLR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="291247735"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="291247735"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 06:32:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="585975010"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 06:32:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oQU0s-002SBu-2U;
        Tue, 23 Aug 2022 16:32:14 +0300
Date:   Tue, 23 Aug 2022 16:32:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH v1 1/1] pinctrl: bcm: Convert drivers to use struct
 pingroup and PINCTRL_PINGROUP()
Message-ID: <YwTW3g4WkJlRbBnO@smile.fi.intel.com>
References: <20220620165053.74170-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdZrCd9vAMg+MOTduAhmZ+uRq9q89Ts6o6RagdTkrrpogA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZrCd9vAMg+MOTduAhmZ+uRq9q89Ts6o6RagdTkrrpogA@mail.gmail.com>
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

On Tue, Jun 28, 2022 at 02:39:00PM +0200, Linus Walleij wrote:
> On Mon, Jun 20, 2022 at 6:50 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > The pin control header provides struct pingroup and PINCTRL_PINGROUP() macro.
> > Utilize them instead of open coded variants in the driver.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This looks very tasty. Can we get a test or ACK from one of the BCM
> people? (Álvaro/Jonas)

Any news?

-- 
With Best Regards,
Andy Shevchenko


