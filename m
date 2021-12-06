Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855A64691C5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239724AbhLFIxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:53:49 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:51205 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhLFIxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:53:48 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N3bfB-1mTrI01Eyh-010g4q; Mon, 06 Dec 2021 09:50:19 +0100
Received: by mail-wm1-f47.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso9813899wms.3;
        Mon, 06 Dec 2021 00:50:19 -0800 (PST)
X-Gm-Message-State: AOAM533soufzpSMHOcVdqH0FKFqpFB62rKpZjEhD5BQ3cuYo56D2TQbZ
        vMxEEU/lGI2NYU9lc0U5qE2xEjCSPY9fqvYm/OY=
X-Google-Smtp-Source: ABdhPJxUxDhd2FdTBrY2LkWd3PHoMfBeT3PMYJLhtdmEIDValutbBwewsbhhcWEEDjBT5kLamtgi/ICPk+qTQ7QwsEw=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr36775318wmi.173.1638780618911;
 Mon, 06 Dec 2021 00:50:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638275062.git.quic_saipraka@quicinc.com> <cc649faf144fce439b7a341303b6cc73ac285949.1638275062.git.quic_saipraka@quicinc.com>
In-Reply-To: <cc649faf144fce439b7a341303b6cc73ac285949.1638275062.git.quic_saipraka@quicinc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Dec 2021 09:50:03 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2JSSJxs92uEiJQAa0iQOvA6NDuww3+Br5cAxYvXVOOAQ@mail.gmail.com>
Message-ID: <CAK8P3a2JSSJxs92uEiJQAa0iQOvA6NDuww3+Br5cAxYvXVOOAQ@mail.gmail.com>
Subject: Re: [PATCHv5 1/4] arm64: io: Use asm-generic high level MMIO accessors
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
        quic_psodagud@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:uYON4I4Cjn9nZOCSzD+SlEpr33MpNioz3E6qMLPoaFvTs0sml4q
 JTZyhnzyDs4vkSD76cUdb6dMohib2xYzZ3qyR6alVnIy9wB4PEBgHanVXSdglQ7n5Wn8kDO
 zpBGdNegTk9EMjSitWF8RLW8WPovgH4Teh/iDYccbICzQ/Y+1SlTUT601SnWOWeHcBxGyqh
 8F1bQntIwRtOfNpLRSxtA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:t//w2yrjMrc=:4rfZmGLr4m4WCBFfonmZyX
 4T7h75Zv+BB0SmjkO56KVZA7BzYSfJ9JPJByd2w8BzjjYXuoIWeKvwZ2WBY1Eti4BN7ifeQVD
 z5DUsAar028LSOX5CI9vR6ljU/9lmFOZPHArwPEC3m6eF+sCZbaA4NqY6Vt9qQCPJdvyxIYpR
 /adgt83NYpMzwVjFFEJvt3/aaPdrhYGal1KkhB1UZx0JeaILMg29uVGV+Aa7Tb+3a3SV1npmq
 YKAozv7xCEmpVImSk8PSXEHcs2wekUVGoajHAjgmXWwdyKZqSKGv6alFt0o1848Vem1NSPE4T
 fYZ43ol1CKGPQNvzYuoSJGEaeiqVnrZJUa4othfURQiYDKX7ScD72g9ahxAI85vqSYGlABs6a
 +GPYacLFcwCyxeB+2mjPdYPnhO6uUHdDUY+q86TXbHbpKiJsGUDziFBwwy8HSl6DClrn5Wyga
 Ya8pB08MAFPQg0rj8vGFwVziZ1bJSkDe1xxAYL4HIo4qA+3tlykFu4ZgZuGIuGbGSloo6EHn+
 XoZ0SSuB058AN5/fMdvzs+AJIEJpBQ7Mic+/2Lu0Bqj0S+gVnzCaNMKz51VEUsrVvAXIzNMZa
 7Tn4GYXHdM1mPnLde1BF2zFciMJX2vXt028bMpo+A46/OFDnHrerm08TFwPJDi+syNfTTDOih
 MG3gGOBGezIMB1qTzfxVSUw7OVi5pJeS/jdZlLPTntHQwmkQzO0AHzh1MP/VRtTKMmcaI4gOJ
 0rEWP7l9mS5R4UvPYAvhm8p+sm1uZYxsDc+frQH//agr1SQJNCLr2BXj7uEDOpEZ7IbPLAriP
 fF8LYAfnIsQYi4Iq1xzyke6KDIHg75dZP9HACc54FpI8NeaXFw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 9:28 AM Sai Prakash Ranjan
<quic_saipraka@quicinc.com> wrote:
>
> Remove custom arm64 MMIO accessors read{b,w,l,q} and their relaxed
> versions in support to use asm-generic ones. Also define arm64
> barrier macros to override the asm-generic defined barriers.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>

This looks correct, but I would change one detail:

> +#define __io_ar(v)             __io_par(v)
> +#define __io_bw()              __iowmb()
> +#define __io_br(v)
> +#define __io_aw(v)

The default __io_par() is defined in terms of __io_ar(), so it would
be more logical
to remove the custom __io_par() and just define __io_ar() here.

I think it would be even better to flip these around and make the low-level
definitions __io_ar() and __io_bw(), and then defining the arm64 specific
macros based on those:

/* arm64-specific, don't use in portable drivers */
#define __iormb(v)     __io_ar(v)
#define __iowmb()      __io_bw()
#define __iomb()        dma_mb()

        Arnd
