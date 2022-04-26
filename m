Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E3150EE72
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 04:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbiDZCFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 22:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiDZCFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:05:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298A98CDAF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 19:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650938545; x=1682474545;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5pyMy/YoPUtswofxDrGu3rhyiIHVCPMk0ik/b0YSP2k=;
  b=cTJ4nazvp8pWeVGMEfLApxm/gPTRAlNrLlPmm1UjlFn2K1etYfB8OWGh
   nJrl16Jr41KPdWcZ7aHqDki248tfAQcBSIs9V7UvjL28obCd9YpsU/IJx
   jGCG1sjm0RlH1FAq0ukU47qNeIV7wsBnVBqBi58CQofZLShllUKNm29zy
   teB9WEPMPQv+XzNmzZnfQ92AKY90mLgTyUimwQkqLAa8mFRji7ReCxwvQ
   U8Iq1P2V2GUaxMKOzOc5OG63xD1C97JEJsXqPmXxrc3hT0sSdKD5kCEYx
   zYwoRu0RUKUBF01+lT3+/n0f3zNnMtolkAZ5iYpbRycTM2wgetmo13+5i
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="264267118"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="264267118"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 19:02:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="532401701"
Received: from mba-mobl1.ccr.corp.intel.com ([10.254.214.60])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 19:02:20 -0700
Message-ID: <6b74e6f3799032d4f12bae0d97a453dc85d03028.camel@intel.com>
Subject: Re: [PATCH v3 3/6] mm/vmscan: activate swap-backed executable
 folios after first usage
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     iamjoonsoo.kim@lge.com, hch@lst.de, osalvador@suse.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 26 Apr 2022 10:02:17 +0800
In-Reply-To: <20220425140711.0c1898862fc817135bbbc56e@linux-foundation.org>
References: <20220425111232.23182-1-linmiaohe@huawei.com>
         <20220425111232.23182-4-linmiaohe@huawei.com>
         <20220425140711.0c1898862fc817135bbbc56e@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-25 at 14:07 -0700, Andrew Morton wrote:
> On Mon, 25 Apr 2022 19:12:29 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
> > We should activate swap-backed executable folios (e.g. tmpfs) after first
> > usage so that executable code gets yet better chance to stay in memory.
> 
> Does this not erase the intended effect of Joonsoo's b518154e59a
> ("mm/vmscan: protect the workingset on anonymous LRU")?

I don't think so.  This is only for executable folios (vm_flags &
VM_EXEC).  The behavior for all other anonymous pages are not affected.

Best Regards,
Huang, Ying

