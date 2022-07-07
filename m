Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779CB56A490
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbiGGNzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbiGGNyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:54:45 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5121F2D7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:53:40 -0700 (PDT)
Received: from mail-yb1-f179.google.com ([209.85.219.179]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MMGVE-1nq8723M8M-00JHeC for <linux-kernel@vger.kernel.org>; Thu, 07 Jul
 2022 15:53:39 +0200
Received: by mail-yb1-f179.google.com with SMTP id 136so823431ybl.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 06:53:38 -0700 (PDT)
X-Gm-Message-State: AJIora/qoPvE9nZ6+tXB4Ns8f6BF0Fw14Vzyxti4RV17E66bY8YgO9ea
        2NGrYK/lhmhx/aTYgN19f+wnV1A6J5jUAo384Bo=
X-Google-Smtp-Source: AGRyM1uyrtkaitsboSJKUbvp50ZN1zEnVuGSaYUBI8C7M6v+5JV6H4jcqrJExy3FRjZcmavKzjZkMz8lGYtlx7xd/QA=
X-Received: by 2002:a25:9f87:0:b0:669:4345:a8c0 with SMTP id
 u7-20020a259f87000000b006694345a8c0mr50084657ybq.472.1657202017703; Thu, 07
 Jul 2022 06:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220707110511.52129-1-zhengqi.arch@bytedance.com>
 <20220707110511.52129-2-zhengqi.arch@bytedance.com> <CAK8P3a0h1rFot013raf+O49pvV0JtyBX4Hwp3dt_85jzsJv3ww@mail.gmail.com>
 <6802d78e-5aeb-6115-a4ec-73be78ccc577@bytedance.com>
In-Reply-To: <6802d78e-5aeb-6115-a4ec-73be78ccc577@bytedance.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Jul 2022 15:53:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2D1KXY_a952Aw_7hH+yzYpqQaBA5LkmkfF6EwiLUgNSA@mail.gmail.com>
Message-ID: <CAK8P3a2D1KXY_a952Aw_7hH+yzYpqQaBA5LkmkfF6EwiLUgNSA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] arm64: run softirqs on the per-CPU IRQ stack
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mYLSqv37lAohkoYfj7I4OBsKwf9qAJbjkl7ga1RSp1+ikbC6TKD
 0vmAMLhRWo6zeTTLIdQSn7Qt4/novff98lVqk4LttE6TNLnKxS3VZBEtOzI3eNcazwxTjCJ
 VhCtC0wZshUawC5nKgycfmYKDOGp8HsBHGTt+52bB3mGC01QDo2/Q7aZrcQnc2ZcrZzIhWa
 PREqzOoNOqXpyFCsTFDzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mms3mT1LfG0=:sQYcX5fthQ2mFPgJ/VvFTs
 Vf3woi6ebbQ8+eVv6VYdBzLTaIFweU6qUsB8uQBm1DFMD2eENb2BV0SA9rFbI5c1kuuOT9UG0
 oaEJ7k6uGI9eRunbm1VMjv+Filsao+U8QIcbKF6EESHSOLgox95uvCpnAZohVP4A1SKuXAB37
 KGDsYTl9QeUIfHofbW0kkvtXmvMJ7Slyr/9eg+h755t1s5asVxgmEfXTlgbSpm7zeDtQhSYHH
 D+6M+C7yS6tUOy6+yb5/yX4uwuvZ0WFk+nL2zhvSqsFqeodYwcCbc6Z6fxV7MZnP+5OoUJNvp
 T7xJ72IBjcKUxwuAJUV8S2wFoQ7E2/6n/lJr+lMrgSosZ2YEZc/+G6H6vUXfe92cyxtKbA7Jp
 6ujf1NvH4EcVxpjT0U+u3ctEoMEdBDIiQzUw1o6VuIvdZG662RZV1ZDokAf4pMtCTd4z40dku
 RsLeu39DAyAyDK9lJ3pwmVS2sVYn+N/vrc0fuBUsanVIA9sQxaYr0G1TeHFALwo2Xm0m7r9di
 i/PSmkLs4xVM/cOy3UIF8l5ompNIftiHs5uSzuopI63q4SbMF0V7SmHiPzvdkddVc6GVwqiyg
 eM17MiplPNNAHYQ2TCA70lsve1+tTNKOUeOGdvbdZSiMqOTkV87PJI1DMkRv7741V/lEAgG9y
 CYI4tJ0inAfK6DXc90KLiWEZqVQO8SgRb4itfbpSksWjS4xLclQdAiicrxCVZGjp/GLsG/zGg
 U3V+GiA4FY7DOE0zOEmm9R9WmH9PiOpwGeiWUWbIo3j0mvKhICclYBJLTqj4yBVKt+vh23lrS
 ercoyBo91HepyHYTiM2S+whSsKB8deY6IchSA4+k6aAx+WgDg3VoZRfL0swQ0VIJ8axmbqtRV
 vykLYfMJI5DcuVodDcdA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 3:43 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> On 2022/7/7 20:58, Arnd Bergmann wrote:
> > On Thu, Jul 7, 2022 at 1:05 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> > Are there any architectures left that use IRQ stacks but don't
> > set HAVE_SOFTIRQ_ON_OWN_STACK? If not, we could
> > also consider removing the Kconfig symbol and just requiring
> > it to be done this way (for non-PREEMPT_RT).
>
> I haven't taken a close look at other architectures than x86 and arm,
> but I think it's a good idea.

I had another look in the meantime, and I think it's only mips and loongarch
now that don't use HAVE_SOFTIRQ_ON_OWN_STACK. Not sure about
arch/um/, which is a bit different from the rest.

       Arnd
