Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C398D54CF16
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346877AbiFOQzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346442AbiFOQzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:55:08 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6E14C42E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:55:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so2693743pjm.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=K8Qz7Vs9q7nXvzUppMlOI1ipfpO9oprPDhdKtEoC/cE=;
        b=aoMavuh7wK4rAf319BPW0UnFM7vqpdOqzns9SsFphs2vsczwbT4Lq5B7c8AJiy4fsR
         YNvD1jZMhUpjTiHq0KhSEvVXKEk4QzLFc64Qb20BNTTWXp2GP9jNoA8XCe0iijZUr2Y3
         lxFtFXjZ5JswRu7VwN/Y1AWd3QHuBlrMBXevga1RCbh/1oF+BPecssT/Ou8vDxFAWW4v
         WKujbRpZ3I7gcY+YQ5FrXtasAAsHA/p9Np68Dmg0oG4/KkzfefjAdT5yfMoeqa2tplys
         ztn3FUfXz/At8hF3Am46sL3qsT80x7dGttJqjPu/28uDNdFWGRS48f9qImyilU75iNr4
         kb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=K8Qz7Vs9q7nXvzUppMlOI1ipfpO9oprPDhdKtEoC/cE=;
        b=eoxoXIefE2B+AyUpGZjmbQuz2HaRxqlzHrAiX4QqN0lcLW/O2Bs1abw1QnvZSQtO4K
         4envJF/tvxpyG4vlmq/f+DKjitGRDh9HTdYlZedZWTButsaaFCcnmXSRdxf0IeZULrho
         DBc1+Th+I6W9WYskqAPfjnmuXZI+vmHnhPCToAp5IMgdK3Y1v5GEdJTTtoi8U891W7Ap
         sBpNYjAwlVMONhLVbJQrE/KepBcg9j2lDFfax0XZ27gbC+pBamBAUV3tnVGSjSAOGeXN
         Udps6I7SbuoYHMR57w8h1IT64XkVqfsKUTY5hvc7i27umzwUAg++ak1+Nbkp7298tbIB
         alpg==
X-Gm-Message-State: AJIora92dSLNxox563CG8e434UR31UiEP0SpabsWZQChBWtvrZ+HqRhK
        2qU1MT1O7HNuS2hom0zGHhmdPA==
X-Google-Smtp-Source: AGRyM1umrgLajayXr/hGrxoLhCuR8bRhZPsFgQ+EIAAt6jl3I/xAwvzaXV0zsGsvJ0MpysAPh6ATUA==
X-Received: by 2002:a17:90b:4b4b:b0:1e8:9e0e:c362 with SMTP id mi11-20020a17090b4b4b00b001e89e0ec362mr352044pjb.187.1655312106819;
        Wed, 15 Jun 2022 09:55:06 -0700 (PDT)
Received: from smtpclient.apple ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902654d00b001637704269fsm9583307pln.223.2022.06.15.09.55.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jun 2022 09:55:06 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [musl] Question about musl's time() implementation in time.c
From:   Adhemerval Zanella <adhemerval.zanella@linaro.org>
In-Reply-To: <CAK8P3a3WZB81QqAJF1zi0Lp0n2vKhjKhiCS4vcOoVi8jt-Y3aA@mail.gmail.com>
Date:   Wed, 15 Jun 2022 09:55:04 -0700
Cc:     musl@lists.openwall.com, John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <929C8485-D7F2-470A-B704-8068540DC358@linaro.org>
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
To:     Arnd Bergmann <arnd@kernel.org>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 15 Jun 2022, at 05:09, Arnd Bergmann <arnd@kernel.org> wrote:
>=20
> On Wed, Jun 15, 2022 at 1:28 AM Rich Felker <dalias@libc.org> wrote:
>> On Tue, Jun 14, 2022 at 11:11:32PM +0200, Arnd Bergmann wrote:
>>>=20
>>> The thing is that a lot of file systems would still behave the same =
way
>>> because they round times down to a filesystem specific resolution,
>>> often one microsecond or one second, while the kernel time =
accounting
>>> is in nanoseconds. There have been discussions about an interface
>>> to find out what the actual resolution on a given mount point is =
(similar
>>> to clock_getres), but that never made it in. The guarantees that you
>>> get from file systems at the moment are:
>>=20
>> It's normal that they may be rounded down the the filesystem =
timestamp
>> granularity. I thought what was going on here was worse.
>=20
> It gets rounded down twice: first down to the start of the current
> timer tick, which is at an arbitrary nanosecond value in the past =
10ms,
> and then to the resolution of the file system. The result is that the
> file timestamp can point to a slightly earlier value, up to max(timer =
tick
> cycle, fs resolution) before the actual nanosecond value. We don't
> advertise the granule of the file system though, so I would expect
> this to be within the expected behavior.
>=20
>> OK, the time syscall doing the wrong thing here (using a different
>> clock that's not correctly ordered with respect to CLOCK_REALTIME)
>> seems to be the worst problem here -- if I'm understanding it right.
>> The filesystem issue might be a non-issue if it's truly equivalent to
>> just having coarser fs timestamp granularity, which is allowed.
>=20
> Adding the kernel timekeeping maintainers to Cc. I think this is a
> reasonable argument, but it goes against the current behavior.
>=20
> We have four implementations of the time() syscall that one would
> commonly encounter:
>=20
> - The kernel syscall, using (effectively) CLOCK_REALTIME_COARSE
> - The kernel vdso, using (effectively) CLOCK_REALTIME_COARSE
> - The glibc interface, calling =
__clock_gettime64(CLOCK_REALTIME_COARSE, ...)
> - The musl interface, calling __clock_gettime64(CLOCK_REALTIME, ...)
>=20
> So even if everyone agrees that the musl implementation is the
> correct one, I think both linux and glibc are more likely to stick =
with
> the traditional behavior to avoid breaking user space code such as the
> libc-test case that Zev brought up initially. At least Adhemerval's
> time() implementation in glibc[1] appears to have done this =
intentionally,
> while the Linux implementation has simply never changed this in an
> incompatible way since Linux-0.01 added time() and 0.99.13k added
> the high-resolution gettimeofday().
>=20
>       Arnd
>=20
> [1] https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommitdiff;h=3D0d56378=
349

Indeed I have changed glibc to be consistent on all architectures to =
mimic kernel
behavior time syscall and avoid this very issue. We did not have a =
consistent
implementation before, so glibc varied depending of architecture and =
kernel
version whether it uses CLOCK_REALTIME or CLOCK_REALTIME_COARSE.

If kernel does change to make time() use CLOCK_REALTIME, it would make
sense to make glibc __clock_gettime64 to use it as well. We will also =
need to
either disable time vDSO usage on x86 and powerpc or make kernel =
implementation=09
to use CLOCK_REALTIME as well.


