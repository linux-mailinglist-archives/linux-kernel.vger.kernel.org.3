Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC764B2BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352037AbiBKRU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:20:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbiBKRU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:20:56 -0500
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF70795;
        Fri, 11 Feb 2022 09:20:54 -0800 (PST)
Received: by mail-pf1-f175.google.com with SMTP id i30so17390892pfk.8;
        Fri, 11 Feb 2022 09:20:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ekIUW5hDwj0MHo/3bOZ5o2l8gislJv8Zv7n+lArEyNc=;
        b=Q7tVdQ9FuKQnIDcl28OTxfgthpF6H5rX7Q8sVLts7lhmugtacz7SLoidxg/e6ERTqV
         P9GP6DB44TMDGxO2sCtrN69NYPIhfHs/X55pUJ6a1F2fu6eT28T1gousRKCJjmGKCm4j
         +IN/PV77NjQ++c7tYjrS/KA52raOi8IUHhbXRWkCjiD9vDR52oGogy07r1shzHERmbv5
         yCCkn6O9uXq5Lz3GVKBXBuauTA0jo/sfU6LAwv99NvUrFjzFn1vkWdQdkNcsscQ8b39p
         f1h59XSlyb1j9bYyrZ6xBWoBXvrCTWdLOmufvKgB4LzCsLSmgPZy4jrlZP6nj6jjb0n2
         H1jQ==
X-Gm-Message-State: AOAM530joyrTiv2GZBsGQ6fG4oaTsQG/uLlHO3HXKR0XKaL8lv4og6p5
        Bz4T6Fvho2fdkcJVnCHxe7RFnNheF5A=
X-Google-Smtp-Source: ABdhPJzJjDohOvhP47JcBas1jDYfHanFwNj76TRXfNhwZQ/9c0i3NfbK2KSe/tIKGaDrfdGDvQkNQw==
X-Received: by 2002:a63:4b4a:: with SMTP id k10mr2171880pgl.488.1644600054301;
        Fri, 11 Feb 2022 09:20:54 -0800 (PST)
Received: from sultan-box.localdomain ([204.152.215.246])
        by smtp.gmail.com with ESMTPSA id t7sm27183808pfj.138.2022.02.11.09.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 09:20:53 -0800 (PST)
Date:   Fri, 11 Feb 2022 09:20:51 -0800
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v7] random: defer fast pool mixing to worker
Message-ID: <Ygaa89GFi1VAQmsk@sultan-box.localdomain>
References: <CAHmME9rC_q4LGq2JaAAeGbtRA2cibTe9bnvhMLng+QnzAy2DVg@mail.gmail.com>
 <20220211170732.571775-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220211170732.571775-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 06:07:32PM +0100, Jason A. Donenfeld wrote:
> On PREEMPT_RT, it's problematic to take spinlocks from hard irq
> handlers. We can fix this by deferring to a workqueue the dumping of
> the fast pool into the input pool.
> 
> We accomplish this with some careful rules on fast_pool->count:
> 
>   - When it's incremented to >= 64, we schedule the work.
>   - If the top bit is set, we never schedule the work, even if >= 64.
>   - The worker is responsible for setting it back to 0 when it's done.
> 
> There are two small issues around using workqueues for this purpose that
> we work around.
> 
> The first issue is that mix_interrupt_randomness() might be migrated to
> another CPU during CPU hotplug. This issue is rectified by checking that
> it hasn't been migrated (after disabling irqs). If it has been migrated,
> then we set the count to zero, so that when the CPU comes online again,
> it can requeue the work. As part of this, we switch to using an
> atomic_t, so that the increment in the irq handler doesn't wipe out the
> zeroing if the CPU comes back online while this worker is running.
> 
> The second issue is that, though relatively minor in effect, we probably
> want to make sure we get a consistent view of the pool onto the stack,
> in case it's interrupted by an irq while reading. To do this, we don't
> reenable irqs until after the copy. There are only 18 instructions
> between the cli and sti, so this is a pretty tiny window.
> 
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Sultan Alsawaf <sultan@kerneltoast.com>
> Cc: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Sebastian - as requested, we now disable irqs for a very short 18
> instructions rather than fishing into migrate_disable() and upsetting
> PeterZ. Might this be the lucky patch? -Jason

I think this might be the lucky patch.

Reviewed-by: Sultan Alsawaf <sultan@kerneltoast.com>

Sultan
