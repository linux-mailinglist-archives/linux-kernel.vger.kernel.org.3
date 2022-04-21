Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E92150AA81
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441823AbiDUVPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245344AbiDUVPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:15:41 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68D349244
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:12:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id h12so2803438plf.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Av/ziOvsBe24F2oAdgKNQqRde9/UDT0IRqk3LqZYlqs=;
        b=S6Q8xGgqM2kfoIUPKvTDKebAdhxR75QL9mtWQP3WR5Jm3lbnjbvaiVV6Br7rZy+pzt
         5cRgVtohDq1YlQvWSplyA61T3eO/4DPMCQ/Fbdw4pCvXJyutRP0j64EnFN14wvCedz5r
         lHxF76La2CJL8tCvUeZdTPU14bKLgyBykRINW/78Ldd/6OYbJEKYfBNfYjOcoWULuMnr
         3I5B46xF9AZ+F/xUhnJ0b/zSNlLUXiLb3odiOHZJfsYIEQnXn2q2uEzZdDldP8IGAsp5
         b0wokV7PIGRjQg40xvtCh/aUweT6Rl6ffS/02fBvhaBFsOu+epFmnXwzdKusJBuC08R6
         fklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Av/ziOvsBe24F2oAdgKNQqRde9/UDT0IRqk3LqZYlqs=;
        b=5HT3BJ3PN1eqmoOP3ILlThaKQs76BKEIEybtc0qyA+f/O+6t7gJIX2lA3udhcJ9Tpx
         MDysPMU7dPfVd+deNbEMH69HpSOm+RTD3Iveh0HU3AbCiPJNGLNMKZDFJpEK/JjtA6s6
         iowgRgx+9rm1W+p3jPP1Fr4GNgYvOO3fDA1xhEv6bbnwDh+fBapK9IXUGYB/vsyep8Gg
         qoWZdIBcHe4jVozZxc78AKecMzFDY1utXsYfPbZ9MsHtSLViCr9lF2Ipnpytt6yBBXMr
         W6A/vAWHAxeXtVitxnHdIhtYc3cCxvmW9HdRUW+yFtQd3V2ejldfJo380wdc3ah5Zx5J
         pfOg==
X-Gm-Message-State: AOAM533rO1ivpsA//PI86QqXbOGanfXkn+iHyed2RAwDmyd0J2lVjsPV
        9wpkmDLTU4ojNKqT/S7HQoIVAQ==
X-Google-Smtp-Source: ABdhPJyx2PWRx3w0ZujjulplgxOwGoryhsFics0FxSW0K1o19/akULPWPf5g9n8TC6i+DmteyWnUQw==
X-Received: by 2002:a17:90b:4d01:b0:1d0:f39f:6073 with SMTP id mw1-20020a17090b4d0100b001d0f39f6073mr1628253pjb.175.1650575570116;
        Thu, 21 Apr 2022 14:12:50 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id m23-20020a17090a7f9700b001cd4989feedsm3697189pjl.57.2022.04.21.14.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 14:12:49 -0700 (PDT)
Date:   Thu, 21 Apr 2022 14:12:49 -0700 (PDT)
X-Google-Original-Date: Thu, 21 Apr 2022 14:12:46 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: mm: Fix set_satp_mode() for platform not having Sv57
In-Reply-To: <CAK9=C2UB-SKcb2Lf=m9VQZnOmkoY1W=kNeSJ40VcVXfr5WuPZQ@mail.gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        alexandre.ghiti@canonical.com, atishp@atishpatra.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, mchitale@ventanamicro.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     apatel@ventanamicro.com
Message-ID: <mhng-95003209-d4f2-4394-be70-d041a44af77b@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 02:30:05 PDT (-0700), apatel@ventanamicro.com wrote:
> Hi Palmer,
>
> On Tue, Apr 12, 2022 at 9:04 AM Anup Patel <apatel@ventanamicro.com> wrote:
>>
>> When Sv57 is not available the satp.MODE test in set_satp_mode() will
>> fail and lead to pgdir re-programming for Sv48. The pgdir re-programming
>> will fail as well due to pre-existing pgdir entry used for Sv57 and as
>> a result kernel fails to boot on RISC-V platform not having Sv57.
>>
>> To fix above issue, we should clear the pgdir memory in set_satp_mode()
>> before re-programming.
>>
>> Fixes: 011f09d12052 ("riscv: mm: Set sv57 on defaultly")
>> Reported-by: Mayuresh Chitale <mchitale@ventanamicro.com>
>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>
> Can this be considered for 5.18-rcX ?

Sorry, there's a queue but I just say this one at the top and it's super 
simple so I'm going to take it now -- IRC is good to ping this sort of 
stuff.

It's in fixes.

Thanks!

>
> Regards,
> Anup
>
>> ---
>>  arch/riscv/mm/init.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 9535bea8688c..b0793dc0c291 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -718,6 +718,7 @@ static __init void set_satp_mode(void)
>>                 if (!check_l4) {
>>                         disable_pgtable_l5();
>>                         check_l4 = true;
>> +                       memset(early_pg_dir, 0, PAGE_SIZE);
>>                         goto retry;
>>                 }
>>                 disable_pgtable_l4();
>> --
>> 2.25.1
>>
