Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A4F5314E0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbiEWQWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbiEWQWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:22:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA5B5BE7D;
        Mon, 23 May 2022 09:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653322949; x=1684858949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AgL1ko85PWWvfyTYsuQmaz71teSdVfxl8k4j+ahVxfE=;
  b=L9LQNrDud0X1e3J51UFsnI413PQlhN5LH8QGXYOyapF+X2SjOo5o++Jm
   NoHdRMinTK+4aVSH3h09fKaxJ84go95hNYw0seGewz3ZJKz7arzO3DXiA
   iNPVT6Hl6REEvEOQZbJEXUKrVjCuk998M89L83hit02mtv7EvGD2DOQqf
   UKw5+LFO6776AjuZup4fIZfvwVgZJ7wUBr2ZWacHcJ8rbAAl18puuOanK
   yM9OSwc25lxhwxOJI+nV82Uy+rnGVwOcLqgvk5QnotpJ8pDQBmShobniG
   ixyd1FfpzGsOg6rK2IwJzQTmbBgiX1V3Osz5vtbDVY92xl+vHiL9PBZ6U
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="260878535"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="260878535"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 09:22:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="526013937"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 09:22:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ntAp5-000JLd-8Z;
        Mon, 23 May 2022 19:22:23 +0300
Date:   Mon, 23 May 2022 19:22:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: Re: [PATCH v3 3/4] platform/x86: simatic-ipc: drop custom P2SB bar
 code
Message-ID: <You0vzJDvuO7A1qv@smile.fi.intel.com>
References: <20220513083652.974-1-henning.schild@siemens.com>
 <20220513083652.974-4-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513083652.974-4-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 10:36:51AM +0200, Henning Schild wrote:
> The two drivers that used to use this have been switched over to the
> common P2SB accessor, so this code is not needed any longer.

Hans, in order to minimize the risk of not getting this into next cycle, I
would like to collect your tag (if you have no objection) and then, when I send
a new version of the P2SB series with this series together, we would everything
ready to be taken by Lee.

-- 
With Best Regards,
Andy Shevchenko


