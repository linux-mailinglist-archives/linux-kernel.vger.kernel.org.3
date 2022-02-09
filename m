Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8DFF4AF081
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbiBIMBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiBIMBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:01:07 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B90E010DA5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 03:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644407646; x=1675943646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XHcEyr4TkkEQt0L52yL9PfVN/CDEFOJal7rChg5lePM=;
  b=M4haFTN7YLNcBjRvM2Oejlqkd/i+jITFNWZy2CA/jrBU+n41IWarj1uH
   oIPOVvKTy1FOJYekpk+LvOd2wRTGOnFgOWUor+ItLlC0yjZVm544HRtnN
   RLjBBlU11vfsLdEQiSeRiIe7kmCJ3tWh3mCWBg7/m/NPz8nVBTFtkvIqf
   Dek7ogLURLCcvdoLVnJR/5bth0l01Cp3S0A9zBPeBKfizw50BDK2ppULy
   GN+swchKsHVGnLDlY/rnEXNnnd1p0I+ZOEn1RczYnnwYSWJHx8qxPdCEL
   DBWDiebo1vQJj4qoNqDDi5aQwMEdii6Po9Cnvyn67DJTJxGNetJXEw5y0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229835499"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="229835499"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 03:54:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="482306049"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 03:54:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nHlWy-002bH8-ER;
        Wed, 09 Feb 2022 13:53:04 +0200
Date:   Wed, 9 Feb 2022 13:53:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] vsprintf: Fix %pK with kptr_restrict == 0
Message-ID: <YgOrIOLrSfrKE9JO@smile.fi.intel.com>
References: <d7cd39abc28f5e0e08faa8958f35cd929165084e.1643281806.git.christophe.leroy@csgroup.eu>
 <YgJ1a0Mi0wEbr88C@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgJ1a0Mi0wEbr88C@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 02:51:39PM +0100, Petr Mladek wrote:
> On Thu 2022-01-27 11:11:02, Christophe Leroy wrote:

...

> Instead, I would create:
> 
> /*
>  * default is to _not_ leak addresses, so hash before printing,
>  * unless no_hash_pointers is specified on the command line.
>  */
> static noinline_for_stack
> char *default_pointer(const char *fmt, char *buf, char *end, void *ptr,
> 		      struct printf_spec spec)
> {
> 	if (unlikely(no_hash_pointers))
> 		return pointer_string(buf, end, ptr, spec);
> 
> 	return ptr_to_id(buf, end, ptr, spec);
> }
> 
> and use it in both hash_pointer() and pointer().

I like this idea.

-- 
With Best Regards,
Andy Shevchenko


