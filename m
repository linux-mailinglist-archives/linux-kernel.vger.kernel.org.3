Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779834D1C3A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347967AbiCHPrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347891AbiCHPrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:47:02 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A374EF6F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:46:05 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u1so29180065wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 07:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LK9uf9V8m3oUibOnNP7wgnje39NrA7Q39n1xrUjRn4w=;
        b=Ie+UyZFVWo5ezaet+8lp260zEbCp6993EFkmk1mHPI9jhs8nlRncCPwQCSETo00K0H
         pR3SzTiNfIkATsEYxTt9yo5CKqDsYAVwOsD8QnHQgTiW5fVT1llyZdkVx1VRS9fAoVFG
         8+iw72UO6+fq2WVAnl9tmvCXwq90akGOAA/85Ykl4vACoans4WkGLlEWgjuv3CLEVacK
         rGXAvbkrOa1zVd73Wl4HDFtyacx5e2YlmCbtaFEzyCIA18hUSn9CXBmCUh19KDQMpgo8
         ebQOiOdN9fksKEhhLR8zhFMGq+kOb0acyH1Eup5qkPf32k1V69yKsvA2POdpsXF1G+wI
         k5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LK9uf9V8m3oUibOnNP7wgnje39NrA7Q39n1xrUjRn4w=;
        b=DgDgTuDCRgNd426uECwdHSBpZWpYmyS1oUlfTNyOzXyD3Nou0cYiiwUx6TubyNQ2+p
         c8fGjExFXcbrFVMSuip/tNrPjp80Y10ku+zXU5fOqyxTXzyCXWK4R6g6ESdjhOmi2IzA
         qShmRHoCvX8OMEOLqlLax6ssWzFC1mqi2Xwrrv0kPKypHnrh/sunLXEApLZGb0dONH8n
         +3IOUzKQ6NEVeNF8K4WuA5dckmxlxfevPvJfnRRgtIN/vNH0h9NZzU62H3DEj7HXzYST
         iAsV+KY+KBQZCKZIs/e3s0k+Mzyh1VW149u3JcF/m4KVouaL/Yy2G5cOxDqa5uyNzD/n
         seEQ==
X-Gm-Message-State: AOAM53192bChC+5eIUqDGsUNJcp6AW5Hklm32achomDSCJ3MqOCNx1Qj
        ztheJzWAI+dw/s9a3hMJIpDPsA==
X-Google-Smtp-Source: ABdhPJwTJKvEz01X94pGA38KQdbjDZPWxtj4C1+0HF/sD9kUnvvEoIEZhWxTc2QmjdZunG1Rm2MuTw==
X-Received: by 2002:adf:fb47:0:b0:1ed:9f2c:492e with SMTP id c7-20020adffb47000000b001ed9f2c492emr12858210wrs.196.1646754363872;
        Tue, 08 Mar 2022 07:46:03 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c4f8400b00380e45cd564sm2817117wmq.8.2022.03.08.07.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 07:46:03 -0800 (PST)
Date:   Tue, 8 Mar 2022 15:46:01 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-serial@vger.kernel.org, hasegawa-hitomi@fujitsu.com,
        dianders@chromium.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, jason.wessel@windriver.com,
        linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        arnd@arndb.de, peterz@infradead.org
Subject: Re: [RFT v4] tty/sysrq: Make sysrq handler NMI aware
Message-ID: <20220308154601.2f2v4aqsny3ta52a@maple.lan>
References: <20220307110328.2557655-1-sumit.garg@linaro.org>
 <20220307142356.ksx7k5xalqlsxnqk@maple.lan>
 <CAFA6WYNdc5fTk61GB2siLj-EkTtRE0u6fq-MtqF3Zt1uwJqJCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYNdc5fTk61GB2siLj-EkTtRE0u6fq-MtqF3Zt1uwJqJCw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 08:13:43PM +0530, Sumit Garg wrote:
> Hi Daniel,
> 
> On Mon, 7 Mar 2022 at 19:53, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> >
> > On Mon, Mar 07, 2022 at 04:33:28PM +0530, Sumit Garg wrote:
> > > Allow a magic sysrq to be triggered from an NMI context. This is done
> > > via marking some sysrq actions as NMI safe. Safe actions will be allowed
> > > to run from NMI context whilst that cannot run from an NMI will be queued
> > > as irq_work for later processing.
> > >
> > > <snip>
> > >
> > > @@ -566,12 +573,46 @@ static void __sysrq_put_key_op(int key, const struct sysrq_key_op *op_p)
> > >               sysrq_key_table[i] = op_p;
> > >  }
> > >
> > > +static atomic_t sysrq_key = ATOMIC_INIT(-1);
> > > +
> > > +static void sysrq_do_irq_work(struct irq_work *work)
> > > +{
> > > +     const struct sysrq_key_op *op_p;
> > > +     int orig_suppress_printk;
> > > +     int key = atomic_read(&sysrq_key);
> > > +
> > > +     orig_suppress_printk = suppress_printk;
> > > +     suppress_printk = 0;
> > > +
> > > +     rcu_sysrq_start();
> > > +     rcu_read_lock();
> > > +
> > > +     op_p = __sysrq_get_key_op(key);
> > > +     if (op_p)
> > > +             op_p->handler(key);
> > > +
> > > +     rcu_read_unlock();
> > > +     rcu_sysrq_end();
> > > +
> > > +     suppress_printk = orig_suppress_printk;
> > > +     atomic_set(&sysrq_key, -1);
> > > +}
> > > +
> > > +static DEFINE_IRQ_WORK(sysrq_irq_work, sysrq_do_irq_work);
> > > +
> > >  void __handle_sysrq(int key, bool check_mask)
> > >  {
> > >       const struct sysrq_key_op *op_p;
> > >       int orig_log_level;
> > >       int orig_suppress_printk;
> > >       int i;
> > > +     bool irq_work = false;
> > > +
> > > +     /* Skip sysrq handling if one already in progress */
> > > +     if (atomic_cmpxchg(&sysrq_key, -1, key) != -1) {
> > > +             pr_warn("Skip sysrq key: %i as one already in progress\n", key);
> > > +             return;
> > > +     }
> >
> > Doesn't this logic needlessly jam sysrq handling if the irq_work cannot
> > be undertaken?
> >
> 
> Here this is done purposefully to ensure synchronisation of three
> contexts while handling sysrq:
> 1. Thread context
> 2. IRQ context
> 3. NMI context

Why is it necessary to provide such synchronization?

Also, if there really is an existing bug in the way thread and irq
contexts interact (e.g. something we can tickle without NMI being
involved) then that should probably be tackled in a separate patch
and with an explanation of the synchronization problem.


> > A console user could unwittingly attempt an !nmi_safe SysRq action on
> > a damaged system that cannot service interrupts. Logic that prevents
> > things like backtrace, ftrace dump, kgdb or reboot is actively harmful
> > to that user's capability to figure out why their original sysrq doesn't
> > work.
> 
> I see your point.
> 
> >
> > I think the logic to prohibht multiple deferred sysrqs should only
> > be present on code paths where we are actually going to defer the sysrq.
> >
> 
> It's not only there to prohibit multiple deferred sysrq (as that alone
> could be handled by irq_work_queue()) but rather to avoid parallelism
> scenarios that Doug mentioned on prior versions.

I'm afraid I'm still a little lost here. I've only done a quick review
but sysrq's entry/exit protocols look like they are intended to handle
stacked contexts. This shouldn't be all that suprising since, even
without your changes, a sysrq triggered by an irq will interrupt
a sysrq triggered using /proc/sysrq-trigger .


> How about the following add-on change to allow passthrough for broken
> irq_work systems?

My question ultimately boils down to whether the existing logic
is necessary, not whether we can make it even more complex!

So before thinking too much about this change I think it would be
useful to have a clear example of the circumstances that you think
it will not be safe to run an NMI-safe sysrq from an NMI.


Daniel.


> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 005c9f9e0004..0a91d3ccf862 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -608,6 +608,15 @@ void __handle_sysrq(int key, bool check_mask)
>         int i;
>         bool irq_work = false;
> 
> +       /*
> +        * Handle a case if irq_work cannot be undertaken on a damaged
> +        * system stuck in hard lockup and cannot service interrupts.
> +        * In such cases we shouldn't atleast block NMI safe handlers
> +        * that doesn't depend on irq_work.
> +        */
> +       if (irq_work_is_pending(&sysrq_irq_work))
> +               atomic_set(&sysrq_key, -1);
> +
>         /* Skip sysrq handling if one already in progress */
>         if (atomic_cmpxchg(&sysrq_key, -1, key) != -1) {
>                 pr_warn("Skip sysrq key: %i as one already in progress\n", key);
> 
> -Sumit
> 
> >
> > Daniel.
