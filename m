Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AAF55DEE3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbiF1B5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiF1B5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:57:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CC1BC94
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656381424; x=1687917424;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=KhNIX1vdfNA11IMZRMjDJRfMks3in0mWikfrfge0Psw=;
  b=B1flKjPXe5i/wv6FEB24J5cJCZoooGxsiAx/39yGU2THZA3R3bfe3uBx
   hN/4hIGaOe4oxwxroOGs8UOfgga71bVbnl81smmoCgZQ1jT1dgX7aBYRP
   WR9xMeVuXz50GSyhmKs/xRrZMigXyq0tITDrSOtwEDSXpGdxgyzK2tku6
   uzhymXXNg+YOdbkPkA8zmXbA8e9HN+PWNTVECoUz7kBgPCZdNIdGPxU/D
   vPYtMNIriAVHIC2FPzpuRPT4lMED3l9RWyx8Tete7z6fFIwn8Hg4fjpR3
   LTW0EeTfdbFleqm6Qva1rC+ybf8zF+VGIRL3Fc+DvjGSPRMJVn55v7aSG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="282699785"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="282699785"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 18:57:04 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="692881407"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 18:57:02 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, <akpm@linux-foundation.org>,
        <david@redhat.com>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] mm/swapfile: fix possible data races of inuse_pages
References: <20220625093346.48894-1-linmiaohe@huawei.com>
        <20220625093346.48894-2-linmiaohe@huawei.com> <Yrml4mB3sa5fZVJa@qian>
        <fe3c4834-71a6-7867-2108-eca43fde62fc@huawei.com>
        <Yrm05NQs5+tCZawR@qian>
Date:   Tue, 28 Jun 2022 09:56:58 +0800
In-Reply-To: <Yrm05NQs5+tCZawR@qian> (Qian Cai's message of "Mon, 27 Jun 2022
        09:47:16 -0400")
Message-ID: <874k057dp1.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Qian Cai <quic_qiancai@quicinc.com> writes:

> On Mon, Jun 27, 2022 at 09:27:43PM +0800, Miaohe Lin wrote:
>> On 2022/6/27 20:43, Qian Cai wrote:
>> > On Sat, Jun 25, 2022 at 05:33:45PM +0800, Miaohe Lin wrote:
>> >> si->inuse_pages could still be accessed concurrently now. The plain reads
>> >> outside si->lock critical section, i.e. swap_show and si_swapinfo, which
>> >> results in data races. READ_ONCE and WRITE_ONCE is used to fix such data
>> >> races. Note these data races should be ok because they're just used for
>> >> showing swap info.
>> > 
>> > Was this found by kcsan? If so, it would be useful to record the exact
>> > kscan report in the commit message.
>> 
>> Sorry, it's found via code inspection.
>
> Well, if we are going to do a WRITE_ONCE() in those places just for
> documentation purpose now, I think we will need to fix all places in the mm
> subsystem to be consistent.

We have already done this in swapfile.c, please search "WRITE_ONCE"
in that file.

Best Regards,
Huang, Ying
