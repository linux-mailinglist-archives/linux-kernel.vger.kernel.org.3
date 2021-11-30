Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F47E4640D2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbhK3WAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhK3WAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:00:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C32C061574;
        Tue, 30 Nov 2021 13:57:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD150B81D35;
        Tue, 30 Nov 2021 21:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BCBC53FCC;
        Tue, 30 Nov 2021 21:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638309431;
        bh=kUUQXubL4SraGE4IjF0ilacjwCfmZF9yFAI38NtvZbo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GDjCD1WVlw4mzytOHo5U2hOk9KUhveswvx2prh0JshYqr6baLtxg5w6XDiYjSmtLW
         ymslIwK6wsLG63vxDvEqn7IJN0FdgYsXI8b94QoCMHqILWXonh+QenENeoHDbPQFGV
         kRqkEEepoKf1Ehefs8skdlJ9FzMccfPdBlSJHSItw8UjLN1aEuGmMFUxnegMwKyvFE
         jy4NmfcsskCm4Bm3YQxp2Lb063vJUPrkalqjdbN3KJFHQS3FwFE94/apTkJJS0xVfM
         xIy+HV+1//QXs86NThip6K7N2uNNwxDnh3Ed0eYEXSzDU8RzE5Efk4LIhi2LSQpQkm
         3dP+dpdu9hokg==
Received: by mail-ed1-f51.google.com with SMTP id v1so92713660edx.2;
        Tue, 30 Nov 2021 13:57:11 -0800 (PST)
X-Gm-Message-State: AOAM530xQTur0nDBOw/bOf4AxxkPEBkRWudkIWCYohmKV9/cD/4V8Ey8
        7FnzrQKyIJbDI3qFi0QEQIIcwW0FXmsqADSwkw==
X-Google-Smtp-Source: ABdhPJy67ASe7BHIiZBS6nwrHr+brgKBXklp9nqQR+8Kf7spUabgBasdxj96SHCwNwEpF3O2Eu8GrhD2c+BUUvd18CE=
X-Received: by 2002:aa7:cc82:: with SMTP id p2mr2380619edt.201.1638309427941;
 Tue, 30 Nov 2021 13:57:07 -0800 (PST)
MIME-Version: 1.0
References: <20211027201641.2076427-1-robh@kernel.org> <CAL_JsqLQWYNHRyNNNeP5VvWJXxp1mmeMvz1DA3ZdyyqZkKzG3A@mail.gmail.com>
In-Reply-To: <CAL_JsqLQWYNHRyNNNeP5VvWJXxp1mmeMvz1DA3ZdyyqZkKzG3A@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 30 Nov 2021 15:56:56 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLxqv=MpzWJyht-YNjpxC6JSdfOhijXhB6j8Z2CWeotjQ@mail.gmail.com>
Message-ID: <CAL_JsqLxqv=MpzWJyht-YNjpxC6JSdfOhijXhB6j8Z2CWeotjQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] Another version of arm64 userspace counter access support.
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:57 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Oct 27, 2021 at 3:16 PM Rob Herring <robh@kernel.org> wrote:
> >
> > The arm64 support departs from the x86 implementation by requiring the user
> > to explicitly request user access (via attr.config1) and only enables access
> > for task bound events. Since usage is explicitly requested, access is
> > enabled at perf_event_open() rather than on mmap() as that greatly
> > simplifies the implementation. Rather than trying to lock down the access
> > as the x86 implementation has been doing, we can start with only a limited
> > use case enabled and later expand it if needed.
> >
> > I've run this version thru Vince's perf tests[14] with arm64 support added.
> > I wish I'd found these tests sooner...
> >
> > This originally resurrected Raphael's series[1] to enable userspace counter
> > access on arm64. My previous versions are here
> > [2][3][4][5][6][7][8][9][10][11][12].
> > A git branch is here[13].
> >
> > Changes in v12:
> >  - Zero PMSELR_EL0 when userspace access is enabled
> >  - Return -EOPNOTSUPP for if h/w doesn't support 64-bit counters
>
> Will, the series rebases cleanly on v5.16-rc1. Please let me know if
> you want me to resend.
>
> Peter, Will is waiting on an ack on the core/x86 bits from you.

Ping!
