Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8E557E6E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbiGVS6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbiGVS6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:58:01 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4D1904D8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:58:00 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m8so6887624edd.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CFtWv8cujsml9Nm915ayXL51uD/obgxi8OyaZQUdDOE=;
        b=EoUYvGEmiLqZvCHAadV8xm3zldGQR/AXQXlplxHKyoH+GrNylYMUcu/cP++VqO2kQj
         Jn6jLRt8ddpSkCTTFV05lNnMWPFZbYpaE1l9/iaVHhsqS04FE30XEhi5KRPIpzUecWk7
         ln4SJtufGrukvBkolkbObTwkHMbWnl355APQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CFtWv8cujsml9Nm915ayXL51uD/obgxi8OyaZQUdDOE=;
        b=K2hRjbfL9ldUW7/jCYgSOpKJVsrpNmJaERl/3wNl/1Y3RTpahZbMqG/LPTZk4FNbHg
         tvVcpZ2/OP5/LObLa4jxjwUPNp3UzjIp6YTDZXwGqbh6zuQq7muSi1Pxxj3iAO97jLT9
         Ea+qXD0+zjQA6/HErf/t5ZKlhOQAzuQ9MjJ73lvmy+qNQyGuahldh1uBh9elIodxSBcz
         HS/xU/pYtiPO1G35qEyxTj7ymgu+xOWkSalr2pkQr+WthMTYVeFvKmJF97Xslmh/8u6x
         oIyATpg0R0fYMeXfNIXLKTTiWZaKOFilk4Wn5+kMKG7uSmVUN0wxUi/DKN0Rler71meQ
         X1Yw==
X-Gm-Message-State: AJIora/6AeZ9TtzvrHkPHQSCXRhWYeuTajioJFsccAKomOmS+iC7/Ijn
        5XJNCKuAiJH5F/J25s5Hp3S8oLUNlPwZSB/g
X-Google-Smtp-Source: AGRyM1sME3hRO/2VTA0BAyIHR2wRYbfLC5kbuypmAO2IYlwZmrm3qaYBZSOxJhEXwylMWSEaCeC8dw==
X-Received: by 2002:a05:6402:84a:b0:423:fe99:8c53 with SMTP id b10-20020a056402084a00b00423fe998c53mr1260221edz.195.1658516278832;
        Fri, 22 Jul 2022 11:57:58 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709066a8400b0070f7d1c5a18sm2286732ejr.55.2022.07.22.11.57.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 11:57:57 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id d8so7668858wrp.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:57:57 -0700 (PDT)
X-Received: by 2002:a05:6000:1049:b0:21e:584f:3574 with SMTP id
 c9-20020a056000104900b0021e584f3574mr838736wrx.274.1658516276828; Fri, 22 Jul
 2022 11:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <YtpXh0QHWwaEWVAY@debian> <CAHk-=wipavrPuNPqiZ_zMP8EdbLKnnTkFukVCWm8FmCTUth4gQ@mail.gmail.com>
 <CADVatmPkXQ3mJpdTvaHxN4qmacYBhvzz=nxduQn-y+QUz4Pu2Q@mail.gmail.com>
In-Reply-To: <CADVatmPkXQ3mJpdTvaHxN4qmacYBhvzz=nxduQn-y+QUz4Pu2Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Jul 2022 11:57:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjFd-2j1qCsqdsakwcH=QML2BJBCpN2+rg10Y+PMGOOg@mail.gmail.com>
Message-ID: <CAHk-=whjFd-2j1qCsqdsakwcH=QML2BJBCpN2+rg10Y+PMGOOg@mail.gmail.com>
Subject: Re: mainline build failure due to b67fbebd4cf9 ("mmu_gather: Force
 tlb-flush VM_PFNMAP vmas")
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 10:20 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> That fixes the alpha build failure.
> If you commit it today then my nightly builds can test other
> combinations of all other arch also.

Thanks.

It's commit 7fb5e5083190 ("mmu_gather: fix the
CONFIG_MMU_GATHER_NO_RANGE case") in my tree now.

I decided to not amend the commit, so it doesn't have your tested-by,
only your reported-by, but I put the link your report (this thread),
so it's kind of there.

                   Linus
