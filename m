Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB3B4BA786
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243925AbiBQRx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:53:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243922AbiBQRx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:53:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C7E2B1033;
        Thu, 17 Feb 2022 09:53:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DD66B8219B;
        Thu, 17 Feb 2022 17:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8512AC340EB;
        Thu, 17 Feb 2022 17:53:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="d95IjEti"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645120415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ltIhEjP8MkERFRDCje13DRgSd1zx0v44Y95lOeSSlxs=;
        b=d95IjEti/GmZaCb2ieIwox7inQMDHNChvL4VyRCRbuL9b//+a94/oVY+f5T2r5xqbT1/JM
        cO7FOhhi4lJkImbH8hE/sWGWcq4ibkwZ4lV5PfJxlQUSUgX3leVXlQX4fQ5pKimQTxDfAL
        bLwExwPr63m12JByDLrgxOtRALI3PEA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8728cd42 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 17 Feb 2022 17:53:35 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2d62593ad9bso40490317b3.8;
        Thu, 17 Feb 2022 09:53:34 -0800 (PST)
X-Gm-Message-State: AOAM531vU+p+J3otGZpOAart+ef+VlKZnwTGJtEFRII7WJdV2ML0zIM7
        ORpc8N5A4YqRrSwopsB3RtfqmtVFc8xiGH6tbsc=
X-Google-Smtp-Source: ABdhPJyDY+aB0zc1eZeuWdQvZFuCUuOBNuWI3d+Np8EtdMjkN5bR41noa0Xtt6HCtBIB8szQmJ9EdrcgxgRSVUbZ/nQ=
X-Received: by 2002:a81:e203:0:b0:2d0:194d:81fd with SMTP id
 p3-20020a81e203000000b002d0194d81fdmr3814901ywl.396.1645120413430; Thu, 17
 Feb 2022 09:53:33 -0800 (PST)
MIME-Version: 1.0
References: <20220217122729.227908-1-Jason@zx2c4.com> <Yg6JhauWYkazt1kJ@linutronix.de>
In-Reply-To: <Yg6JhauWYkazt1kJ@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 17 Feb 2022 18:53:22 +0100
X-Gmail-Original-Message-ID: <CAHmME9prO9dop7iBRwN54=GMtLH7amS3m_VqGUzL44G1h=R+2A@mail.gmail.com>
Message-ID: <CAHmME9prO9dop7iBRwN54=GMtLH7amS3m_VqGUzL44G1h=R+2A@mail.gmail.com>
Subject: Re: [PATCH v5] random: clear fast pool, crng, and batches in cpuhp
 bring up
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

Thank you for finding the time to review this v5.

On Thu, Feb 17, 2022 at 6:44 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> So I think this is the latest, right?

Yes.

> What do you think about this small comment update? :)

I can improve the comments for v6 of this patch, yes. I won't use your
text exactly, as there are other errors in it, but I'll synthesize its
meaning.

> > +#ifdef CONFIG_SMP
> > +/*
> > + * This function is called by the cpuhp system, wired up via the large
> > + * static array in kernel/cpu.c, with the entry CPUHP_RANDOM_PREPARE.
> > + */
> > +int random_prepare_cpu(unsigned int cpu)
> > +{
> > +     /*
> > +      * When the cpu comes back online, immediately invalidate both
> > +      * the per-cpu crng and all batches, so that we serve fresh
> > +      * randomness.
> > +      */
> > +     per_cpu_ptr(&crngs, cpu)->generation = ULONG_MAX;
> > +     per_cpu_ptr(&batched_entropy_u32, cpu)->position = UINT_MAX;
> > +     per_cpu_ptr(&batched_entropy_u64, cpu)->position = UINT_MAX;
>
> This runs before the CPU is up. Could you do the initialisation right
> now?

That wouldn't accomplish anything. See below.

> My problem here is that if this (get_random_u32()) is used between
> CPUHP_AP_IDLE_DEAD and CPUHP_TEARDOWN_CPU then the initialisation will
> happen on the target CPU with disabled interrupts. And will acquire a
> sleeping lock (batched_entropy_u32.lock).

That is not a legitimate problem to be addressed in any way at all by
this patchset. The batches may well be already depleted and the crng
already old, and therefore the "problem" you note is the same both
before and after this patch. If you want to address that, send a
separate patch for it.

> You could perform the initialization cross CPU without the lock because
> the CPU itself isn't ready yet. Something like
>          batch = per_cpu_ptr(&batched_entropy_u32, cpu);
>          _get_random_bytes(batch->entropy_u32, sizeof(batch->entropy_u32));
>          batch->position = 0;
>          batch->generation = next_gen;

I guess, but it wouldn't solve anything. The entire batch could be
filled and then subsequently emptied out before irqs are up, and your
problem will just repeat itself. I'm not going to make any changes
related to that in this patch.

If you find out that there are actual users of get_random_{...} during
that window, and think that this represents a real problem, please
send a patch and we can discuss that then.

I'll send a v6 with comments fixed to your liking. I hope that you can ack it.

Jason
