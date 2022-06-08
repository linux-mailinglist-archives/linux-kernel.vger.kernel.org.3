Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCBB542F81
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbiFHLxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238371AbiFHLxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:53:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB10F1F77F2;
        Wed,  8 Jun 2022 04:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654689213; x=1686225213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=di58yFNgBJOD/mEX4qB4r1jkfobdsQSueMU13pLZF0k=;
  b=YB9YQ/QoGCXEcmFrhzJahQzB7rqH4IuXsjRFpoo3A06imGXMD+GhJ8HJ
   c91LZqUQ+KVrn+IWUq/9Fs6dgQRQj4XcdXcZ9HLRPAI3+2zNg0rLNq7T/
   4vHLr63UEsAd1uCRSiHKQLyv59huNJ34C+znOA7Yirn40oKG+MjQ+XVe5
   jlwRtpF4OQ4ohK1iquFjtcYR052VMmoPBwBNF9h2sxcJRyFRYq6uzD06n
   r7olcNGdoDmna6er2orjmUv11bAjT3dMaGA5ZdwKzz+LVq44qYYKB35KX
   Y0kd6wMDHzicexkv6JBSxyI61s0kP99t4iubCBzf4ZLOorveBn+MPl7V1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="276895384"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="276895384"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 04:53:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="584842519"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 04:53:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nyuFd-000Wjt-82;
        Wed, 08 Jun 2022 14:53:29 +0300
Date:   Wed, 8 Jun 2022 14:53:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] driver core: Introduce device_find_first_child()
 helper
Message-ID: <YqCNuJ3RQX3jIy59@smile.fi.intel.com>
References: <20220607202058.8304-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gmO-BDyurQtG4sU5KLfe2mjs7vm5kpJQoAaxYxF57t3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gmO-BDyurQtG4sU5KLfe2mjs7vm5kpJQoAaxYxF57t3g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 01:29:08PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jun 7, 2022 at 10:22 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> I would define it as
> 
> static int match_first(struct device *dev, void *)
> {
>        return 1;
> }
> 
> struct device *device_find_first_child(struct device *parent)
> {
>         return device_find_first_child(parent, NULL, match_first);
> }
> EXPORT_SYMBOL_GPL(device_find_first_child);
> 
> which is not that much more overhead.

With this we actually may simply provide a match function and it will make the
clean ups (like patch 2 in the series) almost the same without introducing a
device core call.

Something like

int device_match_any_for_find(struct device *dev, void *unused)
{
	return 1;
}

As I replied to Greg it's pity we can't use device_match_any()...

-- 
With Best Regards,
Andy Shevchenko


