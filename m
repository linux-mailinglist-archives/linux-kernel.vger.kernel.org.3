Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023094B51A3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353863AbiBNN3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:29:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiBNN3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:29:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C8D4C794
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:28:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64FFC614DB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04F2C340F0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:28:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TT3Bfsae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644845330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qj6s+p5lGKYQmDCdeCuY81RJiXFpjaiEVYo5mJI+y18=;
        b=TT3BfsaeGZ3+YGGsKavtvt6HaMZGh1kiLBrAWLQgEteKLgMoMD3sQHZHfEKn5Abk+Ke8tI
        a2QB8hagWqowL+hffCKM+tWRKs+wyjdYM5rkkpcVHR8DeGwjmG8Lzhqar88r7kddBoQZO7
        lBtw4RFUwogRc8Nyz8w6XOC/kXHMonk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5a228082 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 14 Feb 2022 13:28:49 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id 124so17927990ybn.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:28:49 -0800 (PST)
X-Gm-Message-State: AOAM530pJHGAYfZYblyzDF5SunulMqu/SihPGww+IsoPTQnJb2oS7nFr
        CeoJUSbx5/BUELA+bySCtweIwjMFNxdNgfB6uxo=
X-Google-Smtp-Source: ABdhPJzyp7NeiZOi9gpMsR4fCMSMu7hwK2rkyZi0IyEhrANbIpGkkJXXDpwXLK3ogdEFa9HVoL4+itv/Th6IoB3zCgE=
X-Received: by 2002:a0d:f244:: with SMTP id b65mr13789321ywf.2.1644845327751;
 Mon, 14 Feb 2022 05:28:47 -0800 (PST)
MIME-Version: 1.0
References: <20220213215343.11652-1-Jason@zx2c4.com> <Ygo3/puhZFpuX91x@linutronix.de>
In-Reply-To: <Ygo3/puhZFpuX91x@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 14 Feb 2022 14:28:36 +0100
X-Gmail-Original-Message-ID: <CAHmME9rAnh6nSRNYo56Ty6VSrY17ej35AoNkSjunFO0AQp1D9Q@mail.gmail.com>
Message-ID: <CAHmME9rAnh6nSRNYo56Ty6VSrY17ej35AoNkSjunFO0AQp1D9Q@mail.gmail.com>
Subject: Re: [PATCH] random: set fast pool count to zero in cpuhp teardown
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Sebastian,

Thanks for your pointers.

I actually think that rollback is less of an issue than:

> - should a CPU already contribute entropy and schedule a worker then we
>   reset the FAST_POOL_MIX_INFLIGHT bit.

If a CPU is going down, and we zero out count, and then it rolls back,
I'm fine with it having to acquire 64 more interrupts. In contrast, if
a CPU comes back online, I'd rather not potentially throw out the
fresh entropy. So I think I will go with your suggestion of:

> - move it to CPUHP_OFFLINE =E2=80=A6 CPUHP_BRINGUP_CPU. This is invoked o=
n
>   another CPU once the is dead / before it comes up.
>   - in that case the function can remain as-is. But we have "rollback".

This seems like the best compromise. Also, executing in that phase
will let us do other things with that handler later (setting the crng
generation counter to ULONG_MAX), where it also would make sense.

I'll give this a shot and send you a v+1.

Jason
