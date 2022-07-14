Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0333B574C69
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbiGNLqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiGNLqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:46:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E428A5A44B;
        Thu, 14 Jul 2022 04:46:39 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657799198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XN6FukeOkgwZ5eOLCbkFNEc5JFvPVvJVxrDFWQ+otX8=;
        b=sMwnU3qbV+b8Wv2npTUlOowTXHkY1kWpGzJfAqV4YVCJxANkFKt2Si4xHbZdVHZmuQ8oNd
        0x/jdFnyZincBOLrzM1oqLSJBHgn1DYRWvk7MCje7WFxNFhMjYBOPe2JkfTfO4bFmPBP93
        H92QNpoVphfL8nB7nJSC06WTQrcnw51Xto2dctxivEN+iqpNKo9LyeD+O4Fwr/6fa9FGSP
        KOEMf+e1sWH0jpaQ1xDrvs7pvx/gL/1BTqEPlb7aXuoeQkxN9slCWb9gH+VAmqWfjpji0K
        ENKsk3azHFWeIvxULM6tLdAjLSDP0Rr8cMblLbJk5Hkn+h+qmYSb5EvKusB8aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657799198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XN6FukeOkgwZ5eOLCbkFNEc5JFvPVvJVxrDFWQ+otX8=;
        b=EAOmilPMjV1ZoGyEoz8L/+yBYppgRVe56A9R2WG/mK2JtxNdpcOdFw9/KgUqfs0QaPEN2A
        ZlsaAKbdwL/2b0Bw==
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        paulus@samba.org, Nicholas Piggin <npiggin@gmail.com>,
        ldufour@linux.ibm.com, pmladek@suse.com, Julia.Lawall@inria.fr,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH linux-next] powerpc: use raw_smp_processor_id in
 arch_touch_nmi_watchdog
In-Reply-To: <CAABZP2x-OiwX7-nRvdPz0NU1D5kgUoL4MQOgTqLK1KgLcrZ5DA@mail.gmail.com>
References: <20220714013131.12648-1-zhouzhouyi@gmail.com>
 <87tu7k6o7n.fsf@jogness.linutronix.de>
 <CAABZP2x-OiwX7-nRvdPz0NU1D5kgUoL4MQOgTqLK1KgLcrZ5DA@mail.gmail.com>
Date:   Thu, 14 Jul 2022 13:52:37 +0206
Message-ID: <87pmi77w82.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-14, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> Thank John for correcting me ;-)

After looking more closely, I do not think disabling migration is the
correct fix either.

The per-cpu variable @wd_timer_tb is written from 2 functions:

- watchdog_timer_interrupt() <-- irq handler
- arch_touch_nmi_watchdog()  <-- called from preemptible

Since watchdog_timer_interrupt() is called from irq context, I expect
that interrupts need to be disabled for the update in
arch_touch_nmi_watchdog(). Perhaps a using a per-cpu local_lock_t with
local_lock_irqsave() to protect write access to @wd_timer_tb?

John Ogness
