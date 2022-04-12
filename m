Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3490E4FC91C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 02:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbiDLALt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 20:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiDLALo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 20:11:44 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C48B1A83E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 17:09:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z12so7854826edl.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 17:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y8z3URoguhv+IQTi/mouDUtJ1RmP13ZImOvifv5RI2M=;
        b=NNPQX65hnmr/JIz88cXsNAgTPOFY8ndkzOTcWHNphGBsbC6wvrcR4hNkLJ38VbYNWF
         T/9237QbwBREHvcfOV5UzvW9+vCtLgcmYw2B533YDJZzU9PiGwWAnPt+GbNggtxVdHKM
         rhHO9xLfhxkT2A0SmDXyLqrI9wT704JxOnqPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8z3URoguhv+IQTi/mouDUtJ1RmP13ZImOvifv5RI2M=;
        b=uWln1nDAwDxOwg2jInETqDCMP2MJnb5p290xfaHTpsVxQWQ7KeCXBFLV4QOjqvvT6Z
         UtZsh9RJoYG5RxAioGuscq83cE7NNZZ2XVNlUGaB8aeYARQNRXRNRe4k6LLVoAW91JnG
         HHMxQNmE6A2AWiE+44TRtZ+eZ7SLURSUdsqYpCNg4E3pyU2aaGfE9L0ZJ+Pz7swFmfmR
         QvCCdzRZx95bDHnGWzjoVBkzAsGvyE6Ad3Gvv1g8Ig3vRCTY6c6rxVCkAW6tky639wXM
         +NLeQMpzacHhokgoAQKnbHcAfx4Go6rRdMd9B/2wf8rDlpBOW58SMAvH0vDcPCj0LSYl
         zjog==
X-Gm-Message-State: AOAM532s0AMBlh3kxdflOAWzouVx8USFWJw9zGKs+Ql4fYikx4ewH4lz
        IWmsdwj0anW71Ar5E6SZzDBmD5uOiX3QXsxA
X-Google-Smtp-Source: ABdhPJx9ngok7bjHmbniWAHY8psLHj2Fl/vmxMKUnApCO/lCHU4gfQYUomHDOJ+FKgtM4D5uSjFWgQ==
X-Received: by 2002:a05:6402:11d2:b0:41d:8443:6849 with SMTP id j18-20020a05640211d200b0041d84436849mr4898504edw.311.1649722164958;
        Mon, 11 Apr 2022 17:09:24 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id q15-20020a1709060e4f00b006cdf4535cf2sm12417138eji.67.2022.04.11.17.09.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 17:09:22 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id o20-20020a05600c511400b0038ebbbb2ad8so613210wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 17:09:20 -0700 (PDT)
X-Received: by 2002:a1c:7518:0:b0:37c:7eb:f255 with SMTP id
 o24-20020a1c7518000000b0037c07ebf255mr1394523wmc.29.1649722159789; Mon, 11
 Apr 2022 17:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220411093819.1012583-1-sumit.garg@linaro.org>
In-Reply-To: <20220411093819.1012583-1-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Apr 2022 17:09:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WZXBG98nKp4qq_=B+VmJ=MUAJJdOhaV4OkAT=AvDcTfg@mail.gmail.com>
Message-ID: <CAD=FV=WZXBG98nKp4qq_=B+VmJ=MUAJJdOhaV4OkAT=AvDcTfg@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: kgdb/kdb: Fix pending single-step debugging issues
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Wei Li <liwei391@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 11, 2022 at 2:38 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> This patch-set reworks pending fixes from Wei's series [1] to make
> single-step debugging via kgdb/kdb on arm64 work as expected. There was
> a prior discussion on ML [2] regarding if we should keep the interrupts
> enabled during single-stepping but it turns out that in case of kgdb, it
> is risky to enable interrupts as sometimes a resume after single
> stepping an interrupt handler leads to following unbalanced locking
> issue:
>
> [  300.328300] WARNING: bad unlock balance detected!
> [  300.328608] 5.18.0-rc1-00016-g3e732ebf7316-dirty #6 Not tainted
> [  300.329058] -------------------------------------
> [  300.329298] sh/173 is trying to release lock (dbg_slave_lock) at:
> [  300.329718] [<ffffd57c951c016c>] kgdb_cpu_enter+0x7ac/0x820
> [  300.330029] but there are no more locks to release!
> [  300.330265]
> [  300.330265] other info that might help us debug this:
> [  300.330668] 4 locks held by sh/173:
> [  300.330891]  #0: ffff4f5e454d8438 (sb_writers#3){.+.+}-{0:0}, at: vfs_write+0x98/0x204
> [  300.331735]  #1: ffffd57c973bc2f0 (dbg_slave_lock){+.+.}-{2:2}, at: kgdb_cpu_enter+0x5b4/0x820
> [  300.332259]  #2: ffffd57c973a9460 (rcu_read_lock){....}-{1:2}, at: kgdb_cpu_enter+0xe0/0x820
> [  300.332717]  #3: ffffd57c973bc2a8 (dbg_master_lock){....}-{2:2}, at: kgdb_cpu_enter+0x1ec/0x820
>
> So, I choose to keep interrupts disabled specifically for kgdb. This
> series has been rebased to Linux 5.18-rc1 and I have dropped Doug's
> review and test tags as there is significant rework involved.

Hmmmm. I guess it's really up to Will here, but re-reading his
previous email made it pretty clear that he wasn't willing to land a
solution that he wasn't willing to land a solution that left
interrupts disabled during step. He also pointed out some things that
would actually be broken, like single-stepping over a call to
irqs_disabled() or single stepping over something that caused an
exception where the exception handler needed interrupts enabled.

I thought he had a proposal at:

https://lore.kernel.org/r/20200626095551.GA9312@willie-the-truck

...that was supposed to make all the problems go away and it was just
that nobody had time to implement his proposal?


> [1] https://lore.kernel.org/all/20200509214159.19680-1-liwei391@huawei.com/
> [2] https://lore.kernel.org/all/CAD=FV=Voyfq3Qz0T3RY+aYWYJ0utdH=P_AweB=13rcV8GDBeyQ@mail.gmail.com/
>
> Sumit Garg (2):
>   arm64: kgdb: Fix incorrect single stepping into the irq handler
>   arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step
>
>  arch/arm64/include/asm/debug-monitors.h |  1 +
>  arch/arm64/kernel/debug-monitors.c      |  5 ++++
>  arch/arm64/kernel/kgdb.c                | 35 +++++++++++++++++++++++--
>  3 files changed, 39 insertions(+), 2 deletions(-)
>
> --
> 2.25.1
>
