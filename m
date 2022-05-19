Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6E752DE0E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244387AbiESUF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbiESUF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:05:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1C96D187;
        Thu, 19 May 2022 13:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652990725; x=1684526725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IEHkZG7WnYsRxPk999KUKG9YJK49N+7dI0JkiNKtyjQ=;
  b=G9/LN1REavz5e20kjTk3lOVilakkbnUyB9csrsrWPw70M59KQP1gjGNQ
   FLgO1CzF66uH7Z8taxj4NmriNVTsz7ZhG6dlKaGs3ZyVLPNizc/THXPTi
   wl/wHyyJ9vfxn3ABYBEqjvcJ60fwU1hYS+5HLMfxxFN4sxlN3U4+y5bHi
   /5d7Ske2I+CEkOi+heD3RGFY+DWzzaaGvDjypSAD+ZUNy0Vb5P9fKeh/5
   AdlBLh97YhJ8v75uFcqkhSRGkg8XUDCznRhf3rWW2fPAZpUuHYcyPsBLd
   e1CU5VTIqEPscfdaTvvN0vZ1wouPdygsrXT9tzJYXmkRgX0JcT5U89j8H
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="252250912"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="252250912"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 13:05:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="627788198"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 13:04:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nrmNo-000GD9-6Q;
        Thu, 19 May 2022 23:04:28 +0300
Date:   Thu, 19 May 2022 23:04:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        willy@infradead.org
Subject: Re: [PATCH v2 22/28] Input/joystick/analog: Convert from seq_buf ->
 printbuf
Message-ID: <Yoaiy1lc+MCMZFTQ@smile.fi.intel.com>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-23-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519172421.162394-23-kent.overstreet@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 01:24:15PM -0400, Kent Overstreet wrote:
> seq_buf is being deprecated, this converts to printbuf which is similar
> but heap allocates the string buffer.
> 
> This means we have to consider memory allocation context & failure: Here
> we're in device initialization so GFP_KERNEL should be fine, and also as
> we're in device initialization returning -ENOMEM is fine.

...

> +       int ret = 0;

Redundant assignment.

...

> -		seq_buf_printf(&s, " %d-hat",
> -			       hweight16(analog->mask & ANALOG_HATS_ALL));
> +		pr_buf(&buf, " %d-hat",
> +		       hweight16(analog->mask & ANALOG_HATS_ALL));

Now you may put it on one line here and in similar cases.

...

> +	ret = buf.allocation_failure ? -ENOMEM : 0;
> +	if (!ret)
> +		strlcpy(analog->name, buf.buf, sizeof(analog->name));
> +	printbuf_exit(&buf);
> +	return ret;

Looks like anti-pattern. On top a bit twisted error code manipulation before
checking for error codes, but what about

static int printbuf_export(*buf, *out, size)
{
	...
}

	ret = printbuf_export(&buf, analog->name, sizeof(analog->name));
	printbuf_exit(&buf);
	return ret;

?

-- 
With Best Regards,
Andy Shevchenko


