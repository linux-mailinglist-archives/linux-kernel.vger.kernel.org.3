Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0245878CA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbiHBINc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbiHBINa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:13:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2371A192B2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:13:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D295FB819CA
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 08:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C37BC433C1;
        Tue,  2 Aug 2022 08:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659428006;
        bh=SDBbx9DKv07X6EYYLWwpQa++5hfBKaClQHY5+gybfgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=texaGZhaW9xehrKNhTB8E5RU/0b+0tRKK8qCs9MtbgBz92y9h3Qz3SmiWM72TWHjt
         OtszHLDhnjmnAVtP+4D/Ryy8AdPY9VFN+wj6w/Epy97r5mgjknaT1rWmsj2FYHbMmy
         XPQwP7BAhxr40s1ibwC8OvYPTvRN23Z2O9o7YsE2ERk4C+/as9pHrz2WBQbK1l9Aor
         1V9H4MluYwqxf1kvkNTIzh136EGmAW75ObMjAsc5zZmxho2wlFNgIQ2LLCfb+bmVsC
         M1eYNJZlfCCi1qGxR+FqCXqyG7ZBOvkRSuXduOSK1BFI9puAgAJ+fAEMjOMiUNZ+Wy
         zj8oHEQuNMhrw==
Date:   Tue, 2 Aug 2022 10:13:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: fix UAF of ref->proc caused by race condition
Message-ID: <20220802081320.kbrnqnzlectmcb3y@wittgenstein>
References: <20220801182511.3371447-1-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220801182511.3371447-1-cmllamas@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 06:25:11PM +0000, Carlos Llamas wrote:
> A transaction of type BINDER_TYPE_WEAK_HANDLE can fail to increment the
> reference for a node. In this case, the target proc normally releases
> the failed reference upon close as expected. However, if the target is
> dying in parallel the call will race with binder_deferred_release(), so
> the target could have released all of its references by now leaving the
> cleanup of the new failed reference unhandled.
> 
> The transaction then ends and the target proc gets released making the
> ref->proc now a dangling pointer. Later on, ref->node is closed and we
> attempt to take spin_lock(&ref->proc->inner_lock), which leads to the
> use-after-free bug reported below. Let's fix this by cleaning up the
> failed reference on the spot instead of relying on the target to do so.
> 
>   ==================================================================
>   BUG: KASAN: use-after-free in _raw_spin_lock+0xa8/0x150
>   Write of size 4 at addr ffff5ca207094238 by task kworker/1:0/590
> 
>   CPU: 1 PID: 590 Comm: kworker/1:0 Not tainted 5.19.0-rc8 #10
>   Hardware name: linux,dummy-virt (DT)
>   Workqueue: events binder_deferred_func
>   Call trace:
>    dump_backtrace.part.0+0x1d0/0x1e0
>    show_stack+0x18/0x70
>    dump_stack_lvl+0x68/0x84
>    print_report+0x2e4/0x61c
>    kasan_report+0xa4/0x110
>    kasan_check_range+0xfc/0x1a4
>    __kasan_check_write+0x3c/0x50
>    _raw_spin_lock+0xa8/0x150
>    binder_deferred_func+0x5e0/0x9b0
>    process_one_work+0x38c/0x5f0
>    worker_thread+0x9c/0x694
>    kthread+0x188/0x190
>    ret_from_fork+0x10/0x20
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Seems sane,
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
