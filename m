Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B194B2B99
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352002AbiBKRSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:18:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347328AbiBKRSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:18:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756532E8;
        Fri, 11 Feb 2022 09:18:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 115BFB82B0C;
        Fri, 11 Feb 2022 17:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80120C340F0;
        Fri, 11 Feb 2022 17:18:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NyZ4HM6k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644599890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SfYGvN9zxLfDorcByl2QkN876mXdSCG/iqqiHsime+4=;
        b=NyZ4HM6kc0VT1Z0pePq62d2Fp1CRFOuxfcb8kdupm1OzZ1niCqmH2IowAsE7ZDU/I3Fhpl
        +r6eRqM0zvks+50T7YFBlgw9AIp4442AJelwhT9I43gVGllMDeJ2CHg4X2UrgVjqNBjq9l
        Tm+WDP2SBv6PY6a2a/uzA/sVG1ls1m8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 01119a3a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 11 Feb 2022 17:18:10 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id j2so27068802ybu.0;
        Fri, 11 Feb 2022 09:18:09 -0800 (PST)
X-Gm-Message-State: AOAM533qKG63XEnyA3F9y9uPyTxpUj+lZzqYC6N9zoAie4G2fHJmRKNS
        mS2IhhHMPF6h9rr+h6IDufWBrAY3b5fqFkXll84=
X-Google-Smtp-Source: ABdhPJyFny8fOHQkFCX9/JxzGdjmEUL+mbbdca++Pmet/pPykT+Mb94KinsOgGgHaOXiHrYeUGBypcfon47wKg71TmI=
X-Received: by 2002:a25:ba49:: with SMTP id z9mr2361602ybj.32.1644599888151;
 Fri, 11 Feb 2022 09:18:08 -0800 (PST)
MIME-Version: 1.0
References: <YgZ6IEbiDgz5X1ON@linutronix.de> <20220211162515.554867-1-Jason@zx2c4.com>
 <YgaSYlVEBOxfJbSD@linutronix.de> <CAHmME9rC_q4LGq2JaAAeGbtRA2cibTe9bnvhMLng+QnzAy2DVg@mail.gmail.com>
 <YgaV0UZO1KfmtLLh@linutronix.de> <CAHmME9qR02XCX48D+AoT1rOFyNo_GXubyHPzoX01BYkJDX7p1A@mail.gmail.com>
 <YgaZuShru2HQiFXg@linutronix.de>
In-Reply-To: <YgaZuShru2HQiFXg@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 11 Feb 2022 18:17:57 +0100
X-Gmail-Original-Message-ID: <CAHmME9oZMFN80M98Mt6JysPSMTJoXfKTjHuxG6BQSsC=+0z5fg@mail.gmail.com>
Message-ID: <CAHmME9oZMFN80M98Mt6JysPSMTJoXfKTjHuxG6BQSsC=+0z5fg@mail.gmail.com>
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

On Fri, Feb 11, 2022 at 6:15 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> A CPU hotplug notifier which removes unconditionally that bit when the
> CPU goes down or sets it to 0.
> We can keep it as it. Just an idea for later maybe ;)

I looked into it and it seemed like the plumbing was kind of miserable
for that. If you want to take a stab, though, that might be an okay
followup patch, and then we can assess atomics vs notifier. I think
notifier will wind up being a lot clunkier, though.

Sounds like we should be all set for the v7 I sent out?

Jason
