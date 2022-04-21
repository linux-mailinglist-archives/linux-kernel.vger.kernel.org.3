Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEEF509569
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 05:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383948AbiDUDd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 23:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiDUDd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 23:33:57 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE66B63F6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 20:31:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b15so3785461pfm.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 20:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c2xt43lqy2p0nWXxBHnaS0FQyyavb3HWvWtp8zGcPaY=;
        b=GAyk5QOfiEl07fA9HKqCHI1F6HGdHGAbSmyBThis1sQ9jQS1NzbOmsDwuRAc5LpWUv
         jcy2G9bxBdL0aeFqbiBVRb0rG8bpj8Cd28XHz6vbi+uI6d5tuBAvmA8byyyz5VPIqnoK
         RREEtOgLls8b8sALGEb88+Y01756kXFmbr3kWWQ6XZSE6zCLRgSLdp+fiyTQmNIPlOf7
         EAstQJmg71tunwe5VAKAavd7liWudn9pUa4aZVWKCF1Ah+OWO5jD0PO3uAY1zRbNOxoO
         7dNEoBryeT2V+n/rXS9Nc16lgkHTsdbzpZwPOMYIsvNGq62+Qxs5LHFpTqczROWt7EOv
         /mDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c2xt43lqy2p0nWXxBHnaS0FQyyavb3HWvWtp8zGcPaY=;
        b=zwkaskYVbptdPc+sAaqoK0n5cTCvnP1O5qCn1O9qBd7+EjzOQHQBl9b2VBtK7EU+Sv
         07zzrFZGzkZT00Yg2XUZR3tYR0p0faKbsBnhjobRK2NvyoTzeD/mhzCcpf53URsPQFrQ
         H817O0msV4Fd0RDo20OxHIG5Y8mXDaBcs117H5v98BpNjXHWuw9GwwrTjSFD7WNvn1kb
         VDyri2xRcQdZl943QKsy5gznq+zqelS6eRLUEpdvhZyMh7buk89CdMDpW/tpDTZ0ldBt
         eFtvMZoFdvsYqgXgFxdlWz9oIhS6BSb6JCicdf13y6M69v2jAMmKTSILtCnipwdQs9Yf
         9yog==
X-Gm-Message-State: AOAM531YZwmFNsZZTiRR7Tx0OkCTs8NQV+V34WxKdGQBF50Rkz7+uG00
        nqa1EtVcflCCRfQRjqIvXg==
X-Google-Smtp-Source: ABdhPJx/r48ziiadpv6xozY7L8v3onlPHY2ByXrEfdexuIfNj8LZ7xH/OWApG+5BRYM8N7mGicwS7g==
X-Received: by 2002:a63:fc05:0:b0:3a9:f17d:3f4f with SMTP id j5-20020a63fc05000000b003a9f17d3f4fmr16961417pgi.590.1650511868321;
        Wed, 20 Apr 2022 20:31:08 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p34-20020a056a000a2200b004cd49fc15e5sm23510481pfh.59.2022.04.20.20.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 20:31:07 -0700 (PDT)
Date:   Thu, 21 Apr 2022 11:31:03 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 6/9] pm/irq: make for_each_irq_desc() safe of irq_desc
 release
Message-ID: <YmDP93yLJw5gsjtQ@piliu.users.ipa.redhat.com>
References: <20220420140521.45361-1-kernelfans@gmail.com>
 <20220420140521.45361-7-kernelfans@gmail.com>
 <CAJZ5v0h2SWN-=-5=OsMGm1amMJrYELqM6BC+J=98EAxSUmxMqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h2SWN-=-5=OsMGm1amMJrYELqM6BC+J=98EAxSUmxMqg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 06:23:48PM +0200, Rafael J. Wysocki wrote:
> On Wed, Apr 20, 2022 at 4:06 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > The invloved context is no a RCU read section. Furthermore there may be
> > more than one task at this point. Hence it demands a measure to prevent
> > irq_desc from freeing. Use irq_lock_sparse to serve the protection
> > purpose.
> 
> Can you please describe an example scenario in which the added locking
> will prevent a failure from occurring?
> 

Sorry to forget mentioning that this is based on the code analysis.

Suppose the following scenario:
Two threads invloved
  threadA "hibernate" runs suspend_device_irqs()
  threadB "rcu_cpu_kthread" runs rcu_core()->rcu_do_batch(), which releases
  object, let's say irq_desc

Zoom in:
  threadA                                               threadB
  for_each_irq_desc(irq, desc) {
      get irq_descA which is under freeing
                                                    --->preempted by rcu_core()->rcu_do_batch()  which releases irq_descA
      raw_spin_lock_irqsave(&desc->lock, flags);
      //Oops

And since in the involved code piece, threadA runs in a preemptible
context, and there may be more than one thread at this stage. So the
preempted can happen.


Thanks,

	Pingfan


> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > To: linux-kernel@vger.kernel.org
> > ---
> >  kernel/irq/pm.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> > index ca71123a6130..4b67a4c7de3c 100644
> > --- a/kernel/irq/pm.c
> > +++ b/kernel/irq/pm.c
> > @@ -133,6 +133,7 @@ void suspend_device_irqs(void)
> >         struct irq_desc *desc;
> >         int irq;
> >
> > +       irq_lock_sparse();
> >         for_each_irq_desc(irq, desc) {
> >                 unsigned long flags;
> >                 bool sync;
> > @@ -146,6 +147,7 @@ void suspend_device_irqs(void)
> >                 if (sync)
> >                         synchronize_irq(irq);
> >         }
> > +       irq_unlock_sparse();
> >  }
> >  EXPORT_SYMBOL_GPL(suspend_device_irqs);
> >
> > @@ -186,6 +188,7 @@ static void resume_irqs(bool want_early)
> >         struct irq_desc *desc;
> >         int irq;
> >
> > +       /* The early resume stage is free of irq_desc release */
> >         for_each_irq_desc(irq, desc) {
> >                 unsigned long flags;
> >                 bool is_early = desc->action &&
> > --
> > 2.31.1
> >
