Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9ED4691E0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbhLFJDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:03:12 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:52073 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhLFJDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:03:10 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N17l4-1mRwoA2J2o-012bDT; Mon, 06 Dec 2021 09:59:40 +0100
Received: by mail-wr1-f45.google.com with SMTP id l16so20848271wrp.11;
        Mon, 06 Dec 2021 00:59:40 -0800 (PST)
X-Gm-Message-State: AOAM532mbZVE5yyzbhp4Z5TuC7PMXaqq2csLbjtD9283/71CAJCBCTQG
        hMv7u4MfMYpPnDlm6ZuDsDyi8zb4+Fi4clz4+8E=
X-Google-Smtp-Source: ABdhPJw8rKwPBIOecacswxTOKMMxeoiEmBfy+YFh9g4vDQi3JLiqejiVdE79PUY+07qh6BJ/4t1a2LtifJmZTf8goHw=
X-Received: by 2002:a5d:64ea:: with SMTP id g10mr42126554wri.137.1638781180234;
 Mon, 06 Dec 2021 00:59:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638275062.git.quic_saipraka@quicinc.com> <e088f4b4021f2e56093c7f73e77f556059e114b7.1638275062.git.quic_saipraka@quicinc.com>
In-Reply-To: <e088f4b4021f2e56093c7f73e77f556059e114b7.1638275062.git.quic_saipraka@quicinc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Dec 2021 09:59:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1wOEkoteJRu+qpE0k3gJ0fRnwfn1Zrtcnmgn5wT4yQdw@mail.gmail.com>
Message-ID: <CAK8P3a1wOEkoteJRu+qpE0k3gJ0fRnwfn1Zrtcnmgn5wT4yQdw@mail.gmail.com>
Subject: Re: [PATCHv5 3/4] tracing: Add register read/write tracing support
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        quic_psodagud@quicinc.com,
        Prasad Sodagudi <psodagud@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:GUNb41Or55BMKgt3KI9K6V9zMJAkWSqJJXgLrv6x1kHppH94xEQ
 PgyF+5Mk7vs9EWfDeTaMX9tkofqcx4c9eTJpf4c1VdW1PnJo3AN/qETUL3vL2V+/Kz9wC41
 dUnHx0VrMTR3eB8/V7Nb0+6Fdh1H43Bf82PJ50gn9GXDm5XuB4/4+MPSt/wEVwu2AYlGOFa
 gFpvkWp4VxU0ALpH4mOTA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oVDn6Z53ECM=:A+nmh7IzDW8YAKJXfImSD2
 YliO6ROxefTNNNkHeOh1hJAhjhdZEAAym2nwKwxL1ZFUiYJ5PMjIdEPeVAz/f7WiRi8or6TCX
 J8JQg3nLqkju2cswwKPdBx1Q6TOLvHvD53wAAclDS18X9P66Tn+0yIToTn/Gw7BHeF54AFXCA
 ebYTsIbq/TA+DMkxEvpBdlkMovfS0GTNhMJCQbDtyL72luJuehRGa/TsWIKcNABLXJ6r98/fO
 4PGBBhvWX5ty6v8JqQpEo+ygtxa9cdXWbF50djilchCreTVvfSbzEZRV2Rwnpm61Jfn2eyLdm
 RRD2y8lhV6k4tXwvDQqGlvxlEPRGW2HT6Ex4A3Ebhx/ZS4Pkdc8U5GLywl6FuDdBuPp9QP80W
 PwZKDrX8n5Uwc1f3/pq2NxyvroB3zX86dqio/xyQnQoEmaINQ7rOSOxYdzv3nGqUtPu+QcA+1
 t2mOl98+S0FV/As9kJT7+L0LtYcfhF+CQA2txh9wfQcryhQa9gcwkA6w7Eqe6QYcNpxH9vMx9
 D7WzGJ1vD+N8WQ0Yq1Pep9bbjXZmnFar+5IV8OAN6FSpfaKXFAkgMZZ/Rbo88FM5nZFCOlETJ
 QVukfZ16DSJ5PWPwKEk43LQfg8Zjr6YwjLehJxvjSlqpcGr3SzkeIDF/r+Ll8qu7L4fOuu+PN
 ULKQaC79UDFfEIXlO1Jlfhvpn3O88q2p/krDY7yyuVY5hiWBf1Uq/Spunts+o5pKCT9pflPfC
 awHpHatG4KlEjBTCa5i5ohpX3OwHAxHo7v3h6NpCe0733Ahbh4lqan4kMoNXZYLIjew9uyLan
 PcNi5V8p2RvFeBqQgNef1m+6uwLbOU/9iSZo3yAm4prvbvj48c=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 9:28 AM Sai Prakash Ranjan
<quic_saipraka@quicinc.com> wrote:
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 420ff4bc67fd..9f55bcc51de1 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -95,6 +95,13 @@ config RING_BUFFER_ALLOW_SWAP
>          Allow the use of ring_buffer_swap_cpu.
>          Adds a very slight overhead to tracing when enabled.
>
> +config TRACE_MMIO_ACCESS
> +       bool "Register read/write tracing"
> +       depends on TRACING
> +       help
> +         Create tracepoints for MMIO read/write operations. These trace events
> +         can be used for logging all MMIO read/write operations.

I think this needs a 'depends on ARCH_HAVE_TRACE_MMIO_ACCESS'
or similar.

> +void log_read_mmio(u8 width, const volatile void __iomem *addr)
> +{
> +       trace_rwmmio_read(CALLER_ADDR0, CALLER_ADDR1, width, addr);
> +}

Here, it may be better to pass the caller address as an argument, I think
CALLER_ADDR1 is not always reliable, though it's possible that it is
in the configurations when this file gets enabled.

       Arnd
