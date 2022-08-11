Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BF55901CC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbiHKPy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbiHKPxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:53:47 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E2163AB
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:45:19 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g12so16827505pfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=wgIBglyDiY3KB6HM29FTTdKDZNb7OUXfe8TnmIwNm5c=;
        b=hEH12hyFXBHshNWK8eGibGdry1CsakVDjNu7i3pW/bqNftRhuWogZ4NM2nYBBsqnfD
         TQJ9dVd4/8GChFQtUX781cdLr7LTCIU/Wy3d2DbX3ajOEOHPlHAXUJhVmB8RdeFuHrzA
         6yG7fcS6Wm8mzfk3tHl6AD/kfD+i9mvS04U4LagIFHsWBKJQ5ipzT7tGUvEf9cSwcDTa
         OlBbGqqWrH8fBomBAwGDdSvjIv4ClLpo2R/tzQBqD34s6CeLSkdNz/PVSG7ctmWKav1j
         mK9bVIwDDJKNDvfuSzkblMpa5/twB3Ukj3s4e3PM7k8S5ysGJ2yOMziuhuHeXJzfYYCS
         In5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=wgIBglyDiY3KB6HM29FTTdKDZNb7OUXfe8TnmIwNm5c=;
        b=ElJ+UdK9RM71XMZbSstFkYh8t4jM3XHh1Tme6w8MIWQMMl2UcvNHOLv2EZMiFlKdT1
         SIjF53uRaK8GgB5Y0zcmkz4TKlJqlWLGWdu1HysDsBj4bcn28ltUMDm3lbw9OzlIRsVK
         U+tnmrX4bFoeaBcsG9t2rOe8DCLAnGt2fsYdKViMO8OQfC4Kt/tyYsXvKEGlq227EoT4
         j9akr+iWY3r23mP122ALBLf0e+QHK0iNokZmtItFpGSEsR78rJjvlj8PJlU3dddDdHns
         rZ2e+XJVRIrlDLsFuCgO9f4GQ/6URo0nj3hNfNgRbbJ0zdr2531S9/XoIRgAssTk3bi/
         Jz4Q==
X-Gm-Message-State: ACgBeo0oBj3Ah0xbj0OHyFsPau2jNEaFsJIgKf0DPEv19n326vpKUreW
        LDsIckUam7WZzuF1Pn7uuSbuGA==
X-Google-Smtp-Source: AA6agR6dd1fRyPM1u3MobTledxZFhW9GS+asncCvV3rmn0Yv9hX3pp+Q4CJy55kWLkFI5sXYjqblIQ==
X-Received: by 2002:a63:1d1d:0:b0:41c:3d54:b123 with SMTP id d29-20020a631d1d000000b0041c3d54b123mr27197433pgd.357.1660232718650;
        Thu, 11 Aug 2022 08:45:18 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y67-20020a623246000000b0052acb753b8bsm4182857pfy.158.2022.08.11.08.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 08:45:18 -0700 (PDT)
Date:   Thu, 11 Aug 2022 08:45:18 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Aug 2022 08:38:56 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: use __smp_processor_id() instead of smp_processor_id()
In-Reply-To: <20220623074315.3814826-1-xianting.tian@linux.alibaba.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        alex@ghiti.fr, liaochang1@huawei.com, mick@ics.forth.gr,
        guoren@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, xianting.tian@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     xianting.tian@linux.alibaba.com
Message-ID: <mhng-34326299-6545-4626-b804-0b2bcf02ba4a@palmer-mbp2014>
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

On Thu, 23 Jun 2022 00:43:15 PDT (-0700), xianting.tian@linux.alibaba.com wrote:
> Use __smp_processor_id() to avoid check the preemption context when
> CONFIG_DEBUG_PREEMPT enabled, as we will enter crash kernel and no
> return.
>
> Without the patch,
> [  103.781044] sysrq: Trigger a crash
> [  103.784625] Kernel panic - not syncing: sysrq triggered crash
> [  103.837634] CPU1: off
> [  103.889668] CPU2: off
> [  103.933479] CPU3: off
> [  103.939424] Starting crashdump kernel...
> [  103.943442] BUG: using smp_processor_id() in preemptible [00000000] code: sh/346
> [  103.950884] caller is debug_smp_processor_id+0x1c/0x26
> [  103.956051] CPU: 0 PID: 346 Comm: sh Kdump: loaded Not tainted 5.10.113-00002-gce03f03bf4ec-dirty #149
> [  103.965355] Call Trace:
> [  103.967805] [<ffffffe00020372a>] walk_stackframe+0x0/0xa2
> [  103.973206] [<ffffffe000bcf1f4>] show_stack+0x32/0x3e
> [  103.978258] [<ffffffe000bd382a>] dump_stack_lvl+0x72/0x8e
> [  103.983655] [<ffffffe000bd385a>] dump_stack+0x14/0x1c
> [  103.988705] [<ffffffe000bdc8fe>] check_preemption_disabled+0x9e/0xaa
> [  103.995057] [<ffffffe000bdc926>] debug_smp_processor_id+0x1c/0x26
> [  104.001150] [<ffffffe000206c64>] machine_kexec+0x22/0xd0
> [  104.006463] [<ffffffe000291a7e>] __crash_kexec+0x6a/0xa4
> [  104.011774] [<ffffffe000bcf3fa>] panic+0xfc/0x2b0
> [  104.016480] [<ffffffe000656ca4>] sysrq_reset_seq_param_set+0x0/0x70
> [  104.022745] [<ffffffe000657310>] __handle_sysrq+0x8c/0x154
> [  104.028229] [<ffffffe0006577e8>] write_sysrq_trigger+0x5a/0x6a
> [  104.034061] [<ffffffe0003d90e0>] proc_reg_write+0x58/0xd4
> [  104.039459] [<ffffffe00036cff4>] vfs_write+0x7e/0x254
> [  104.044509] [<ffffffe00036d2f6>] ksys_write+0x58/0xbe
> [  104.049558] [<ffffffe00036d36a>] sys_write+0xe/0x16
> [  104.054434] [<ffffffe000201b9a>] ret_from_syscall+0x0/0x2
> [  104.067863] Will call new kernel at ecc00000 from hart id 0
> [  104.074939] FDT image at fc5ee000
> [  104.079523] Bye...
>
> With the patch we can got clear output,
> [   67.740553] sysrq: Trigger a crash
> [   67.744166] Kernel panic - not syncing: sysrq triggered crash
> [   67.809123] CPU1: off
> [   67.865210] CPU2: off
> [   67.909075] CPU3: off
> [   67.919123] Starting crashdump kernel...
> [   67.924900] Will call new kernel at ecc00000 from hart id 0
> [   67.932045] FDT image at fc5ee000
> [   67.935560] Bye...
>
> Fixes: 0e105f1d0037 ("riscv: use hart id instead of cpu id on machine_kexec")
> Co-developed-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  arch/riscv/kernel/machine_kexec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
> index df8e24559035..86d1b5f9dfb5 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
> @@ -171,7 +171,7 @@ machine_kexec(struct kimage *image)
>  	struct kimage_arch *internal = &image->arch;
>  	unsigned long jump_addr = (unsigned long) image->start;
>  	unsigned long first_ind_entry = (unsigned long) &image->head;
> -	unsigned long this_cpu_id = smp_processor_id();
> +	unsigned long this_cpu_id = __smp_processor_id();
>  	unsigned long this_hart_id = cpuid_to_hartid_map(this_cpu_id);
>  	unsigned long fdt_addr = internal->fdt_addr;
>  	void *control_code_buffer = page_address(image->control_code_page);

Thanks, this is on for-next.
