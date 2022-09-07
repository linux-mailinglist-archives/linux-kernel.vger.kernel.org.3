Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AD05B0FAA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 00:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiIGWKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 18:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIGWKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 18:10:13 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E672E6C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 15:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662588612; x=1694124612;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+WGzlmVGQfVQKwWsQ/nLccXRYPuiLkLOyjP7dhlNJe8=;
  b=KT66x2/yvbsQZ4iBCtkohZG65fSX6f4Y/5qTI0sFO+4dfHhGWT+np12H
   ObdQPfWZYDP7v5Z0zHFPmerBUyhy08ZdfhjECGCCSM6FccIzwraEn8qmV
   Z7LLwvVs0eMP7kbr769drwkG/JixHy2BcNush173+8pI1PKsrHie2LoKm
   Il7iNVgD1F1AlhT/8EAIcbEha7XQAZs8E/qfh+2lggxwa+upb5osaBBcG
   bqcWypBRnq10KfGXkjKsecpfdPR+yTt1ROHC9taJYHiFlS9slrgGAY2eD
   qcoPU8sKacQ+yf9oUa3qjz6ITt8LwI7FoFI7tE2WjaBofV7hD3IQOQg91
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="284027574"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="284027574"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 15:10:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="644804153"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.53.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 15:10:11 -0700
Message-ID: <dbe336c7d7618db4c56613fa53479c18df1e0b9b.camel@linux.intel.com>
Subject: Re: [PATCH v4] ipc/msg: mitigate the lock contention with percpu
 counter
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jiebin Sun <jiebin.sun@intel.com>, vasily.averin@linux.dev,
        shakeelb@google.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, ebiederm@xmission.com, legion@kernel.org,
        manfred@colorfullife.com, alexander.mikhalitsyn@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com
Date:   Wed, 07 Sep 2022 15:10:11 -0700
In-Reply-To: <20220907143427.0ce54bbf096943ffca197fee@linux-foundation.org>
References: <CALvZod44uUFnwfF4StC24t+d1s_XE10hkmSCgb04FjtTATo6xQ@mail.gmail.com>
         <20220907172516.1210842-1-jiebin.sun@intel.com>
         <eb13cb3e5e1625afe1bb783810f4d6b52a66a2f6.camel@linux.intel.com>
         <20220907143427.0ce54bbf096943ffca197fee@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-09-07 at 14:34 -0700, Andrew Morton wrote:
> 
> I think this concept of a percpu_counter_add() which is massively
> biased to the write side and with very rare reading is a legitimate
> use-case.  Perhaps it should become an addition to the formal interface.
> Something like
> 
> /* 
>  * comment goes here
>  */
> static inline void percpu_counter_add_local(struct percpu_counter *fbc,
> 					    s64 amount)
> {
> 	percpu_counter_add_batch(fbc, amount, INT_MAX);
> }
> 
> and percpu_counter_sub_local(), I guess.
> 
> The only instance I can see is
> block/blk-cgroup-rwstat.h:blkg_rwstat_add() which is using INT_MAX/2
> because it always uses percpu_counter_sum_positive() on the read side.
> 
> But that makes two!

Sure. We can create this function and use it for both cases.  No objections.

Tim

