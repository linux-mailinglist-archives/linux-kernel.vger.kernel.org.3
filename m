Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B2054DDDA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376347AbiFPJGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359247AbiFPJGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:06:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0966033EBD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:06:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655370386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oFI56HYR9PA5Ni16nC26doRrmOppgXN3t+kO6eIWTFA=;
        b=VK5QKlFRYfKGcn9OY7lq9YOj8skLghk27/PST3Lm95lG70hNkUiVdi/YK1/UnwLQzG42k2
        8iB1fITFD4bDuY3oRsY98T445F+eRHkg6PceegYcylaVlEnT3TNB5vawgsJPZ8+thb2DIX
        8A+DqYV6MfoxzE4dwshbJtk7HtPvgBj8C0yShrCupuFnKJGFzdjpb/b6czXd5eTHY3CZnK
        x5jQsLb7rDkeAzvRa5xFBZ3BsbRRHEr5zzNQc86GT3EIHoql/xN4wuO4Q4bPT4p+zFgY9o
        3uM3y+s1t6yQYOcG8h7fZ/XF3ycacNEFUXq3QSPUXCAWBWSumUwpQTnEGint0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655370386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oFI56HYR9PA5Ni16nC26doRrmOppgXN3t+kO6eIWTFA=;
        b=VzuuvudXOmLoHB6TccL+4+XJkN6NR1Gy8ohPgscaTBTa8v87d2dXRIx0QpCkRVtqysiRSL
        UAmi1my6HwXWMEDA==
To:     Arnd Bergmann <arnd@kernel.org>, musl@lists.openwall.com
Cc:     John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>
Subject: Re: [musl] Question about musl's time() implementation in time.c
In-Reply-To: <CAK8P3a3WZB81QqAJF1zi0Lp0n2vKhjKhiCS4vcOoVi8jt-Y3aA@mail.gmail.com>
References: <CAFJhRnoEifeo0Tr2qfKD031C=9jYZ7oP3zSR9hFUmFp86Og7+Q@mail.gmail.com>
 <CAK8P3a1RVKLFT0aX38fJoFejgrq7VCz7auHjtsBB9W0rwnedCw@mail.gmail.com>
 <20220607163053.GD7074@brightrain.aerifal.cx>
 <CAFJhRnrWPC6pk67Xo9A9EeHFhoJCkE2PfwS4wFUep2JS3D9ujQ@mail.gmail.com>
 <CAK8P3a04TcLnhEE+MmQGOLU_AcVD5Rb+8vCKFSRF-zg33161ig@mail.gmail.com>
 <20220614170013.GH7074@brightrain.aerifal.cx>
 <CAK8P3a0d9hOuv+RiN_eQZtmfc7DCbJe6nEhL+W1AU2kFjiDZWw@mail.gmail.com>
 <20220614204900.GI7074@brightrain.aerifal.cx>
 <CAK8P3a0jk736rPueff--Uor=tHmicHZgoikrAsjp0DHxmkaiWg@mail.gmail.com>
 <20220614232826.GJ7074@brightrain.aerifal.cx>
 <CAK8P3a3WZB81QqAJF1zi0Lp0n2vKhjKhiCS4vcOoVi8jt-Y3aA@mail.gmail.com>
Date:   Thu, 16 Jun 2022 11:06:25 +0200
Message-ID: <87mted0yge.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15 2022 at 14:09, Arnd Bergmann wrote:
> On Wed, Jun 15, 2022 at 1:28 AM Rich Felker <dalias@libc.org> wrote:
> Adding the kernel timekeeping maintainers to Cc. I think this is a
> reasonable argument, but it goes against the current behavior.
>
> We have four implementations of the time() syscall that one would
> commonly encounter:
>
> - The kernel syscall, using (effectively) CLOCK_REALTIME_COARSE
> - The kernel vdso, using (effectively) CLOCK_REALTIME_COARSE
> - The glibc interface, calling __clock_gettime64(CLOCK_REALTIME_COARSE, ...)
> - The musl interface, calling __clock_gettime64(CLOCK_REALTIME, ...)
>
> So even if everyone agrees that the musl implementation is the
> correct one, I think both linux and glibc are more likely to stick with
> the traditional behavior to avoid breaking user space code such as the
> libc-test case that Zev brought up initially. At least Adhemerval's
> time() implementation in glibc[1] appears to have done this intentionally,
> while the Linux implementation has simply never changed this in an
> incompatible way since Linux-0.01 added time() and 0.99.13k added
> the high-resolution gettimeofday().

That's correct. Assumed this call order:

       clock_gettime(REALTIME, &tr);
       clock_gettime(REALTIME_COARSE, &tc);
       tt = time();

You can observe

  tr->sec > tc->sec
  tr->sec > tt

but you can never observe

      tc->sec > tt

The reason for this is historical and time() has a distinct performance
advantage as it boils down to a single read and does not require the
sequence count (at least on 64bit). Coarse REALTIME requires the
seqcount, but avoids the hardware read and the larger math.

The costy part is the hardware read. Before TSC became usable, the
hardware read was a matter of microseconds, so avoiding it was a
significant performance gain. With a loop of 1e9 reads (including the
loop overhead) as measured with perf on a halfways recent SKL the
average per invocation is:

time()                           7 cycles
clock_gettime(REAL_COARSE)      21 cycles
clock_gettime(REAL) TSC         60 cycles
clock_gettime(REAL) HPET      6092 cycles (~2000 cycles syscall overhead)
clock_gettime(REAL) ACPI_PM   4096 cycles (~2000 cycles syscall overhead)

So at the very end it boils down to performance and expectations. File
systems have chosen their granularity and the underlying mechanism to
get the timestamp according to that.

It's clearly not well documented, but I doubt that we can change the
implementation without running into measurable performance regressions.

VDSO based time() vs. clock_gettime(REAL) TSC is almost an order of
magnitude...

Thanks,

        tglx
