Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA284CA9AD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240059AbiCBPx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243540AbiCBPxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:53:15 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919A8F6E;
        Wed,  2 Mar 2022 07:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646236351; x=1677772351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TqsuJriP++ovSWqDaQay3x14Ubx1MvNdyBmhpmZ4zGU=;
  b=Aj4jl8UBRDVsGutTs3kEr2Bc4CqmZ4auxtoN1Dwb2sKQOgirXfZs303O
   Kmw6O1zp9l/nNazF0xCERMJfO7c2Ck8bsuPRMlW7F8gRBEi5zSBkewbLm
   aElH/b+c7513u5lbO/mQ2zFfCznbO4ICFCtL5ptqBKsTzxkXZVhY1b/gh
   rELmtyZq0s3TnBG00zg4FOuydDtRkcU0eyX5I5/TVJgZ9pcffwfgt6VS/
   jjvPYUAwOtZDEVxK/qP5C+u2UbodO6DDQZBozOLv4IyCx/t63+JXu8isV
   COziFnp3xtx/ZEUu6b/FZflwsRoamF4XIq8goHXZgjSwR1h5MASNrxApP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="236941828"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="236941828"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 07:52:31 -0800
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="594041589"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 07:52:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nPRGQ-00AMrv-Et;
        Wed, 02 Mar 2022 17:51:42 +0200
Date:   Wed, 2 Mar 2022 17:51:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 1/1] media: c8sectpfe: Clean up handling of
 *_buffer_aligned
Message-ID: <Yh+SjmGgSZGGaW/I@smile.fi.intel.com>
References: <20220209182521.55632-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209182521.55632-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 08:25:21PM +0200, Andy Shevchenko wrote:
> There are a few cases where code is harder than needed to read.
> Improve those by:
> - dropping unnecessary castings (see note below)
> - use PTR_ALING() to be more explicit on what's going on there
> - use proper definitions instead of hard coded values
> 
> Note, dropping castings will allow to perform an additional check
> that type is not changed from void * to something else, e.g. u64,
> which may very well break the bitmap APIs.

Any comments on it?
Can it be applied?

-- 
With Best Regards,
Andy Shevchenko


