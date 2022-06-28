Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBADE55CAF0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345423AbiF1LKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343969AbiF1LKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:10:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656FD2B252;
        Tue, 28 Jun 2022 04:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656414649; x=1687950649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sh8CDNz7phFGpULk8cj2R1XFUA4dQiJJ0YaEGaFVak0=;
  b=Qc+NoJCIbR0AqRnSi0VFFbJSG2IwiSZqh4dXBQ2hNi47vZKmqkEqbUFy
   mxacw1wHbF+NZmfzlk2MohZUAWKPdmVEhoroDvBPSLh1Jjk61Y8s0UaDY
   yOAcB/R5oxVAmjNH3W1qFFi/S0ehBYJJEC3c0TcAl7o/pycr+cNpQe41Z
   vY38m0pEj6aKkpo+7MBSQwfdAvwK8sDTpB77YqrVWXTdaNAbyLR9HDqA8
   WJvV+EOHXwLNAM68wfin4K0sTWJ3o5YtfeCvaa0tDBN2zhMiZnxTNvpKX
   k1HTwz13WtY5eyyi6LEsfVQ8cL7nozYhYATa7iRXZYLgif/Gz81Dofeso
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="345708030"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="345708030"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 04:10:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="693066778"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 04:10:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o697E-000wkk-0d;
        Tue, 28 Jun 2022 14:10:44 +0300
Date:   Tue, 28 Jun 2022 14:10:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michael Walle <michael@walle.cc>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
Message-ID: <Yrrhs3D++V79/4Jk@smile.fi.intel.com>
References: <4e1d5db9dea68d82c94336a1d6aac404@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e1d5db9dea68d82c94336a1d6aac404@walle.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 02:49:51PM +0200, Michael Walle wrote:
> Hi,
> 
> I tired to iterate over all child nodes, regardless if they are available
> or not. Now there is that handy fwnode_for_each_child_node() (and the
> fwnode_for_each_available_child_node()). The only thing is the OF backend
> already skips disabled nodes [1], making fwnode_for_each_child_node() and
> fwnode_for_each_available_child_node() behave the same with the OF backend.
> 
> Doesn't seem to be noticed by anyone for now. I'm not sure how to fix that
> one. fwnode_for_each_child_node() and also fwnode_get_next_child_node() are
> used by a handful of drivers. I've looked at some, but couldn't decide
> whether they really want to iterate over all child nodes or just the enabled
> ones.
> 
> Any thoughts?

It was discussed at least twice this year (in regard to some new IIO drivers)
and Rob told that iterating over disabled (not available) nodes in OF kinda
legacy/design mistake. That's why device_for_each_child_node() goes only
over available nodes only.

So, why do you need to iterate over disabled ones?

-- 
With Best Regards,
Andy Shevchenko


