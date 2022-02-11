Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B854B2B2A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351869AbiBKRAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:00:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiBKRAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:00:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01CEBD6;
        Fri, 11 Feb 2022 09:00:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B153618F8;
        Fri, 11 Feb 2022 17:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEBBC340E9;
        Fri, 11 Feb 2022 17:00:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="h2SpPH1n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644598834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C9IVZkbdA8oN9E2Z4/YFEIlHEsl8hy8tO1E3qKdfEdg=;
        b=h2SpPH1nJSREKLO/2BP72RdjuKuixvCIpBAWy51gR2BuxR6CI1bry9aEb6XH58bT+l3tyX
        MHufFaSfI97iAlF6YAgnwzYI45L3sf0bvnNFJTOWOZKbDYOQdWCkDH2NhpVrhj07YLFvDj
        Cj3FRWEgJo8Cj1noNRUQFj00dON6sKI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9ef0b82b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 11 Feb 2022 17:00:34 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id v47so26710690ybi.4;
        Fri, 11 Feb 2022 09:00:33 -0800 (PST)
X-Gm-Message-State: AOAM530bX53FjK0ui+Yv/oc7lDRjGFe5nRULLj4VbdmlcM6dc0czyEe2
        PkExutpxmpq105iQeyoJfdOUON4gYkT7XEPLzdI=
X-Google-Smtp-Source: ABdhPJzRmZbwROoTGWk4Ik9cqBCwTOHkOSdZChh4VdhcxipEcaWO0yDyMIzQIrCRijtuPo76xBfeBIvrjhSqZV1Z1ZQ=
X-Received: by 2002:a25:ba49:: with SMTP id z9mr2268190ybj.32.1644598832549;
 Fri, 11 Feb 2022 09:00:32 -0800 (PST)
MIME-Version: 1.0
References: <YgZ6IEbiDgz5X1ON@linutronix.de> <20220211162515.554867-1-Jason@zx2c4.com>
 <YgaSYlVEBOxfJbSD@linutronix.de> <CAHmME9rC_q4LGq2JaAAeGbtRA2cibTe9bnvhMLng+QnzAy2DVg@mail.gmail.com>
 <YgaV0UZO1KfmtLLh@linutronix.de>
In-Reply-To: <YgaV0UZO1KfmtLLh@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 11 Feb 2022 18:00:21 +0100
X-Gmail-Original-Message-ID: <CAHmME9qR02XCX48D+AoT1rOFyNo_GXubyHPzoX01BYkJDX7p1A@mail.gmail.com>
Message-ID: <CAHmME9qR02XCX48D+AoT1rOFyNo_GXubyHPzoX01BYkJDX7p1A@mail.gmail.com>
Subject: Re: [PATCH v6] random: defer fast pool mixing to worker
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
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

On Fri, Feb 11, 2022 at 5:59 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> > Okay, I'll do that then, and then in the process get rid of the
> > cmpxchg loop since it's no longer required.
>
> So the only reason why we have that atomic_t is for rare case where run
> on the remote CPU and need to remove the upper bit in the counter?

Yes. That's the only remaining reason. Annoying, but whatareyagonnado?

Jason
