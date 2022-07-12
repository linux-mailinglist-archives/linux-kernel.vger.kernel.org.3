Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F36570F25
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiGLA7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGLA7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:59:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6368286C9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657587558; x=1689123558;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=fG91vXyd24Ic0YiHkKexFzSUOf3x6QD+anlpijtsSlc=;
  b=nz8O7aiB7ieS/dUycNx74A+pVkQGNPo+ZOuvJRshEjjQ9l5NP1Fs3KjN
   jhX8VMogs0pjNedzijOCUWk5mmp705OmCcmOsrwvPCkTHIfS0fqEQq1AU
   mwr9apgLiunyxmLPZo0zxlSfLTDf54K2+IqhWqewNb/ezvzuCxBm6TXwe
   evT3Q2fZfkaV+4ewLrdWHefDwaAsSO3gG8HpUt/AxcrczIcKxNHjgDXUN
   cqaI4DjADOjtm5kZoXtztWP+BJWrBYUhDUoFeTnyrHnbm6FfdAhgYfxBu
   4YbAJYD5OwcUD0UjXBjORLlHqooRf7hW7UaknT+Y9pw548gtItUvCUhnI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="346491017"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="346491017"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:59:18 -0700
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="569991996"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:59:16 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH -V2 1/7] migrate: fix syscall move_pages() return value
 for failure
In-Reply-To: <YswPApwvAjvX1VEd@localhost.localdomain> (Oscar Salvador's
        message of "Mon, 11 Jul 2022 13:52:34 +0200")
References: <20220711084948.274787-1-ying.huang@intel.com>
        <20220711084948.274787-2-ying.huang@intel.com>
        <YswPApwvAjvX1VEd@localhost.localdomain>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Tue, 12 Jul 2022 08:59:12 +0800
Message-ID: <87zghf5eov.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oscar Salvador <osalvador@suse.de> writes:

> On Mon, Jul 11, 2022 at 04:49:42PM +0800, Huang Ying wrote:
>>  	return store_status(status, start, node, i - start);
>> @@ -1768,8 +1768,12 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>>  
>>  		err = move_pages_and_store_status(mm, current_node, &pagelist,
>>  				status, start, i, nr_pages);
>> -		if (err)
>> +		if (err) {
>> +			/* We have stored status of page i */
>
> IMHO, "We have accounted for page i" gives a more clear statement.

Sure.  Will change this.

> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks!

Best Regards,
Huang, Ying

>> +			if (err > 0)
>> +				err--;
>>  			goto out;
>> +		}
>>  		current_node = NUMA_NO_NODE;
>>  	}
>>  out_flush:
>> -- 
>> 2.30.2
>> 
>> 
