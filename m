Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723064CBC13
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiCCLEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbiCCLE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:04:29 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EF5154D1A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646305424; x=1677841424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/RW/N6B+ssSGVQ6wcwnQS4QdW4gHzRTOnYqgyJWbHN4=;
  b=YGtjEfcSifb2yzl6vkUefmZVJAt4VpEWu6XgjHRiJxgwYvyp+hqFhUv9
   2hK81t5fDm5owH+Gkq+BwOb6ZgSrt4pi0OjliD6liJl76HWFqrkkGJeN+
   x5ZvQVY6NOdEQdrysQkVmCmX+MHL1UrHNm7ApHBX+13XicaUKGPmXmxG4
   kZ0x3+vmijSUqeZu4iZGdSqW7KGldw8V2QvdfGD1/nSrsU1C2WSmHbwMF
   65GvnOJjcjqksrxo2Z3VdG4DOKB08JOODRs/3n/s/97Rar6yUalapLbjT
   Z0sVcmWfRYEkSQbJR5rxAlWJhFveN/FzTFAWeIFxlU0lonL75rT97VCg7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="241064128"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="241064128"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 03:03:42 -0800
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="493903034"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 03:03:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nPjEU-00AkcN-L8;
        Thu, 03 Mar 2022 13:02:54 +0200
Date:   Thu, 3 Mar 2022 13:02:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Lars Poeschel <poeschel@lemonage.de>
Subject: Re: [PATCH v1 1/3] auxdisplay: lcd2s: Fix lcd2s_redefine_char()
 feature
Message-ID: <YiCgXgsWlqGHEAp5@smile.fi.intel.com>
References: <20220223154718.83500-1-andriy.shevchenko@linux.intel.com>
 <CANiq72kNXwo7hpc0+XX_UsyT_3D9o=o0eVjqN-QtDd46kjdd6g@mail.gmail.com>
 <CANiq72mT3cWkhAjbXu+-SSq9823BT0P0zFgLWEr2hB3TrdeTGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mT3cWkhAjbXu+-SSq9823BT0P0zFgLWEr2hB3TrdeTGA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 11:46:32AM +0100, Miguel Ojeda wrote:
> On Thu, Mar 3, 2022 at 2:18 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > Thanks Andy, queued.
> 
> By the way, I fixed a typo in the commit message.

Thank you, Miguel!

-- 
With Best Regards,
Andy Shevchenko


