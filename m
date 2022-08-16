Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8C25961D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbiHPSDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbiHPSCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:02:33 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2078483BE9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:02:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id tl27so20390533ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=uXGdesIi7LyqHlMu2dT0RxDIuJI5AzNBe4VjC5+ytdY=;
        b=BGaXGJuiB7eGotBqcqWfwy8VgrYrFL9S/Bz2cQMnHb8DGajRYxwJbBwi51UswnEen4
         qeGfJgSl2eiS9ekAhwJadkZI/p8h6CBxAi08OQH7SCDmC5kp547O/7op0YNbaXEekIdO
         A36MXq6QBuMAzvlOfavBoL7t/c3fRWsSF+dBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uXGdesIi7LyqHlMu2dT0RxDIuJI5AzNBe4VjC5+ytdY=;
        b=qgrug8tISebJFboUEGy+sg09UzsKZou4aoobq7GO1iZdnCZLSxe2zlyuhBa10EUIfq
         nBF6tGq84yStqU28CjNi6LdJuTbgTRul2ANfYgDNdsmJjJWunisiMH58ybRax/Qyc2Co
         jYLdPwUrbFJeOYVdlal4/C6yB/PJf7bTvcXBGsev7mP+2nuequfqmTxf4bZmYz/K/9+r
         G3PqUpHbx9SCLXzhVjzWsvMu8bWLGcVMu0ujp45tDkVSFD/wmoc1Fr3BdlhPuRNLalhD
         PfzayfU26crksyC7j9wil/q/IvlaNDJcix3qKo+kPaN0YWDeC3keRcBQc4bES5OP2lWg
         z/Ow==
X-Gm-Message-State: ACgBeo0b9teG4FbnwUT4WuRrZWV8FxGQuRhSZHP1sljbLq8h2NiHUpk7
        wL7MGFEFkrXsZTzUHojkZuFYcZbcgCxbEQlV5cQ=
X-Google-Smtp-Source: AA6agR6VBnEoyRr8j0yhiI/d6msBIvPBIAJKiQZjcUMrN0voFOoMap3TF4IO0dxyzGS2xCBQmW+TOQ==
X-Received: by 2002:a17:907:72d1:b0:730:a0c4:2aaa with SMTP id du17-20020a17090772d100b00730a0c42aaamr13864027ejc.560.1660672950480;
        Tue, 16 Aug 2022 11:02:30 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id f25-20020a17090631d900b00730ad7c0d42sm5513249ejf.207.2022.08.16.11.02.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 11:02:29 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id bu15so5043816wrb.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:02:29 -0700 (PDT)
X-Received: by 2002:a05:6000:2a4:b0:225:162f:4cc7 with SMTP id
 l4-20020a05600002a400b00225162f4cc7mr2836760wry.274.1660672938800; Tue, 16
 Aug 2022 11:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220816070311.89186-1-marcan@marcan.st> <20220816140423.GC11202@willie-the-truck>
 <c545705f-ee7e-4442-ebfc-64a3baca2836@marcan.st> <20220816173654.GA11766@willie-the-truck>
 <CABdtJHt_3TKJVLhLiYMcBtvyA_DwaNapv1xHVeDdQH7cAC6YWw@mail.gmail.com>
In-Reply-To: <CABdtJHt_3TKJVLhLiYMcBtvyA_DwaNapv1xHVeDdQH7cAC6YWw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 Aug 2022 11:02:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3dCn5a4fZuJ7cewJoG9Vrm9xSOShiwgC6MA9=yJvXPg@mail.gmail.com>
Message-ID: <CAHk-=wh3dCn5a4fZuJ7cewJoG9Vrm9xSOShiwgC6MA9=yJvXPg@mail.gmail.com>
Subject: Re: [PATCH] locking/atomic: Make test_and_*_bit() ordered on failure
To:     Jon Nettleton <jon@solid-run.com>
Cc:     Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>,
        jirislaby@kernel.org, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Asahi Linux <asahi@lists.linux.dev>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 10:49 AM Jon Nettleton <jon@solid-run.com> wrote:
>
> It is moot if Linus has already taken the patch, but with a stock
> kernel config I am
> still seeing a slight performance dip but only ~1-2% in the specific
> tests I was running.

It would be interesting to hear if you can pinpoint in the profiles
where the time is spent.

It might be some random place that really doesn't care about ordering
at all, and then we could easily rewrite _that_ particular case to do
the unordered test explicitly, ie something like

-        if (test_and_set_bit()) ...
+       if (test_bit() || test_and_set_bit()) ...

or even introduce an explicitly unordered "test_and_set_bit_relaxed()" thing.

                 Linus
