Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F4251DD5A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443545AbiEFQRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443843AbiEFQRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:17:23 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D290F719E3
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:13:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso4637564wml.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 09:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xHwhyGSZ8M7KgMR41LAhUVAh1aLKO+4GZC+elUdkaQw=;
        b=aLNHmO7PvI0eqRd0nXHKzziXf7s/DX9WJ0YTeDvtS83z1w8LgrPbyIZrR4hqiZwRw3
         1klQU2WJAx6Cddz+CPc+fW1X6waIDpUXiiofceEemFsR5jh9KdFLTUwh+d281MScCKr7
         JaIkjhtFhlC6S/MI0W4FTg9J2whX2KN72RW1cogrE6CR7YXMBzkf4YH9GRCz18i6VGow
         y9OXk8SYMWn3/Q4JJdrCIScNN6tx/eFYGQHWOrxHu1QRomi6Bp6RWOkqJ5k0LPe9vqZ+
         iEKPA7U0EpEScWNHjJG9fazlYb6SOnIzBn41h6ST2a5HVU6nancGfBJnbbmJbOmAJbjT
         ekEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xHwhyGSZ8M7KgMR41LAhUVAh1aLKO+4GZC+elUdkaQw=;
        b=R/hxMt8BZBG8YbyKxFtOEmKPW0xjB8BYolJ9kCtJyWQzJvjDBSM1o9M7MRWWmmJ1s6
         iTwYgHqa4sWZhmDleYEvwWE0M38hMGaygYCzPsYD6nu75HliY8pgiMwWCxt5XxucDO/C
         hyob+SBpuITCk8N4ATVOpLePci9/Hyz2Z6qFyYRg7dJhf/kIS02v4b8VKVb6r5naANwY
         plqwSam8Q43289A0fgL6PGciogT+SE7i42ZvHle3dIzA3CDMmwQfn1+So21vd7hq2MIY
         Q0bXuBqge/O3HiUAjRTy40Sa9Otw+PnZEB+h9mO2h+YjexPtodE0lS9yBDGoI9jtyRwL
         +jfw==
X-Gm-Message-State: AOAM530gWYnQ1ABfRSxmoSjBGziaHpXhtX0mTq9L0sIvNJF+EbkJC9wd
        +ncNsvmV1vMfQRKrTU5Ga6QJ9A==
X-Google-Smtp-Source: ABdhPJzu+78loa4zZaY8G+UHf0dkbz4Kpnc3msqyLIQAKMTzarKNJaGFRZHD4BaGmo6ewAPdjp/WuA==
X-Received: by 2002:a05:600c:3584:b0:394:5870:2c44 with SMTP id p4-20020a05600c358400b0039458702c44mr4146897wmq.4.1651853581359;
        Fri, 06 May 2022 09:13:01 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id z18-20020adff1d2000000b0020c77f36b13sm3925962wro.100.2022.05.06.09.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 09:13:00 -0700 (PDT)
Date:   Fri, 6 May 2022 17:12:58 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
        will@kernel.org, liwei391@huawei.com, catalin.marinas@arm.com,
        mark.rutland@arm.com, mhiramat@kernel.org,
        jason.wessel@windriver.com, maz@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: kgdb: Set PSTATE.SS to 1 to re-enable
 single-step
Message-ID: <20220506161258.p5jztdy33hlua3bu@maple.lan>
References: <20220413065458.88541-1-sumit.garg@linaro.org>
 <20220413065458.88541-3-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413065458.88541-3-sumit.garg@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 12:24:58PM +0530, Sumit Garg wrote:
> After fixing wrongly single-stepping into the irq handler, when we execute
> single-step in kdb/kgdb, we can see only the first step can work.

I might be nitpicking since, again, I've no problems with the code
but... I'd rather this patch description focused on what this patch
does rather than what the patch before it does!

Something more like:

  Currently only the first attempt to single-step has any effect.
  After that all further stepping remains "stuck" at the same program
  counter value.


Daniel.



 
> Refer to the ARM Architecture Reference Manual (ARM DDI 0487E.a) D2.12,
> i think PSTATE.SS=1 should be set each step for transferring the PE to the
> 'Active-not-pending' state. The problem here is PSTATE.SS=1 is not set
> since the second single-step.
> 
> After the first single-step, the PE transferes to the 'Inactive' state,
> with PSTATE.SS=0 and MDSCR.SS=1, thus PSTATE.SS won't be set to 1 due to
> kernel_active_single_step()=true. Then the PE transferes to the
> 'Active-pending' state when ERET and returns to the debugger by step
> exception.
> 
> Before this patch:
> ==================
> Entering kdb (current=0xffff3376039f0000, pid 1) on processor 0 due to Keyboard Entry
> [0]kdb>
> 
> [0]kdb>
> [0]kdb> bp write_sysrq_trigger
> Instruction(i) BP #0 at 0xffffa45c13d09290 (write_sysrq_trigger)
>     is enabled   addr at ffffa45c13d09290, hardtype=0 installed=0
> 
> [0]kdb> go
> $ echo h > /proc/sysrq-trigger
> 
> Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to Breakpoint @ 0xffffad651a309290
> [1]kdb> ss
> 
> Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to SS trap @ 0xffffad651a309294
> [1]kdb> ss
> 
> Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to SS trap @ 0xffffad651a309294
> [1]kdb>
> 
> After this patch:
> =================
> Entering kdb (current=0xffff6851c39f0000, pid 1) on processor 0 due to Keyboard Entry
> [0]kdb> bp write_sysrq_trigger
> Instruction(i) BP #0 at 0xffffc02d2dd09290 (write_sysrq_trigger)
>     is enabled   addr at ffffc02d2dd09290, hardtype=0 installed=0
> 
> [0]kdb> go
> $ echo h > /proc/sysrq-trigger
> 
> Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to Breakpoint @ 0xffffc02d2dd09290
> [1]kdb> ss
> 
> Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd09294
> [1]kdb> ss
> 
> Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd09298
> [1]kdb> ss
> 
> Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd0929c
> [1]kdb>
> 
> Fixes: 44679a4f142b ("arm64: KGDB: Add step debugging support")
> Co-developed-by: Wei Li <liwei391@huawei.com>
> Signed-off-by: Wei Li <liwei391@huawei.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  arch/arm64/include/asm/debug-monitors.h | 1 +
>  arch/arm64/kernel/debug-monitors.c      | 5 +++++
>  arch/arm64/kernel/kgdb.c                | 2 ++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
> index 00c291067e57..9e1e864d6440 100644
> --- a/arch/arm64/include/asm/debug-monitors.h
> +++ b/arch/arm64/include/asm/debug-monitors.h
> @@ -104,6 +104,7 @@ void user_regs_reset_single_step(struct user_pt_regs *regs,
>  void kernel_enable_single_step(struct pt_regs *regs);
>  void kernel_disable_single_step(void);
>  int kernel_active_single_step(void);
> +void kernel_regs_reset_single_step(struct pt_regs *regs);
>  
>  #ifdef CONFIG_HAVE_HW_BREAKPOINT
>  int reinstall_suspended_bps(struct pt_regs *regs);
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index 4f3661eeb7ec..ea3f410aa385 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -438,6 +438,11 @@ int kernel_active_single_step(void)
>  }
>  NOKPROBE_SYMBOL(kernel_active_single_step);
>  
> +void kernel_regs_reset_single_step(struct pt_regs *regs)
> +{
> +	set_regs_spsr_ss(regs);
> +}
> +
>  /* ptrace API */
>  void user_enable_single_step(struct task_struct *task)
>  {
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index 2aede780fb80..acf2196b1e9b 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -224,6 +224,8 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
>  		 */
>  		if (!kernel_active_single_step())
>  			kernel_enable_single_step(linux_regs);
> +		else
> +			kernel_regs_reset_single_step(linux_regs);
>  		err = 0;
>  		break;
>  	default:
> -- 
> 2.25.1
