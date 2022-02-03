Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AA34A89FC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352835AbiBCR1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:27:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:55175 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240405AbiBCR1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643909232; x=1675445232;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=cn6/09SV3lqefS0xNwIEv6umSLUPYlv5eEXG63Iv6sM=;
  b=A3NicTapTCUO+waAQ46WAIRHJC/Glg2nz8SmaY52KmqUrylMZwx8SgCf
   WKdHFagBtV5fQ13QJFrWi30m6xO8YFV2eJl/2X+LnZmVnRwyGVPQ9AOmr
   tVyP4tQUmFzI2v7cGNn2TurQYs5yRf4wZ5xYyIAEU+tPqTffZOxkEeo/I
   w2dL1UPt46cHgdwE2Tl1ExY7/YSMa8Rml+rZrHgKYESQ2CDcxAHkk9u3p
   EkKR7GuJWIVjfMKfD0TVhgSHlfvo+beE8LRbdIj3ElnlDN3Xgunhiaypx
   0CGeOe2uLMdwnzy+3htFsPwIoxQDcjLORQe8s6xxwKyOlyVpn8/cfiUWl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="231766297"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="231766297"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 09:27:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="535267996"
Received: from oshoron-mobl.amr.corp.intel.com (HELO [10.209.125.125]) ([10.209.125.125])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 09:27:11 -0800
Message-ID: <feffc13d-5ee5-7326-1f5d-d803d0ab44b2@intel.com>
Date:   Thu, 3 Feb 2022 09:27:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Nikita Popov <npv1310@gmail.com>, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Juergen Gross <jgross@suse.com>
References: <CA+cA0PB92khCo7dNAyw-zUmhKJHg-D2aQyT=HmLHhyVvd_Cd5g@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: A logical error in arch/x86/mm/init.c
In-Reply-To: <CA+cA0PB92khCo7dNAyw-zUmhKJHg-D2aQyT=HmLHhyVvd_Cd5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 02:30, Nikita Popov wrote:
> It appears that there is a logical error in arch/x86/mm/init.c in the
> master branch. Although it is unlikely to occur in practice. I
> discovered it while studying source code in that file.

I looked at this a bit.  It seems to have originated in:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=c9b3234a6aba

which isn't the best changelog in the history of the world.  It's also
fixing a boot problem in a configuration that I can't readily reproduce
(Xen PV guest).

There's one thing from the old changelog that's confusing me:

>     But after we get back that page for pgt, it tiggers one bug in pgt allocation
>     with xen: We need to avoid to use page as pgt to map range that is
>     overlapping with that pgt page.

and presumably alluding to the same issue from your mail:

> ... which can incur MMU issues if that page is allocated as a page
> directory)

What are these "MMU issues"?

> In my opinion one of the simplest fixes here is to completely remove
> the following lines:
>     if (!ret && can_use_brk_pgt)
>             ret = __pa(extend_brk(PAGE_SIZE * num, PAGE_SIZE));

This _might_ be right.  But, my confidence that it won't break anything
else is pretty low.  It's also obviously not been tested.

I'd be much more confident if this issue was reproduced, even if the
reproduction was contrived by doing something like purposefully
exhausting the pgt_buf_* area.

If you really feel that this is something that needs to be fixed, I'd
appreciate if you could find some way to reproduce it and then send a
proper patch.
