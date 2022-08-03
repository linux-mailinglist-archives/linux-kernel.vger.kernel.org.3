Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D2B5889E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbiHCJxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237822AbiHCJx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:53:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AD112D04;
        Wed,  3 Aug 2022 02:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659520379; x=1691056379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MxxCVP+vAwOM2bKeznjCj6UV9sekl/IK34sVGSu3FF4=;
  b=JbhMKTng52cURQYcj8Ely4c1hAcjDNjaNgxNWn5AwbYgVzKaQuXmdYOC
   PH9mhL0pGclzWruJAuGwN2A+TcBLBbeGJWHBx1W5QTadHGwCqwR9/31eA
   oxMWkqoMZF0KKJ0S5+cMvePvTZi0ztceO3MtH4G4neWRWZhcOw56mE7O0
   s0ga5u/nSIju2ArlhF7dMabTCqq6uXjvr3Qw0HSc5b/2yDI+WeC8zpsxb
   C0VLzIYmk3y/j8Q/RnABR7+pZ/oI2K6nntEava/3UolZJ63gQzDhdggQM
   LqEb5s4x/Wwwj7JWu26CuDd9yDeLqmYMW54B5aE1WHc3zjXJOWjlVRo9o
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="288388955"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="288388955"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 02:52:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="848525050"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 02:52:56 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 03 Aug 2022 12:50:42 +0300
Date:   Wed, 3 Aug 2022 12:50:42 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Krc <reg.krn@pkrc.net>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] gpiolib: acpi: Add a quirk for Asus UM325UAZ
Message-ID: <YupE8pTpGndReTYH@lahna>
References: <20220803042501.515-1-mario.limonciello@amd.com>
 <20220803042501.515-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803042501.515-2-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 11:25:00PM -0500, Mario Limonciello wrote:
> Asus UM325UAZ has GPIO 18 programmed as both an interrupt and a wake
> source, but confirmed with internal team on this design this pin is
> floating and shouldn't have been programmed. This causes lots of
> spurious IRQs on the system and horrendous battery life.
> 
> Add a quirk to ignore attempts to program this pin on this system.
> 
> Reported-by: Pavel Krc <reg.krn@pkrc.net>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216208
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
