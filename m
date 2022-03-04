Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6794CD49D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiCDM7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiCDM7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:59:39 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A58516E7D2;
        Fri,  4 Mar 2022 04:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646398732; x=1677934732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Btv+CYeKwUyKPv5JPjPWjvpuR50skIoOrrEn+RtgT8w=;
  b=idIpOnDTIiC9oc1zcUv9+5uIubDgfVSBjFkohxwPoEqaV5FHeccAEGbh
   CDMxSpyAHcTVY43ELjq+SMKIKidBdJOwEaa22LLV+FDTW82wBYZOhCUmb
   MkgbciD3BHbxpy+bcOFMghFtItQsyybqV/29V2HqWGDFJ1/vdHc+sT21E
   W14WaDcZUJdGsPcDYkNJCVEAwgvjrWQ37K+LRkL6CHxsj7sxqigXueZR+
   J/vxClD1+pxPtWI1Gq1ExkruAJX1inoOxVmnnSTz97quWlnbMrgDmAuhy
   9QVqN9D1mkKPWfjfLOLEu1Mn+9ubYLTwmfJ0oypCq4Z6YsaTwcek2RJP+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="314684644"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="314684644"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 04:58:51 -0800
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="642503282"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 04:58:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nQ7VS-00BE1b-FY;
        Fri, 04 Mar 2022 14:58:02 +0200
Date:   Fri, 4 Mar 2022 14:58:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3 3/6] typec: mux: Introduce indirection
Message-ID: <YiIM2rBHcyRAIY0y@smile.fi.intel.com>
References: <20220303223351.141238-1-bjorn.andersson@linaro.org>
 <20220303223351.141238-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303223351.141238-3-bjorn.andersson@linaro.org>
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

On Thu, Mar 03, 2022 at 02:33:48PM -0800, Bjorn Andersson wrote:
> Rather than directly exposing the implementation's representation of the
> typec muxes to the controller/clients, introduce an indirection object.
> 
> This enables the introduction of turning this relationship into a
> one-to-many in the following patch.

...

> +	dev_set_name(&sw_dev->dev, "%s-switch",
>  		     desc->name ? desc->name : dev_name(parent));

Besides a possible shorten form of

	dev_set_name(&sw_dev->dev, "%s-switch", desc->name ?: dev_name(parent));

this lacks of the error checking (it seems in original code like this and
should be fixed as preparatory patch for easy backporting).

...

> +	dev_set_name(&mux_dev->dev, "%s-mux",
>  		     desc->name ? desc->name : dev_name(parent));

Ditto.

-- 
With Best Regards,
Andy Shevchenko


