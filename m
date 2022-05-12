Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C85524C51
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353516AbiELMC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353513AbiELMCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:02:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A2824641F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:02:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652356970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0TDK3FCVRTz87zaUbyq9enp7BRasruSrvfPhIqvEbrA=;
        b=oGONUfWPrupXQpuMINj0gDWWK+uuFnS9UjxgbDtMqCJhaIi4NMmZvHnYUuiDeosbeX4Z9I
        Bf9uKD/Ly1S+wigL2KvU0CueTVZgaRJ66O+b/oO4SRkaqWADH1/hCEM/uVvhj0qVSiLXCS
        +v9GB28oACZ640BIHGtsadqH89lqjT+RG8Rc89JYKLM6qiCF7qDHjOjXfyb6oOr4qYL/6D
        XNOCfEs0jfGeXo9aeFvWToG1B8Qe6mTXqigKG2dSxQBbKAABwi0flVfbdPnHi1qNgOuPqI
        BrAo6PTgBhdBtiOTT9GgIhSeyj4LX1nWXL+7seSyVHw7Ow+/h/E/cJQOPg6MAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652356970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0TDK3FCVRTz87zaUbyq9enp7BRasruSrvfPhIqvEbrA=;
        b=L8/lKOjs5l1lxZa3s6AqtfYIEEq1nHtEtgbWnlgbayv16zFi26kbpDUcbi1FGGVdS0OsS3
        ZuAps1ijRnp8/zBA==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFCv2 03/10] x86: Introduce userspace API to handle per-thread
 features
In-Reply-To: <20220511022751.65540-5-kirill.shutemov@linux.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-5-kirill.shutemov@linux.intel.com>
Date:   Thu, 12 May 2022 14:02:50 +0200
Message-ID: <87o803vtzp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11 2022 at 05:27, Kirill A. Shutemov wrote:
> Add three new arch_prctl() handles:
>  
> +static long thread_feature_prctl(struct task_struct *task, int option,
> +				 unsigned long features)

Bah. I really hate the task pointer on all these x86 prctls. @task must
always be current, so this @task argument is just confusion.

> +{
> +	const unsigned long known_features = 0;
> +
> +	if (features & ~known_features)
> +		return -EINVAL;

This implementation allows to task->read features_[locked] with
@features == 0. That should be documented somewhere.

> +	if (option == ARCH_THREAD_FEATURE_LOCK) {
> +		task->thread.features_locked |= features;
> +		return task->thread.features_locked;
> +	}


> +	/* Do not allow to change locked features */
> +	if (features & task->thread.features_locked)
> +		return -EPERM;
> +
> +	if (option == ARCH_THREAD_FEATURE_DISABLE) {
> +		task->thread.features &= ~features;
> +		goto out;
> +	}
> +
> +	/* Handle ARCH_THREAD_FEATURE_ENABLE */
> +
> +	task->thread.features |= features;
> +out:
> +	return task->thread.features;

Eyes bleed.

	if (option == ARCH_THREAD_FEATURE_ENABLE)
        	task->thread.features |= features;
        else
        	task->thread.features &= ~features;

	return task->thread.features;

It's bloody obvious from the code that the counterpart of enable is
disable, no? So neither the goto nor the 'comment the obvious' is useful
in any way.

Thanks,

        tglx



