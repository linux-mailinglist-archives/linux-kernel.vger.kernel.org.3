Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEA0527120
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 15:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiENNFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 09:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiENNFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 09:05:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ED460E1;
        Sat, 14 May 2022 06:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652533505; x=1684069505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pwnFxE/TveUFXffMYKprLMDD+T/4IQLlNvNwrmbcBnE=;
  b=KV5z2zwfnV1wxsad8HZihkatQ3HxSZiGlIzQqdvCYWvyFZJz4fyVdwca
   YrZN33X13NnqsgTPPTpc+sMGS/0Zyl3WXmYOJnPXyj39CTtPtd23etQL9
   wOc0jao5ANGatAMt+ldHeZg8+96RoA/7u+dVbOSfrZGrdSl282vz22tUf
   FnmXfB3VoKvJbO8RCuSgSJcfZMoikB286HyvklK2s0Q7Z64R80S62mCUC
   t1IfQV4iRu3jQSovod2GjAlQRO1nbiVWe6/bNH7BoGAD1BzNqmhhOMdTY
   X77IH5sP9t3Vg6vFNYdsQFBhlsixbngYb4WL4MwrR/kTCVf3Em9StjyMz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270186576"
X-IronPort-AV: E=Sophos;i="5.91,226,1647327600"; 
   d="scan'208";a="270186576"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 06:05:02 -0700
X-IronPort-AV: E=Sophos;i="5.91,226,1647327600"; 
   d="scan'208";a="712765657"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 06:05:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nprS5-0004z6-7P;
        Sat, 14 May 2022 16:04:57 +0300
Date:   Sat, 14 May 2022 16:04:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     andy@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpio: ml-ioh: Add devm_free_irq() call to remove flow
Message-ID: <Yn+o+CgAsyW7asSK@smile.fi.intel.com>
References: <CAHp75Vfz-Qq3qo3Re7tsL0mfXNVYZYspGDFCDXhtZxwac7bEiw@mail.gmail.com>
 <20220512124755.2360648-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512124755.2360648-1-zheyuma97@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 08:47:55PM +0800, Zheyu Ma wrote:
> When removing the module, we will get the following flaw:
> 
> [   14.204955] remove_proc_entry: removing non-empty directory 'irq/21', leaking at least 'gpio_ml_ioh'
> [   14.205827] WARNING: CPU: 0 PID: 305 at fs/proc/generic.c:717 remove_proc_entry+0x389/0x3f0
> [   14.209994] RIP: 0010:remove_proc_entry+0x389/0x3f0
> [   14.217820] Call Trace:
> [   14.218264]  unregister_irq_proc+0x14c/0x170
> [   14.220206]  pci_disable_device+0x1ad/0x380
> [   14.220613]  ioh_gpio_remove+0xc5/0xe0 [gpio_ml_ioh]

I would expect something like:

  [   14.204955] remove_proc_entry: removing non-empty directory 'irq/21', leaking at least 'gpio_ml_ioh'
  [   14.205827] WARNING: CPU: 0 PID: 305 at fs/proc/generic.c:717 remove_proc_entry+0x389/0x3f0
  ...
  [   14.220613]  ioh_gpio_remove+0xc5/0xe0 [gpio_ml_ioh]
  [   14.221075]  pci_device_remove+0x92/0x240

It pretty much explains the case.

> Fix this bug by adding devm_free_irq() call to remove flow.


P.S. When sending a new version do not attach it to previous thread, always
     start a new one. It will be simpler to handle by tools.

-- 
With Best Regards,
Andy Shevchenko


