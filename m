Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3A24C3A80
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbiBYAuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbiBYAuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:50:18 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E7B2556CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645750188; x=1677286188;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=EgGx5qIAw7Tb4rEPAO2/54qSHMC2QYlZA6qYHpBBk3k=;
  b=e2JYhnOhiPDcNHDigfycZN8n7kNekkgvnLObf2BZ1CKEDdXqNAWA+Z3o
   4VX1ng/FvgblEs2rqsCCEAdIzLRN7jMlAWNScB9ovifBev120/i3ZP7mc
   HdOwndPdxi01aMTWBZwKmt982LMZhDJCaGQDrS62hruD4DSKMj/G34uxn
   zctXNVGFRfO5b5n3frd4StaDxDsiUTolX0HE6HM08dDzSA60oobCK4mXp
   bakK4/2T1dTVjmPwdu3bTmSKVkVuR+0VX9BXijC79W+P3o8C/ab+O2ALY
   5zdi4koo8qYDw5GKGE/8ahvKmkmd5lhdIJs9GEQkdngSwDDmP9dxwP8vK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252307394"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="252307394"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 16:49:48 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="639938510"
Received: from hthen-mobl2.amr.corp.intel.com (HELO [10.209.48.194]) ([10.209.48.194])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 16:49:47 -0800
Message-ID: <4d3c777e-20bd-b1f2-12ba-6af9d08cca45@intel.com>
Date:   Thu, 24 Feb 2022 16:49:43 -0800
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
 <f5edb9dc-8b25-47c2-9905-09e88e41861b@intel.com>
 <4e8067e1-0574-c9d2-9d6c-d676d32071bd@linux.vnet.ibm.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH -V11 2/9] mm/migrate: update node demotion order on
 hotplug events
In-Reply-To: <4e8067e1-0574-c9d2-9d6c-d676d32071bd@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 15:37, Abhishek Goel wrote:
> 
> On 24/02/22 05:35, Dave Hansen wrote:
>> On 2/23/22 15:02, Abhishek Goel wrote:
>>> If needed, I will provide experiment results and traces that were used
>>> to conclude this.
>> It would be great if you can provide some more info.  Even just a CPU
>> time profile would be helpful.
> 
> Average total time taken for SMT=8 to SMT=1 in v5.14 : 20s
> 
> Average total time taken for SMT=8 to SMT=1 in v5.15 : 36s
> 
> (Observed in system with 150+ CPUs )

I was kinda thinking of:

	perf record / perf report

output.  Not wall clock time.  We need to know what the kernel is doing
during those extra 16 seconds.

