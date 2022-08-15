Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17675927EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 04:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiHOCvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 22:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiHOCvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 22:51:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD1F13DE7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 19:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660531903; x=1692067903;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=+PBNMqIeqDhFYEnVesPZtIzro2EO9NNYkXRv9MxnHf0=;
  b=b/KZtne5eIlvVZmJ903A+RQjfOLedqeuecjNjiGn2dpYoDPJr4vES1nu
   mkxJGZJ90sW0CUeg5LolSIb1uIoFyB9nJ/y0UgpJmkvJUGQUbzAZk1vOs
   ulUX5DavaxCvk61NDkGanAK3nvK64rUkiSP3c3djz0Yqg8lcQFWINWeB3
   6Z0AZuRbPVwzxuRNjULapSreuyrNV2n7YXalhHtf6qXx9WlbSCghM1IY/
   7/qVOFrTlTd6FxiJnpT22tgcBRT4aC7CeGjdEBgr6hxTywN5pUZmVaWnN
   K5vK4gP2bS8PcIEZOnRnGPpzatDA1C0x+wJQqkrE782gy7VoJ39CLakis
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="293147980"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="293147980"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 19:51:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="635326866"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 19:51:41 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Wang, Haiyue" <haiyue.wang@intel.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "naoya.horiguchi@linux.dev" <naoya.horiguchi@linux.dev>,
        "alex.sierra@amd.com" <alex.sierra@amd.com>
Subject: Re: [PATCH v3 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
References: <20220812084921.409142-1-haiyue.wang@intel.com>
        <20220815010349.432313-1-haiyue.wang@intel.com>
        <20220815010349.432313-2-haiyue.wang@intel.com>
        <878rnqe074.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <BYAPR11MB34951FC5879F86F0183C8608F7689@BYAPR11MB3495.namprd11.prod.outlook.com>
        <BYAPR11MB34959E47398000C2430E7188F7689@BYAPR11MB3495.namprd11.prod.outlook.com>
Date:   Mon, 15 Aug 2022 10:51:37 +0800
In-Reply-To: <BYAPR11MB34959E47398000C2430E7188F7689@BYAPR11MB3495.namprd11.prod.outlook.com>
        (Haiyue Wang's message of "Mon, 15 Aug 2022 10:15:41 +0800")
Message-ID: <87o7wmcj7q.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Wang, Haiyue" <haiyue.wang@intel.com> writes:

>> -----Original Message-----
>> From: Wang, Haiyue
>> Sent: Monday, August 15, 2022 10:11
>> To: Huang, Ying <ying.huang@intel.com>
>> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; akpm@linux-foundation.org; david@redhat.com;
>> linmiaohe@huawei.com; songmuchun@bytedance.com; naoya.horiguchi@linux.dev; alex.sierra@amd.com
>> Subject: RE: [PATCH v3 1/2] mm: migration: fix the FOLL_GET failure on following huge page
>>
>> > -----Original Message-----
>> > From: Huang, Ying <ying.huang@intel.com>
>> > Sent: Monday, August 15, 2022 09:59
>> > To: Wang, Haiyue <haiyue.wang@intel.com>
>> > Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; akpm@linux-foundation.org; david@redhat.com;
>> > linmiaohe@huawei.com; songmuchun@bytedance.com; naoya.horiguchi@linux.dev; alex.sierra@amd.com
>> > Subject: Re: [PATCH v3 1/2] mm: migration: fix the FOLL_GET failure on following huge page
>> >
>> > Haiyue Wang <haiyue.wang@intel.com> writes:
>> >
>
>
>> >
>> > > This is an temporary solution to mitigate the racing fix.
>> >
>> > Why is it "racing fix"?  This isn't a race condition fix.
>>
>> The 'Fixes' commit is about race condition fix.
>>
>> How about " his is an temporary solution to mitigate the side effect
>> Of the race condition fix"
>
> Try to add more words to make things clean:
>
> "This is an temporary solution to mitigate the side effect of the race
> condition fix by calling follow_page() with FOLL_GET set."

Looks good to me.  Thanks!

Best Regards,
Huang, Ying

>>
>> >
>> > Best Regards,
>> > Huang, Ying
>> >
>> > > After supporting follow huge page by FOLL_GET is done, this fix can be
>> > > reverted safely.
>> > >
>> > > Fixes: 4cd614841c06 ("mm: migration: fix possible do_pages_stat_array racing with memory offline")
>> > > Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
>> >
>> > [snip]
