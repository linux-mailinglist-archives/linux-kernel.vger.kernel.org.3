Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FE74DC253
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiCQJIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiCQJIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:08:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1111D12E7;
        Thu, 17 Mar 2022 02:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647508054; x=1679044054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3LOKV8T+J6ndpx4yRF7CsKdRnALN/jjLjomuYjUYYFg=;
  b=An2dln0AGqQvJ3YQgloLgxipFQ5e7tZ4Tp2tGyTQ6PsZ/k9tnhMArj+y
   Xu0BDkybHL4fCXL71DAKzoVz2lxSQWtdi2yaBvnvWDduFbKtnotYjteaK
   vil2mAzJ8r+di4Joy8lc2MrQRZWfy/qN3htsb0tX+R3lJiHPqiXXCJoo2
   rFQop7bJqTk5WykgZVpW8FzW9rcJqbry0IHfSqu8Ru60z8UAS1KQ1+zPA
   vWRzTpHzvo28sBX7321gAyuxCO8uxnS0JdyCXJfo3AKSgWDl4IAtNL/xk
   cLztCpcFGexc3bXbjwcyDHJE+pv1vl2gc2bNGoUlluLVAyXVFxtaCsdLp
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="237428185"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="237428185"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 02:07:34 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="646981440"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 02:07:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nUm5r-001Q0N-NG;
        Thu, 17 Mar 2022 11:06:51 +0200
Date:   Thu, 17 Mar 2022 11:06:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bill Wendling <morbo@google.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] gpiolib: acpi: use correct format characters
Message-ID: <YjL6K49CkH+YC4FQ@smile.fi.intel.com>
References: <20220316213055.2351342-1-morbo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316213055.2351342-1-morbo@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 02:30:55PM -0700, Bill Wendling wrote:
> When compiling with -Wformat, clang emits the following warning:
> 
> drivers/gpio/gpiolib-acpi.c:393:4: warning: format specifies type
> 'unsigned char' but the argument has type 'int' [-Wformat]
>                         pin);
>                         ^~~
> 
> The types of these arguments are unconditionally defined, so this patch
> updates the format character to the correct ones for ints and unsigned
> ints.

hhX specifier refers to unsigned char. It's a bug in the compiler.

NAK.

-- 
With Best Regards,
Andy Shevchenko


