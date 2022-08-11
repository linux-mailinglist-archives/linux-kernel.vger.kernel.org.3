Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A281B5903D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbiHKQYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 12:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbiHKQXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:23:46 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D4B1117F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:05:19 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 130so16824002pfv.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=d0u1p8R8Qde2ve36Abm6cDksJ4xjEyO5Zx7tA20Gdo4=;
        b=72hpLRYS883vixroIwg3mFYuCWRng9p0gc9YWN4NGkrCEVdvrpuBZ+zFhXTx7lBsGt
         jnYtHZnyAQCyUMyaXxk4n97h+3rx4La1veaOtjQ+rUT0YNDNn3XBlPXFPTVehYcv1r7m
         KZ7V7di0uamozJzVU5PJgBMx20NCjFQ9K+zG8euY9/7J1+LLyKW4JE6TsbNOAN3gOSLY
         GXcZ1vRV+LAkwt/oC3IcvKMpxXNaoTYVbYBGz1Carcd4E8bFRUqPN+V1aEVLzFWrBOrv
         m/8RktYKvyDwdKiXmOVA52v5IVqzpvkztYaJYwGwr9Ywr/0lIYrSIHl4m/bK3Y3kCPmI
         NMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=d0u1p8R8Qde2ve36Abm6cDksJ4xjEyO5Zx7tA20Gdo4=;
        b=VES6LHaqPBoydm81RgkcUrJULCCNPnu1v3dloW8LafoBdRhQYP+ejrZOcHJo/s7e1x
         Nhccc9tA8bDb4HF3K+pQgeQDRaF+Eo8sYLcMohKTEoPy83Y0YMUHNIv++UvaGNX793Qa
         86EFuRmE+B5Q8dWCtkc3zHtLE6/mOylqQYb5AAKt1tsZQeFI2jinSzFxhTmFIInG3nHB
         gu+N1gigIjrAGMShgiE+CRXKgIobt0Ti+8gZlrJTXRD5j1afzMiiaoydo/QI71WepgOd
         Kyfgzl/WScT0CjdFoO7XOrfKGYGlR8hRu3KIs48+UZdnzUAFJBGa+J8DZ4+iWotyudZs
         nwUA==
X-Gm-Message-State: ACgBeo3DibDF8h1UG7lHXpk1gwMeTYGTQYMroRO+Gg3+i8nVJ4F0d9IO
        AR9P18n5vDysNwMqI3c9/Rma/g==
X-Google-Smtp-Source: AA6agR6isMDGVMr7bmbSvX20FFwxSxUuQ6z8kvqSth7ginkx17kOTN5fQHEz08/ycUABZvTvf+rhqA==
X-Received: by 2002:a63:905:0:b0:415:fcde:2423 with SMTP id 5-20020a630905000000b00415fcde2423mr27906416pgj.374.1660233918463;
        Thu, 11 Aug 2022 09:05:18 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id f20-20020a635554000000b0041a716cec9esm11458346pgm.62.2022.08.11.09.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 09:05:18 -0700 (PDT)
Date:   Thu, 11 Aug 2022 09:05:18 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Aug 2022 09:05:16 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: use __smp_processor_id() instead of smp_processor_id()
In-Reply-To: <mhng-34326299-6545-4626-b804-0b2bcf02ba4a@palmer-mbp2014>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        alex@ghiti.fr, liaochang1@huawei.com, mick@ics.forth.gr,
        guoren@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, xianting.tian@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     xianting.tian@linux.alibaba.com
Message-ID: <mhng-3d40a456-c1da-41c8-9234-0ea16a2c7d09@palmer-mbp2014>
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

On Thu, 11 Aug 2022 08:45:18 PDT (-0700), Palmer Dabbelt wrote:
> On Thu, 23 Jun 2022 00:43:15 PDT (-0700), xianting.tian@linux.alibaba.com wrote:
>> Use __smp_processor_id() to avoid check the preemption context when
>> CONFIG_DEBUG_PREEMPT enabled, as we will enter crash kernel and no
>> return.
>>
>> Without the patch,
>> [  103.781044] sysrq: Trigger a crash
>> [  103.784625] Kernel panic - not syncing: sysrq triggered crash
>> [  103.837634] CPU1: off
>> [  103.889668] CPU2: off
>> [  103.933479] CPU3: off
>> [  103.939424] Starting crashdump kernel...
>> [  103.943442] BUG: using smp_processor_id() in preemptible [00000000] code: sh/346
>> [  103.950884] caller is debug_smp_processor_id+0x1c/0x26
>> [  103.956051] CPU: 0 PID: 346 Comm: sh Kdump: loaded Not tainted 5.10.113-00002-gce03f03bf4ec-dirty #149
>> [  103.965355] Call Trace:
>> [  103.967805] [<ffffffe00020372a>] walk_stackframe+0x0/0xa2
>> [  103.973206] [<ffffffe000bcf1f4>] show_stack+0x32/0x3e
>> [  103.978258] [<ffffffe000bd382a>] dump_stack_lvl+0x72/0x8e
>> [  103.983655] [<ffffffe000bd385a>] dump_stack+0x14/0x1c
>> [  103.988705] [<ffffffe000bdc8fe>] check_preemption_disabled+0x9e/0xaa
>> [  103.995057] [<ffffffe000bdc926>] debug_smp_processor_id+0x1c/0x26
>> [  104.001150] [<ffffffe000206c64>] machine_kexec+0x22/0xd0
>> [  104.006463] [<ffffffe000291a7e>] __crash_kexec+0x6a/0xa4
>> [  104.011774] [<ffffffe000bcf3fa>] panic+0xfc/0x2b0
>> [  104.016480] [<ffffffe000656ca4>] sysrq_reset_seq_param_set+0x0/0x70
>> [  104.022745] [<ffffffe000657310>] __handle_sysrq+0x8c/0x154
>> [  104.028229] [<ffffffe0006577e8>] write_sysrq_trigger+0x5a/0x6a
>> [  104.034061] [<ffffffe0003d90e0>] proc_reg_write+0x58/0xd4
>> [  104.039459] [<ffffffe00036cff4>] vfs_write+0x7e/0x254
>> [  104.044509] [<ffffffe00036d2f6>] ksys_write+0x58/0xbe
>> [  104.049558] [<ffffffe00036d36a>] sys_write+0xe/0x16
>> [  104.054434] [<ffffffe000201b9a>] ret_from_syscall+0x0/0x2
>> [  104.067863] Will call new kernel at ecc00000 from hart id 0
>> [  104.074939] FDT image at fc5ee000
>> [  104.079523] Bye...
>>
>> With the patch we can got clear output,
>> [   67.740553] sysrq: Trigger a crash
>> [   67.744166] Kernel panic - not syncing: sysrq triggered crash
>> [   67.809123] CPU1: off
>> [   67.865210] CPU2: off
>> [   67.909075] CPU3: off
>> [   67.919123] Starting crashdump kernel...
>> [   67.924900] Will call new kernel at ecc00000 from hart id 0
>> [   67.932045] FDT image at fc5ee000
>> [   67.935560] Bye...
>>
>> Fixes: 0e105f1d0037 ("riscv: use hart id instead of cpu id on machine_kexec")
>> Co-developed-by: Guo Ren <guoren@kernel.org>
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>> ---
>>  arch/riscv/kernel/machine_kexec.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
>> index df8e24559035..86d1b5f9dfb5 100644
>> --- a/arch/riscv/kernel/machine_kexec.c
>> +++ b/arch/riscv/kernel/machine_kexec.c
>> @@ -171,7 +171,7 @@ machine_kexec(struct kimage *image)
>>  	struct kimage_arch *internal = &image->arch;
>>  	unsigned long jump_addr = (unsigned long) image->start;
>>  	unsigned long first_ind_entry = (unsigned long) &image->head;
>> -	unsigned long this_cpu_id = smp_processor_id();
>> +	unsigned long this_cpu_id = __smp_processor_id();
>>  	unsigned long this_hart_id = cpuid_to_hartid_map(this_cpu_id);
>>  	unsigned long fdt_addr = internal->fdt_addr;
>>  	void *control_code_buffer = page_address(image->control_code_page);
>
> Thanks, this is on for-next.

Connor pointed out that there's a series with more fixes, so I'm going 
to take that instead.
