Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9D04D2A7C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiCIIUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiCIIU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:20:29 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FA54705C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 00:19:30 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so4531119pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 00:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCM0UJU71vFmyCpvtGIqyRExM308THX8NeEE98HuLyw=;
        b=gwfkCt1GAlSaodP0da2aU5ijkHHXhqGoGlbjYk663NKD1SrXZapaIevPk4V/BUsure
         XiII23Bedvc2rrKNeyYHYgjzXv3KsoB/+4Ds30KpSr3Hr7y6/5lPopHFM4TlRI6kWXre
         Gw6nP8e1NrtRAvosc5MyiQqEphN740qAPvBYzGespEErPvbb8F4EihlrxY7PhQYVE09t
         WaoUfdZaOOMahJ4Qo03Y9jny8wu9pCQgUcmYnHbi5Zw/GeYRaMhj7D/cpJWfQf8j7eHj
         0sgV14InB6YZRPViUaBp6GXwi8BQZFWV84uGIwCxj5o9JwyIxCgGdEeVcECDAUVLL4eB
         imbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCM0UJU71vFmyCpvtGIqyRExM308THX8NeEE98HuLyw=;
        b=lvae2uwSgMy4EGKLzR9DDMVs7oIQWXSOlwrmT1nJBAgAi58Kmg0tfYzvBqm7c+McrN
         aXAVNSXMjNsf/ACbeI1gtUI81WLVIKhQydKFWbCdf0ke2DOUO2KGAJZ4/Ouw/q67nL/L
         gQ6CQux7oehML8Q5oJSw96QRHJ8mxEvRSiKne8wv0BG370eM20kcl8Lv8zk85XVqmthk
         Axg4m17qTjEr9+uxYyNYpUJeOKXXSo8jA8WbLrAKxaydMVmuGWXoplnOfH92zwUl1IDQ
         /DaVac3nGjsJEIDKVqXguE69OwjaDICE+CwJxmu/jfmY4RvA3vrvWutDOUs6Qnykl1dg
         DBEA==
X-Gm-Message-State: AOAM532qWPR9FUpFVnu8DcgnX8IdXhqkmQH33NSl6B7kja9oLS4X8vPJ
        09FYJaoo+Ir6p2m4VaURol7qyHztB7hN5YnzKYyugxZabFFUUw==
X-Google-Smtp-Source: ABdhPJz045akFz//p5zwqF9zhV51bLG2qLT/+7QeGLl2UBCq6zdhnpxyjgYFb71IUkYVcraRmuyxI8DKbl+UEJaKq6w=
X-Received: by 2002:a17:90b:1c03:b0:1bf:5720:f8a1 with SMTP id
 oc3-20020a17090b1c0300b001bf5720f8a1mr9120979pjb.100.1646813969912; Wed, 09
 Mar 2022 00:19:29 -0800 (PST)
MIME-Version: 1.0
References: <20220307110328.2557655-1-sumit.garg@linaro.org>
 <20220307142356.ksx7k5xalqlsxnqk@maple.lan> <CAFA6WYNdc5fTk61GB2siLj-EkTtRE0u6fq-MtqF3Zt1uwJqJCw@mail.gmail.com>
 <20220308154601.2f2v4aqsny3ta52a@maple.lan>
In-Reply-To: <20220308154601.2f2v4aqsny3ta52a@maple.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 9 Mar 2022 13:49:18 +0530
Message-ID: <CAFA6WYO7j7U89GgCH3ffZgFzGLES_ZqOO8Q6B_dbewZ0dCF+_w@mail.gmail.com>
Subject: Re: [RFT v4] tty/sysrq: Make sysrq handler NMI aware
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, hasegawa-hitomi@fujitsu.com,
        dianders@chromium.org, jirislaby@kernel.org,
        jason.wessel@windriver.com, linux-kernel@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, arnd@arndb.de,
        peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2022 at 21:16, Daniel Thompson <daniel.thompson@linaro.org> wrote:
>
> On Tue, Mar 08, 2022 at 08:13:43PM +0530, Sumit Garg wrote:
> > Hi Daniel,
> >
> > On Mon, 7 Mar 2022 at 19:53, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> > >
> > > On Mon, Mar 07, 2022 at 04:33:28PM +0530, Sumit Garg wrote:
> > > > Allow a magic sysrq to be triggered from an NMI context. This is done
> > > > via marking some sysrq actions as NMI safe. Safe actions will be allowed
> > > > to run from NMI context whilst that cannot run from an NMI will be queued
> > > > as irq_work for later processing.
> > > >
> > > > <snip>
> > > >
> > > > @@ -566,12 +573,46 @@ static void __sysrq_put_key_op(int key, const struct sysrq_key_op *op_p)
> > > >               sysrq_key_table[i] = op_p;
> > > >  }
> > > >
> > > > +static atomic_t sysrq_key = ATOMIC_INIT(-1);
> > > > +
> > > > +static void sysrq_do_irq_work(struct irq_work *work)
> > > > +{
> > > > +     const struct sysrq_key_op *op_p;
> > > > +     int orig_suppress_printk;
> > > > +     int key = atomic_read(&sysrq_key);
> > > > +
> > > > +     orig_suppress_printk = suppress_printk;
> > > > +     suppress_printk = 0;
> > > > +
> > > > +     rcu_sysrq_start();
> > > > +     rcu_read_lock();
> > > > +
> > > > +     op_p = __sysrq_get_key_op(key);
> > > > +     if (op_p)
> > > > +             op_p->handler(key);
> > > > +
> > > > +     rcu_read_unlock();
> > > > +     rcu_sysrq_end();
> > > > +
> > > > +     suppress_printk = orig_suppress_printk;
> > > > +     atomic_set(&sysrq_key, -1);
> > > > +}
> > > > +
> > > > +static DEFINE_IRQ_WORK(sysrq_irq_work, sysrq_do_irq_work);
> > > > +
> > > >  void __handle_sysrq(int key, bool check_mask)
> > > >  {
> > > >       const struct sysrq_key_op *op_p;
> > > >       int orig_log_level;
> > > >       int orig_suppress_printk;
> > > >       int i;
> > > > +     bool irq_work = false;
> > > > +
> > > > +     /* Skip sysrq handling if one already in progress */
> > > > +     if (atomic_cmpxchg(&sysrq_key, -1, key) != -1) {
> > > > +             pr_warn("Skip sysrq key: %i as one already in progress\n", key);
> > > > +             return;
> > > > +     }
> > >
> > > Doesn't this logic needlessly jam sysrq handling if the irq_work cannot
> > > be undertaken?
> > >
> >
> > Here this is done purposefully to ensure synchronisation of three
> > contexts while handling sysrq:
> > 1. Thread context
> > 2. IRQ context
> > 3. NMI context
>
> Why is it necessary to provide such synchronization?
>
> Also, if there really is an existing bug in the way thread and irq
> contexts interact (e.g. something we can tickle without NMI being
> involved) then that should probably be tackled in a separate patch
> and with an explanation of the synchronization problem.
>
>
> > > A console user could unwittingly attempt an !nmi_safe SysRq action on
> > > a damaged system that cannot service interrupts. Logic that prevents
> > > things like backtrace, ftrace dump, kgdb or reboot is actively harmful
> > > to that user's capability to figure out why their original sysrq doesn't
> > > work.
> >
> > I see your point.
> >
> > >
> > > I think the logic to prohibht multiple deferred sysrqs should only
> > > be present on code paths where we are actually going to defer the sysrq.
> > >
> >
> > It's not only there to prohibit multiple deferred sysrq (as that alone
> > could be handled by irq_work_queue()) but rather to avoid parallelism
> > scenarios that Doug mentioned on prior versions.
>
> I'm afraid I'm still a little lost here. I've only done a quick review
> but sysrq's entry/exit protocols look like they are intended to handle
> stacked contexts. This shouldn't be all that suprising since, even
> without your changes, a sysrq triggered by an irq will interrupt
> a sysrq triggered using /proc/sysrq-trigger .
>

Yeah you are right. I see problems with how globals like
"suppress_printk" and "console_loglevel" are modified and restored
within __handle_sysrq(). A concurrent sysrq may easily lead to
incorrect value restoration as an example below:

Thread 1
                      Thread 2
orig_suppress_printk = suppress_printk; # here value is 1
suppress_printk = 0;

                            orig_suppress_printk = suppress_printk; #
here value is 0
suppress_printk = orig_suppress_printk; # here value is 1

                            suppress_printk = 0;

                            suppress_printk = orig_suppress_printk;
#incorrect value restored as 0

Greg,

Do let me know if I am missing something otherwise I will create a
separate patch for this issue.

-Sumit

>
> > How about the following add-on change to allow passthrough for broken
> > irq_work systems?
>
> My question ultimately boils down to whether the existing logic
> is necessary, not whether we can make it even more complex!
>
> So before thinking too much about this change I think it would be
> useful to have a clear example of the circumstances that you think
> it will not be safe to run an NMI-safe sysrq from an NMI.
>
>
> Daniel.
>
>
> > diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> > index 005c9f9e0004..0a91d3ccf862 100644
> > --- a/drivers/tty/sysrq.c
> > +++ b/drivers/tty/sysrq.c
> > @@ -608,6 +608,15 @@ void __handle_sysrq(int key, bool check_mask)
> >         int i;
> >         bool irq_work = false;
> >
> > +       /*
> > +        * Handle a case if irq_work cannot be undertaken on a damaged
> > +        * system stuck in hard lockup and cannot service interrupts.
> > +        * In such cases we shouldn't atleast block NMI safe handlers
> > +        * that doesn't depend on irq_work.
> > +        */
> > +       if (irq_work_is_pending(&sysrq_irq_work))
> > +               atomic_set(&sysrq_key, -1);
> > +
> >         /* Skip sysrq handling if one already in progress */
> >         if (atomic_cmpxchg(&sysrq_key, -1, key) != -1) {
> >                 pr_warn("Skip sysrq key: %i as one already in progress\n", key);
> >
> > -Sumit
> >
> > >
> > > Daniel.
