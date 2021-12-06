Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DAC469508
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242460AbhLFLed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:34:33 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:34195 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhLFLeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:34:31 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MStKq-1n09Ga101u-00UJXC; Mon, 06 Dec 2021 12:31:02 +0100
Received: by mail-wr1-f50.google.com with SMTP id i5so21783240wrb.2;
        Mon, 06 Dec 2021 03:31:02 -0800 (PST)
X-Gm-Message-State: AOAM533KHtartIlMC6DVp1SLZb5kjydBUT95KhJMb7sHertR7WtaQxGw
        Z5Io3Duy0WJ8ombemZxmbYPL7Agr1kPDy4o1gCQ=
X-Google-Smtp-Source: ABdhPJw16WAm7wgvwNNb9nTOQaZy5OVqt+aN1W6z8NVgK3jqrVKeeh7oCCksIsCkQd3pen14ghmmMCL95nhGoAj6w3M=
X-Received: by 2002:adf:d091:: with SMTP id y17mr44777548wrh.418.1638790261818;
 Mon, 06 Dec 2021 03:31:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638275062.git.quic_saipraka@quicinc.com>
 <cc649faf144fce439b7a341303b6cc73ac285949.1638275062.git.quic_saipraka@quicinc.com>
 <CAK8P3a2JSSJxs92uEiJQAa0iQOvA6NDuww3+Br5cAxYvXVOOAQ@mail.gmail.com> <7b2b5888-c2ca-2ca0-8c0c-32128fcb37d2@quicinc.com>
In-Reply-To: <7b2b5888-c2ca-2ca0-8c0c-32128fcb37d2@quicinc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Dec 2021 12:30:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0TZp349d7xFvpa6rzGSa4Wj2cAhqOg9-BAewA-d+yvJA@mail.gmail.com>
Message-ID: <CAK8P3a0TZp349d7xFvpa6rzGSa4Wj2cAhqOg9-BAewA-d+yvJA@mail.gmail.com>
Subject: Re: [PATCHv5 1/4] arm64: io: Use asm-generic high level MMIO accessors
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
X-Provags-ID: V03:K1:3/j8d64qhzDw/fq9QUxhzyzgN1ZRYs/kcsRiMSRU5EiMPehgiej
 Gj8ZHjoLZCz9e79CCX7t3v25tv4RCuLOCsq06YvRfbjMIY4uz951aPiq2V9HvayFTOC8uCB
 2VGxC7hfxFpeXynYPWMbIb1KV4VDUf016kd3mSUP2KKs9N7TtcvfJihrDDyUCqTRUQhxZUg
 xooslz2eD7W2qg4+s4wFw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XDv8maYSOO8=:23cgFAt5pFIGZDYs2u6jVJ
 Dwok92b2XfQANW3gq3jTvf6gkmKATlx7bpzSq4vQqzpR7jbwoln3AXQ7niJVgMBcucW3xukxz
 6NhwMa00jmNm1Bf/wsBQ5o1doCHXZcK/zoLh8C7AoIUqc6rkjsZbvleTYxlor3FHVTKe6RTcp
 Ebfk9dbx73wKlZ+A6jdpk5ru2mWpE6lqpWZRGDk4rQCobr7ez4dROQTnE6wyWZT2VFWSCuJAu
 vALvEFFSu2ZyOcGH7TXWGs8uCJ9qln/G3ZWXrIQGWzAUlAPzxVfwqRQUv8w7lMjcok0tuPh+u
 uqBdmUa0uZ2ZGKCuXzGeZ6eNRd+sIKSf/bKuMruJqDZz3Ip57KW95o1RNkH9cHAFCPWv7ZkOX
 MmYkTJkLIavxp4cODyJeA4hHAJaQYk68UXNI5y8Qmqx2WjFcIN6inLxwGcxcYeoddl1ilLc1P
 iTGDaYYbYUh+UJa2+70botEb9Pe86QDBYVrwOH0bKMLgPyEQ1nty+FeukqbU6R0HiftOCyhqE
 QGcYr/5UGtMctqbe6kAzylWCTUqvaQVAWdFU8+fg+Hy0X+vKGMsDgI2gnfyoQmxzmeo8Cbajm
 oY3ZpzfSOzsthQJwrQtO609knT1vjEqqoYqGeCG3SFO3n9SGppbEziIdyXwcceBJX2P6lAjAN
 zsSJI4AiT66ogoTWKsi06R8zYl3ocUGQZFMpBFyLtkyhXgDrc4BFRpf0vdC/dO2Yrl8XpsipS
 qDm9CXdySDkBvIQR8zyvDqzBHMlxn6IAKkL4xI0xxRADO5iLUeLN7+x6lPl88X8Z30+3nuEvb
 7mhPc4mW3bRnZA19SLwMzTXVWDoJ57nyCssN+adlUj7cHBTMc0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 12:12 PM Sai Prakash Ranjan
<quic_saipraka@quicinc.com> wrote:
> On 12/6/2021 2:20 PM, Arnd Bergmann wrote:
> > I think it would be even better to flip these around and make the low-level
> > definitions __io_ar() and __io_bw(), and then defining the arm64 specific
> > macros based on those:
> >
> > /* arm64-specific, don't use in portable drivers */
> > #define __iormb(v)     __io_ar(v)
> > #define __iowmb()      __io_bw()
> > #define __iomb()        dma_mb()
> >
> >
>
> So __iormb on arm64 has some dummy control dependency stuff as well based on
> ("arm64: io: Ensure calls to delay routines are ordered against prior
> readX()") and then we would need to change __iormb definition to __io_ar which
> doesn't seem like __iormb definition to be exact right?

I'm not sure what you are asking here. As far as I can tell, __io_ar()
and __iormb() have the same calling conventions and the same barrier
requirements, so they should be interchangeable, we just need to decide
which one is the primary definition.

       Arnd
