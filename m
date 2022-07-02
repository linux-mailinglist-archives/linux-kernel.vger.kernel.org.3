Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4113563E0D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 05:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiGBDsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 23:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGBDs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 23:48:29 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4011146B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 20:48:27 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 68so4074861pgb.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 20:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=E+a0fSglUmSzLtUA/HQMDcrrUZQr3oJWl2+1+N37CIA=;
        b=hk8vWE4AyG7nKuc3dM6Y5EKeyQLDxzRuUokPB3LDsBI0HjtaJ0beLxG32bVGxn6Wde
         it+xaLS75T2W5Fuaz7VfpOYznPUWcUXaaynQWGCRXa66+bBQFqulkr+eKbALfJJzuDOL
         COwoIM2uEGUHrCh9Wb5G52dete0Tg5RpVu+PhEMFO8SWA2nwGrL36e/oGhY2bixu+AZa
         0NTnI/5b+NaLJFKWCgbc00vO/YwJbJUZ/7fUGB75NtOCi+NAWF4YU92TrB7EQgUaTTrm
         kKeABTlRaMqCNAOYABKPlOgj2bPUMOJM161MB5+ey86bM90Di49yhW8PmER5V480zxCK
         i6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=E+a0fSglUmSzLtUA/HQMDcrrUZQr3oJWl2+1+N37CIA=;
        b=xflwTvptDzp498rLMDyhGe6sKtbFyh5SmG2T2eEM9XBmRAQb/1NwU9APtaHpcRrJqK
         eNRoC2eQK5BxeewI+pu69d7FaiqR0XlzlTDR8COfn+NgzhepGElEco7WT7ob7E34p/yn
         iA0oPsdlyfFn0LgmCYRYf/46lGmdZ+MjNn1P+WsGDWLx9BvTB+cczUGBf5MYL0PgPZcD
         zXmEyd8WN6WdQIXi1lHruhLibw6bZWCzQIYrUff+ulnIz7sSVELMXL8Dh9MnpBaI9Pi/
         dRqidr7xvjmb7G/AkEdSQKN+nvTohuywXwhEiQ7YkN2HH3ercXQlXUMknnND4QWym2/t
         dnkg==
X-Gm-Message-State: AJIora+Oy/I/0WbBeq4MYN3UqK2hMqXlikiQIs2voTEG/Espr2+xYkdX
        yd1bkuC3JUVDV0XH3VNPFlVzvw==
X-Google-Smtp-Source: AGRyM1s6LX2zewUsQS0u1Pg2MKxq5mpaLSFYqeQj34/Fx24LOwoI2kpeK15nvs314AqUOGWuAHlQXA==
X-Received: by 2002:a63:3e47:0:b0:40c:f2dd:bc4 with SMTP id l68-20020a633e47000000b0040cf2dd0bc4mr14694749pga.47.1656733706454;
        Fri, 01 Jul 2022 20:48:26 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w17-20020aa78591000000b0051b9ac5a377sm16419846pfn.213.2022.07.01.20.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 20:48:25 -0700 (PDT)
Date:   Fri, 01 Jul 2022 20:48:25 -0700 (PDT)
X-Google-Original-Date: Fri, 01 Jul 2022 20:48:22 PDT (-0700)
Subject:     Re: [PATCH v4 0/2] use static key to optimize pgtable_l4_enabled
In-Reply-To: <CAAhSdy0mkwacNMVa_jFZmZ+NRPBa1TpKUQGpzr6Z9_wfoq1R4g@mail.gmail.com>
CC:     jszhang@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, ryabinin.a.a@gmail.com, glider@google.com,
        andreyknvl@gmail.com, dvyukov@google.com,
        vincenzo.frascino@arm.com, alexandre.ghiti@canonical.com,
        Atish Patra <atishp@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     anup@brainfault.org
Message-ID: <mhng-17913c13-57bd-42f9-9136-b4eb9632253c@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jun 2022 21:33:07 PDT (-0700), anup@brainfault.org wrote:
> On Sat, May 21, 2022 at 8:13 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>>
>> The pgtable_l4|[l5]_enabled check sits at hot code path, performance
>> is impacted a lot. Since pgtable_l4|[l5]_enabled isn't changed after
>> boot, so static key can be used to solve the performance issue[1].
>>
>> An unified way static key was introduced in [2], but it only targets
>> riscv isa extension. We dunno whether SV48 and SV57 will be considered
>> as isa extension, so the unified solution isn't used for
>> pgtable_l4[l5]_enabled now.
>>
>> patch1 fixes a NULL pointer deference if static key is used a bit earlier.
>> patch2 uses the static key to optimize pgtable_l4|[l5]_enabled.
>>
>> [1] http://lists.infradead.org/pipermail/linux-riscv/2021-December/011164.html
>> [2] https://lore.kernel.org/linux-riscv/20220517184453.3558-1-jszhang@kernel.org/T/#t
>>
>> Since v3:
>>  - fix W=1 call to undeclared function 'static_branch_likely' error
>>
>> Since v2:
>>  - move the W=1 warning fix to a separate patch
>>  - move the unified way to use static key to a new patch series.
>>
>> Since v1:
>>  - Add a W=1 warning fix
>>  - Fix W=1 error
>>  - Based on v5.18-rcN, since SV57 support is added, so convert
>>    pgtable_l5_enabled as well.
>>
>>
>>
>> Jisheng Zhang (2):
>>   riscv: move sbi_init() earlier before jump_label_init()
>>   riscv: turn pgtable_l4|[l5]_enabled to static key for RV64
>
> I have tested both these patches on QEMU RV64 and RV32.
>
> Tested-by: Anup Patel <anup@brainfault.org>
>
> Thanks,
> Anup

Thanks for testing these.  Unfortunatly they're failing for me under my 
kasan+sparsemem-vmemmap config, which looks like a defconfig with

    CONFIG_KASAN=y
    # CONFIG_FLATMEM_MANUAL is not set
    CONFIG_SPARSEMEM_MANUAL=y
    CONFIG_SPARSEMEM=y
    # CONFIG_SPARSEMEM_VMEMMAP is not set

Nothing's really jumping out and I'm not sure that's a super compelling 
configuration, but IIRC it's found a handful of issues before so I'm not 
sure it's sane to just toss it.

I've put this all on the riscv-pgtable_static_key branch of 
kernel.org/palmer/linux .  If nobody has the time to look then I'll try 
and give it another shot, but I'm pretty buried right now so happy to 
have the help.

>
>>
>>  arch/riscv/include/asm/pgalloc.h    | 16 ++++----
>>  arch/riscv/include/asm/pgtable-32.h |  3 ++
>>  arch/riscv/include/asm/pgtable-64.h | 60 ++++++++++++++++++---------
>>  arch/riscv/include/asm/pgtable.h    |  5 +--
>>  arch/riscv/kernel/cpu.c             |  4 +-
>>  arch/riscv/kernel/setup.c           |  2 +-
>>  arch/riscv/mm/init.c                | 64 ++++++++++++++++++-----------
>>  arch/riscv/mm/kasan_init.c          | 16 ++++----
>>  8 files changed, 104 insertions(+), 66 deletions(-)
>>
>> --
>> 2.34.1
>>
