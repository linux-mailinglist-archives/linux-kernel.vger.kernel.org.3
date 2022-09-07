Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D24C5B0F35
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiIGVed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiIGVea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:34:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56238E0BB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:34:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E29396194E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 21:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E25C433D6;
        Wed,  7 Sep 2022 21:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662586468;
        bh=UgoD/NLQ0MqihZ87VFspXN0wI9uOU/Esj7gHe+uAoqo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lWhoM2fwKkQ0+S3jLkEBCouMBZXU7I4Tg04RzM5+IrYRYOobXKSOVdFVr4tcHdWjO
         EVP9+WRSEW+9l1GV5Qoh9gWaWoXbY3LYcfo1RxrZrWB2jqQx06huNTu0MnL/0ynzEG
         zKHib011BQJcyBAO1tyDumbf/8nTVs+l35cI4WvM=
Date:   Wed, 7 Sep 2022 14:34:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Jiebin Sun <jiebin.sun@intel.com>, vasily.averin@linux.dev,
        shakeelb@google.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, ebiederm@xmission.com, legion@kernel.org,
        manfred@colorfullife.com, alexander.mikhalitsyn@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com
Subject: Re: [PATCH v4] ipc/msg: mitigate the lock contention with percpu
 counter
Message-Id: <20220907143427.0ce54bbf096943ffca197fee@linux-foundation.org>
In-Reply-To: <eb13cb3e5e1625afe1bb783810f4d6b52a66a2f6.camel@linux.intel.com>
References: <CALvZod44uUFnwfF4StC24t+d1s_XE10hkmSCgb04FjtTATo6xQ@mail.gmail.com>
        <20220907172516.1210842-1-jiebin.sun@intel.com>
        <eb13cb3e5e1625afe1bb783810f4d6b52a66a2f6.camel@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Sep 2022 09:01:53 -0700 Tim Chen <tim.c.chen@linux.intel.com> wrote:

> On Thu, 2022-09-08 at 01:25 +0800, Jiebin Sun wrote:
> > The msg_bytes and msg_hdrs atomic counters are frequently
> > updated when IPC msg queue is in heavy use, causing heavy
> > cache bounce and overhead. Change them to percpu_counter
> > greatly improve the performance. Since there is one percpu
> > struct per namespace, additional memory cost is minimal.
> > Reading of the count done in msgctl call, which is infrequent.
> > So the need to sum up the counts in each CPU is infrequent.
> > 
> > 
> > Apply the patch and test the pts/stress-ng-1.4.0
> > -- system v message passing (160 threads).
> > 
> > Score gain: 3.17x
> > 
> > 
> ...
> >  
> > +/* large batch size could reduce the times to sum up percpu counter */
> > +#define MSG_PERCPU_COUNTER_BATCH 1024
> > +
> 
> Jiebin, 
> 
> 1024 is a small size (1/4 page). 
> The local per cpu counter could overflow to the gloabal count quickly
> if it is limited to this size, since our count tracks msg size.
>   
> I'll suggest something larger, say 8*1024*1024, about
> 8MB to accommodate about 2 large page worth of data.  Maybe that
> will further improve throughput on stress-ng by reducing contention
> on adding to the global count.
> 

I think this concept of a percpu_counter_add() which is massively
biased to the write side and with very rare reading is a legitimate
use-case.  Perhaps it should become an addition to the formal interface.
Something like

/* 
 * comment goes here
 */
static inline void percpu_counter_add_local(struct percpu_counter *fbc,
					    s64 amount)
{
	percpu_counter_add_batch(fbc, amount, INT_MAX);
}

and percpu_counter_sub_local(), I guess.

The only instance I can see is
block/blk-cgroup-rwstat.h:blkg_rwstat_add() which is using INT_MAX/2
because it always uses percpu_counter_sum_positive() on the read side.

But that makes two!
