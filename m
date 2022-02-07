Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414FD4AC41C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345091AbiBGPm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbiBGPgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:36:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FC5C0401CC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:36:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F280614C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21450C004E1;
        Mon,  7 Feb 2022 15:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644248169;
        bh=BLkm1GdmzHsOVnabP/GWrS29PbIl8CqAmJZiVXAFXBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJeWWIQzxVCSSZmZ2qfvZ6IO0oKpUlBXIpPfsO05Q0HFf+VDLBBSSMC10WlDEF1Oj
         FITGcsuineVMuowgdjDwPRIrrLXz0h8t6MV1gYJV6luh6TNveMs+ZCZ5MY8uwwzYPw
         +9b5Qs6YPKCDqPG0zOHBdhcWsOiHA0HUW40OuE123gltqd2mfScJ2hP45m2nptXuBn
         GdrhEgKFr2HUJ507Na2+0N8pS+0A6i8N7prpketY5LTzorubkR7q1ERa9gOhnU5YOA
         JnTZ2De7SIHHEYvU1ccQFcvjy1zXL+dwaZBLYC1hFedo7Q2xAjqXDcwoV2I9UzZPMI
         4f/Xa3zgPhfOw==
Date:   Mon, 7 Feb 2022 16:36:07 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: Re: [patch v11 09/13] task isolation: add preempt notifier to sync
 per-CPU vmstat dirty info to thread info
Message-ID: <20220207153607.GA526451@lothringen>
References: <20220204173537.429902988@fedora.localdomain>
 <20220204173554.854482726@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204173554.854482726@fedora.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 02:35:46PM -0300, Marcelo Tosatti wrote:
> If a thread has task isolation activated, is preempted by thread B,
> which marks vmstat information dirty, and is preempted back in,
> one might return to userspace with vmstat dirty information on the 
> CPU in question.
> 
> To address this problem, add a preempt notifier that transfers vmstat dirty
> information to TIF_TASK_ISOL thread flag.

Ah ok that answers my previous question :)

> Index: linux-2.6/mm/vmstat.c
> ===================================================================
> --- linux-2.6.orig/mm/vmstat.c
> +++ linux-2.6/mm/vmstat.c
> @@ -353,6 +353,13 @@ void init_sync_vmstat(void)
>  	set_thread_flag(TIF_TASK_ISOL);
>  }
>  EXPORT_SYMBOL_GPL(vmstat_dirty);
> +
> +void vmstat_dirty_to_thread_flag(void)
> +{
> +	if (raw_cpu_read(vmstat_dirty) == true)

__this_cpu_read()?

> +		set_thread_flag(TIF_TASK_ISOL);
> +}
> +EXPORT_SYMBOL_GPL(vmstat_dirty_to_thread_flag);
>  #else
>  static inline void mark_vmstat_dirty(void)
>  {
> 
> 
