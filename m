Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361AB4CA975
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240402AbiCBPso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbiCBPsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:48:41 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145ECA186
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646236078; x=1677772078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ngP++JXVNaD954tv/wt36r6GL2U3pQlPCLsYXIT1Zo=;
  b=Nk+xBSPZdBFY8OrLIYWHGuKkslwbczlcYd7rIpW7nWm7RdYLr9/l/Wmr
   KHjbtEto23pRzCazMp0O9l5X0Oghr2vn67UHEcPeYj/vjbEFcr578X7Vo
   q0gB8zRxSJH5PCIObHgBYw7x/g1EuD4xLV8nduK0KhVV/VpW6qMT0iwn+
   5sJD8tuZ8yyWj63VYJzQxLsbu+bgyRZh2IpYLPpPSwsu6gcOoTb45K3EJ
   SzMOjD6OFmO953FZvrQRNOu4rmmStlRmQu3sqg0JH6Vk8yBXZzGxfF5Ok
   GkKk2T9cBg5HWNM1V5pKgrHkGGvw8xdLIPi4bC8bmczC6kMAXM2APX/V8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="251003725"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="251003725"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 07:47:57 -0800
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="709553011"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 07:47:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nPRC1-00AMmT-Dn;
        Wed, 02 Mar 2022 17:47:09 +0200
Date:   Wed, 2 Mar 2022 17:47:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Lars Poeschel <poeschel@lemonage.de>
Subject: Re: [PATCH v1 1/3] auxdisplay: lcd2s: Fix lcd2s_redefine_char()
 feature
Message-ID: <Yh+RfBIeC5huOvsA@smile.fi.intel.com>
References: <20220223154718.83500-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223154718.83500-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 05:47:16PM +0200, Andy Shevchenko wrote:
> It seems that the lcd2s_redefine_char() has never been properly
> tested. The buffer is filled by DEF_CUSTOM_CHAR command followed
> by the character number (from 0 to 7), but immediately after that
> these bytes are got rewritten by the decoded hex stream.
> 
> Fix the index to fill the buffer after the command and number.

Any comments on this, please? There are fixes and seems auxdisplay subsystem
is a bit lagging... Should we worry about?

-- 
With Best Regards,
Andy Shevchenko


