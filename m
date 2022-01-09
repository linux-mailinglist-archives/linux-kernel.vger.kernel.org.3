Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F71488B72
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbiAIRtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiAIRtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:49:08 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E96C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 09:49:08 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so19674367pjf.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 09:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=xsoAWNosIdPVJ1Fl9G5Tr80hXNfNjq7TugQVBy3FAk0=;
        b=oB5Sz94wLdR3j1q+l51Yresn0Y1jPQCTUvZzCkBx8kTi0BXQIaHv1dQCgnpM6FUhah
         cIbTMO4JJZyxU+ZPTAR3b2K5a1uRM+nG41E+pHWWFWAKnFZedM3ZvpPHeIdg7N5+GZAu
         yJM+tOEtuQ+HqNqFz7gAUdNfnS4hZBYR9nT6dnuTbFcU0jFW8HT8Gewi1SAFzkgQESz6
         GnGbP5o1zd6rN2qjM4BXIiq5U81ffSH1zsXdYGkzw0duZo6VzgahPpMfMTtpdbyNiMug
         X40PqNh0hSsRryVBLZbSbRZWvYgAxS2dGfdjIcA3Nb6ICHP2l41XspelCIPKb2wvEqnR
         VYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=xsoAWNosIdPVJ1Fl9G5Tr80hXNfNjq7TugQVBy3FAk0=;
        b=V4rfyrtuxAJ9qO3SlqI3zyiLG8Rzszpt6Yt2hfX63C4uMejUOu0UNM2OflGcz6Q7oV
         uUgL/S+fe+0NJuHCvPq7BOVMkGx7QeGYzOmDXmBgwSK49hjabYSB5g50+akCVKcZ72F3
         eShLHTMw/U6gq9zPtLMJ3cTw40iuZk/Gf9uejMa5dUwcuDH8LnWel/IEBCw1uE/9b8QG
         lvVBrPnZo0KfNXj5pp62C6ZX8MDoqHh+b2YQ1c+Huh2eaAD4rXwzqwdeqdOvYimxOqnc
         8C4+3m6BdcSLeTS21wQuhaDgAsw1b4LGhXcjWNWfq5Hhf3/CjG5DWHauGFU6jg67fE0P
         jggA==
X-Gm-Message-State: AOAM5319zNh0QMyMdVivAclyuHNb7VPawpT5DO7uNwqX3vmZB3mM99KY
        kx5SHrnL+ffrtWExHol/5MMhsg==
X-Google-Smtp-Source: ABdhPJzLR2V3yUS3diDRA3uXEy46KKw/VEQ1VoyJDxcEBGTsI1UFlJLGwKJ/AmQ1aXC3HVOqqwc+Yw==
X-Received: by 2002:a17:90b:4b8d:: with SMTP id lr13mr26715780pjb.0.1641750547751;
        Sun, 09 Jan 2022 09:49:07 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 20sm507953pge.68.2022.01.09.09.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 09:49:07 -0800 (PST)
Date:   Sun, 09 Jan 2022 09:49:07 -0800 (PST)
X-Google-Original-Date: Sun, 09 Jan 2022 09:48:38 PST (-0800)
Subject:     Re: [PATCH -next 0/2] riscv/mm: Enable THP migration
In-Reply-To: <3c9ba160-74b2-a933-e8e5-9fd5359dc2cc@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        palmerdabbelt@google.com, wangkefeng.wang@huawei.com,
        anup@brainfault.org, alex@ghiti.fr, jszhang@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     sunnanyong@huawei.com
Message-ID: <mhng-518b6eb2-d3e2-4ff8-b960-f0598473152c@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2021 22:45:57 PST (-0800), sunnanyong@huawei.com wrote:
> Hi Palmer,
>
> This patchset has been sent for one month ago, I was wondering if you could
>
> have a review and give a feedback please, thanks.

Sorry for being slow, the queue got long over the holidays and I'm still 
trying to dig out.  I was kind of worried about losing some bits, but I 
don't think it's actually that big of a deal -- it's not like there's 
really any user ABI here, aside from being able to use less swap.  If 
someone wants to fix that I'm all ears, but I don't think it's worth 
waiting.

This is on for-next.

Thanks!

> On 2021/11/23 22:06, Nanyong Sun wrote:
>> This series enables THP migration on riscv via ARCH_ENABLE_THP_MIGRATION.
>> But first this adjusts PAGE_PROT_NONE to satisfy generic memory semantics
>> like the behavior of pmd_present() and pmd_trans_huge() when in
>> THP splitting or migration.
>>
>> This feature can reduce the time of THP migration by not splits THP
>> before migration and can guarantee the pages after migration are still
>> contiguous.[1]
>>
>> I have tested the below test case on qemu based on riscv after
>> enabling this feature, the throughput of THP migration gains 13x
>> performance improvement:
>> https://github.com/x-y-z/thp-migration-bench
>>
>> I also have tested and passed the test cases under
>> tools/testing/selftests/vm.
>>
>> [1]: https://lwn.net/Articles/723764/
>>
>> Nanyong Sun (2):
>>    riscv/mm: Adjust PAGE_PROT_NONE to comply with THP semantics
>>    riscv/mm: Enable THP migration
>>
>>   arch/riscv/Kconfig                    |  1 +
>>   arch/riscv/include/asm/pgtable-bits.h |  2 +-
>>   arch/riscv/include/asm/pgtable.h      | 16 +++++++++++-----
>>   3 files changed, 13 insertions(+), 6 deletions(-)
>>
