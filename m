Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3BE598F51
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 23:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346802AbiHRVRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 17:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346630AbiHRVPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 17:15:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB342DDA85
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660856867; x=1692392867;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GmkbBbjW1HbR2hnXSAPeOB4FglG3wvlQRjoDRd8WvxM=;
  b=mlBnhip74xFnZAhv/6vUi+kkNwlGqC1pN41C6i9sTUnprYMdIUvwaOs7
   Nh3qR+838nhHs3GU+wEczQFHMNOQddU/Bo2BeA/CbfD9uovFnD5mvsnQs
   4Y9ikQwG4Zg4mh0amIyjBbZzgOyKxaVNmf7bVJjxm/pKeUa3MAqZcOZ2A
   457wHr/+V4KOe7A3tvAwd8YjuPfS+5e5P4MmIFnbgQcIntDCH0MiJenCk
   Nc2Z/k3Fmgqz1s3eZdprdoHMUW43QV4qd4GgBodM1zItTXJl95gKjeahh
   xg78ebxO82Y83YOITgpp5rzv4Q/9GzY/oj/qwQnDov1XBln9uPYInLUdF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="294147250"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="294147250"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 14:07:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="853552702"
Received: from tathomp-mobl.amr.corp.intel.com (HELO [10.212.238.171]) ([10.212.238.171])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 14:07:46 -0700
Message-ID: <19144f97-2b00-fed6-5395-0221bbc60802@intel.com>
Date:   Thu, 18 Aug 2022 14:07:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC] mm, proc: add PcpFree to meminfo
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, Aaron Lu <aaron.lu@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kemi Wang <kemi.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, Liu Shixin <liushixin2@huawei.com>
References: <20220816084426.135528-1-wangkefeng.wang@huawei.com>
 <99556483-9f22-4597-8270-b4414cc97e64@huawei.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <99556483-9f22-4597-8270-b4414cc97e64@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/22 00:16, Kefeng Wang wrote:
> On 2022/8/16 16:44, Kefeng Wang wrote:
>> From: Liu Shixin <liushixin2@huawei.com>
>>
>> The page on pcplist could be used, but not counted into memory free or
>> avaliable, and pcp_free is only showed by show_mem(). Since commit
>> d8a759b57035 ("mm, page_alloc: double zone's batchsize"), there is a
>> significant decrease in the display of free memory, with a large number
>> of cpus and nodes, the number of pages in the percpu list can be very
>> large, so it is better to let user to know the pcp count.
> Add more experts according to commit d8a759b57035，
> any advice would be much appreciated，thanks.

Adding a new meminfo field seems like overkill.  I'd just make this a
part of MemFree if anything.

Also, some actual data would be nice here.  Like:

	Before commit d8a759b57035, the maximum amount of pages in the
	pcp lists was theoretically $FOO MB.  After the patch, the lists
	can hold $BAR MB.  It has been observed to be $BAZ MB in
	practice.

	This was all on a system with $X memory NUMA nodes and $Y CPUs.

