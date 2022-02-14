Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87804B4567
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242761AbiBNJRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:17:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242726AbiBNJRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:17:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0D1606DD;
        Mon, 14 Feb 2022 01:16:57 -0800 (PST)
Date:   Mon, 14 Feb 2022 10:16:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644830214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L3eaGmR/p10lNmvfPVXQTySENGIIG80ziw3LWG/fQX4=;
        b=OAdtLvBhRo2BefKiDpb8nAEA2nw1OY6OAueRIunVcfc4Bfd+j9uhT+Fz7VetFeZV/a4h/c
        YQmmpXVheGbodePbgAlyufltAUel5xcpKwg6mkfK69WDm5HXqcfLXlk5Gg6Lt6Dx9fBWDM
        8XgrRPL4D0spgToNjPLjSBjBHTJT3Oz0FWo4tdWnjiFa2t7PQQaAKnqOLBPEm816P3mNeg
        6nYxnw85KQ5SSS/eewQUhE7aph51tOH78yRTDLO0VlnJH9UmQWyFRSP8lZEcXbznbBbieN
        lMeGR1hzoscRqux19kjznAjZCK+R5YNrCtKgOm/s+IpuMgFNvg11EdH85Xqi7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644830214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L3eaGmR/p10lNmvfPVXQTySENGIIG80ziw3LWG/fQX4=;
        b=qCmVxrA2ydrllWOdk7Z9xnvT2LcUi6uCCZInfyxF+zXccowR0dWs2vWBvo1UOiGaCLaqcI
        5Hl5X+5nA3LcFmAg==
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
Message-ID: <YgoeBYJ5nwc8BTG3@linutronix.de>
References: <YgZ6IEbiDgz5X1ON@linutronix.de>
 <20220211162515.554867-1-Jason@zx2c4.com>
 <YgaSYlVEBOxfJbSD@linutronix.de>
 <CAHmME9rC_q4LGq2JaAAeGbtRA2cibTe9bnvhMLng+QnzAy2DVg@mail.gmail.com>
 <YgaV0UZO1KfmtLLh@linutronix.de>
 <CAHmME9rsOWuprpYqo9G9eUboQwUxRgWqYRYgyHG7cNOG16c5EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9rsOWuprpYqo9G9eUboQwUxRgWqYRYgyHG7cNOG16c5EA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-13 18:37:33 [+0100], Jason A. Donenfeld wrote:
> I started looking at this and came up with this draft with questions:
> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?h=jd/no-irq-trylocks

to
| - Does anything anywhere call get_random_xx() before the worker has a
|   chance to run?

Once you queue a work item I don't think that the scheduler needs to put
it on the CPU right away. It may have already have other tasks waiting
including some with a RT priority.
Also, the lock is irqsave() so they can be users in an interrupt
handler. I remember the original reason why I made it irqsave is because
something did kmalloc() and SLUB somehow asked for random bits.

> Some research remains...
> 
> Jason

Sebastian
