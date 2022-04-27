Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3931B511EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243944AbiD0RWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiD0RWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:22:32 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0726B43EEE;
        Wed, 27 Apr 2022 10:19:19 -0700 (PDT)
Received: from mail-yb1-f177.google.com ([209.85.219.177]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M3lHZ-1nk2AY3Yhf-000pwR; Wed, 27 Apr 2022 19:19:18 +0200
Received: by mail-yb1-f177.google.com with SMTP id y76so4637875ybe.1;
        Wed, 27 Apr 2022 10:19:17 -0700 (PDT)
X-Gm-Message-State: AOAM531+el4QSdxw258V6dhpmKYBsthoDpzNMuJRfg2G2rqhJY7U0zPF
        tOAY0RJXUQchtqJqCDXOk4ygqMzOqVYwCMBmjFA=
X-Google-Smtp-Source: ABdhPJxykFm2YFdeTD9c0X4acekrQD5pMu7gY+0N7BMUQZQ8AeFGwdPZwBJhORkCJQqjgz7RTTvsKHR+rJyDsdyNlv0=
X-Received: by 2002:a25:75c5:0:b0:648:dccd:e1c with SMTP id
 q188-20020a2575c5000000b00648dccd0e1cmr2536236ybc.452.1651076102000; Wed, 27
 Apr 2022 09:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1644824638.git.quic_saipraka@quicinc.com> <8cf9304d9941c25d920c4835cbc624ff5c2ac2cb.1644824638.git.quic_saipraka@quicinc.com>
In-Reply-To: <8cf9304d9941c25d920c4835cbc624ff5c2ac2cb.1644824638.git.quic_saipraka@quicinc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 Apr 2022 18:14:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1WwghVToFBNZMpG7Wcji_k3CebK3--LL8YNJs_Wu3rBQ@mail.gmail.com>
Message-ID: <CAK8P3a1WwghVToFBNZMpG7Wcji_k3CebK3--LL8YNJs_Wu3rBQ@mail.gmail.com>
Subject: Re: [PATCHv10 5/6] lib: Add register read/write tracing support
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        quic_psodagud@quicinc.com, gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fNiZgmJlIJjWIct59kSQx8ulkmtN7VhuK0xD8FBYWGJHejqOqrI
 WFoOWk0Jgc7ITQkzCBP5gToDgyKqCqne6ABQKANTZkYzI1M5xyZ9RUDFVXiffCSp9+h9Zj1
 UOaUe5K+szrhJSycphxyeSlW48qZTsHNffCN4KgdaxAMECjwlxLO5GZc/ro/Q3GDdbaDM5o
 q37ylgOliMyNA6s2ZlGGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mOXcYFdOMKM=:QmOMmZLYg82fxODCPrNcJ0
 JSFAZq7c4sP4ApFc32S0zxRzq9pXxIuf1/FtJ/ltcbaIBDMqW2sWzroaY/plVcskhNUEixEsK
 9qB5s94QXjaTur14KQdE1bO3mD2qeDKo6jClJxyGYNxGTGgZRMdgsBFiBI+zwdT5457qvykQG
 KtzY7BDW6aAKlLyZhTxHbrheYXdBUGfYjydv21D5O96VD3bqLz4g/sASmb+CqjS8QP7f24NbE
 Hv1yFrTMcgw1ecRKj15UGFZOHZQxypiY+JTz0eTjmJ5F2LVEprNAGpI0j6f7XbTZzs/0rDIZc
 JtaBpJKwXbjoxUPynlZdO1D8HdLGhlzFpXKg/Ai6goHh63fs75tSHhkx00iO6QLHsV8FyWIJj
 Y/CHAYNo8Lz83S2XZzf7YM2rxW+8ZegpOJDjzcFSH10BoZ46528Ga/+nJtTqfQLo7ldcGckNX
 EkiAXt8HLH3DvuQjpxf6W57oV1SiRQr5q+whbtup0clInB2B0Lb0W/X3soL/JQ3kX96XLWFDC
 yioUU8XbUrRZPYGqyx26m5PCmPSD4YwpvAJekKKBiPYSSE0T7SlWRPSzfI0xXLbEPzOEFyCnb
 4LCFFDtw+SahIIwrOyxL4W0VBW4ua78M/c4791VuqB9RInnZiCuEwK3U5zteFDRt7beC+u52v
 V9OKFr67tL8nOBBR3QtLtojhYG3BiEMV1frW64JklzhkcMTT8a+t7LLIjgW4yJtAERwdrV1Q3
 +6oKpKHEDbtMFdhfOz2ZCQrnzUSGis9snuu0tCA5hN77ikYFKyyMW0I173A0FigpnGDX/DR7J
 N4PKUBbPALox6FEjjz/W5hNkL2cYboQ2JFlwxUQlN8IZfcOt0Y=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 7:07 AM Sai Prakash Ranjan
<quic_saipraka@quicinc.com> wrote:
>
> From: Prasad Sodagudi <psodagud@codeaurora.org>
>
> Generic MMIO read/write i.e., __raw_{read,write}{b,l,w,q} accessors
> are typically used to read/write from/to memory mapped registers
> and can cause hangs or some undefined behaviour in following few
> cases,
>
> * If the access to the register space is unclocked, for example: if
>   there is an access to multimedia(MM) block registers without MM
>   clocks.
>
> * If the register space is protected and not set to be accessible from
>   non-secure world, for example: only EL3 (EL: Exception level) access
>   is allowed and any EL2/EL1 access is forbidden.
>
> * If xPU(memory/register protection units) is controlling access to
>   certain memory/register space for specific clients.
>
> and more...
>
> Such cases usually results in instant reboot/SErrors/NOC or interconnect
> hangs and tracing these register accesses can be very helpful to debug
> such issues during initial development stages and also in later stages.
>
> So use ftrace trace events to log such MMIO register accesses which
> provides rich feature set such as early enablement of trace events,
> filtering capability, dumping ftrace logs on console and many more.
>
> Sample output:
>
> rwmmio_write: __qcom_geni_serial_console_write+0x160/0x1e0 width=32 val=0xa0d5d addr=0xfffffbfffdbff700
> rwmmio_post_write: __qcom_geni_serial_console_write+0x160/0x1e0 width=32 val=0xa0d5d addr=0xfffffbfffdbff700
> rwmmio_read: qcom_geni_serial_poll_bit+0x94/0x138 width=32 addr=0xfffffbfffdbff610
> rwmmio_post_read: qcom_geni_serial_poll_bit+0x94/0x138 width=32 val=0x0 addr=0xfffffbfffdbff610
>
> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> Co-developed-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>

I think this is ok in general. I saw that Steve had a minor comment, and
I suppose you could have just resent the same patches with a fixup in order
to have me pick it up into the asm-generic tree for 5.19.

There is one more thing that I saw looking through this patch again: the
address you print is the virtual __iomem token, but it might be more
valuable to have the physical address instead, which can be looked up
in the devicetree to know which register is affected.

There is a small extra cost to walk the page table, and I'm not sure
if we actually have an interface for it (vmalloc_to_page is almost
what we want, but it returns an invalid page pointer). Any suggestions
on this?

       Arnd
