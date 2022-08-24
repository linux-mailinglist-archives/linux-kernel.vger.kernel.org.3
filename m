Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F655A02A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239910AbiHXUVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiHXUU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:20:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8AE52E6C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:20:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C1F961862
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 20:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7151FC433D6;
        Wed, 24 Aug 2022 20:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661372455;
        bh=kRQnWajQgE2HYeZwEoZJedDllC5u1W7kZ8WwowXaYZs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SlzzfNubdkMe2QxX9jTNJ0N2WInsKhQ16Qz3XTkrg6lUYoF5q50eiCBDoPwlj2M00
         BL0H4KtHiWyD+7Jml8cfjV0Uy0Erelp1luMfxF92MQBkjj8MG9wiDXQYGyxnBlE6XR
         U8MYQatJJQp3B9dsgI/VIE2MXXnOloaWvpGZWUQI=
Date:   Wed, 24 Aug 2022 13:20:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     atomlin@redhat.com, frederic@kernel.org, cl@linux.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 1/3] mm/vmstat: Use per cpu variable to track a
 vmstat discrepancy
Message-Id: <20220824132054.54ec0472496db153223282c4@linux-foundation.org>
In-Reply-To: <20220817191524.140710201@redhat.com>
References: <20220817191346.287594886@redhat.com>
        <20220817191524.140710201@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 16:13:47 -0300 Marcelo Tosatti <mtosatti@redhat.com> wrote:

> From: Aaron Tomlin <atomlin@redhat.com>
> 
> Add CPU-specific variable namely vmstat_dirty to indicate if
> a vmstat imbalance is present for a given CPU. Therefore, at the
> appropriate time, we can fold all the remaining differentials.
> 
> This speeds up quiet_vmstat in case no per-CPU differentials exist.
> 
> Based on 
> https://lore.kernel.org/lkml/20220204173554.763888172@fedora.localdomain/
> 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
>  mm/vmstat.c |   54 ++++++++++++++++++++----------------------------------
>  1 file changed, 20 insertions(+), 34 deletions(-)
> 
> Index: linux-2.6/mm/vmstat.c
> ===================================================================
> --- linux-2.6.orig/mm/vmstat.c
> +++ linux-2.6/mm/vmstat.c
> @@ -195,6 +195,12 @@ void fold_vm_numa_events(void)
>  #endif
>  
>  #ifdef CONFIG_SMP
> +static DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
> +
> +static inline void mark_vmstat_dirty(void)
> +{
> +	this_cpu_write(vmstat_dirty, true);
> +}

If we're to have a helper for this then how about helpers for clearing
it and reading it?

Also, vmstat_mark_dirty(), vmstat_clear_dirty() and vmstat_dirty()
would be better identifiers.

Then those helper functions become good sites for comments explaining
what's going on.

