Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7FA469326
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241722AbhLFKEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:04:53 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:50547 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbhLFKEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:04:51 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MZCSt-1n72od0YvR-00V8cd; Mon, 06 Dec 2021 11:01:22 +0100
Received: by mail-wr1-f49.google.com with SMTP id j3so21282981wrp.1;
        Mon, 06 Dec 2021 02:01:22 -0800 (PST)
X-Gm-Message-State: AOAM532nQUcXTPImaBBQS+fW/9NOn9CgL45ys395qdXVXeG7OXNXJ2uv
        PZwcJ+Jsv6N6wY2zgNiLIeKOOtWKppWfxwd5k1Q=
X-Google-Smtp-Source: ABdhPJzK344dYgqqfzp94G+JGpMAcIVesiyoKyE+J1TuWbu6tT5SKZ+BIEtzC2v8Q05uMleLTlgzpaYZiFmuZWtba64=
X-Received: by 2002:adf:d091:: with SMTP id y17mr44249813wrh.418.1638784881789;
 Mon, 06 Dec 2021 02:01:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638275062.git.quic_saipraka@quicinc.com>
 <99ecc64c6da3abb3ea2930082c40f1820655664c.1638275062.git.quic_saipraka@quicinc.com>
 <CAK8P3a1k-1_m7r-u0uO1nW1m43bt_hR9u+UeW=SqK40+Ltb+iA@mail.gmail.com> <0cd0bc8c-e3db-b3fb-5be4-c619d1d5d633@quicinc.com>
In-Reply-To: <0cd0bc8c-e3db-b3fb-5be4-c619d1d5d633@quicinc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Dec 2021 11:01:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0mxRshs=OrOK+NaMharykS0PffATq30wJTv4qe52_ecg@mail.gmail.com>
Message-ID: <CAK8P3a0mxRshs=OrOK+NaMharykS0PffATq30wJTv4qe52_ecg@mail.gmail.com>
Subject: Re: [PATCHv5 4/4] asm-generic/io: Add logging support for MMIO accessors
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        quic_psodagud@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:J3TkbCg7aC1Iac3AU6TOXHijEJswfqbq8n6ZzKwhFN7LxzieaKL
 MOXPJiiF3I0oZJEdLw+bbmAM/efQ0WN6hhPWHXscX8ilpCOs6VjEGUzySqBskfjCMxA3O2i
 NOm4SBD7B50qIItjGRiYdGyhjBVnlOpcKyx0MjZ2+DpVvq10bBm0ZlhCCxvoebMMLfJQ5jT
 5eHnfHJsNWh0VdDdfCccA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hSxWIA+lA5s=:fiozv8I+XydeTj9fGjcfSn
 x3Stjuo4WziE1gOqDlx3hRcpFAapjPRBQ3XJ8kJXkAOTwxsdwGGCVdedpmLxkDUc4A2+F1HNM
 pVaEn0OvtZGflGzyiR1j+W0vfKc1a6GtFByIC9rF1xZsnFnJZ7CBEcyMYEQDYJEBIdTgVQfXJ
 wjIF6LydBvMg7AdtZKCoGqa8ryEZ3Vb527za17O7h/zX1NTk6luNdbMG2zQ1U7J4EuxBfvd2H
 qY4hrzprrvz+XIXQkp87mwJDHjuEzLpUR++Cu2ByRn9TAYgfzZT1T2hkECOeF9em9EsrINDJN
 PGT2xmxDgrJ2rTWZNa7fQpgeAXEpKS2DW6wXqLRAh+45fm2W4RPf3k31NqHxt/0MJyIiHD9gF
 bwoeBbX4MVbUF5M0B9hrwnuZRD6LKbJBIudyDTfQOibEeOuH9QuV2O+yjHFK9mJB8wLZljkNn
 tf1QQJUe+i5RsiVNPs7lVqRJXjhxmZ19GJlsn1x5U1NX+L1x752anmoDJ9E0FVLpn/ouAg560
 7ViH4HPvSYDmve7TB9kgtG9LD2ThANnZzSYjCQ1ehRL/9Elbk2qz8aCq3DWOr4QokzBFkqp42
 SXgnubLRMKoyWIokC0SVnCqZtSRfRRmI53UOAAI8rxjPflrjL5xPNTwuIAZdbdBgvlTIEyp1Q
 4Wz/r7RHSBUfoerDtv8RnG8ZuJghzedvF6AgkueNGFmFnLcpH6NNIJML8ERqaqLgoUYc=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 10:52 AM Sai Prakash Ranjan
<quic_saipraka@quicinc.com> wrote:
>
> Yes just the trace after read/write won't serve our usecase where we
> expect crashes/hangs on accessing
> these registers but internally we did have a log_post_read_mmio() as
> well, if it is useful then I can add it.

Are there any downsides to tracing both before and after, besides another growth
in binary size? Aside from the 'value', that would also allow
measuring the time it
takes to complete a readl(), which may be valuable for other users as these
can be significant.

Not sure how to best do that that, we could return a timestamp from the 'before'
tracepoint and pass it into the 'after' tracepoint in order to log the
difference, or just
rely on calculating the differences in user space based on the log.

For the 'write' style accessors, the timing data would be less interesting, at
least for posted PCI transactions, but it may be helpful to do the same for
symmetry reasons.

         Arnd
