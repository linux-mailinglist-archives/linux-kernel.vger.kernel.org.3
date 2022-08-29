Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE52B5A5016
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiH2PU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiH2PU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:20:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875D5647D3;
        Mon, 29 Aug 2022 08:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661786455; x=1693322455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uxJC5RyIvqRPTFaq8u3zwzY6+WnQHFd6VU87M4w9eys=;
  b=Q8cENqbX5xpldMsAIOqW7/SkUTTvxk6Smfu4SLoeSyq00N+Qoi1OZa5H
   J99VmjOOAn9tHL0MoVPcDvzpkZKWlSJ8Sj0u2pm4K6k8XO2HdaktZcPfR
   yThsocjUvxNw2eW6ra6O98xusooPLdrqDuGsITZwHp23MKfxfCwDbtdEa
   J5KfWOKGVaWwAd3sIRj9btH1HbahmciWoSZlcr+/AFREkV8eKUon3YtUC
   ptGUOlbfexJlT3WWfFmB0ceveGSDgmVpD0Hqhm1RyfGStlP6NUgWnfamK
   FTNz7JS3HK+VVMCyMX7kzSPgXvJ89FM57TJ4QnZf90QQu3CUCJ8kuuH5O
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="295697971"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="295697971"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 08:20:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="562255775"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 08:20:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oSgX4-005aCL-0G;
        Mon, 29 Aug 2022 18:18:34 +0300
Date:   Mon, 29 Aug 2022 18:18:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 4/4] ACPI: platform: Keep list of ACPI IDs sorted
Message-ID: <YwzYxTam0TLox11+@smile.fi.intel.com>
References: <20220829141100.63934-1-andriy.shevchenko@linux.intel.com>
 <20220829141100.63934-4-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jtk0SBz6X3cwpKbckhGdmGE39Ynd94M5C8c4RvqVWQ=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jtk0SBz6X3cwpKbckhGdmGE39Ynd94M5C8c4RvqVWQ=A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 04:28:23PM +0200, Rafael J. Wysocki wrote:
> On Mon, Aug 29, 2022 at 4:10 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > For better maintenance keep list of the ACPI IDs sorted.
> > While at it, replace terminator with more standard '{ }'.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Subject: ACPI: platform: Sort forbidden_id_list[] in ascending order
> 
> Changelog:
> 
> "For easier maintenance, sort the forbidden_id_list[] table rows in
> ascending order with respect to the device ID field.
> 
> While at it, use an empty row as the list terminator, which is more
> usual in the kernel."
> 
> Pretty please.

Sure, thanks for the corrections, will embed them in v2.

-- 
With Best Regards,
Andy Shevchenko


