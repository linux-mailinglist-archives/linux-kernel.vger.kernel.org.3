Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A31850168E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348281AbiDNPDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346583AbiDNN5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:57:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCAFB0A4E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:47:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649944043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DskRBwo4rT1rGp5QQmzQS42mfpKQLeowJJ61wZ0sDW4=;
        b=cSau7DOuRTJNXQB0QHHE/kiUNmafm8uRqmUsMWa1R7Ic8A345Or+QOmhjYSenoOHFrS++5
        tNEEM225xr4rVy2ml7vqsrBtti8HzYcOHrbPs6WZlSqd8clwjDxjX35A5DYOifA1BOZM82
        DOntAAbKK9u438FJ4qkXK20JJ7UPKHbzwUpmn+4n76bzVFPeXujaJE3eN+5GJBWGraodmP
        kzxl/2BwnGMf7ps+1hMZv6UXCGlaCuQBMBnk9qauD1wP8MjekNg3dubvYnwAOo3eYQ0vVn
        pog1XVECkVbDVX7k9AYgGzdH2qQzZ/LvxusyvLudO88lw3gBRH6WN0O3BNoVtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649944043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DskRBwo4rT1rGp5QQmzQS42mfpKQLeowJJ61wZ0sDW4=;
        b=q1MoJDHv8bT1KKL0R1zPtEOsCoqB24WzPb3ZqCjUqcabVHcPQACN3uJ9Uk2lITkirC63zH
        msEQBu2gOm/FoIAw==
To:     Zqiang <qiang1.zhang@intel.com>, akpm@linux-foundation.org,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irq_work: Add event-tracing points for irq_work
In-Reply-To: <20220414063829.2472251-1-qiang1.zhang@intel.com>
References: <20220414063829.2472251-1-qiang1.zhang@intel.com>
Date:   Thu, 14 Apr 2022 15:47:22 +0200
Message-ID: <87h76vepzp.ffs@tglx>
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

On Thu, Apr 14 2022 at 14:38, Zqiang wrote:
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/irq_work.h>
> +
>  static DEFINE_PER_CPU(struct llist_head, raised_list);
>  static DEFINE_PER_CPU(struct llist_head, lazy_list);
>  static DEFINE_PER_CPU(struct task_struct *, irq_workd);
> @@ -81,7 +84,9 @@ static void __irq_work_queue_local(struct irq_work *work)
>  	bool rt_lazy_work = false;
>  	bool lazy_work = false;
>  	int work_flags;
> +	int cpu = smp_processor_id();
>  
> +	trace_irq_work_queue_on(cpu, work);

What about work_flags to see on which list this ends up?

Thanks,

        tglx
