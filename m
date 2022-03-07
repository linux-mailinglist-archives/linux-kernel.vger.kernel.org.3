Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AA94CF87F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbiCGJzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238539AbiCGJid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:38:33 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D6D45078;
        Mon,  7 Mar 2022 01:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646645573; x=1678181573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qOTDz0USKGfY7/VVrIyvvAYOkFRB9THq3FS4Y8cCEpI=;
  b=PFmi+yS9XX/4IjJdTVkq6UXukdUiKggJif34aIKiSJo8pEevEehuzGxu
   bfLhpLmf6Lj3bKpgnYnQ5U81OSA0cd1X6EA5ieEUFd8mp/HQ7K+/hMZEt
   0X3GKtRxzD5B0K6+EB6ElRQhQidcHvs4vKeD3jXx37iFMsQ2pTbKUmSwM
   KLn1f071CVAK41lPif4O2gjAHnuimLz3+IhNAY410y+v7u1POFknf18u9
   M4RZkD+9eKV43F5R6htPvHzzNrG3B/ckGxUhAN/nxFDglv2ilytvp3fVg
   7j3yZgfXZYON2uE1o6y8mREzTYdKrD4E1aQj2FokXV1O8Uist27qxZwFK
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="253177707"
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="253177707"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 01:32:25 -0800
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="509651189"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 01:32:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nR9iL-00Cgk7-2j;
        Mon, 07 Mar 2022 11:31:37 +0200
Date:   Mon, 7 Mar 2022 11:31:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3 1/6] device property: Helper to match multiple
 connections
Message-ID: <YiXQ+JChrlcQohx6@smile.fi.intel.com>
References: <20220303223351.141238-1-bjorn.andersson@linaro.org>
 <YiIL/ejgxhfRhTDP@smile.fi.intel.com>
 <YiIXDZnquRZj8dU5@paasikivi.fi.intel.com>
 <YiIZoyfsJDcwR4gr@smile.fi.intel.com>
 <YiVrcN3NA3uS0icv@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiVrcN3NA3uS0icv@yoga>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2022 at 08:18:24PM -0600, Bjorn Andersson wrote:
> On Fri 04 Mar 07:52 CST 2022, Andy Shevchenko wrote:
> > On Fri, Mar 04, 2022 at 03:41:33PM +0200, Sakari Ailus wrote:

...

> > I have checked vsnprintf() and indeed, it expects to have the size is 0 when
> > the resulting buffer pointer is NULL, and it doesn't do any additional checks.
> 
> Per the vsnprintf() semantics it's not the destination buffer being NULL
> that's significant, but rather just the length being 0 that matters.

Actually the main point is to have buffer to be NULL. But at the same
time size also has to be 0.

When the size is 0, but buffer is not NULL, it's a different story.

> To follow that, I should fill @matches_len entries in @matches and then
> just continue counting without storing anything in @matches.
> 
> But that won't work in this case, because in the event that the @match
> function returns something that has to be freed (such as the refcounted
> objects returned by the typec_mux code), dropping this in favor of just
> counting it would cause memory/reference leaks.
> 
> As such, I think this should differ in that @matches = NULL is
> significant, and it's nice to not have matches_len turn negative/bogus
> in the count case.
> 
> So I like your suggestion.

-- 
With Best Regards,
Andy Shevchenko


