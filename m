Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1551758B3FB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 08:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbiHFGBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 02:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiHFGBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 02:01:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF1412ADA;
        Fri,  5 Aug 2022 23:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659765687; x=1691301687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U/SwseuymD6gqKnxn8AIA5OHSAkfqCq30LwXPcgnVr0=;
  b=UD6JeEYgK8JulKX9f+B+M1QAnoibwa2zqqjM86yYq7clu88yLlsEE9Ky
   PaVipmKlLLKHNyJwuobV22ztx3TCeOjFs+Q2CUDW/TPFD11WmiGK0xdci
   3bB37ff43E6u0whxXy28Sz6LKNiBHpDgYscb0prBehZ1nytj2n3G9XqSl
   UujcVACttCciYoBCjZF1P0mtTTbOEibz1sjv1VEI1gkpO3Mf9wXijiAYs
   P64rmQF0uBRLO+tISN0u79zQI6edZTQVNV++PpIw820tMCOUnHLSs0Gym
   1vkXObZ5UaYzL2glxiUpVT1LfQQR6PIg/rIHh2QuwYqubJCYcCGSjzdQD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="290351812"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="290351812"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 23:01:27 -0700
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="663266524"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 23:01:24 -0700
Received: by lahna (sSMTP sendmail emulation); Sat, 06 Aug 2022 09:01:22 +0300
Date:   Sat, 6 Aug 2022 09:01:22 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-watchdog@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] watchdog: wdat_wdt: Set the min and max timeout values
 properly
Message-ID: <Yu4DssMsVUP2Oee7@lahna>
References: <20220806000706.3eeafc9c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806000706.3eeafc9c@endymion.delvare>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 12:07:06AM +0200, Jean Delvare wrote:
> The wdat_wdt driver is misusing the min_hw_heartbeat_ms field. This
> field should only be used when the hardware watchdog device should not
> be pinged more frequently than a specific period. The ACPI WDAT
> "Minimum Count" field, on the other hand, specifies the minimum
> timeout value that can be set. This corresponds to the min_timeout
> field in Linux's watchdog infrastructure.
> 
> Setting min_hw_heartbeat_ms instead can cause pings to the hardware
> to be delayed when there is no reason for that, eventually leading to
> unexpected firing of the watchdog timer (and thus unexpected reboot).
> 
> I'm also changing max_hw_heartbeat_ms to max_timeout for symmetry,
> although the use of this one isn't fundamentally wrong, but there is
> also no reason to enable the software-driven ping mechanism for the
> wdat_wdt driver.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Fixes: 058dfc767008 ("ACPI / watchdog: Add support for WDAT hardware watchdog")
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc! Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
