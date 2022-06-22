Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF1D555421
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 21:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiFVTTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 15:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiFVTTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 15:19:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1EC3587E;
        Wed, 22 Jun 2022 12:19:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A821B820DF;
        Wed, 22 Jun 2022 19:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F12C34114;
        Wed, 22 Jun 2022 19:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655925582;
        bh=/mqJhZHnFZv4yLcCic7/bc1inkKszgYj0JD8prJIpjk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qjWwYVRfzc+N/uWK1DpW6CQ1YtCEOGV22eBql0f6AWWGbzOZS1IgM/pjtupsLc42h
         ta0txrydZ00LBL7/oBed2qA17Gp2fr41qccvrNnizD0i9RH0wCeQC//+fWo2G90mHl
         9zKKVEDbrzi7kVNmY0rEi2WI55V7CHa6d6G4mfM4=
Date:   Wed, 22 Jun 2022 12:19:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: do not lookup algorithm in backends table
Message-Id: <20220622121930.4f8d3f882bb2b0520fd6917c@linux-foundation.org>
In-Reply-To: <YrMzJSNb4b+tODqR@google.com>
References: <20220622023501.517125-1-senozhatsky@chromium.org>
        <YrMzJSNb4b+tODqR@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 00:20:05 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> On (22/06/22 11:35), Sergey Senozhatsky wrote:
> > Always use crypto_has_comp() so that crypto can lookup module,
> > call usermodhelper to load the modules, wait for usermodhelper
> > to finish and so on. Otherwise crypto will do all of these steps
> > under CPU hot-plug lock and this looks like too much stuff to
> > handle under the CPU hot-plug lock. Besides this can end up in
> > a deadlock when usermodhelper triggers a code path that attempts
> > to lock the CPU hot-plug lock, that zram already holds.
> 
> And we think that we (not exactly "we", our partners) actually
> see a deadlock. It goes something like this:
> 
> - path A. zram grabs CPU hot-plug lock, execs /sbin/modprobe from crypto
>   and waits for modprobe to finish

Nope, can't do that.

> disksize_store
>  zcomp_create
>   __cpuhp_state_add_instance
>    __cpuhp_state_add_instance_cpuslocked
>     zcomp_cpu_up_prepare
>      crypto_alloc_base
>       crypto_alg_mod_lookup
>        call_usermodehelper_exec
>         wait_for_completion_killable
>          do_wait_for_common
>           schedule

The usermode helper is free to do anything it wants, including
operations that take the CPU hotplug lock.  Or operations which might
in the future be changed to take that lock.

> - path B. async work kthread that brings in scsi device. It wants to
>   register CPUHP states at some point, and it needs the CPU hot-plug
>   lock for that, which is owned by zram.
> 
> async_run_entry_fn
>  scsi_probe_and_add_lun
>   scsi_mq_alloc_queue
>    blk_mq_init_queue
>     blk_mq_init_allocated_queue
>      blk_mq_realloc_hw_ctxs
>       __cpuhp_state_add_instance
>        __cpuhp_state_add_instance_cpuslocked
>         mutex_lock
>          schedule
> 
> - path C. modprobe sleeps, waiting for all aync works to finish.
> 
> load_module
>  do_init_module
>   async_synchronize_full
>    async_synchronize_cookie_domain
>     schedule
> 
> And none can make any progress.
> 
> So I think we need to move crypto_alg_mod_lookup()->call_usermodehelper_exec()
> out of CPU hot-plug lock and pre-load modules in advance, before we grab the
> hot-plug lock.

If the locking is fixed, why is there still a need to preload modules?
