Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA15949FCD1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349540AbiA1P3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbiA1P3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:29:45 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB02C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 07:29:45 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ah7so17184167ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 07:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gxZkJu6FJ69bUcRomzpMRNHdLaWf54dm0ETw8AtKvx8=;
        b=So6o0O3EKbkumlI5+MgQMzwWKJ5FpvRMc9FuQT5kamJ66YIjlvVFqwjQBD70urH8XB
         LtMEIWUNv1IX4UE0D/pCJMqKpsuB2hAkbCm+9MZ7OvotY9rp9gAZF0d4Xb67aKS4M2X4
         iOEkaNTwbTXj0v5LBFtCz0CI75kIFtLZW8U1fFqfsFHjJUQucI5ooyDtezYGmKXRyTmW
         XLqPoDoSmkFrKlTW86wAHvOHQQucs60uY017cniOy/mBPZPtq9ovWzU2oHYq7KguK4Cu
         7abpQOQrqrddnlSaxIpe1kkE4TKVxndmZ4C30rB5oxBhfYFhEuC3HU+y/RrQjUETo5Un
         GboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gxZkJu6FJ69bUcRomzpMRNHdLaWf54dm0ETw8AtKvx8=;
        b=a14d/lmlvwl8UHhhWQb8UaMZkDSp70Fkx554FArWzurYqv1GEZvjLfVTXfnVeg/O2J
         dJ5xRYzgmYaopgUrTrpwebsYqdA5LbPt9h7NWDBEAhYqi7XC+3fsiRMg2b1Ra+JnEyEs
         5NNSTT84beYwTw6wAdmU0znLj220Aebp4pkcJ3npv4AsKbLMz1heaXjarZzFrT+S5wHI
         N1vSlHgy4xf2YmuSBuxhohPDP2+dq48BQP+dxGo2Imxzkg9ExhQ8MX8Cx42wuNJ0Qyjj
         LHk+415nH9isuLT4aA2MhRqfGN0HOhkPbfGJ/Ob36qpFXws8dbbaU8BW6EHXkh+MJgWw
         9Z4A==
X-Gm-Message-State: AOAM533lW5XArRt9BALrHI07eiJPHh1UgGRL7dc0qHsjS2sc05TawIcG
        zEnsFGSUU4dhxxpmyBUoOyBiILR2tuH8e2+SsNKNErTX+JI=
X-Google-Smtp-Source: ABdhPJwsAaQcZjDQVHohsHPPSptw72Y4I0oHkVDRgCxlZ6yLH4qLrNIY8lkMZ3AIm4AJMt1LUgPylEwnc4BPZ3uqp2s=
X-Received: by 2002:a17:906:6a0a:: with SMTP id qw10mr7262623ejc.564.1643383783955;
 Fri, 28 Jan 2022 07:29:43 -0800 (PST)
MIME-Version: 1.0
References: <1643120437-14352-1-git-send-email-anshuman.khandual@arm.com>
 <20220127202220.GA2191206@p14s> <YfPKvsw+fOsJvSm7@arm.com>
In-Reply-To: <YfPKvsw+fOsJvSm7@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 28 Jan 2022 08:29:32 -0700
Message-ID: <CANLsYkwOdYsFwmp+tBazJetivFdJU=y8NEp=sz8mFH3s__pzkg@mail.gmail.com>
Subject: Re: [PATCH V3 RESEND 0/7] coresight: trbe: Workaround Cortex-A510 erratas
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        coresight@lists.linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 at 03:51, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi Mathieu,
>
> On Thu, Jan 27, 2022 at 01:22:20PM -0700, Mathieu Poirier wrote:
> > On Tue, Jan 25, 2022 at 07:50:30PM +0530, Anshuman Khandual wrote:
> > > Anshuman Khandual (7):
> > >   arm64: Add Cortex-A510 CPU part definition
> > >   arm64: errata: Add detection for TRBE ignored system register writes
> > >   arm64: errata: Add detection for TRBE invalid prohibited states
> > >   arm64: errata: Add detection for TRBE trace data corruption
> > >   coresight: trbe: Work around the ignored system register writes
> > >   coresight: trbe: Work around the invalid prohibited states
> > >   coresight: trbe: Work around the trace data corruption
> > >
> > >  Documentation/arm64/silicon-errata.rst       |   6 +
> > >  arch/arm64/Kconfig                           |  59 ++++++++++
> > >  arch/arm64/include/asm/cputype.h             |   2 +
> > >  arch/arm64/kernel/cpu_errata.c               |  27 +++++
> > >  arch/arm64/tools/cpucaps                     |   3 +
> > >  drivers/hwtracing/coresight/coresight-trbe.c | 114 ++++++++++++++-----
> > >  drivers/hwtracing/coresight/coresight-trbe.h |   8 --
> > >  7 files changed, 183 insertions(+), 36 deletions(-)
> >
> > I have applied this set and sent a pull request to Catalin for the arm64
> > portion.
>
> Well, I'm happy for the whole series to go in via Greg's tree or however
> the coresight patches go in (that's why I acked them). The last three
> patches depend on the first four, so you might as well send them all
> together. I'd split the series only if there's a conflict with the arm64
> tree (I haven't checked).
>

Very well - thanks for the follow up.

> --
> Catalin
