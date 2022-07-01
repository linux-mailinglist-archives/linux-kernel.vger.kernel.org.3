Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48D956345E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiGANaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiGANaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:30:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E89A12AEA;
        Fri,  1 Jul 2022 06:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656682211; x=1688218211;
  h=message-id:subject:from:to:date:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=+d47PHEG6GUuN8KKZaAK99mo1O1Vtw5dAs10yx1siLA=;
  b=kLB17VtznB/RTb60SoYBMr3O3yAEkIhMGFmueZgyt9a69Yevkqdvyado
   HSdrfyO8DPhOMmiODY6J365uZphglypALahpQDL5F2iNFvSQwa2x2DLY/
   Ae2NPUJZd4DRjOn6YDSSXy9xrmDI4MVjJtUd+G1x1JQtJl4mlqECvEWkb
   dS5kMNiDFLRi9qyEA8/f/VcF0gkFlWazHyoqDboQbR7tSVYIC9DboWzNV
   l1vqfTzl8hqEsM4jM8CEe7XVdTyIyHNWE+WPeCrK0BXn3WuiN7uqYhmXt
   kR8ECKz5N9NRo4TWNWZcSFn2CqWUU571BKllfc5t19XpkEwL9Dnk8Xh+b
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="283752679"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="283752679"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 06:30:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="648348078"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jul 2022 06:30:10 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.72.79])
        by linux.intel.com (Postfix) with ESMTP id 77F6C580B55;
        Fri,  1 Jul 2022 06:30:08 -0700 (PDT)
Message-ID: <b35cf10b03b441a95704648e816ff1acc150f38b.camel@linux.intel.com>
Subject: Re: [PATCH] intel_idle: add CPUIDLE_FLAG_IRQ_ENABLE to SPR C1 and
 C1E
From:   Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To:     Jon Kohler <jon@nutanix.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 01 Jul 2022 16:30:07 +0300
In-Reply-To: <20220630194309.40465-1-jon@nutanix.com>
References: <20220630194309.40465-1-jon@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Thu, 2022-06-30 at 15:43 -0400, Jon Kohler wrote:
> Add CPUIDLE_FLAG_IRQ_ENABLE to spr_cstates C1 and C1E, which will
> allow local IRQs to be enabled during fast idle transitions on SPR.

Did you have a chance to measure this? When I was doing this for ICX and CLX, I
was using cyclictest and wult for measuring IRQ latency.

I was planning to do this for SPR as well.

> Note: Enabling this for both C1 and C1E is slightly different than
> the approach for SKX/ICX, where CPUIDLE_FLAG_IRQ_ENABLE is only
> enabled on C1; however, given that SPR target/exit latency is 1/1
> for c1 and 2/4 for C1E, respectively, which is slower than C1
> for SKX, it seems prudent to now enable it on both states.

I was also going to measure this for C1E.

Could we please hold on this a bit - I'd like to measure this before we merge
it.

Artem.

