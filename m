Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261544DC263
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiCQJPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiCQJPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:15:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A88D76F8;
        Thu, 17 Mar 2022 02:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647508430; x=1679044430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8IL//g/TMfBIk8JNUXUEvy1l+g02hROaz5Pc67EYVBM=;
  b=VogIT2l/LSLhQMNk1Fo+3EQGs8vyuxnfD+vcUYMVjQ2i/UbZ/pNArPJ1
   YHuHZrAgEl2+R+1qtMQlYJIICuGU/7d3AEt9wtpw6647/0xcYRJL5/YpV
   ZsMyNL9M3ioZVT5ooG6mvLJkOnY4VKdUwkcGW43ZZOWzYC5z1OFbiP/NV
   CIoX5XExwalmEGS3zbbtrH4MgcW1XldDTYMpvv/90YNCNBrX7AtuptyPR
   UqgFzU6HPyGA+W3Ld+ckpjDvNmpTS9cTrd07w/2RCAZ/s/T0qnrgL6x7W
   ZgHOT8Go/nhJfNcmFEEM61SDzxdjj+bpC4fLPEiHc4DdL/enjK5+vaO9f
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="238984974"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="238984974"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 02:13:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="635304398"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 02:13:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nUmBZ-001QAZ-Rm;
        Thu, 17 Mar 2022 11:12:45 +0200
Date:   Thu, 17 Mar 2022 11:12:45 +0200
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
Message-ID: <YjL7jWpOCjo9R0SH@smile.fi.intel.com>
References: <20220316213055.2351342-1-morbo@google.com>
 <YjL6K49CkH+YC4FQ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjL6K49CkH+YC4FQ@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 11:06:51AM +0200, Andy Shevchenko wrote:
> On Wed, Mar 16, 2022 at 02:30:55PM -0700, Bill Wendling wrote:
> > When compiling with -Wformat, clang emits the following warning:
> > 
> > drivers/gpio/gpiolib-acpi.c:393:4: warning: format specifies type
> > 'unsigned char' but the argument has type 'int' [-Wformat]
> >                         pin);
> >                         ^~~
> > 
> > The types of these arguments are unconditionally defined, so this patch
> > updates the format character to the correct ones for ints and unsigned
> > ints.
> 
> hhX specifier refers to unsigned char. It's a bug in the compiler.
> 
> NAK.

Oh, I read this wrong, sorry. The pin has been checked to fit in one byte,
but its type is bigger indeed.

I will apply your patch right away and send as a fix after rc1.

-- 
With Best Regards,
Andy Shevchenko


