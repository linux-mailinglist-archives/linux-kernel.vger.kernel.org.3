Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456324D3BA4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 22:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbiCIVD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 16:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbiCIVDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:03:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77303467C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:02:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B31FB82396
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDADC340E8;
        Wed,  9 Mar 2022 21:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646859770;
        bh=K+SVF3NIC6AclGAEc157GL3w6NzdafbLPewFtDqSVgM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GwsZDdIu5bwip/A6obnXFxBfi+WYu6RF1OUwfUL4x28lPu1gcUgU3dSf7BNb3S8U5
         1P1a+63Qj9msEHdGm5YoIOjZywkf5jAMRFpbVQTsA8faitK8wrGQA6R+bXRkp+G5Ti
         8WqvS5tb8LYBjaXVS7zgCps2LccoM0eiqAT1UH9Q=
Date:   Wed, 9 Mar 2022 13:02:49 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Only re-generate demotion targets when a numa node
 changes its N_CPU state
Message-Id: <20220309130249.60733272aafb3bd5f2e6b88c@linux-foundation.org>
In-Reply-To: <20220309144644.4278-1-osalvador@suse.de>
References: <20220309144644.4278-1-osalvador@suse.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Mar 2022 15:46:44 +0100 Oscar Salvador <osalvador@suse.de> wrote:

> Abhishek reported that after patch [1], hotplug operations are
> taking ~double the expected time. [2]
> 
> The reason behind is that the CPU callbacks that migrate_on_reclaim_init()
> sets always call set_migration_target_nodes() whenever a CPU is brought
> up/down.
> But we only care about numa nodes going from having cpus to become
> cpuless, and vice versa, as that influences the demotion_target order.
> 
> We do already have two CPU callbacks (vmstat_cpu_online() and vmstat_cpu_dead())
> that check exactly that, so get rid of the CPU callbacks in
> migrate_on_reclaim_init() and only call set_migration_target_nodes() from
> vmstat_cpu_{dead,online}() whenever a numa node change its N_CPU state.
> 
> [1] https://lore.kernel.org/linux-mm/20210721063926.3024591-2-ying.huang@intel.com/
> [2] https://lore.kernel.org/linux-mm/eb438ddd-2919-73d4-bd9f-b7eecdd9577a@linux.vnet.ibm.com/
> 
> ...
>
>  extern bool numa_demotion_enabled;
> +#ifdef CONFIG_HOTPLUG_CPU
> +extern void set_migration_target_nodes(void);
> +#else
> +static inline void set_migration_target_nodes() {}

Compiler won't like that.  Please test (compile and runtime) with
CONFIG_HOTPLUG_CPU=n.

>
> ...
>
