Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1B94E2E92
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351527AbiCUQy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351516AbiCUQyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:54:18 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88F2187BAC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:52:37 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id o8so10717041pgf.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gj3UMHNqRnWzHHbAUcJXNoc5r5iBg4SQ+AeAQZLvh7A=;
        b=axKWmjQWLsFSpRdKAcGLNz1Y8g7HJYhfDahyiH8OYH8MEdHYj5s8sQVkmSGnBGsIgV
         np4F/HkcnZnBI6EdjjlmkG2t9Wr9bRuHrlcs46EGc4dUnBfjPSeLjZM11/n2yHdQoW1B
         O15BpOmynAS/GM4VMD7qvHuVJ6hche1Kxb1Yjb3UjxCoNWxkKFoxwAQ/HwDqA4mHf11u
         rq1NFXFbngQCFT6L3nZTmBp1RYIKMogA7Lya3JfzBdVn4vl4zcnFAiJsrXw0iOOYbIuP
         gKp77FWl+0MO1lQ09pa6hmy3Z1gnPMy7Yfk2xz1iaISphqEbb0WqwTuShLIJ9u/jHCS8
         kC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Gj3UMHNqRnWzHHbAUcJXNoc5r5iBg4SQ+AeAQZLvh7A=;
        b=0VvaenYexPE9jdfmkdyGAIDeA3Bb3T2rY+8i9n0qaslOjSE/F7ecPrsYu2vUl8dmB4
         Q762LHi3loJuQZQYnaOa5vNw2FyLl0bSgfHiZ0AV8920XCFfTxOIqEC2wMwE2MNrAqD6
         fIPKrhqBkz8Wa27OP1GCadi2t2h63ks0Po0ZHch+a6YsrvrrND7D2zQGy9+B5/9MyqVC
         HJLyRaGD1WA4sCyMJr03mwt5vcCv5GMwRedRfs493imjDX4SO7sJlvJsN30Krq6uDhFm
         PhglOP57J7cIEX4MmVFZMigREKwoqmC2puZBoDWoQiV7Oejv1q/K53PRJf/thIUn9zSA
         F0gw==
X-Gm-Message-State: AOAM5329NVNT7SbpR2On3I/0Fd0RUu0TE6VOrVh9B5A+lL721lr/e/rL
        NaN1ur2XHRaTZBic3mlGuWeYtlitnNYFrA==
X-Google-Smtp-Source: ABdhPJzgkJikm279F9gmGa3GYbcjgEBBfiEB60g0R8SZ0ZzPnD9A+sDgF3heTiJEB73kZJ3IocFA+g==
X-Received: by 2002:a65:604a:0:b0:375:5cc8:7458 with SMTP id a10-20020a65604a000000b003755cc87458mr19022943pgp.205.1647881556857;
        Mon, 21 Mar 2022 09:52:36 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id n14-20020a17090a394e00b001c670d67b8esm35842pjf.32.2022.03.21.09.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:52:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 21 Mar 2022 06:52:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 (repost)] workqueue: Warn flushing of kernel-global
 workqueues
Message-ID: <YjitUuIKTWbpX1/G@slm.duckdns.org>
References: <2efd5461-fccd-f1d9-7138-0a6767cbf5fe@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2efd5461-fccd-f1d9-7138-0a6767cbf5fe@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Tetsuo.

On Sat, Mar 19, 2022 at 01:42:59PM +0900, Tetsuo Handa wrote:
> Since flush operation synchronously waits for completion, flushing
> kernel-global WQs (e.g. system_wq) might introduce possibility of deadlock
> due to unexpected locking dependency. Tejun Heo commented that it makes no
> sense at all to call flush_workqueue() on the shared WQs as the caller has
> no idea what it's gonna end up waiting for.
> 
> Although there is flush_scheduled_work() which flushes system_wq WQ with
> "Think twice before calling this function! It's very easy to get into
> trouble if you don't take great care." warning message, syzbot found a
> circular locking dependency caused by flushing system_long_wq WQ [1].
> Therefore, let's change the direction to that developers had better use
> their local WQs if flush_workqueue() is inevitable.
> 
> To give developers time to update their modules, for now just emit
> a warning message with ratelimit when flush_workqueue() is called on
> kernel-global WQs. We will eventually convert this warning message into
> WARN_ON() and kill flush_scheduled_work().
> 
> This patch introduces __WQ_NO_FLUSH flag for emitting warning. Don't set
> this flag when creating your local WQs while updating your module, for
> destroy_workqueue() will involve flush operation.
> 
> Theoretically, flushing specific work item using flush_work() queued on
> kernel-global WQs (which are !WQ_MEM_RECLAIM) has possibility of deadlock.
> But this patch does not emit warning when flush_work() is called on work
> items queued on kernel-global WQs, based on assumption that we can create
> kworker threads as needed and we won't hit max_active limit.

As noted in the other thread, we can float this sort of patches in -next to
suss out ones which aren't immediately obvious - e.g. something saves a
pointer to one of the system workqueues and flushes that, but if this is to
happen, somebody has to do the most of the legwork to convert most if not
all of the existing users, which isn't necessarily difficult but is tedious,
which is why it hasn't been done yet. So, if you wanna take on this, you
gotta take on the conversions too. Just declaring it so doesn't really work.

Thanks.

-- 
tejun
