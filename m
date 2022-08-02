Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E34587EF1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbiHBP02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbiHBP01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:26:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13C811459;
        Tue,  2 Aug 2022 08:26:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B8E6B81F3A;
        Tue,  2 Aug 2022 15:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E72FC433D7;
        Tue,  2 Aug 2022 15:26:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VbzFnC79"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659453980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tQJM6tWRe+AugrI/jdskPbUMgC3DfuzbF/kyIe4KAOE=;
        b=VbzFnC79NjP6+4DeDW8OpGIv7KJI6BXcr+TiGQFuRWyGYiVsuCGDG+OFRHJK8rGdljKNQM
        YlSMgx8hLBk67lYpYV0C8HlD1fEbGtcVTLiptH/b+jQzYpttzH88kWnV7+1Jl7pCcsRpgD
        1PFCpp8wzaUYl7V772o8V80cDELPQ0I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id eb937373 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 2 Aug 2022 15:26:19 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id p71so5815219yba.9;
        Tue, 02 Aug 2022 08:26:19 -0700 (PDT)
X-Gm-Message-State: ACgBeo2hx5EN8afAG3UL738WWhb3mP8aFhwg1kYFXVJD32nAV4x7O8vX
        hsWp9Dhvs6rh0zFnLS17+OfO01aMGbgVUCAb51k=
X-Google-Smtp-Source: AA6agR4drDLEGsxa2J+96KcQcEmrkBtHVh8Gc8ge+WUeNhMrH00xMqqo9UOWiS7Mz55CBD3MKpGWVpS+OlGf9DBX6NA=
X-Received: by 2002:a05:6902:100a:b0:676:ed53:25b0 with SMTP id
 w10-20020a056902100a00b00676ed5325b0mr10107374ybt.365.1659453977890; Tue, 02
 Aug 2022 08:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220729145525.1729066-1-Jason@zx2c4.com> <CAHk-=wiLwz=9h9LD1-_yb1+T+u59a2EjTmMvCiGj4A-ZsPN1wA@mail.gmail.com>
 <YuXCpyULk6jFgGV5@zx2c4.com> <87zggnsqwj.ffs@tglx> <Yuhe6IIFXqNMZs5b@zx2c4.com>
 <87bkt2sqq4.ffs@tglx> <YuktqQS7Rb0IbJNh@zx2c4.com> <878ro6smmm.ffs@tglx>
In-Reply-To: <878ro6smmm.ffs@tglx>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 2 Aug 2022 17:26:05 +0200
X-Gmail-Original-Message-ID: <CAHmME9pNN6Pc_1NaMDv+hqv_ULXiVUYFXM=Xigu_StvGS_-53A@mail.gmail.com>
Message-ID: <CAHmME9pNN6Pc_1NaMDv+hqv_ULXiVUYFXM=Xigu_StvGS_-53A@mail.gmail.com>
Subject: Re: [PATCH RFC v1] random: implement getrandom() in vDSO
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Aug 2, 2022 at 5:14 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> Seriously no.

Why so serious all at once? :-)

> All existing VDSO functions have exactly the same function
> signature and semantics as their syscall counterparts. So they are drop
> in equivalent.
>
> But:
>
>   ssize_t getrandom(void *, void *, size_t, unsigned int);
>
> is very much different than
>
>   ssize_t getrandom(void *, size_t, unsigned int);
>
> Different signature and different semantics.

Different signature, but basically the same semantics.

> So you have to go through the whole process of a new ABI whether you
> like it or not.

Ahh, in that sense. Yea, I'd rather not have to do that too, with the
additional opaque handle passed as the first argument. It'd be nice if
there were some private place where I could store the necessary state,
but I'm not really sure where that might be at the moment. If you have
any ideas, please let me know.

Jason
