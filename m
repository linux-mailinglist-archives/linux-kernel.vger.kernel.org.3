Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A97957DB77
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbiGVHnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVHnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:43:16 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E169474CF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:43:14 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31e7ca45091so39523997b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iKIaSypFVYjNqK3UF0MeX1uLadeX9F3Ok+Ln5q+DbjI=;
        b=VUqsj7keIvOwEm3DCbFmxPyirWn7ZQoYV/6Oa7SWUtEp+DwZ2XdPOSzxBlZreg9Q+I
         OXt24U5uowN/S/d5PWcRxWvlOXhnilAgAVtmiQNQPCSaKAS/A8GfUVuZN4VvTx9NWIi3
         8O7XKCNXDyKUGia51sEQkHG/LNz/1eyxPbIhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iKIaSypFVYjNqK3UF0MeX1uLadeX9F3Ok+Ln5q+DbjI=;
        b=O+xml+vPByAQdFhEVmE9UB3hJLus3m9c+yWoPoRw7twcDXMVuyEvJPSFvxDkpNsIg7
         996wYlN8FOqCfNQjZozJfHLqdKpi7CGdQg/3WKCwQmx0s/p0I0YZByviCDln7+UZjDGB
         F4UYROF3aBa2f3bQ/CpDpM6z9q0Jcy+YhcCP86bTZ+08UaErkcDgIAyWyI3KzSsHAk4w
         wJpOlkGQy5Iu914xn+Un4F45seZWUW2U7w4xK8I0sDwazcaHPHPkqdSo9Uk9264L+Vcm
         11sXdJ06hOA8Kp+5V++9DgcfsEXrax7Z0vsOrt9fD3VegSrUtsTHttquovk89k5ek/F5
         IsSQ==
X-Gm-Message-State: AJIora94n/0sD58nrsVrqCIIFeRsjgO0GCPcBnNkPAw/ukChTN4Dd/x5
        GXp/ulUdWWp4CzwOKEmlqAecAQVtCLKIEsXWWH8R
X-Google-Smtp-Source: AGRyM1u64u+ogJpYA5v+bu4lLY7zZ/TjRksFjpfQgu6GNUBIQyu8+rjIg+XRXzaiAqXFk46lwk0tafSmilZn0T2HQHw=
X-Received: by 2002:a81:9182:0:b0:31e:68cd:3d5c with SMTP id
 i124-20020a819182000000b0031e68cd3d5cmr2003480ywg.194.1658475793496; Fri, 22
 Jul 2022 00:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220717101323.370245-1-xianting.tian@linux.alibaba.com> <20220717101323.370245-3-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220717101323.370245-3-xianting.tian@linux.alibaba.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 22 Jul 2022 00:43:02 -0700
Message-ID: <CAOnJCULnWnzZ-EdM2bhqoM8GebXsDU2SSRi896jkQftW1ibOVA@mail.gmail.com>
Subject: Re: [PATCH 2/5] RISC-V: use __smp_processor_id() instead of smp_processor_id()
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Guo Ren <guoren@kernel.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        crash-utility@redhat.com, huanyi.xj@alibaba-inc.com,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        k-hagio-ab@nec.com, hschauhan@nulltrace.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 3:14 AM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
>
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
> Reviewed-by: Guo Ren <guoren@kernel.org>
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
>         struct kimage_arch *internal = &image->arch;
>         unsigned long jump_addr = (unsigned long) image->start;
>         unsigned long first_ind_entry = (unsigned long) &image->head;
> -       unsigned long this_cpu_id = smp_processor_id();
> +       unsigned long this_cpu_id = __smp_processor_id();
>         unsigned long this_hart_id = cpuid_to_hartid_map(this_cpu_id);
>         unsigned long fdt_addr = internal->fdt_addr;
>         void *control_code_buffer = page_address(image->control_code_page);
> --
> 2.17.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Reviewed-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
