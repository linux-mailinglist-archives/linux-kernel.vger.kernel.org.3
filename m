Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEE65854FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 20:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbiG2SX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 14:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbiG2SXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 14:23:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0377A62A67
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 11:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659119004; x=1690655004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X2VF3pNp8E/hZzwDvRsZjaNCBkmtMXVopMiWXQZ7zTY=;
  b=ICv9sTvPXKXviwoSVJlnrvRBuq6DR5284aAxslYdveaUeiOIam7Sn90G
   qWpfwra8rOwMjKZ7uaZsP9+3wQWfIalh1zix4dMAWD4BENSi7/bnKbBsi
   XKuQJTrPaBh36pmYfpY/hJZ0fTcSw7bzU/6VcfR738zZ8QBu5ZZayMdem
   /JKOwM4/KLOOJ8aquoz1szsewWXXf0ZqJx63N1qJr4MqfoZxednkb4QN2
   grtD9aCWS10rRGIt71D3d97ZuQzFjXWwK5EWAEVk35HgFhnHAQEGmYdIi
   jtBIScyvYnHw4n6hLjar2sXiE3Nd76ePxoMRIq7yezkpsnbgDqEU97OIU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="375126867"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="375126867"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 11:23:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="743616506"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 11:23:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oHUdg-001eiV-3C;
        Fri, 29 Jul 2022 21:23:08 +0300
Date:   Fri, 29 Jul 2022 21:23:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] firmware: dmi: Don't take garbage into
 consideration in dmi_smbios3_present()
Message-ID: <YuQljCM4LZXhSkbh@smile.fi.intel.com>
References: <20220726094329.1725-1-andriy.shevchenko@linux.intel.com>
 <20220727102504.6bbefcf9@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727102504.6bbefcf9@endymion.delvare>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 10:25:04AM +0200, Jean Delvare wrote:
> On Tue, 26 Jul 2022 12:43:29 +0300, Andy Shevchenko wrote:
> > The byte at offset 6 represent length. Don't take it and drop it immediately
> > by using proper accessor, i.e. get_unaligned_be24().
> 
> The subject sounds like you are fixing a bug, while this is only, at
> best, a minor optimization.

I don't know how to improve it, but it kinda a bug in a logic for non-prepared
reader, esp. as specification suggests different thing about version offset.

...

> > -		dmi_ver = get_unaligned_be32(buf + 6) & 0xFFFFFF;
> > +		dmi_ver = get_unaligned_be24(buf + 7);

> I admit I did not know about get_unaligned_be24(). While I agree that
> it makes the source code look better, one downside is that it actually
> increases the binary size on x86_64. The reason is that
> get_unaligned_be32() is optimized by assembly instruction bswapl, while
> get_unaligned_be24() is not. Situation appears to be the same on ia64
> and arm. Only arm64 would apparently benefit from your proposed
> change.

Good to know!
But here it's not a hot path, right?

> I'm not too sure what is preferred in such situations.

For cold paths I think the correctness prevail the performance.

Alternatively we might add a comment in the code explaining the trick,
although I won't like to do it.

Another way is to have a subset of 24-/48-bit unaligned accessors that
use the trick specifically for hot paths with a caveat that they may
access data out of the 24-/48-bit boundaries.

-- 
With Best Regards,
Andy Shevchenko


