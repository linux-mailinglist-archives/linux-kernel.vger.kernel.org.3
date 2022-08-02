Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8055882B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiHBTkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiHBTkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:40:37 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E9D45F59
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 12:40:36 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t2so14393454ply.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 12:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=nWj0FhksjabybXNp3qFOH2lNB02WXVc0/mX0kJ/DW/k=;
        b=hq8zXzTari8TnZ5lN5JRAqpoNNbJ0/f9EtoTOnMSY1tsRdEz8WE2gnQwpMMG1GsvIB
         B7QdsNnMHiT0cxy8HbjMFoQ4WBBbDBzI0+lvynZp0V8Ce29myBt5nXje0oWidIOpYSHU
         W7UgA3CkPXfXutyzOMWVUblfs1Y5eW7Vdp6DU5QI8oP6n3c18DHwk2jBCJSMoLZoAAvg
         VNgXAnTYeBoPXI0KkWlAwYYOc6Qh3m6BxwwoZ05VsH52EVeNKqW/IQFTwPcgbRISlV41
         0Cabu16y+L2rRhKLwWuSiUd3IbXjUhVobuM9LeNazRJtX2QWvLSp4pLoEgkj+H6tevr3
         Fhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=nWj0FhksjabybXNp3qFOH2lNB02WXVc0/mX0kJ/DW/k=;
        b=HTFTRWAvIUp4SuK/nDCn9woo1NfQwJ+l6CORfHIx+YcYhvf/EyTmc97ok528wgTse5
         uUAMIsa1NFACrlK4WCkx19sK12QHdADU/E105X+sEENLaiIeeCKaT+zvL0itYJLP+wUW
         qcxccpCIxVWDvMWfvchkvawvL0x65yi/OU1m1B/J3Q6vT4vEDTfnEWrfM9NRMG38peQj
         57LOb/71pTxaEEgcpfr8f8XhsUfqQoDrHams+NQ2sEahA7AbVM0NGQUwNnlux5MkNTwd
         KyirRjaviYkbaQ5qFIbsWhsyjyncVP8KuW6XP1lolN4NyM5yVGo4hJMG/SdMxnFc2T1Y
         LW8w==
X-Gm-Message-State: ACgBeo2wCyj2BZYUtGr+7tKIa3s45hioMcdNcngq5wB1V1wwz6U6OMG8
        TjN7MGNAxQHbWLw819SrKAcj1g==
X-Google-Smtp-Source: AA6agR6DKgWrAL/++AQla64J6PSTzCiSs0v7Eu4JZO/PjKqPeK73HHiMI7xUqHyBALMAkfLu/Ibrhg==
X-Received: by 2002:a17:903:124f:b0:16b:8167:e34e with SMTP id u15-20020a170903124f00b0016b8167e34emr22440521plh.52.1659469235879;
        Tue, 02 Aug 2022 12:40:35 -0700 (PDT)
Received: from google.com (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709027b9700b0016d1d1c376fsm53231pll.287.2022.08.02.12.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 12:40:35 -0700 (PDT)
Date:   Tue, 2 Aug 2022 19:40:32 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] binder: fix UAF of ref->proc caused by race condition
Message-ID: <Yul9sEAtM+4aGbEg@google.com>
References: <20220801182511.3371447-1-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801182511.3371447-1-cmllamas@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
>  drivers/android/binder.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 362c0deb65f1..9d42afe60180 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -1361,6 +1361,18 @@ static int binder_inc_ref_for_node(struct binder_proc *proc,
>  	}
>  	ret = binder_inc_ref_olocked(ref, strong, target_list);
>  	*rdata = ref->data;
> +	if (ret && ref == new_ref) {
> +		/*
> +		 * Cleanup the failed reference here as the target
> +		 * could now be dead and have already released its
> +		 * references by now. Calling on the new reference
> +		 * with strong=0 and a tmp_refs will not decrement
> +		 * the node. The new_ref gets kfree'd below.
> +		 */
> +		binder_cleanup_ref_olocked(new_ref);
> +		ref = NULL;
> +	}
> +
>  	binder_proc_unlock(proc);
>  	if (new_ref && ref != new_ref)
>  		/*
> -- 
> 2.37.1.455.g008518b4e5-goog
> 

Sorry, I forgot to CC stable. This patch should be applied to all stable
kernels starting with 4.14 and higher.

Cc: stable@vger.kernel.org # 4.14+
