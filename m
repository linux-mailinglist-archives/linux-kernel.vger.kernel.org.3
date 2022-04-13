Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88E6500156
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbiDMVrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiDMVq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:46:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BED7205EB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:44:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2576861F55
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 21:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384FBC385A6;
        Wed, 13 Apr 2022 21:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649886275;
        bh=f7kQXgt88Fq9j64i0VJmNNGivVtdjfUG1FWA4LVgpnc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tP9AhuZsKqcU4xtK6Loi4iDoLIwHFlwI08A1leycs/htb8cD9mQPq/MaBqe3mwTqT
         mF+AJSbO5sOKftSb+qAAhZPYJvwe7SpILtbIBGXnu++4C7ioYKIoP5kpvfFNeLceQH
         Yfd/9Nt6WfUYaelFcDRd0P4N9YvjqSg7ieeeodNU=
Date:   Wed, 13 Apr 2022 14:44:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, baolin.wang@linux.alibaba.com,
        dave.hansen@linux.intel.com, ying.huang@intel.com
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
Message-Id: <20220413144434.6eedb827c629a3a7e08f56b6@linux-foundation.org>
In-Reply-To: <20220413092206.73974-1-jvgediya@linux.ibm.com>
References: <20220413092206.73974-1-jvgediya@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 14:52:01 +0530 Jagdish Gediya <jvgediya@linux.ibm.com> wrote:

> Current implementation to find the demotion targets works
> based on node state N_MEMORY, however some systems may have
> dram only memory numa node which are N_MEMORY but not the
> right choices as demotion targets.

Why are they not the right choice?  Please describe this fully so we
can understand the motivation and end-user benefit of the proposed
change.  And please more fully describe the end-user benefits of this
change.

> This patch series introduces the new node state
> N_DEMOTION_TARGETS, which is used to distinguish the nodes which
> can be used as demotion targets, node_states[N_DEMOTION_TARGETS]
> is used to hold the list of nodes which can be used as demotion
> targets, support is also added to set the demotion target
> list from user space so that default behavior can be overridden.

Permanently extending the kernel ABI is a fairly big deal.  Please
fully explain the end-user value, usage scenarios, etc.

What would go wrong if we simply omitted this interface?

> node state N_DEMOTION_TARGETS is also set from the dax kmem
> driver, certain type of memory which registers through dax kmem
> (e.g. HBM) may not be the right choices for demotion so in future
> they should be distinguished based on certain attributes and dax
> kmem driver should avoid setting them as N_DEMOTION_TARGETS,
> however current implementation also doesn't distinguish any 
> such memory and it considers all N_MEMORY as demotion targets
> so this patch series doesn't modify the current behavior.
> 
> Current code which sets migration targets is modified in
> this patch series to avoid some of the limitations on the demotion
> target sharing and to use N_DEMOTION_TARGETS only nodes while
> finding demotion targets.
> 
> Changelog
> ----------
> 
> v2:
> In v1, only 1st patch of this patch series was sent, which was
> implemented to avoid some of the limitations on the demotion
> target sharing, however for certain numa topology, the demotion
> targets found by that patch was not most optimal, so 1st patch
> in this series is modified according to suggestions from Huang
> and Baolin. Different examples of demotion list comparasion
> between existing implementation and changed implementation can
> be found in the commit message of 1st patch.
> 
> Jagdish Gediya (5):
>   mm: demotion: Set demotion list differently
>   mm: demotion: Add new node state N_DEMOTION_TARGETS
>   mm: demotion: Add support to set targets from userspace
>   device-dax/kmem: Set node state as N_DEMOTION_TARGETS
>   mm: demotion: Build demotion list based on N_DEMOTION_TARGETS
> 
>  .../ABI/testing/sysfs-kernel-mm-numa          | 12 ++++

This description is rather brief.  Some additional user-facing material
under Documentation/ would help.  Describe the format for writing to the
file, what is seen when reading from it, provide a bit of help to the
user so they can understand how to use it, what effects they might see,
etc.

>  drivers/base/node.c                           |  4 ++
>  drivers/dax/kmem.c                            |  2 +
>  include/linux/nodemask.h                      |  1 +
>  mm/migrate.c                                  | 67 +++++++++++++++----
>  5 files changed, 72 insertions(+), 14 deletions(-)

