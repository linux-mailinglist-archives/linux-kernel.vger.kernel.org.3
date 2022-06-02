Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E826453B32B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 07:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiFBF5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 01:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiFBF50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 01:57:26 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2321CB02
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 22:57:24 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id s12so3717799plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 22:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=rtSAfXv93YAiiHV0sWw5VQFhHGbge7rpQR/Jq2+le+A=;
        b=L3dN8bpTjYGHxIQGNCFp5vkGe6DEd129vWFFNvXkztPl9NA0+UQP7DC4bxloOfDaEs
         SLXTD8ZHKa1i+tq1gBO22B+gtFmwcSC5dbBo6Jnaomdl1vP2Xhsn4xaMXdkRTypkVgTW
         5DpqbNJQGJF69YXACNKNOY3Skk0wPRPb5z+reiVbRTdSsW+vAlhfOTOlZMqGLOn5/JiG
         m3ql81nKrnkbCW2HdftG8QtMoGiCRRipXulgSb7VRv5rIIv/0eOrn/772S20pjFBlv8T
         oyHYOf1gJkOOuGUb4OAEbdudYkLCm1DonOLicWQ5mVflW79+XN8uyCXqqO4CftN8vlDZ
         NckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=rtSAfXv93YAiiHV0sWw5VQFhHGbge7rpQR/Jq2+le+A=;
        b=qoVhjvALnh8FTZogcQNK4liBMoS2G8kONXgOkxnU1ub+Fg7Tjm/i2emsKdNq9QKAtj
         zvGSZ/mfVxBobvlhlSfIFmrs0oFbL6Wf04w1j0Wh7LvbOyOefxMLsMq4RdPf3cDdgePh
         ZmMYhhNx0RKSggDxPrh39/7ivY4DFtMBHC8WNxRB/PeOjzzhWEkWLUxpj/Tnlt/geHar
         +CfzRFDj3Dnzdgfu5rH6EaZ3IGqU4ChNJFfxJfoza5wDU1yGGd+Wi9tH2P4y4Dspft8k
         XDQypRqhG7hcnEarcsXnsarxdPX4yel1VuPvUVDW7hwoCP0DJGWM/nke/I0w75MwCjh7
         3bDA==
X-Gm-Message-State: AOAM5314AfzYNWjanrr7d3fn3jL+NP6nkahurmXyn9HAu5APGgSR+mWx
        clzdAN7TQAwVwhKR9xi9z7ne+w==
X-Google-Smtp-Source: ABdhPJwjQZkpLbffvjZwQnZtMS49tNZbp/lMIOvZYRNMfACTTu7YqLJJJxS4yqNvV1+hh8zoEqPg7A==
X-Received: by 2002:a17:90b:4b0c:b0:1e0:96b:c3fe with SMTP id lx12-20020a17090b4b0c00b001e0096bc3femr38350620pjb.212.1654149443517;
        Wed, 01 Jun 2022 22:57:23 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id h69-20020a628348000000b0050dc7628138sm2619315pfe.18.2022.06.01.22.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 22:57:22 -0700 (PDT)
Date:   Wed, 01 Jun 2022 22:57:22 -0700 (PDT)
X-Google-Original-Date: Wed, 01 Jun 2022 22:09:03 PDT (-0700)
Subject:     Re: [PATCH v3] RISC-V: Mark IORESOURCE_EXCLUSIVE for reserved mem instead of IORESOURCE_BUSY
In-Reply-To: <CAJF2gTRZCchLk9apNQagNmsNb3Pv+WfPTisrsWDDrQyVncUYeA@mail.gmail.com>
CC:     mick@ics.forth.gr, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        rppt@kernel.org, david@redhat.com, wangborong@cdjrlc.com,
        twd2.me@gmail.com, seanjc@google.com, alex@ghiti.fr,
        petr.pavlu@suse.com, Atish Patra <atishp@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        jianghuaming.jhm@alibaba-inc.com, heiko@sntech.de,
        xianting.tian@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     guoren@kernel.org
Message-ID: <mhng-d1f0bf41-82a3-4e76-98a0-c787ebcd0799@palmer-ri-x1c9>
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

On Sun, 29 May 2022 19:47:51 PDT (-0700), guoren@kernel.org wrote:
> Hi Palmer,
>
> Please have a look at this patch which is a critical fixup. Our
> current riscv implementation has broken the reserved memory.

Putting "fix" somewhere in the subject is generally the best way to do 
that, this one just looked like a feature and I stumbled into it when 
going through stuff for this merge window.

It's in for-next, which is still aimed at 5.19.

Thanks!

>
> On Wed, May 18, 2022 at 9:34 AM Xianting Tian
> <xianting.tian@linux.alibaba.com> wrote:
>>
>> Commit 00ab027a3b82 ("RISC-V: Add kernel image sections to the resource tree")
>> marked IORESOURCE_BUSY for reserved memory, which caused resource map
>> failed in subsequent operations of related driver, so remove the
>> IORESOURCE_BUSY flag. In order to prohibit userland mapping reserved
>> memory, mark IORESOURCE_EXCLUSIVE for it.
>>
>> The code to reproduce the issue,
>> dts:
>>         mem0: memory@a0000000 {
>>                 reg = <0x0 0xa0000000 0 0x1000000>;
>>                 no-map;
>>         };
>>
>>         &test {
>>                 status = "okay";
>>                 memory-region = <&mem0>;
>>         };
>>
>> code:
>>         np = of_parse_phandle(pdev->dev.of_node, "memory-region", 0);
>>         ret = of_address_to_resource(np, 0, &r);
>>         base = devm_ioremap_resource(&pdev->dev, &r);
>>         // base = -EBUSY
>>
>> Fixes: 00ab027a3b82 ("RISC-V: Add kernel image sections to the resource tree")
>> Reported-by: Huaming Jiang <jianghuaming.jhm@alibaba-inc.com>
>> Reviewed-by: Guo Ren <guoren@kernel.org>
>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>> Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>> ---
>> Changes from v2:
>> - Fix typo in commit message: casued -> caused
>> - Remove Reviewed-by of Nick Kossifidis, who didn't give Reviewed-by actually
>> - Add Co-developed-by of Nick
>>
>> Changes from v1:
>> - Mark reserved memory as IORESOURCE_EXCLUSIVE, suggested by Nick
>> ---
>>  arch/riscv/kernel/setup.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index 834eb652a7b9..e0a00739bd13 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -189,7 +189,7 @@ static void __init init_resources(void)
>>                 res = &mem_res[res_idx--];
>>
>>                 res->name = "Reserved";
>> -               res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>> +               res->flags = IORESOURCE_MEM | IORESOURCE_EXCLUSIVE;
>>                 res->start = __pfn_to_phys(memblock_region_reserved_base_pfn(region));
>>                 res->end = __pfn_to_phys(memblock_region_reserved_end_pfn(region)) - 1;
>>
>> @@ -214,7 +214,7 @@ static void __init init_resources(void)
>>
>>                 if (unlikely(memblock_is_nomap(region))) {
>>                         res->name = "Reserved";
>> -                       res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>> +                       res->flags = IORESOURCE_MEM | IORESOURCE_EXCLUSIVE;
>>                 } else {
>>                         res->name = "System RAM";
>>                         res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>> --
>> 2.17.1
>>
