Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2D74D0091
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242942AbiCGN7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237489AbiCGN7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:59:45 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353323A5DC;
        Mon,  7 Mar 2022 05:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646661531; x=1678197531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iOYwNBZ7SWLE0LYmBh3sE36eosAdsT/ywY3fPycTBgA=;
  b=OlFCRn7OFIh+9oLm8zHek4tZub7yRdQ7ErXoqAcuShs6CEmXqBNwqi3d
   rWGmgaq0rqJDlm515W6danJqsM3qg61OGjqbv1ZFhUE2HCxaPHqWybFRL
   vCnbslzV03kYTpJvbEpNZGuDgpmiaIB456ldCxyznyexFSdFPIzjgxu9A
   j3S7R0ubIMNNCHGFQFVKhUCDjtxStFJzvs+SJp0yzZekyTnHDEq/7sJlo
   NqIzp6V4cW8kEFQTWkPLY0B/ym+F1PNIr6PHmcmDdzkZQfk5rW2xQOPe9
   F6sHnPgKgVnk7ARWqCUlKIx5yHSPwE7wUYnkiCaZN8gtFSSEziK+wfDJE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="234348269"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="234348269"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 05:58:50 -0800
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="495066821"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 05:58:47 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 07 Mar 2022 15:56:33 +0200
Date:   Mon, 7 Mar 2022 15:56:33 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v1 1/1] gpiolib: acpi: Convert ACPI value of debounce to
 microseconds
Message-ID: <YiYPETHe39pU7Hoi@lahna>
References: <20220307115623.37492-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307115623.37492-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 01:56:23PM +0200, Andy Shevchenko wrote:
> It appears that GPIO ACPI library uses ACPI debounce values directly.
> However, the GPIO library APIs expect the debounce timeout to be in
> microseconds.
> 
> Convert ACPI value of debounce to microseconds.
> 
> While at it, document this detail where it is appropriate.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215664
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Fixes: 8dcb7a15a585 ("gpiolib: acpi: Take into account debounce settings")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
