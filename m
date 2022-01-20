Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75643494B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359667AbiATJzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:55:10 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:57323 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiATJzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:55:09 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MYvTy-1moVHW2eSO-00UoWY; Thu, 20 Jan 2022 10:55:06 +0100
Received: by mail-wm1-f45.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so6510904wmb.1;
        Thu, 20 Jan 2022 01:55:06 -0800 (PST)
X-Gm-Message-State: AOAM533xnQaFQL7Fx8lrjkhk+jLGMH/6OOq675trPeMS9NuNO3/zP9Zv
        /OCf0BFriz+p72xzpnVDLv0DovLP2WJBYo5IITQ=
X-Google-Smtp-Source: ABdhPJxuH3ieTJMrWvtM18t+kt/eQKxNsX0S1JRfafUu0rov1od6UeEmq8/soY26aK2ZvAh1u2FgbOu1pscCT0xGmKw=
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr8086318wmj.82.1642671086465;
 Thu, 20 Jan 2022 01:31:26 -0800 (PST)
MIME-Version: 1.0
References: <20220120073911.99857-8-guoren@kernel.org>
In-Reply-To: <20220120073911.99857-8-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 Jan 2022 10:31:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1UvqsS-D7cVXBkp4KCRWDfquQ6QTkvrQ=FqLxhsAi7Rw@mail.gmail.com>
Message-ID: <CAK8P3a1UvqsS-D7cVXBkp4KCRWDfquQ6QTkvrQ=FqLxhsAi7Rw@mail.gmail.com>
Subject: Re: [PATCH V3 07/17] riscv: compat: Re-implement TASK_SIZE for COMPAT_32BIT
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        inux-parisc@vger.kernel.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xTBun3ZXxnLifiuOxxDufMcjML4rD9/1P/VhGe2XRM6qFE6b8Ac
 7p6cMbtbwHVRMZ8MEmdqJFUPmNo9pWAgN2OC+YQKB/aCY2hF2pPZqtYfpXT97nUAAY+4WqP
 dxEHxNI1S9yKSh16dPEji4y+dWChqEIM2xxlibEmh7tQAzHtpD76+1R7qDZOFQcZ+T9IipA
 tjD8PJ3zLMCyGrVEUODiA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4sDz69w6jkA=:gWaTpMg+mdUCqDBMa3M/q0
 k+aAL9D3GP0uqJfok98tMYLsQg95/nFhCEZL5xdhcRcpNBaUqz6ujo4SG+8eyzaC8hDdaU9eA
 bc8Bb5x3otTSrevVd35HtXc6yoLHZx2KEQA0tuhJcIMKFznwbwBlw7U+vIIu5ROa7LIVoOsuH
 o5CjYjEApeMWl+JUv/QrpyeTcFlINsPkfUW8/4Zttfs3/OKSHGC6A1up+VKkLtVhhTZp9tuAU
 v6ZnkX5mu4b9D3SyekT561XTRaZEOvCobeTYlIjDfW6NQqcnOAmW1nSK121SkqeTgIgwf48vy
 NKRM7yFmN6U0hR7bosJA0XWKiwwxFtpgb0lo1ItaP6gxOrvH+3GbLLhx6cDc2mhunwHvMpzZC
 cb46KmNSqBQ/KMdPkoT5FNhSjK+gnfB3X66QxBudzqc4N7XAMv1cirzFJ9oJ5lNaTQJpq6S6L
 jrrvjEWWPPP2+4JxAumtzwwJSHdlQ2MrlNRWncV6gkFFQsBZe7XlNw2OuefrL3xhqneiZGUK/
 gjL+e+ZYNXoEADEu23N3p6R3rmdSbpClCjNnW7IQH6oj6dS3/KrUyo2DRs63DDvKRFJczoIze
 wwtRvqVwIQAC7VN6PEQEN32uDZ/tUHe60EffNgwtjy4OoE1qBSpcE3ZTWo8u/wxkOoNW5lAHf
 +NU3sBZRsZHsjDtIZ5uc8A9R1ayfqh0zs2dfV2INuF81wRibNpGDsIcEomVNlgAk0RDybYlGL
 6hln/osiMXMwIoBrOCAr7p1VAq2nkPXwqdVqszpMRiLN11gNvLAQE6lZlIVMEjJiyLIbKS1cQ
 M7NuG42zhvW/+DgY9nxdIs9dE6dUcQ6lLur2e+0q6mL+4Ucp2Bf0hM+NfmhSJwpLquPebXN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 8:39 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Make TASK_SIZE from const to dynamic detect TIF_32BIT flag
> function. Refer to arm64 to implement DEFAULT_MAP_WINDOW_64 for
> efi-stub.
>
> Limit 32-bit compatible process in 0-2GB virtual address range
> (which is enough for real scenarios), because it could avoid
> address sign extend problem when 32-bit enter 64-bit and ease
> software design.
>
> The standard 32-bit TASK_SIZE is 0x9dc00000:FIXADDR_START, and
> compared to a compatible 32-bit, it increases 476MB for the
> application's virtual address.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
