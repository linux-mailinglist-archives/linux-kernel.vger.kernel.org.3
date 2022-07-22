Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EFF57E4F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiGVRD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiGVRDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:03:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8CE13EA7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:03:54 -0700 (PDT)
Date:   Fri, 22 Jul 2022 19:03:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658509431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MoW3LDeqiTY0nuzhPANH/f/OIkFt4fdCcIJ/GQpSa9M=;
        b=zw9S3TD3czrnmWI+lDF95w9FqbVEhAdDla1KDruMU7Dnv9SjxNRbNatl4nK8q9Ak1aRaLB
        Qfe+yq1zykied5UPOJs0YS8DQi3czob6tVDGwIqtbs+pUOqWmbvcZmne3wIXtrMae/Qlph
        wk4RnxU2CUKLxhDoH8g+fA6DoPsHouYiiEROb4FCd/7ZItl8oJ1lZJP67Rg7TOLJr5psNC
        c37kuLktHVobLJu1ygo9iG8n7BaPb4Dna2fAyBjIexLyV0QWXzG5gCquudH27x8oc0dI12
        aMQkFcefttuP2w/lZT7EGGGFULUhWF2GYVV5yJbz7o2nCUZaNQawGd93aaTulw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658509431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MoW3LDeqiTY0nuzhPANH/f/OIkFt4fdCcIJ/GQpSa9M=;
        b=cw/jqKKjJy5mffwGbALFLcVO5YNnNFkBA+r+Ua+ABHvuzNiGjQ5oQSRTDCcznW4ABWvXt1
        VdSuT90C8ZxnKDCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] printk: Skip console drivers on PREEMPT_RT.
Message-ID: <YtrYdXWGb0NQLKNA@linutronix.de>
References: <YtgjtfjYVMQrzFTK@linutronix.de>
 <87y1wn3g3g.fsf@jogness.linutronix.de>
 <Ytgu17hATM8iqdGC@linutronix.de>
 <87ilnrn06u.fsf@jogness.linutronix.de>
 <Ytj3PisFjOfS9L0Y@linutronix.de>
 <YtqakGJAQzw/IPul@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YtqakGJAQzw/IPul@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-22 14:39:44 [+0200], Petr Mladek wrote:
> On Thu 2022-07-21 08:50:38, Sebastian Andrzej Siewior wrote:
> > printk might be invoked in a context with disabled interrupts and or
> > preemption and additionally disables interrupts before it invokes the
> > console drivers. This is behaviour is not compatible with PREEMPT_RT.
>=20
> Maybe I do not understand it correctly. It sounds like we could not
> disable interrupts when interrupts or preemption is already disabled.
> Like nested disablement of interrupts is bad.
>=20
> Is this a generic rule? Is is about the nesting?

You must not invoke the console drivers with disabled interrupts. This is
bad. So even if the context you were called from has interrupts enabled
then in console_emit_next_record() you have printk_safe_enter_irqsave()
before call_console_driver() which disables interrupts and this is bad.
More below=E2=80=A6

> Or is is somehow specific to the console drivers called from printk()
> directly? Do you always want to disable here because it might
> be an atomic context and they might take too long?

You can't acquire a sleeping lock with disabled interrupts and or
preemption. Therefore the console drivers must not be invoked because
they need to acquire a sleeping lock(s).

> I guess that the sentence "additionally disables interrupts before
> it invokes the console drivers" is not really important" and it confused =
me.

This refers to printk_safe_enter_irqsave(). You could argue that it is
safe to invoke the console drivers if the context, in which printk() is
invoked, is safe. However this is not possible because printk disables
interrupts prio invoking the console drivers as just explained.
Therefore I don't see a way how to invoke the console drivers on RT as
of v5.19-rc7.

>=20
> > Disable console printing until the return of atomic consoles and the
> > printing thread. This allows to retrieve the log buffer from user space
> > which is not possible by disable printk.
>=20
> I guess that this is for RT tree because the kthreads and the atomic
> consoles are still not in the mainline.

I would like to have this applied to the v5.20 upstream tree and then
revoked once the missing bits have been  merged. Based on what I see,
there shouldn't be any road blocks.

> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2843,6 +2843,16 @@ void console_unlock(void)
> >  	}
> > =20
> >  	/*
> > +	 * On PREEMPT_RT it is not possible to invoke console drivers with
> > +	 * disabled interrupts and or preemption. Therefore all drivers are
> > +	 * skipped and the output can be retrieved from the buffer.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > +		__console_unlock();
> > +		return;
> > +	}
>=20
> Do you want this even in panic() or early boot?

yes. I don't see a way to invoke the console drivers without the
print-kthread.

> AFAIK, only the serial console has atomic write() callback in the RT
> tree. Is this the only console used by RT kernel users in practice?

The atomic console is made for emergencies. Everything else should be
written using the printk thread.

>=20
> > +	/*
> >  	 * Console drivers are called with interrupts disabled, so
> >  	 * @console_may_schedule should be cleared before; however, we may
> >  	 * end up dumping a lot of lines, for example, if called from
>=20
> Best Regards,
> Petr

Sebastian
