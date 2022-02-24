Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE744C205F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 01:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245133AbiBXAGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 19:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239487AbiBXAGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:06:36 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B253558380
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645661164; x=1677197164;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=Uu+jTVal72wWHq+zRSDpCjRHJopUoZhOIPfQFDisbtU=;
  b=UZmRO4wP5INCTYApUxIveaRquM5lsq6ho+icEkZ0kn4zOPjcAQcFQqWZ
   +fvfFQ5uESqJLjnwITl1NQ+BM8YxAhnIkyjZuI9L63AuB7v2EFExFjy3i
   8eEwS1pVlR7AXf4WfMIOtiMTNHuRzFckrRrEodeEQj594p7j/JMuzSDjf
   9RHo48QaFFkKUn1wdsQuzuwyaz/7eA/XAQk9KKCoqgZccsghXcllvsSGF
   RO0C8hn05oUoz3xohvijDUmUdzRHOQS5LHxR4jwYtUCJLH7DM5G7pq1FQ
   HdUhjp2jYM41pmjQ8pWTscTN2/oE44NmI/pn6f/ng1Ifn9e48Ofnzu0ki
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="312828359"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="312828359"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 16:06:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="491398664"
Received: from chakanog-mobl.amr.corp.intel.com (HELO [10.212.198.215]) ([10.212.198.215])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 16:06:03 -0800
Message-ID: <f5edb9dc-8b25-47c2-9905-09e88e41861b@intel.com>
Date:   Wed, 23 Feb 2022 16:05:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210721063926.3024591-1-ying.huang@intel.com>
 <20210721063926.3024591-2-ying.huang@intel.com>
 <eb438ddd-2919-73d4-bd9f-b7eecdd9577a@linux.vnet.ibm.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH -V11 2/9] mm/migrate: update node demotion order on
 hotplug events
In-Reply-To: <eb438ddd-2919-73d4-bd9f-b7eecdd9577a@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/22 15:02, Abhishek Goel wrote:
> If needed, I will provide experiment results and traces that were used
> to conclude this.

It would be great if you can provide some more info.  Even just a CPU
time profile would be helpful.

It would also be great to understand more about what "hotplug on power
systems" actually means.  Is this a synthetic benchmark, or are actual
end-users running into this issue?  Are entire nodes of CPUs going
offline?  Or is this just doing an offline/online of CPU 22 in a 100-CPU
NUMA node?
