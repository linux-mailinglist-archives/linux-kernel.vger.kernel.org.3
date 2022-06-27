Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EB455B540
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 04:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiF0CbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 22:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbiF0Ca7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 22:30:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C392BEC
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 19:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656297057; x=1687833057;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=0SZC9BGvouesbvfVcPjJ+JnRsLbGoyd+wiUACFE3uhM=;
  b=lhjfXDU6NgbKKAa9khMwdeQ1J2O0jc/AeOZm6/V0BSNPuzem03MvgO4a
   bZeejuvJQyiw6JXm+iO8JN2b3zvA+iM2mEuoss9rQ4GJH/jGaA0Nltejn
   FXcmQAZrqN9tgSRGZTYesyXz/vBGFm1sPYK5cxMgj15d47buQIfa318mN
   TGhewawZvL5tn7NHPBA+XAgfKOvqYJMZMRMAJvuJASBj9bdjzczJ2/mc3
   xXX/3p43elMWgH3AmB9UFBDy7qsWG+mcXskGFNitu3rlUoM6Hi/H91WIJ
   B/eEga6PbT7gYLuOHyq/tnf7l15ykHbcMqwNhs9CvM5n3uT1k4l96AABC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="345338943"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="345338943"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 19:30:57 -0700
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="657477850"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 19:30:55 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH 0/7] migrate_pages(): fix several bugs in error path
References: <20220624025309.1033400-1-ying.huang@intel.com>
        <3134549d-f17e-5dba-72f7-ed591ce4d1c8@linux.alibaba.com>
Date:   Mon, 27 Jun 2022 10:30:51 +0800
In-Reply-To: <3134549d-f17e-5dba-72f7-ed591ce4d1c8@linux.alibaba.com> (Baolin
        Wang's message of "Fri, 24 Jun 2022 18:11:56 +0800")
Message-ID: <87v8sm7s84.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> ( 6/24/2022 10:53 AM, Huang Ying S:
>> From: "Huang, Ying" <ying.huang@intel.com>
>> During review the code of migrate_pages() and build a test program
>> for
>> it.  Several bugs in error path are identified and fixed in this
>> series.
>> Most patches are tested via
>> - Apply error-inject.patch in Linux kernel
>> - Compile test-migrate.c (with -lnuma)
>> - Test with test-migrate.sh
>> error-inject.patch, test-migrate.c, and test-migrate.sh are as
>> below.
>> It turns out that error injection is an important tool to fix bugs in
>> error path.
>> 
>
> Hi Ying,
>
> The subject prefix shows there are 7 patches in your patch set,
> however I only received 5 patches in my mail box, and I checked the
> link [1], it also shows there are 5 patches. Seems you missed 2
> patches?
>
> https://lore.kernel.org/all/20220624025309.1033400-1-ying.huang@intel.com/

Hi, Baolin,

Thanks a lot for your information!  It turns out to be a format error in
my [6/7] that prevent git-send-email to work properly.  I have fixed it
and send out [6/7] and [7/7] in this thread.

Best Regards,
Huang, Ying
