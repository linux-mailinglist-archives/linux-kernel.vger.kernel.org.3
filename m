Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DF24DB6B9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350363AbiCPQxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357688AbiCPQxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:53:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7793701C;
        Wed, 16 Mar 2022 09:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647449522; x=1678985522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=M6xWvkasIs+4Huuwh1wbLinzgQqked41NLVqaR8etdQ=;
  b=WqdHC6+IZo0bW+qlxs3j8rxcI9HapZid24R6z2nLa49doQA8yHWa5doK
   hnyb3M2jFB7rA8s9PFCCzMcJGh30VoDcFOZAcoU1Ccen9gFNgbwwM9D1C
   zlvGgi1rGIrdrEwDlM4GuowC1rRo99VTS7pHm7hQrQpIaJJl7YG0Y8jEl
   2oL2Dodry7TbDqaI573A/w89NvvfYBu3lFiH1vm/7HMAkzeBX/bk9Mhos
   dWQw+paMGVGwXYkUTTIQm0QwGBlKQlEdK591Z3zoj8XpnrPx0Zo25cRLp
   bO+FoMJF6pC3p1sphIqBOTvFDTEZLcMGSEEqAi3nq5Yb7z8P1cV3mksUQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="281443925"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="281443925"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 09:52:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="635058087"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 09:52:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nUWro-0010gf-UM;
        Wed, 16 Mar 2022 18:51:20 +0200
Date:   Wed, 16 Mar 2022 18:51:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] staging: fbtft: Consider type of init sequence
 values in fbtft_init_display()
Message-ID: <YjIViC4U3ZwfiXlU@smile.fi.intel.com>
References: <20220304193414.88006-1-andriy.shevchenko@linux.intel.com>
 <Yi97SaQdudVfKV9W@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yi97SaQdudVfKV9W@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 06:28:41PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 04, 2022 at 09:34:14PM +0200, Andy Shevchenko wrote:

...

> Any reason you didn't test build this?

My test build doesn't include the WERROR for this driver, so I missed the
warning. Sorry for that. Now fixed.

> drivers/staging/fbtft/fbtft-core.c: In function ‘fbtft_init_display’:
> drivers/staging/fbtft/fbtft-core.c:1038:48: error: passing argument 3 of ‘fbtft_dbg_hex’ discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>  1038 |                                           s16, &par->init_sequence[i + 1], j,
>       |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/staging/fbtft/fbtft.h:441:50: note: in definition of macro ‘fbtft_par_dbg_hex’
>   441 |                 fbtft_dbg_hex(dev, sizeof(type), buf,\
>       |                                                  ^~~
> drivers/staging/fbtft/fbtft-core.c:52:26: note: expected ‘void *’ but argument is of type ‘const s16 *’ {aka ‘const short int *’}
>    52 |                    void *buf, size_t len, const char *fmt, ...)
>       |                    ~~~~~~^~~
>   LD [M]  drivers/staging/gdm724x/gdmulte.o
> cc1: all warnings being treated as errors

-- 
With Best Regards,
Andy Shevchenko


