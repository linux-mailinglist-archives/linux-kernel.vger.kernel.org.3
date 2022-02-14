Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E244B5B33
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 21:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiBNUp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:45:29 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiBNUpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:45:05 -0500
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4529F2409C8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:42:05 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id b13so29009771edn.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgwPr3jWEXZiHeYJRBUfKrH3C5wLRAnP7Z6R5s1EJ5U=;
        b=ZcumWtnhggjMFDUHhywZOsPSWocj5WFiFD4wxX4meGi3Jv+FEek8bAx8wm544tPFuD
         FZMy/4sQc4BwvneObDdXEv1mNtlI8GPACMt1JW8whp1hkRcRU1/uCicaO7g7UXSaSO+q
         JQ0jz81cHBjFl3QlKdIkLJ7hR07DlS4kmaNNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgwPr3jWEXZiHeYJRBUfKrH3C5wLRAnP7Z6R5s1EJ5U=;
        b=jjTegN0uk6Pqpr1SEq67xRBOv+ADkfiHNSLJMDh9llM+Vg5NFELSTloXDc2zNiMyjh
         yhxSrw1IKk7gp9q4I+is0z2AzLls0qGgrEIT6XSc7QuScRk1OIgt5RmR3o4kjqv6mEjt
         g7BV3BqwVCeqMdPj1ZFlEiyCVVsKg6GBsdfcYk/LdTq5h0fteywA5CPgdL0uLwZ01LUv
         AZ8sj5PwEcpxiMeVdlln4s/gIYkA3dlMZlZmYn+tfIqQlTaEa8k1rKDT4vBUprJtkSPN
         TEgmax9Ez4KWH6dKX4eu7UXZMORoeWplFuNIvuKT9yEI8qh3frr0FSZ/wLUaHy/TZ+Ii
         ZU/Q==
X-Gm-Message-State: AOAM532wkNH+GXrPtCiSw6ypSrxH6Cv+LimUlzgnmWxgHVoyw/lKDBLz
        I0qey8ubtvdQUuQuvCJ11d4XvGfFvUa6TLkcP+I=
X-Google-Smtp-Source: ABdhPJz6SBK0fakQkr5yMM9BE37jF2mW081LbltnaHzyfMThvB8qfz8YnsM7aYc3mhfzxwBzdeiUFg==
X-Received: by 2002:a05:6512:3b8b:: with SMTP id g11mr490683lfv.397.1644868893591;
        Mon, 14 Feb 2022 12:01:33 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id i18sm4243700lfv.257.2022.02.14.12.01.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 12:01:32 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id w6so3709518ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:01:21 -0800 (PST)
X-Received: by 2002:a2e:a231:: with SMTP id i17mr205093ljm.443.1644868881602;
 Mon, 14 Feb 2022 12:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-5-arnd@kernel.org>
 <YgqLFYqIqkIsNC92@infradead.org> <CAK8P3a1F3JaYaJPy9bSCG1+YV6EN05PE0DbwpD_GT1qRwFSJ-w@mail.gmail.com>
In-Reply-To: <CAK8P3a1F3JaYaJPy9bSCG1+YV6EN05PE0DbwpD_GT1qRwFSJ-w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Feb 2022 12:01:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whq6_Nh3cB3FieP481VcRyCu69X3=wO1yLHGmcZEj69SA@mail.gmail.com>
Message-ID: <CAHk-=whq6_Nh3cB3FieP481VcRyCu69X3=wO1yLHGmcZEj69SA@mail.gmail.com>
Subject: Re: [PATCH 04/14] x86: use more conventional access_ok() definition
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Helge Deller <deller@gmx.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Greentime Hu <green.hu@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Richard Weinberger <richard@nod.at>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 11:46 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> As Al pointed out, they turned out to be necessary on sparc64, but the only
> definitions are on sparc64 and x86, so it's possible that they serve a similar
> purpose here, in which case changing the limit from TASK_SIZE to
> TASK_SIZE_MAX is probably wrong as well.

x86-64 has always(*) used TASK_SIZE_MAX for access_ok(), and the
get_user() assembler implementation does the same.

I think any __range_not_ok() users that use TASK_SIZE are entirely
historical, and should be just fixed.

                 Linus

(*) And by "always" I mean "as far back as I bothered to go". In the
2.6.12 git import, we had

    #define USER_DS          MAKE_MM_SEG(PAGE_OFFSET)

so the user access limit was actually not really TASK_SIZE_MAX at all,
but the beginning of the kernel mapping, which on x86-64 is much much
higher.
