Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552F74B0D98
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 13:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241546AbiBJMdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 07:33:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbiBJMdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:33:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D32A21BB;
        Thu, 10 Feb 2022 04:33:42 -0800 (PST)
Date:   Thu, 10 Feb 2022 13:33:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644496420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TxmbYaTryp+KlSSB5iDMTD3Bmc1tpuLh8fsDSqyGEx4=;
        b=oRGiCWX4/uWUoh3HHtJCnQ6kOsATOu93uH9Mudn7oi5/S1tu4G3bGL3kCpGp/+iPdYOCUG
        VJoOSE0r13M4DS3ERa34umQNeOeYY14sZTRgJCHlGxMSFmn0O/6Zd7PFDC7hJa6aO7aZaF
        fPwTne3eGenywlqht72sxWeEJsX/QxPDBu9svTfr72AwpS8LiD1Bn1X43C37/qv/KvJeE2
        Qsuhvhgs0xsGW7sr/o+lJH9XdwXdGgR3Lgy9oX7kY4z3klUzfuMsAc+HILNLw6oDbw1omq
        CpWJyn56PCc41Kj1OAaThNImIoHj1HF3Wz+Ly9QCjwdWG6Rcdir7X9jEKb2woA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644496421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TxmbYaTryp+KlSSB5iDMTD3Bmc1tpuLh8fsDSqyGEx4=;
        b=VOxiAlEUiI3YtqFLr6dIHVVav7shnvA8NSoP9z/vuiFbgiRafe1qH7vlnB4rTUlYCxxMcM
        Xhcn7N91mmCjOqDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH REPOST] irq_poll: Add local_bh_disable() in cpu_dead
 notifier
Message-ID: <YgUGI9qAKUh4AOUY@linutronix.de>
References: <YgJ/XWVxxWDVBBVA@linutronix.de>
 <YgNzsnIE9bwQZ1Zg@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YgNzsnIE9bwQZ1Zg@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-08 23:56:34 [-0800], Christoph Hellwig wrote:
> On Tue, Feb 08, 2022 at 03:34:05PM +0100, Sebastian Andrzej Siewior wrote:
> > __raise_softirq_irqoff() adds a bit to the pending sofirq mask and this
> > is it. The softirq won't be handled in a deterministic way but randomly
> > when an interrupt fires and handles the softirq in its irq_exit() routi=
ne or
> > if something randomly checks and handles pending softirqs in the call
> > chain before the CPU goes idle.
> >=20
> > Add a local_bh_disable/enable() around the IRQ-off section which will
> > handle pending softirqs.
>=20
> And I still haven't seen any good explanation of why this is useful.

You need to handle the pending softirqs. If you don't handle them
immediately or in a deterministic say (like on IRQ exit) then they will
be handled at a random point. If you don't handle them at all, the CPU
will go idle and at least the NO_HZ will complain about pending softirqs
(can_stop_idle_tick()).

You could still argue that the CPU will go down and the there are
latencies involved but=E2=80=A6
I want to avoid waking ksoftirqd for that since there is no need to wake
it and the pending work can be done in-context, right away.

Sebastian
