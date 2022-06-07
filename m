Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DE253F990
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbiFGJZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiFGJZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:25:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7951CCE5E3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:24:59 -0700 (PDT)
Date:   Tue, 7 Jun 2022 11:24:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654593897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FloNaf8D58jhB0fCm1c2XD5keenpp+deqxqaoSmn3Mw=;
        b=JlbTFyrJRmWjNrFubZjQ3Wzp05c3hj+XQU3ax5OPoGlAT14D/8rNYxjerkC7FbUT4y7Dax
        euhIKJloIfM12Vhol0IKGuFOkCbYF+ECHjw77GMZVuH6TY3J/aBi+ha4wYjGxWDqxLmLgx
        2iQ00qA7UTL+CX5VL7o4t38jsl7AlmWntK9S+3uvC0BXs0UBf1rvz6i6VvxHi3yA01uaOy
        s1fXJQs785uEMcjkebvZytRxT94tvsz9AlxFtsnDQ+7baM7XHtDic43gCcmEIk+najLAVO
        IVYBAt+iod8rjZa4vXGQ1zrsT1ZJ9hCFqhCU2uUOynkQwexOD8/2PVTYNW/vUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654593897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FloNaf8D58jhB0fCm1c2XD5keenpp+deqxqaoSmn3Mw=;
        b=VhCRQJZ84okUu/Q3DrI9YmnJVpIMlGNbUqwZTq9HuX3utrBCRS7z3JZ6dTYH8+yb4DqGVV
        4BOSyyW1wLuUPZCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Zhipeng Shi <zhipeng.shi0@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.comb, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, tglx@linutronix.de,
        schspa@gmail.com, shengjian.xu@horizon.ai,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/rtmutex: Provide proper spin_is_contended
Message-ID: <Yp8ZaHHBrHzg+o49@linutronix.de>
References: <20220607091514.897833-1-zhipeng.shi0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220607091514.897833-1-zhipeng.shi0@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-07 17:15:14 [+0800], Zhipeng Shi wrote:
> Commit d89c70356acf ("locking/core: Remove break_lock field when
> CONFIG_GENERIC_LOCKBREAK=y") removed GENERIC_LOCKBREAK, which caused
> spin_is_contended depend on the implementation of arch_spin_is_contended.
> But now in rt-spinlock, spin_is_contended returns 0 directly.
> 
> This causes cond_resched_lock to fail to correctly detect lock contention
> in RT-linux. In some scenarios (such as __purge_vmap_area_lazy in vmalloc),
> this will cause a large latency.
> 
> This patch provides the implementation of spin_is_contended for
> rt-spinlock.

Do you have a test-case or an example?

The thing if _this_ task has higher priority than other tasks waiting on
this lock then a simple unlock+lock won't do a thing. That is why I
ripped it all out while it was half way done.

> Signed-off-by: Zhipeng Shi <zhipeng.shi0@gmail.com>

Sebastian
