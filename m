Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEFF52DEF4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245019AbiESVJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240850AbiESVJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:09:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC38EC3C6;
        Thu, 19 May 2022 14:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652994587; x=1684530587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z0vwwnertIb8gyQoZWQ6y9deYebDJGKCpPTslvNseDk=;
  b=csGsEWmrfgr4aMnmVFSqMoStfveldiQ5PVIL9ZsiYKdv0e1WstFiWw3N
   TNnZ7xpCbkT+ZagIinA1sP6gJK13/DeDiMikOTvkBjQDbNH/x37FLgfn5
   oslh6/wM38QoYv9LjIrL1b/TSozH8VIPqyKyP/KAbBO965qf0lQgL0fR8
   881zSh3ExuFk0ecrprjjTYNWl7iE6wrjNMMYB7D3UQOzo6qhEXQpCWzE/
   eHDPKd1+8foZJL6lVc2P2OZMmf6LZMJx/c0h1FuJHTDEK7xZ/Wd/WOOE4
   eHjfe1jLeJJvIvvULHlSZcu4BnYgGDpVo0eqPwQLwGDYbf2aVvnyHTzqW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="269968524"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="269968524"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 14:09:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="570429135"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 14:09:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nrnOv-000GHY-SP;
        Fri, 20 May 2022 00:09:41 +0300
Date:   Fri, 20 May 2022 00:09:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        willy@infradead.org
Subject: Re: [PATCH v2 22/28] Input/joystick/analog: Convert from seq_buf ->
 printbuf
Message-ID: <YoayFe8PXexTtlK9@smile.fi.intel.com>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-23-kent.overstreet@gmail.com>
 <Yoaiy1lc+MCMZFTQ@smile.fi.intel.com>
 <20220519201927.keuztpaa7q6nqcol@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519201927.keuztpaa7q6nqcol@moria.home.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 04:19:27PM -0400, Kent Overstreet wrote:
> On Thu, May 19, 2022 at 11:04:27PM +0300, Andy Shevchenko wrote:
> > On Thu, May 19, 2022 at 01:24:15PM -0400, Kent Overstreet wrote:

..

> This conversion predated my adding external buffers to printbufs - now the patch
> is more of a direct conversion:
> 
> -- >8 --
> Subject: [PATCH] Input/joystick/analog: Convert from seq_buf -> printbuf

This looks much better.

-- 
With Best Regards,
Andy Shevchenko


