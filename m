Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE936525E94
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378710AbiEMIw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378706AbiEMIwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:52:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E147D2380FB;
        Fri, 13 May 2022 01:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652431972; x=1683967972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WPHRLNPNME0NDGQGoQpZR816AnIOnZEm73SaRs8RZSk=;
  b=ZhKP9J07VFgxdQSL5ot/fsGpx3KrnmqmkqTAIxukBk8eYMSybDHTWj9s
   VF/SkTLc16M7pe7S17zrbKtcWeFgDARv+7yyU7tqK+BmyurhPdCJ82Wxl
   vTLeyfdUH/SMQLD7oRgKLOBciNbeP5RzkFyT1LD8j9igUsz2o8Vxgf6/C
   oZ5nyrswwp8AL1qDV3aLLqz2vqnVVIWjL4vr0Jq5POBcP3vk2t8ok6oCy
   Xks9qNjKAqeokzVFdx4Hkbpgm2m9ZYUoJ9EWIYDCwCoPTcVpInfN/dqBR
   FgciyQ9TTHyvNr9IyiIvw74Y6U3EI/8hA1GKAKXHdhnKOa36OUiqaQ24B
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="269926776"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="269926776"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 01:52:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="671254140"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 01:52:47 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 13 May 2022 11:52:45 +0300
Date:   Fri, 13 May 2022 11:52:45 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marc Zyngier <maz@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 5/5] pinctrl: lynxpoint: make irq_chip immutable
Message-ID: <Yn4cXRYAE99IQxpm@lahna>
References: <20220512173921.8210-1-andriy.shevchenko@linux.intel.com>
 <20220512173921.8210-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512173921.8210-5-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 08:39:21PM +0300, Andy Shevchenko wrote:
> Since recently, the kernel is nagging about mutable irq_chips:
> 
>    "not an immutable chip, please consider fixing it!"
> 
> Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
> helper functions and call the appropriate gpiolib functions.
> 
> While at it, switch hwirq variable to use the correct type for
> the sake of consistency.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
