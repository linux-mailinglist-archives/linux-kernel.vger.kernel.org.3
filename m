Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540F246941F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbhLFKuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:50:11 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:38835 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239216AbhLFKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:50:10 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mzhax-1mgWVk0E2T-00vdg1; Mon, 06 Dec 2021 11:46:41 +0100
Received: by mail-wm1-f46.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so10099771wme.0;
        Mon, 06 Dec 2021 02:46:40 -0800 (PST)
X-Gm-Message-State: AOAM532B8hsKo/WYJk9/TOZWbkeleb9tgQcFrcgGomKW7sIR5TLcg2fZ
        vBR/OqsPXM0uKdbejqqVeDDH2ROWDp9GiCLiG50=
X-Google-Smtp-Source: ABdhPJzYUKIlrOfYm3GCVv91696ljxy2eEsPNm2UtKuqsw0J5k50ncwMkGn48XY4inudDYZdG3bD6FhSOPufbM/s+t4=
X-Received: by 2002:a1c:1c1:: with SMTP id 184mr37915721wmb.1.1638787600454;
 Mon, 06 Dec 2021 02:46:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638275062.git.quic_saipraka@quicinc.com>
 <e088f4b4021f2e56093c7f73e77f556059e114b7.1638275062.git.quic_saipraka@quicinc.com>
 <CAK8P3a1wOEkoteJRu+qpE0k3gJ0fRnwfn1Zrtcnmgn5wT4yQdw@mail.gmail.com> <09a477b7-4219-756d-ed72-96fcdeb6a77b@quicinc.com>
In-Reply-To: <09a477b7-4219-756d-ed72-96fcdeb6a77b@quicinc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Dec 2021 11:46:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2hoQHTDUs5YNWwrAk2GfD7bFh6ipvgqSttDxNdUX6jyg@mail.gmail.com>
Message-ID: <CAK8P3a2hoQHTDUs5YNWwrAk2GfD7bFh6ipvgqSttDxNdUX6jyg@mail.gmail.com>
Subject: Re: [PATCHv5 3/4] tracing: Add register read/write tracing support
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        quic_psodagud@quicinc.com,
        Prasad Sodagudi <psodagud@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:gyGyoNmukxw+VtiPFtXDgfIR4YZ4lYtED6+kr1bepxVRLZSFspO
 1TFd19+tb+lS/cDX2C0fyPaRYDkL7dkt2/BrjetSX0xLNYPfGJURYlR+h7pGYyLL8D3mHl6
 nuvgJXcTHoT6gmT8vhBqKeZD7DxrFTou3A7bidOhaze7nAb+lDTklSoBPt0lNxzAy1S7GD2
 6NMUIhfWsDEFR+FDwQlpA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8p2zCe4N+Oo=:f3TraTMPMTvrqrPNJtkrjD
 5QrkI1eaefni6zwU1ocJvBxMUQTmCrnVIKMacXrw71jPgHGmd84yO2QyyTjMG7jHlbzRtlMMk
 Ub7rNNI+EoJ/iSnikIYYw+twjyhlL0wgAHPGd1d5d+6uTfLdHgSK2vW5uf5fbSwZ7TH7xHwoV
 kpE+tEtPqzwfZv5QScoJJYDu9WZBvDkj6nxdxWRIR75V5E0OjMJOVH+YqWp+Aw4xFsNnLEDdM
 7w+p9ZJsduae8Uhpj3Sc8Xbvu7MZ1IjASf6TnOlfOSHmTmhixkPUg5tzPpXKveH8tfur46t02
 A5Z+irtv7icksX78L8EL1lqIpcIJpwUzSFjIIe2z6CP+wWAy8EdEYWl6zL0bAqHepYHAY2jPg
 D0zCn7VfQMvJJO3TnVJO8j+i3MRm8J+oFfcrVs/hjN5cExxuuN9h2dS9Lks3wHTfLc549DYzr
 C7vbbhOc4olHgJ1bH3FCn7KjBFHDjiu70PPApk3mrxf+j7wFmAxM8JnSNePS/PByyvrhlO2s0
 3LPVQO8ohctT0eZrqDogequpkrOEenqEfdl6a6WSpcblswu0r18fXsTMvFazo1KLRrtFcmf0a
 +boxkB/DODxAoowl4bjag8wbcps5iad3kIqEfx9U7qpLTdP4wBQxoBPewgAb/bwEggKPZNO9k
 09OVg+Gonm+AHiLe1X6bC0eW5na15sjp3O/Y8lrzQOScFyarj9CBBmzT/sqi/lkxtMn+cceBC
 3klrZyawhzqiqViSvKvXOjUlGZ/tGE9SHEG+6yAIqCHaxrWXzQsz3vDQXI5wBf3UAZKP2LD1a
 jEev1+ea7oORhm/eyNVPPiSPDsGhwoK2C/VEDcVvTG6T1KoZ+Y=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 11:11 AM Sai Prakash Ranjan
<quic_saipraka@quicinc.com> wrote:
> On 12/6/2021 2:29 PM, Arnd Bergmann wrote:
> > On Mon, Dec 6, 2021 at 9:28 AM Sai Prakash Ranjan
> >> +void log_read_mmio(u8 width, const volatile void __iomem *addr)
> >> +{
> >> +       trace_rwmmio_read(CALLER_ADDR0, CALLER_ADDR1, width, addr);
> >> +}
> > Here, it may be better to pass the caller address as an argument, I think
> > CALLER_ADDR1 is not always reliable, though it's possible that it is
> > in the configurations when this file gets enabled.
> >
> >
>
> Do you mean that we use __builtin_return_address(0,1) directly here or
> that I pass __func__ as the argument to log_read/write_mmio or is there
> some other way to pass the caller address?

I meant passing CALLER_ADDR0 from readl() down to
log_read_mmio().

       Arnd
