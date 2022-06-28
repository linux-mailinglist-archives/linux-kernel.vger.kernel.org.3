Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFE655C881
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344981AbiF1LTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344678AbiF1LTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:19:38 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76AF2DD7A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:19:36 -0700 (PDT)
Received: from mail-yb1-f175.google.com ([209.85.219.175]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M1YxX-1o3g9F3xoR-0032se for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022
 13:19:35 +0200
Received: by mail-yb1-f175.google.com with SMTP id p136so15448025ybg.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:19:34 -0700 (PDT)
X-Gm-Message-State: AJIora/Kp8cQA41EcruH7lCvZZ9v0K/Yi3bCrOIRF0MjdrBJHh1Ckqah
        gsGQ+gcg/hDJRfQKBzj4lykG8umpULNmuikLRu4=
X-Google-Smtp-Source: AGRyM1uhkOooiDFNPC514SJWx//rgkt+35tUOqAOt1VbBGUV2jW1wsrJtZpO2droMDkfCWDr+wp0TbWz076KcvudEek=
X-Received: by 2002:a25:8b8b:0:b0:669:b37d:f9cd with SMTP id
 j11-20020a258b8b000000b00669b37df9cdmr19090584ybl.394.1656415173804; Tue, 28
 Jun 2022 04:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <YrrQOifFIiISf/3g@hirez.programming.kicks-ass.net>
In-Reply-To: <YrrQOifFIiISf/3g@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Jun 2022 13:19:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2XfzQo6emT4pXXxAjWewdP2LiAe2fOskFf-0suSmBJQQ@mail.gmail.com>
Message-ID: <CAK8P3a2XfzQo6emT4pXXxAjWewdP2LiAe2fOskFf-0suSmBJQQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] kconfig: Add implicit CONFIG_ prefix to IS_ENABLED()
 and co
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, mmarek@suse.cz,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:cBETAGnTRQ/TX1LlyQsKtaaP8J5J3ZIVcTiJQZfaDQA6UJLYG43
 Be0Sqg9X9DLoxA2RhVcKP/WC2kXSTFgXI9Jy66W6XJv7WLXQAU92yaQxuHacNbrlSr9uqOK
 QZ/QcksKabYKbXinIVwWGRq2M+8BWhUtUC/zj5BtHwFxBTWiJ+1gOOypA2uu2NY32fJvCjp
 eRsMqEDKfwkVXIdv4lgQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wXgPbWiIbxc=:CoUUJ6nWbtp9yKa8733xYp
 px4zrjC5tJJdr3WofEM11qmAe9CtucHRNG0ts/aRgubnJD0kyOY9RNwpj4F/hUNZM/qoU7DyB
 rSGX5+mqwztV3IAR3lXTwWgccUjlkUNXdwjpc0yF+vEh5RtBMsAFdVOlLO2Kzh5FPpjq34nVF
 +g7GqiczSahEHpSrQ25YYDj1r0sZRSGm1XyA5tF3SGZ+nAcI77rk9KIX8ZkUYaEWBSJOzlyiv
 HZlgwdcbzsS2zeI0zewgZdxZAl0OAcpp6svjBz7gD/4N5rW3K8H3083T8ZZuA1u9TDzblog6g
 dat/47hPldv+GURMasJCZCGGD0wpIqQIs4dIBE7SvhCdammy7iUrV+l0cT5Lw+T1AXjbekI/O
 n70fh7MalEWwuRoKFaN9IqZCnviXrPCq0LzxaTRCxSbrsGNp56lp+gNAsXeA9XX6iKQ6bBKP0
 K4/U8a+ZbCbzxfjhEi+18XdZoy25xw2ZxGFmsQJ0FFPyAcP+yL4194vUS79k7WafEDdStyMkq
 YJthJCH881rhTAYqMhOh0qWDGAzZBezsDeVuJTtc3xV9QVAdjmKHHrV6O9/pK3NBZ5Qk3ucIO
 Bu4Cdodek8GDIH/4mWirdPH/J+qzKSvazXZy9T95est5NoT75tum0I4pURQfjGMELwVsXR4UZ
 FAZG3wyy79xGLJBohH99QPsiRHMKjC1STVHk81B85NBQMpPmrAjmlvQ+q0qia5VxYcrknEqGV
 to7obyZdbimwJQ7r8gJ+Fd+77M5OFm5RbQcvZA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 11:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Since IS_ENABLED() (and friends) are clearly meant to be used on
> CONFIG_foo symbols and IS_ENABLED(CONFIG_ is so long and almost an
> tautology, allow the more compact usage of: IS_ENABLED(foo).
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I'd prefer to keep the more verbose usage, mainly because it makes it easier
to grep for a symbol. If today you do 'git grep CONFIG_PM_SLEEP', you find
all instances in Makefile, in #ifdef and in IS_ENABLED(), though not the
references in Kconfig language, which leave out the prefix.

If we remove the prefix for IS_ENABLED(), the same grep fails to get
all the results, while searching for the substring without the CONFIG_
prefix can end up finding false-positives by finding longer strings (e.g.
CONFIG_DEBUG_STACKOVERFLOW vs
CONFIG_HAVE_DEBUG_STACKOVERFLOW).

       Arnd
