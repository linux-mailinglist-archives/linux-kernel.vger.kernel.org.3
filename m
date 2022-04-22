Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2875650AE20
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443619AbiDVCx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346148AbiDVCx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:53:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8748731361;
        Thu, 21 Apr 2022 19:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650595864; x=1682131864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/zDeu1maS4StPpX2cIeVhckAYcmm2fpQM1uG5EBWJfM=;
  b=bWZPcgI3ryS0Kf4relQOgf0iXT0pe+Y8eM6xDi8RpfhgevfigPSKHrKY
   gdO4zf8qfAEjzFL3bo7QQ94ODf4YCdPYZr+SLqfnKwA9nzUJMtWyh1JHo
   9+0SPKWZm+zvJvSx8DXeNNSLbckMCkAzUR3JZuAVVkt+XhmVgYaAfTgD5
   yBUky8TIdi3sTZVG2yGPUGY0dWUiwFHLTWmdvujrmgWh6SRxYBsgcR9On
   YoR+PXNeg4WSxejR/TdhgCAhyvNG0WtCKrmiAOBPI7mHeBKR4njr08BNp
   eZkDz5H+Yd3YtqjCBFRQvuBUJxv4HmdhcS2RLdrEZkJ6YriBpO8IQTyWX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="350989550"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="350989550"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 19:51:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="556122543"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 19:51:04 -0700
Date:   Thu, 21 Apr 2022 19:51:02 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH v2] topology/sysfs: Fix allnoconfig build breakage.
Message-ID: <YmIYFjI/B+33PQn+@agluck-desk3.sc.intel.com>
References: <20220421152645.3a849198@canb.auug.org.au>
 <YmD+geU9CmjoVnN9@kroah.com>
 <YmF8Hrq5kgDdfvtS@agluck-desk3.sc.intel.com>
 <YmF+FTxgu2U4/oPA@kroah.com>
 <YmGEL2klp4S97UiH@agluck-desk3.sc.intel.com>
 <20220422092247.5c638079@canb.auug.org.au>
 <90d0e2c9b4a74c92bcdd5fc4313a7629@intel.com>
 <20220422100054.74cadded@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422100054.74cadded@canb.auug.org.au>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 10:00:54AM +1000, Stephen Rothwell wrote:
> I assume that there is some good reason that topology_ppin() is not
> implemented as a static inline function?

I don't think so. I just cut & pasted how all the other topology_*()
things were implemented.

Making it a static inline appears to fix this problem. But before
embarrassing myself with a third broken version I'll let zero day
crunch on:

  git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git hide_ppin

to see if there is some subtle config or arch where the inline trick
doesn't work.

Thanks for the idea! :-)

-Tony
