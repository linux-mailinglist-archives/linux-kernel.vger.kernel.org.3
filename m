Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099DF536BE9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 11:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiE1J0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 05:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiE1J0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 05:26:37 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7B4273E
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 02:26:33 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 975C43F7F6
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 09:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653729991;
        bh=51HZ/ZF/DBZUi+hYAZR96Rw1JBH9NEA5/WPL/bsRkcs=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=PjRpaU37gizYPwysg6ZSC1IqCUDHQYN0F2kj6DgY+j73+SaykqM6mgVCdWuByQs+5
         ptFYa1JPHQbvy+v+PvGJT3w/AbJOzjxALha+WHtdwjY8wkXqnv/++oKIY/xLA2Sawk
         ma7kPiHQLAzstktNCuzPQwivLGL3x0q3WM3wC53za1p7fhjXQteSjSM97gvVP15LUz
         3/LE+JgoyeFrrZt5HYbbbCf1Jhmd6sw+qTLe/M23u1PJwTssJdcE+1LpusbRul/Mon
         gzkyGyXZyp2RCmZ3DJSHn0VuAb2YNzwQ7hWQk6FEaj0av8zLI13Vg537oqtWR6XiJ1
         zQLqc/Q4cDfOQ==
Received: by mail-ed1-f72.google.com with SMTP id v1-20020a056402348100b0042b4442b954so4538968edc.22
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 02:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=51HZ/ZF/DBZUi+hYAZR96Rw1JBH9NEA5/WPL/bsRkcs=;
        b=p6UJ0mTrmZTWUEphqxAeQy6pWwcyd1a1pHHWlyVlFpVXi2dzwIJZUYs5E+lE7kSgRl
         s7Zx4J6RSPNr2ecJE9AlARGBaHHCtEgYi6Mr71EslIJyEhFmKwbf22FA5D648HjSfGsv
         SGSQaXYcUGOY8AKWQ1aAidDmu9Qca2KdGXVj4uHfNHQzuPWu0n2ZlZjlml6bgFDdjwuu
         /yJwnUmHK9cnz5Qx/3b66EUkPMVpFy/wrcpTlPoY+vuYHbbpMa5eNQmplQjdcuqSYdBQ
         SBJ+LDXspg3sisp1zUX57/SWJbv7IbyzpC+ZPmMiqcivfvgT2KB/C4wcZvQbxIzoD5q8
         Rw3Q==
X-Gm-Message-State: AOAM530JYA6O/uyjjTz/ERPv6osEPVUBpT+wCh6BrukrJSoLcJGmlNqh
        EZx8YnaMJn9GrFMT3VeTCrvRNWfQA1lJO/s6FNYBz2P9VQotWX2K6VuGSEmN2avIB2skQVMZa3Y
        cKPmRZW1HJdnODXxavIN384ROSOSyatrnWilWJ8obrA==
X-Received: by 2002:a17:907:6e12:b0:6fe:c2fd:89b7 with SMTP id sd18-20020a1709076e1200b006fec2fd89b7mr28883574ejc.581.1653729991239;
        Sat, 28 May 2022 02:26:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTIoHfWrOT9U2e85CFhK4imRJ1Ycox2VrkT/sTmCYMzAKvkrW+16CaVVHurj+g2SGaWKw6qQ==
X-Received: by 2002:a17:907:6e12:b0:6fe:c2fd:89b7 with SMTP id sd18-20020a1709076e1200b006fec2fd89b7mr28883553ejc.581.1653729990956;
        Sat, 28 May 2022 02:26:30 -0700 (PDT)
Received: from [192.168.123.94] (ip-062-143-094-109.um16.pools.vodafone-ip.de. [62.143.94.109])
        by smtp.gmail.com with ESMTPSA id w24-20020a50d798000000b0042db87b5ff4sm607240edi.88.2022.05.28.02.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 02:26:30 -0700 (PDT)
Message-ID: <7b93efe6-fb54-d6f8-dd3b-3fb260652f15@canonical.com>
Date:   Sat, 28 May 2022 11:26:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] riscv: read-only pages should not be writable
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
References: <20220528014132.91052-1-heinrich.schuchardt@canonical.com>
 <CAMj1kXGmwwD==yOnzfYgPg8Bpz1POK7aPBULcuMdgS-E1G2EAw@mail.gmail.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAMj1kXGmwwD==yOnzfYgPg8Bpz1POK7aPBULcuMdgS-E1G2EAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/22 11:13, Ard Biesheuvel wrote:
> On Sat, 28 May 2022 at 03:41, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> If EFI pages are marked as read-only,
>> we should remove the _PAGE_WRITE flag.
>>
>> The current code overwrites an unused value.
>>
>> Fixes: b91540d52a08b ("RISC-V: Add EFI runtime services")
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   arch/riscv/kernel/efi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/efi.c b/arch/riscv/kernel/efi.c
>> index 024159298231..1aa540350abd 100644
>> --- a/arch/riscv/kernel/efi.c
>> +++ b/arch/riscv/kernel/efi.c
>> @@ -65,7 +65,7 @@ static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
>>
>>          if (md->attribute & EFI_MEMORY_RO) {
>>                  val = pte_val(pte) & ~_PAGE_WRITE;
>> -               val = pte_val(pte) | _PAGE_READ;
>> +               val |= _PAGE_READ;
>>                  pte = __pte(val);
>>          }
>>          if (md->attribute & EFI_MEMORY_XP) {
>> --
>> 2.36.1
>>
> 
> Thanks Heinrich
> 
> Queued in efi/urgent.

I guess this should also be down-ported to 5.15 and 5.10.

Best regards

Heinrich
