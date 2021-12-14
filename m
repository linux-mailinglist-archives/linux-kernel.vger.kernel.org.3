Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DFB474811
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbhLNQ3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbhLNQ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:29:31 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3D6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:29:31 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b13so13934277plg.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=UtzwvPGJGsxSlX5yHONhsOG3Z07A2+rV1SqqO3BO/EM=;
        b=NQSXVVpuoBWD7LQqRbZceG6VsWT9sGdtZlkIK0WEDUWkm79louNmrWzV1akuEiO9C6
         DYmhBGdiTdKCEMizjZ4l02g6uJJ6J7N+pCUb86uV039Trb6DxUEjtXgZQ/GaXYoILF/H
         WyuFcp2Pj1yecgyjU/ZdHEzsFKNB2rvJYLeD4JL2/E/u2oftX3xhqp75L2M48qe43Rvw
         PLY8ZuKFiISF8J1Z29ThfWkgHc56zgQnO16XgRd3FsQIyzK3dRDNbCtkFwfNUf5J4c+a
         IAW3735BLWBnqwmCcwS0TBXv665M2Bk/XMl7wGsoWMWhU1k17wWIog3EL+ezo7irH9an
         kEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=UtzwvPGJGsxSlX5yHONhsOG3Z07A2+rV1SqqO3BO/EM=;
        b=VxFqRYyzXmgkBozWdlbvPcVCrgtlEwN6CXqj1iTLLEobd1ztMPyznJE2Es1C8AJeIt
         MkiKpx5/Yh+7fsiKFunwvlSPZIGQOSimXnAW21jMx+6m7Qz7ZPqP1p1HomdHjIO0p/uE
         yGy7t+sU0QtlggZgoeVwB8HZvAym8AanJZyfIy7ZSAtcJXIIE+nwwh+nACn2V7k4ZpvK
         vkLEWNXCC4e4SL5KIKfwdZJg08aVPoDUp4dPCW9rcavaTNadeLliCTsuD3qaY6PIuh3l
         T09Uu6gR6hV4sQGKhcek0K/+5+XzfPxU+FNweVKL9Dg3SWdc6xm8156fyZmtMAW4joV9
         gUiw==
X-Gm-Message-State: AOAM533FxSahw/pm0ByMAUFwpau07SUjLarptiiMoH8QkP9ieBqOPgbk
        zukbwddSd2EuDkQlvatBeo9EhA==
X-Google-Smtp-Source: ABdhPJzZfZK8Q8jExHWiMImmlWW+dHRzTFrYTgGnuAbNJwuBTr9CHS5VVcJ0wUjgObTaDPXiKaCBhg==
X-Received: by 2002:a17:90a:5d98:: with SMTP id t24mr1068496pji.109.1639499370924;
        Tue, 14 Dec 2021 08:29:30 -0800 (PST)
Received: from localhost ([12.163.77.120])
        by smtp.gmail.com with ESMTPSA id lb4sm3200381pjb.18.2021.12.14.08.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:29:30 -0800 (PST)
Date:   Tue, 14 Dec 2021 08:29:30 -0800 (PST)
X-Google-Original-Date: Mon, 13 Dec 2021 19:41:25 PST (-0800)
Subject:     Re: [PATCH v9 08/17] riscv: Add vector struct and assembler definitions
In-Reply-To: <15d09938180ee45bc5481c4a2d41ad656ca23c82.1636362169.git.greentime.hu@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     greentime.hu@sifive.com
Message-ID: <mhng-a7a94a37-5791-4c76-8f2d-072130d71819@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Nov 2021 01:48:20 PST (-0800), greentime.hu@sifive.com wrote:
> Add vector state context struct in struct thread and asm-offsets.c
> definitions.
>
> The vector registers will be saved in datap pointer of __riscv_v_state. It
> will be dynamically allocated in kernel space. It will be put right after
> the __riscv_v_state data structure in user space.
>
> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/include/asm/processor.h   |  1 +
>  arch/riscv/include/uapi/asm/ptrace.h | 11 +++++++++++
>  arch/riscv/kernel/asm-offsets.c      |  6 ++++++
>  3 files changed, 18 insertions(+)
>
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index 46b492c78cbb..a268f1382e52 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -35,6 +35,7 @@ struct thread_struct {
>  	unsigned long s[12];	/* s[0]: frame pointer */
>  	struct __riscv_d_ext_state fstate;
>  	unsigned long bad_cause;
> +	struct __riscv_v_state vstate;
>  };
>
>  /* Whitelist the fstate from the task_struct for hardened usercopy */
> diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
> index 882547f6bd5c..bd3b8a710246 100644
> --- a/arch/riscv/include/uapi/asm/ptrace.h
> +++ b/arch/riscv/include/uapi/asm/ptrace.h
> @@ -77,6 +77,17 @@ union __riscv_fp_state {
>  	struct __riscv_q_ext_state q;
>  };
>
> +struct __riscv_v_state {
> +	unsigned long vstart;
> +	unsigned long vl;
> +	unsigned long vtype;
> +	unsigned long vcsr;

Don't we also need vlen to adequately determine the vector state?  
Otherwise we're going to end up dropping some state when vl isn't vlmax, 
which IIUC isn't legal.

> +	void *datap;
> +#if __riscv_xlen == 32
> +	__u32 __padding;
> +#endif

Why is there padding?

> +};
> +
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* _UAPI_ASM_RISCV_PTRACE_H */
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index 90f8ce64fa6f..34f43c84723a 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -72,6 +72,12 @@ void asm_offsets(void)
>  	OFFSET(TSK_STACK_CANARY, task_struct, stack_canary);
>  #endif
>
> +	OFFSET(RISCV_V_STATE_VSTART, __riscv_v_state, vstart);
> +	OFFSET(RISCV_V_STATE_VL, __riscv_v_state, vl);
> +	OFFSET(RISCV_V_STATE_VTYPE, __riscv_v_state, vtype);
> +	OFFSET(RISCV_V_STATE_VCSR, __riscv_v_state, vcsr);
> +	OFFSET(RISCV_V_STATE_DATAP, __riscv_v_state, datap);
> +
>  	DEFINE(PT_SIZE, sizeof(struct pt_regs));
>  	OFFSET(PT_EPC, pt_regs, epc);
>  	OFFSET(PT_RA, pt_regs, ra);
