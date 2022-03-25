Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C77E4E746D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 14:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358202AbiCYNqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 09:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358158AbiCYNqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:46:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCF2D0804;
        Fri, 25 Mar 2022 06:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648215911; x=1679751911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hq160nSx3cYf3Gi4P+MNKgWZRgkFDiVQtZz9POH7o20=;
  b=K5leJEbC+WKuQfzpxMqvwd18Hq7EQ8yU1Ky3E/ZKhhKAljERI0l0h7fM
   7hbfR97XXfQTuklpOMG1OWglneZsRNZFktXP32W2e5NiP2Wgz8ade5TKb
   qB5bSbGuK1jk+1LmdbNxGY9gR/ic/0tBGSl9JGNlO2wgi7QYkQvJtUEQf
   0L7Goy1vdYyxCafnVoVo0ZVkF3sNLW7JSpZhUb9PkHWHl95D8blxZinwY
   HQVkHEicZXmx+nUmYFn4Eg7Vn3OX00zhIF86MoLw8EpH22+iL7GIaBEuq
   DYoTpqCKpWX+1FBBl9mYshmGGIVbwM71Hsz0J7V91F3eWCsJzrqjQ91bx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="258351087"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="258351087"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 06:45:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="545084694"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 06:45:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nXkF1-006QGm-1O;
        Fri, 25 Mar 2022 15:44:35 +0200
Date:   Fri, 25 Mar 2022 15:44:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] spidev: Do not use atomic bit operations when
 allocating minor
Message-ID: <Yj3HQtndH8HHqpvK@smile.fi.intel.com>
References: <20220323140215.2568-1-andriy.shevchenko@linux.intel.com>
 <Yj25Mp2Ai0jKQtN3@smile.fi.intel.com>
 <Yj3DG+d96RnZ25ON@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yj3DG+d96RnZ25ON@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 01:26:51PM +0000, Mark Brown wrote:
> On Fri, Mar 25, 2022 at 02:44:34PM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 23, 2022 at 04:02:12PM +0200, Andy Shevchenko wrote:

...

> > Shall I resend the series without this patch, or can you apply the rest
> > if you have no comments / objections?
> 
> I've already queued the rest.

Thanks!

-- 
With Best Regards,
Andy Shevchenko


