Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CED4AF490
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbiBIO6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbiBIO6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:58:06 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CFFC0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 06:58:09 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id v186so6764949ybg.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 06:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ECpUMaTdm+yyS+IRsgx6JK+2PJOAWfEZbqpS8KRUZVM=;
        b=HtziXKNwy97T5nE4WySc3JUaj9CPpnWW5FC5nbT/LagHDXn71TVCpQ4AS2gUP0TTbO
         0pF5q+D+Cdr+w69NbcO9hAMYvbTDBmXooJN6jICUEcfd2fjNPhg3jr/Rnp0c3+CSV/l1
         vBfoGUMqkinuBVs3wgp44GH+BE6Qm/r63QstwFYosJR8ivZBa4UI1nwStTkGYZLUmHW1
         LKgIgIAhr5n4grPxJaztFFvrqjIAiW1p/LxmHBNIvz/Ffo22R0kCpRx4LBHRxP+AsXqE
         DG3opXXZKhg5P9yNB+RRXwDsUvg1cR75gRgbMAI0YejwfBwWcLG+/dsrAw+SABPIBWrn
         A7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ECpUMaTdm+yyS+IRsgx6JK+2PJOAWfEZbqpS8KRUZVM=;
        b=dSr28ybkS5Gcch/c24DVSrBD6YnCtN+IDaY010uqbKLhCVA8KxumANHbUS9iy0hmZf
         FEtYciif0UWrXZqfEoRX8+kkgZX77BzrsOKFgTa0pB5RuTjGeDgR11InWRe/LvW+LTs6
         R8PQI4YRKRQRf8JlenBoahMUG76Qw1ADJS1eeVnr/fYld/HeO5wlOvBEnGpdMmYLq1Ia
         mgIXmkAufAyvabhYq/bx8l1j+G/4bIWpY9TffD9O4uRkXYcJd9yBsiLYcQd4LxbtHekW
         MPkj9Mr5yoEYp+aCl8kpzkOxGcNKZSRd2NVG0S+bWKfd23sfzb7ms56uVoPM219HBSmG
         kIWQ==
X-Gm-Message-State: AOAM531DwNXe6NT7F0zejGrjsw74bcfBb1s3brm5uVemwmswtPSThKjU
        u1sMDzPrVopaZ2Q13bD5265R5/I7ODn4hg/LATPoE4Lvc8UxsQ==
X-Google-Smtp-Source: ABdhPJx6k/2CaivTOLnv01Uwjtg/gSghQiwECY/vFRnpXknpD8tKFEXHMvirvryWKGLl396E5KSyDbgKusErY0jh9FY=
X-Received: by 2002:a25:6b45:: with SMTP id o5mr2446049ybm.704.1644418687758;
 Wed, 09 Feb 2022 06:58:07 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Feb 2022 20:27:56 +0530
Message-ID: <CA+G9fYv_ssRhvYi4mM1ZeGCL2meFwRsakpADp_Cz3bNDZz2zSA@mail.gmail.com>
Subject: Re: mm/munlock: mlock_page() munlock_page() batch by pagevec
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org
Cc:     Hugh Dickins <hughd@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following build regression noticed while building Linux next 20220209
arm/riscv/sh of allnoconfig and tinyconfig builds failed with gcc-10,
gcc-11 and clang-13.

clang: warning: argument unused during compilation: '-march=armv7-m'
[-Wunused-command-line-argument]
mm/swap.c:637:2: error: implicit declaration of function
'mlock_page_drain' [-Werror,-Wimplicit-function-declaration]
        mlock_page_drain(cpu);
        ^
1 error generated.
make[2]: *** [scripts/Makefile.build:289: mm/swap.o] Error 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
