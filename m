Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E57C5B2291
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiIHPjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiIHPjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:39:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAD3AE869
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:39:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 777E061D67
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 15:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B900C433D7;
        Thu,  8 Sep 2022 15:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662651540;
        bh=zZ/SyZ5uIrt8M1sN+XQtWuDHRLfUcWLVoooJIAPUxWc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VNj8EE9Tsz+k+9CeVk3OH0tXqA2Bek+2sVutF1nf5+f3H6uQsmbmuIpt2w3+Oa4gN
         5tIzImAjWGJsCo7KdraKE/T3mvvwGbieq+imtYEDiG1WLvGDyvP2iO1H7VCFBa6jNm
         cCz9UIj4TRuhegDcTp3YHsRqbQobf2QswLBu+AZk=
Date:   Thu, 8 Sep 2022 08:38:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Sun, Jiebin" <jiebin.sun@intel.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>, vasily.averin@linux.dev,
        shakeelb@google.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, ebiederm@xmission.com, legion@kernel.org,
        manfred@colorfullife.com, alexander.mikhalitsyn@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com
Subject: Re: [PATCH v4] ipc/msg: mitigate the lock contention with percpu
 counter
Message-Id: <20220908083859.24c989f08d62ddbd031005de@linux-foundation.org>
In-Reply-To: <c8e771c8-4b01-f2b4-5b54-e9931f556270@intel.com>
References: <CALvZod44uUFnwfF4StC24t+d1s_XE10hkmSCgb04FjtTATo6xQ@mail.gmail.com>
        <20220907172516.1210842-1-jiebin.sun@intel.com>
        <eb13cb3e5e1625afe1bb783810f4d6b52a66a2f6.camel@linux.intel.com>
        <20220907143427.0ce54bbf096943ffca197fee@linux-foundation.org>
        <c8e771c8-4b01-f2b4-5b54-e9931f556270@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2022 16:25:47 +0800 "Sun, Jiebin" <jiebin.sun@intel.com> wrote:

> In our case, if the local 
> percpu counter is near to INT_MAX and there comes a big msgsz, the 
> overflow issue could happen.

percpu_counter_add_batch() handles this - your big message
won't overflow an s64.


Lookng at percpu_counter_add_batch(), is this tweak right?

- don't need to update *fbc->counters inside the lock
- that __this_cpu_sub() is an obscure way of zeroing the thing

--- a/lib/percpu_counter.c~a
+++ a/lib/percpu_counter.c
@@ -89,8 +89,8 @@ void percpu_counter_add_batch(struct per
 		unsigned long flags;
 		raw_spin_lock_irqsave(&fbc->lock, flags);
 		fbc->count += count;
-		__this_cpu_sub(*fbc->counters, count - amount);
 		raw_spin_unlock_irqrestore(&fbc->lock, flags);
+		__this_cpu_write(*fbc->counters, 0);
 	} else {
 		this_cpu_add(*fbc->counters, amount);
 	}
_

