Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385E759175D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbiHLWdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiHLWdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:33:33 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819EE13D33
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 15:33:31 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 12so1900705pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 15:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=J9waYuqiXiBo6CoKOY7xSmYY7/t2Q162Stvs30VRjP0=;
        b=o6Q7RXb92DprDTEK+xuWZspARQoP6RYVzSVAfk0YB28mr9jc7AQl4X79nUF/2oo3bb
         n5ESpjMYSYV0pMInItoE9jj6D0rCgz0yH4oUTYnwsWsKHOB4T9DNBymmbbSO8N35oXqV
         iweQz4HA3ceRqgscHKCc4abaIonTH62RhMC/tsv8a9WRHdMlCI0hDygMLJSN2XKqsRPp
         i90nqzmFhAxcigkrmOiVRUwfVYs4znxLzmenwmd0GucYeWPdPtS8u7KIQtWzGzAtyEbS
         N009eCfbkBSP+76LfCWw+BGRxCUOXFsd0VExQ9K1zvuOLYJHT31hkgbeEaZpjDBz/N5o
         5iUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=J9waYuqiXiBo6CoKOY7xSmYY7/t2Q162Stvs30VRjP0=;
        b=w1tJ9+nxEXQ14awKknxy3SnsVph8ihxA6ev/0ASE2vb55Hz1PK/iosDnukYMSuBFL1
         V+JH+k3hT6OmtRbcAmnPhbWkc0SptDpMtR5Q6sRnjLzzpXyCRaNeM8YFw7ZLAk3enP42
         pcwfUp0xAL4pUISEGTrVW4DAGsnhKIcfJ+qXAXJ/AnAyS7lw/M9m8NTF8j6bgFmGCyAo
         EphahSdRkO8IiqzQPpqO71kF9Swd/PiR+EPldcuRNIJPVjt2QYGQP1RYRfr1zabBdUNx
         T7ngp4ZqITVP1lRCv8bxI600do04KX0yQvBswahlybEs22bSPxvftio2Yepvfqet17hJ
         ycIg==
X-Gm-Message-State: ACgBeo1BTuj9DdTPWf46/G2kAkRKS3FkMLnbehDBUsnkIw8P7HMzbmHG
        O2dOWNW9FIUuulOm59PppBYLEg==
X-Google-Smtp-Source: AA6agR7dGB9/EdbtT/JngiW+GGXOkOM5zXiMIlvHsOMRb7xCxt7iRELMkk+G/LhhZRhJaf8KIVotQg==
X-Received: by 2002:a05:6a00:230d:b0:52b:1819:3a0 with SMTP id h13-20020a056a00230d00b0052b181903a0mr5842336pfh.53.1660343610994;
        Fri, 12 Aug 2022 15:33:30 -0700 (PDT)
Received: from localhost ([50.221.140.186])
        by smtp.gmail.com with ESMTPSA id i16-20020a056a00005000b0052d82ce65a9sm2185008pfk.143.2022.08.12.15.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 15:33:30 -0700 (PDT)
Date:   Fri, 12 Aug 2022 15:33:30 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Aug 2022 15:33:29 PDT (-0700)
Subject:     Re: [PATCH] perf: riscv: fix broken build due to struct redefinition
In-Reply-To: <84e4739c-0197-f9d9-5529-24f6037c85fa@microchip.com>
CC:     jrtc27@jrtc27.com, atishp@atishpatra.org, anup@brainfault.org,
        Will Deacon <will@kernel.org>, mark.rutland@arm.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor.Dooley@microchip.com
Message-ID: <mhng-32b44fa5-288d-4186-bc79-6c5f2608aa36@palmer-ri-x1c9>
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

On Fri, 12 Aug 2022 07:19:54 PDT (-0700), Conor.Dooley@microchip.com wrote:
> On 12/08/2022 15:13, Jessica Clarke wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>> 
>> On 12 Aug 2022, at 14:51, Conor Dooley <conor.dooley@microchip.com> wrote:
>>>
>>> Building riscv/for-next produces following error:
>>> drivers/perf/riscv_pmu_sbi.c:44:7: error: redefinition of 'sbi_pmu_ctr_info'
>>> union sbi_pmu_ctr_info {
>>>       ^
>>> arch/riscv/include/asm/sbi.h:125:7: note: previous definition is here
>>> union sbi_pmu_ctr_info {
>>>
>>> This appears to have been caused by a merge conflict resolution between
>>> riscv/for-next & riscv/fixes, causing the struct define not being
>> 
>> union, not struct
> 
> autopilot, thanks :)
> 
>> 
>> Jess
>> 
>>> properly moved to its header.
>>>
>>> Fixes: 9a7ccac63f9c ("perf: riscv_pmu{,_sbi}: Miscallenous improvement & fixes")
>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>> ---
>>> drivers/perf/riscv_pmu_sbi.c | 14 --------------
>>> 1 file changed, 14 deletions(-)
>>>
>>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>>> index e7c6fecbf061..6f6681bbfd36 100644
>>> --- a/drivers/perf/riscv_pmu_sbi.c
>>> +++ b/drivers/perf/riscv_pmu_sbi.c
>>> @@ -41,20 +41,6 @@ static const struct attribute_group *riscv_pmu_attr_groups[] = {
>>>        NULL,
>>> };
>>>
>>> -union sbi_pmu_ctr_info {
>>> -     unsigned long value;
>>> -     struct {
>>> -             unsigned long csr:12;
>>> -             unsigned long width:6;
>>> -#if __riscv_xlen == 32
>>> -             unsigned long reserved:13;
>>> -#else
>>> -             unsigned long reserved:45;
>>> -#endif
>>> -             unsigned long type:1;
>>> -     };
>>> -};
>>> -
>>> /*
>>>   * RISC-V doesn't have hetergenous harts yet. This need to be part of
>>>   * per_cpu in case of harts with different pmu counters

Atish just poked me about this as I was tagging my PR, I squashed it in.  
I don't see a message on lore, not sure if something went off the rails 
or if it's just in the outbox on my box at home.
