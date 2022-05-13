Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241CE525EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348514AbiEMIwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378684AbiEMIwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:52:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AD12380E9;
        Fri, 13 May 2022 01:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652431931; x=1683967931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uYn+WuPRsWoXZxNkCTtEQjQ5w4bTUeHB9c4uuI66TJ0=;
  b=SQOg+wZDd8xi1OG39nboR0tZyQbzgwElhMs55bCPnVoVFtmll4ZcxWDS
   ASoxLZG/33VM0t4surzoQpPfMYi2kTYPuMqQyPOmaYgbcG5h6iBL3SSnr
   HI1VwPTtp61akQy1eH2HGHzinr6WrjRNpPT3MplWsFBmZW2jIbrOyYVn7
   2A++btJNDhByq633bZKG+DBRqTFmvXQgjePdi25WtQotEGmuruNLvyCV/
   IcurnYxJa9H3OeHzFdXsy6FzpAGesNpZuDC02gN1Zqx9Kg1v2ipcg3nKn
   uwdmQETYDBJxd60Vkp1qZnVyt8wot7uWXM8I7lRvKy47nMO1s6x8myCR1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="250155988"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="250155988"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 01:52:08 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="740078333"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 01:52:04 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 13 May 2022 11:52:02 +0300
Date:   Fri, 13 May 2022 11:52:02 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marc Zyngier <maz@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 4/5] pinctrl: cherryview: make irq_chip immutable
Message-ID: <Yn4cMhb72IoKi0RA@lahna>
References: <20220512173921.8210-1-andriy.shevchenko@linux.intel.com>
 <20220512173921.8210-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512173921.8210-4-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 08:39:20PM +0300, Andy Shevchenko wrote:
> Since recently, the kernel is nagging about mutable irq_chips:
> 
>    "not an immutable chip, please consider fixing it!"
> 
> Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
> helper functions and call the appropriate gpiolib functions.
> 
> While at it, switch to use hwirq variable instead of pin for
> the sake of consistency.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
