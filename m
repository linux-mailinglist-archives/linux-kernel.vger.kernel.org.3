Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9414B4EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347943AbiBNLdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:33:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352597AbiBNLbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:31:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D280C6516D;
        Mon, 14 Feb 2022 03:16:35 -0800 (PST)
Date:   Mon, 14 Feb 2022 12:16:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644837394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mGouKSJGIoDr3ZG9aOBrrLpVT+0XirfwXSklJD4/Fu0=;
        b=ucDpzAP8wWhsZkbVAW32g4NjJ3XxIrk28gOGl9Z92Qxd7xp+L2gJ/CGT0SoExSdsJa+i8V
        38anv/Ip2e8CO0o9vH/fmTybr+07iTSo+lrQyCemMR1bgB3HAlIa2uujK8WeDHrBorr+RF
        6QyhcqL4gHolpGrpcjbwxZhFAR9AiXh+z/61f8KWpewgKa/Nq8isFLuqesOK16xlZJOPui
        SI+pP1i6Lm4br7IM5fB830EaAUW6Ps/F4STArrl4nZSOHGFuOHFVS0RsA/8kvcN91kwnj4
        3pSMcpsUhJnKm8ryUjro8ESym4adLdBi7yVZWzPL7vhxEf7imLMvftBpPQUIXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644837394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mGouKSJGIoDr3ZG9aOBrrLpVT+0XirfwXSklJD4/Fu0=;
        b=z3XXlTp0Uq1z/SpwR/LLay3zWfXJd04XJi9ufCRb/w5oh0KDNXSBejRwWGYP0DFk6gLQ59
        Yq0KklMc55vcRMCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v6] random: defer fast pool mixing to worker
Message-ID: <Ygo6EX1YVgTrtjVT@linutronix.de>
References: <YgZ6IEbiDgz5X1ON@linutronix.de>
 <20220211162515.554867-1-Jason@zx2c4.com>
 <YgaSYlVEBOxfJbSD@linutronix.de>
 <CAHmME9rC_q4LGq2JaAAeGbtRA2cibTe9bnvhMLng+QnzAy2DVg@mail.gmail.com>
 <YgaV0UZO1KfmtLLh@linutronix.de>
 <CAHmME9rsOWuprpYqo9G9eUboQwUxRgWqYRYgyHG7cNOG16c5EA@mail.gmail.com>
 <YgoeBYJ5nwc8BTG3@linutronix.de>
 <CAHmME9otmV1QCX29D_DXsHB-41puTKurWtyZ39huPZtD4mt5ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9otmV1QCX29D_DXsHB-41puTKurWtyZ39huPZtD4mt5ng@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-14 11:17:20 [+0100], Jason A. Donenfeld wrote:
> On 2/14/22, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > to
> > | - Does anything anywhere call get_random_xx() before the worker has a
> > |   chance to run?
> >
> > Once you queue a work item I don't think that the scheduler needs to put
> > it on the CPU right away. It may have already have other tasks waiting
> > including some with a RT priority.
> > Also, the lock is irqsave() so they can be users in an interrupt
> > handler. I remember the original reason why I made it irqsave is because
> > something did kmalloc() and SLUB somehow asked for random bits.
> 
> Right. So there are two sides of the questions: 1) how bad is this
> actual race, and are there any drivers that do regularly get bit by
> this? 2) There's a largeish window between workqueue_init_early()
> setting up the system highprio workqueue, and workqueue_init()
> enabling queued workers to actually run. Interrupts also get enabled
> in the interim. Does anything get bit by that window?

This is only important during boot-up, right? Otherwise it just extracts
entropy from the pool.
I posted numbers earlier on where the work go scheduled and the three or
four interrupts came in before the work-item was scheduled. I could send
you the diff if you want to up it on some machines.
 
> Jason

Sebastian
