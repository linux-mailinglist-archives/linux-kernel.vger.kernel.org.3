Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C8851E58C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 10:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382421AbiEGIYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 04:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350131AbiEGIYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 04:24:41 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0527637BE3
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 01:20:54 -0700 (PDT)
Date:   Sat, 7 May 2022 17:20:45 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651911652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hd5CM1qzcCwDjyFZyVOqcVeGkHR+TKhu4UVTHR6z5lE=;
        b=B85RkQDctqyRPhdNfTNBgza0C7cEraJry7F8yX+lcnYZNpPX3oXda/1XstNugruF9LECa/
        xGMXc7tzqX8j7lq/v0iVW//G449MFuNrAuj7KNoVTJ8FfAzIzA0niIWp9xY6oQW0/sk+hn
        +zOXKtAGiOqaF29M2n7cN7PLgIWLZxA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Wu Fengguang <fengguang.wu@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: Re: [PATCH 3/4] mm/memofy-failure.c: optimize hwpoison_filter
Message-ID: <20220507082045.GA1716199@u2004>
References: <20220429142206.294714-1-pizhenwei@bytedance.com>
 <20220429142206.294714-4-pizhenwei@bytedance.com>
 <20220506085920.GC1356094@u2004>
 <3c0e25fb-695d-4a29-6de4-c892f89cea7a@bytedance.com>
 <ac3fc5b9-d09c-5fb6-998d-f7c655d7fa00@redhat.com>
 <a60933f2-ef07-92a3-66cf-071670a03101@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a60933f2-ef07-92a3-66cf-071670a03101@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 08:28:05AM +0800, zhenwei pi wrote:
> 
> On 5/7/22 00:28, David Hildenbrand wrote:
> > On 06.05.22 15:38, zhenwei pi wrote:
> > > 
> > > 
> > > On 5/6/22 16:59, Naoya Horiguchi wrote:
> > > > On Fri, Apr 29, 2022 at 10:22:05PM +0800, zhenwei pi wrote:
> > > > > In the memory failure procedure, hwpoison_filter has higher priority,
> > > > > if memory_filter() filters the error event, there is no need to do
> > > > > the further work.
> > > > 
> > > > Could you clarify what problem you are trying to solve (what does
> > > > "optimize" mean in this context or what is the benefit)?
> > > > 
> > > 
> > > OK. The background of this work:
> > > As well known, the memory failure mechanism handles memory corrupted
> > > event, and try to send SIGBUS to the user process which uses this
> > > corrupted page.
> > > 
> > > For the virtualization case, QEMU catches SIGBUS and tries to inject MCE
> > > into the guest, and the guest handles memory failure again. Thus the
> > > guest gets the minimal effect from hardware memory corruption.
> > > 
> > > The further step I'm working on:
> > > 1, try to modify code to decrease poisoned pages in a single place
> > > (mm/memofy-failure.c: simplify num_poisoned_pages_dec in this series).

This is fine to me.

> > > 
> > > 2, try to use page_handle_poison() to handle SetPageHWPoison() and
> > > num_poisoned_pages_inc() together. It would be best to call
> > > num_poisoned_pages_inc() in a single place too. I'm not sure if this is
> > > possible or not, please correct me if I misunderstand.

SetPageHWPoison() can be cancelled in memory_failure(), so simply bundling
it with num_poisoned_pages_inc() might not be optimal.  I think that
action_result() is supposed to be called when memory error handling is
effective (not filtered, not cancelled). So moving num_poisoned_pages_inc()
(and notification code in your plan) into this function might be good.

> > > 
> > > 3, introduce memory failure notifier list in memory-failure.c: notify
> > > the corrupted PFN to someone who registers this list.
> > > If I can complete [1] and [2] part, [3] will be quite easy(just call
> > > notifier list after increasing poisoned page).
> > > 
> > > 4, introduce memory recover VQ for memory balloon device, and registers
> > > memory failure notifier list. During the guest kernel handles memory
> > > failure, balloon device gets notified by memory failure notifier list,
> > > and tells the host to recover the corrupted PFN(GPA) by the new VQ.
> > 
> > Most probably you might want to do that asynchronously, and once the
> > callback succeeds, un-poison the page.
> > 
> Yes!
> 
> > > 
> > > 5, host side remaps the corrupted page(HVA), and tells the guest side to
> > > unpoison the PFN(GPA). Then the guest fixes the corrupted page(GPA)
> > > dynamically.
> > 
> > I think QEMU already does that during reboots. Now it would be triggered
> > by the guest for individual pages.
> > 
> Yes, currently QEMU supports to un-poison corrupted pages during
> reset/reboot. We can reuse some code to do the work in this case, this
> allows a VM to fix corrupted pages as soon as possible(also no need to
> reset/reboot).

So this finally allows to replace broken page mapped to guest with
a healthy page without rebooting the guest. That sounds helpful.

Thanks,
Naoya Horiguchi

> 
> > > 
> > > Because [4] and [5] are related to balloon device, also CC Michael,
> > > David and Jason.
> > 
> > Doesn't sound too crazy for me, although it's a shame that we always
> > have to use virtio-balloon for such fairly balloon-unrelated things.
> > 
> Thanks!
> 
> -- 
> zhenwei pi
