Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7850F50D743
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 04:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbiDYDAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 23:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240476AbiDYDAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:00:16 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80C37A9B4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 19:57:13 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id bg9so12255242pgb.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 19:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rSgg1bFzB82nI4SXTp8v1aMM10w2QAAs8IWVWPQwgY0=;
        b=VKqeCpf0/DTgKuVHWQ/Oq5myWVAbEdgXIDKUHC4c6P6GcyNM//crnsYJD4mj5v/UZS
         bM8AgG4kX7lVzBtbZ5GPjgncf79yziPPVu996BygIy0jIlwsv8s635PlBupV+VhdG6uM
         pNsbk/Gow1LdVxDX9GyvNHC6BZSdLYTIuFE4vhaSLmL/XJBakAilhGiughoWJTqm/3uV
         1R3Kfls/3nyM0GZpJ1vaDOkIhe0YpfLl2k+8ii0thUE407e9T1VrQ/+2q2Nm+mWhRay+
         df7MLTV1dKS6LkvfJKGr4CRN8cAbDi5hfKGmmaBvaooEtfowr0h9KAOyf4YLgsNq/Eto
         Oe8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rSgg1bFzB82nI4SXTp8v1aMM10w2QAAs8IWVWPQwgY0=;
        b=O1awfbnFlOhmRjxXqip21lyppGX3ziBFKBGiqDU3CYK8F1GlG8i3rRG23pD+rI5r56
         mbpKNmK68vqjz1lJP7dWA18WRel/f/OlqT5+MWUGuMFeMGCh1OGcZHq7GY+/rkmv+HAf
         1mwIfln4NvveWmyjbdT2YVKPWlRttImxImvqM+2UvgxGJ/aBjEMdQD57hvREeX3KBF1W
         80Ow62KY5MdxXLIEtAxqsOSNoN9jMrWJ7KIGZSRV9Z2UGNISQ0MYoRsN/ukVmEGOXujd
         H3fsNrxHj+r1KjgCTjAlIb2vuLnKdKHIt/oFELdm2LoCV3EUMRYQ6JAvTATIq7rSZpiy
         xKTA==
X-Gm-Message-State: AOAM5304pUQfnRej5xiybA/CNUCESdTbAz2hZ1KcX3EcI2RbIvf2hrpE
        YEULnVpvw7bwKFYmKMAl4g==
X-Google-Smtp-Source: ABdhPJwSsZvGJ2UNTsvwP28l2ZX8H5NhItKaU2yYE5KXPq5vWL3oW5C2C4n2gqksO7pJQbiS8691aA==
X-Received: by 2002:a05:6a00:ac1:b0:4f1:29e4:b3a1 with SMTP id c1-20020a056a000ac100b004f129e4b3a1mr16713999pfl.63.1650855433347;
        Sun, 24 Apr 2022 19:57:13 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g15-20020a056a0023cf00b004e17e11cb17sm9963667pfc.111.2022.04.24.19.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 19:57:12 -0700 (PDT)
Date:   Mon, 25 Apr 2022 10:57:05 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Baokun Li <libaokun1@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 7/9] irq: remove needless lock in takedown_cpu()
Message-ID: <YmYOAfz3Oh1bYiVi@piliu.users.ipa.redhat.com>
References: <20220420140521.45361-1-kernelfans@gmail.com>
 <20220420140521.45361-8-kernelfans@gmail.com>
 <87y1zys9f7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1zys9f7.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 06:11:56PM +0200, Thomas Gleixner wrote:
> On Wed, Apr 20 2022 at 22:05, Pingfan Liu wrote:
> 
> First of all, the subject prefix for the core interrupt subsystem is
> 'genirq' and the sentence after the colon starts with an uppercase
> letter. See:
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html
> 
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index d0a9aa0b42e8..94a6b512c26d 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -1033,18 +1033,16 @@ static int takedown_cpu(unsigned int cpu)
> >  	kthread_park(st->thread);
> >  
> >  	/*
> > -	 * Prevent irq alloc/free while the dying cpu reorganizes the
> > -	 * interrupt affinities.
> > +	 * RCU keeps watching 'cpu' until do_idle()->rcu_report_dead().
> > +	 * And cpu_stopper's fn is dispatched with preemption disabled.
> > +	 * So it can not occur to release a irq_desc.
> >  	 */
> > -	irq_lock_sparse();
> 
> Not everything is about RCU here. You really need to look at all moving
> parts:
> 
> irq_migrate_all_off_this_cpu() relies on the allocated_irqs bitmap and
> the sparse tree to be in consistent state, which is only guaranteed when
> the sparse lock is held.
> 

For the irq which transfer from active to inactive(disappearing) after
fetching, desc->lock can serve the sync purpose. In this case,
irq_lock_sparse() is not needed. For a emergeing irq, I am not sure
about it.

> I'm not sure what you are trying to solve here. Not taking sparse_irq_lock
> here is not gaining anything.
>

It was a big lock preventing my original series to make kexec-reboot parallel on
arm64/riscv platform. But my new series takes a different way. And this
big lock is not a problem any longer.

Thanks for your time.

Regards,

	Pingfan
