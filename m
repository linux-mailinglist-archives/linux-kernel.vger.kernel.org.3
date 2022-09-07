Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26C25B09B3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiIGQFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiIGQFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:05:13 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAFB9F8E1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662566636; x=1694102636;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8qmgsTp0R++7umL+kTPdAI4AENu4bF7ohljPEUK86+0=;
  b=HKSvGvG1OJu++CvzXa4nDRLqv6ShHqUeZiqTjNJCnYfGFTfgHunbTRoZ
   Avz8CQ5QU6YViwjOvSJ+1NnQ6pxx8UZeLmr+/L30jFUOaxcM6QYmATeay
   X27qdgakosp78XYbqHzubH83i7L0N+5xOIOZXpOgNOFjgPpbeJSkht8nM
   rdpQGmUwNXfpt7SSUWSY371E7HZJiaV6082vitslsO6+6/YsigPw5JBNK
   W1SaKX8rS+Hgt2qwk/WLzbuavW/gO2hlzFi6dD/E8Mm1X6cptdSj3mv3B
   BSRfur2Yg/a54s+PqgRN0MqKzAXRarHidoPaQ7o0LDpBRlJq8OiOT/Fzi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="283917477"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="283917477"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 09:01:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="565570756"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.53.232])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 09:01:53 -0700
Message-ID: <eb13cb3e5e1625afe1bb783810f4d6b52a66a2f6.camel@linux.intel.com>
Subject: Re: [PATCH v4] ipc/msg: mitigate the lock contention with percpu
 counter
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiebin Sun <jiebin.sun@intel.com>, akpm@linux-foundation.org,
        vasily.averin@linux.dev, shakeelb@google.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, ebiederm@xmission.com,
        legion@kernel.org, manfred@colorfullife.com,
        alexander.mikhalitsyn@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com
Date:   Wed, 07 Sep 2022 09:01:53 -0700
In-Reply-To: <20220907172516.1210842-1-jiebin.sun@intel.com>
References: <CALvZod44uUFnwfF4StC24t+d1s_XE10hkmSCgb04FjtTATo6xQ@mail.gmail.com>
         <20220907172516.1210842-1-jiebin.sun@intel.com>
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

On Thu, 2022-09-08 at 01:25 +0800, Jiebin Sun wrote:
> The msg_bytes and msg_hdrs atomic counters are frequently
> updated when IPC msg queue is in heavy use, causing heavy
> cache bounce and overhead. Change them to percpu_counter
> greatly improve the performance. Since there is one percpu
> struct per namespace, additional memory cost is minimal.
> Reading of the count done in msgctl call, which is infrequent.
> So the need to sum up the counts in each CPU is infrequent.
> 
> 
> Apply the patch and test the pts/stress-ng-1.4.0
> -- system v message passing (160 threads).
> 
> Score gain: 3.17x
> 
> 
...
>  
> +/* large batch size could reduce the times to sum up percpu counter */
> +#define MSG_PERCPU_COUNTER_BATCH 1024
> +

Jiebin, 

1024 is a small size (1/4 page). 
The local per cpu counter could overflow to the gloabal count quickly
if it is limited to this size, since our count tracks msg size.
  
I'll suggest something larger, say 8*1024*1024, about
8MB to accommodate about 2 large page worth of data.  Maybe that
will further improve throughput on stress-ng by reducing contention
on adding to the global count.

Tim


