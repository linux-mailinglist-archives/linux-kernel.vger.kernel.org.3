Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE3F490C04
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbiAQQBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiAQQBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:01:50 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCA8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 08:01:49 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c126-20020a1c9a84000000b00346f9ebee43so577507wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 08:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PDB6ZPHKwe/hrqwhjvJ+lqedINeLilxIqWASb1lAKsI=;
        b=aM4VrHnZjsUNZ86EZ70fZigXQD9zdi2m4OqvA1hZllwluURgPkWQ8/P43mpv32ifER
         TI62GnFfyvXNR0M40oTGJlmA9Se7kbEdjTfIXzR03OQRq7edFsUq9JdaCuzmW9at+jJU
         7sNSrnpTFW7T8TSihE/9MxWj93vPZTGCZqik2UDfveFm+KfZqiNk+jBd9JLYSeIpnPzP
         1m4GCkrjRhESFUJSELNUpt68nnno6W+wgiSOQCFZTEMEQRHmMMe0IWOVnLLGnKd/goxO
         Xavmc2HENOCGBBoD+6okmM8THXG/7YsUnPxsNiRfHBYhpmKyR8oJX/DUB8YYvpMPrQI/
         22/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PDB6ZPHKwe/hrqwhjvJ+lqedINeLilxIqWASb1lAKsI=;
        b=drO3LO/szYwuM9wn5ksymc7SYMYtwdqC5THISQ5KmRR19W7u+pyVQwXDamqS+lmnA9
         MQQ5Og2rGSjbRfGSgZS+AIQlxvIa6d9T/AydeJ/z+ouRollSoJ1zQfAdte95ung3s6qH
         G3lKkkV24twsXYMQCTB2aGpG7NUwUKfeUdmEGsoBZ7zjKHDKiaha1t7f73mjGq2gllUm
         PoP+KBs+YmR8H18PNaPJv5GlXtyNvqPXKCPcbug1o4bShDPeENmkGi+AcEbtQHXtU95s
         kCaa3BTHmdZGujO61T98VoNR2WJ2EQww9Wf+QnKHC0sbFtNxqRPrwJMDZyDCjZ9zHkk4
         zncA==
X-Gm-Message-State: AOAM531s0+DhlXo2eDu6bD1iUJ/Xb+C/DOi4BBX+BFpXTURBmbuTlq0D
        21E593wcaajIpeFBL0jydiacfsIwfiYiDTXUuqUqAaE1YPE=
X-Google-Smtp-Source: ABdhPJxByHzLGB6dnZw9C3tyzWLClUbQFe7uPPVU11CNLm61xcUez9IRDmLOmL7g5c+giSDBct6MIrOtZ7FswfM6Zm0=
X-Received: by 2002:a5d:584e:: with SMTP id i14mr5513557wrf.690.1642435308432;
 Mon, 17 Jan 2022 08:01:48 -0800 (PST)
MIME-Version: 1.0
References: <20211225054647.1750577-1-atishp@rivosinc.com> <20211225054647.1750577-3-atishp@rivosinc.com>
In-Reply-To: <20211225054647.1750577-3-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 17 Jan 2022 21:31:37 +0530
Message-ID: <CAAhSdy0Ja4HaHNvRL-bwJZTiiiFaP6M9d5m4ffgtZRgTmq9jvg@mail.gmail.com>
Subject: Re: [v5 2/9] RISC-V: Add CSR encodings for all HPMCOUNTERS
To:     Atish Patra <atishp@atishpatra.org>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        DTML <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 11:17 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> From: Atish Patra <atish.patra@wdc.com>
>
> Linux kernel can directly read these counters as the HPMCOUNTERS CSRs are
> accessible in S-mode.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/csr.h | 58 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 87ac65696871..e4d369830af4 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -89,9 +89,67 @@
>  #define CSR_CYCLE              0xc00
>  #define CSR_TIME               0xc01
>  #define CSR_INSTRET            0xc02
> +#define CSR_HPMCOUNTER3                0xc03
> +#define CSR_HPMCOUNTER4                0xc04
> +#define CSR_HPMCOUNTER5                0xc05
> +#define CSR_HPMCOUNTER6                0xc06
> +#define CSR_HPMCOUNTER7                0xc07
> +#define CSR_HPMCOUNTER8                0xc08
> +#define CSR_HPMCOUNTER9                0xc09
> +#define CSR_HPMCOUNTER10       0xc0a
> +#define CSR_HPMCOUNTER11       0xc0b
> +#define CSR_HPMCOUNTER12       0xc0c
> +#define CSR_HPMCOUNTER13       0xc0d
> +#define CSR_HPMCOUNTER14       0xc0e
> +#define CSR_HPMCOUNTER15       0xc0f
> +#define CSR_HPMCOUNTER16       0xc10
> +#define CSR_HPMCOUNTER17       0xc11
> +#define CSR_HPMCOUNTER18       0xc12
> +#define CSR_HPMCOUNTER19       0xc13
> +#define CSR_HPMCOUNTER20       0xc14
> +#define CSR_HPMCOUNTER21       0xc15
> +#define CSR_HPMCOUNTER22       0xc16
> +#define CSR_HPMCOUNTER23       0xc17
> +#define CSR_HPMCOUNTER24       0xc18
> +#define CSR_HPMCOUNTER25       0xc19
> +#define CSR_HPMCOUNTER26       0xc1a
> +#define CSR_HPMCOUNTER27       0xc1b
> +#define CSR_HPMCOUNTER28       0xc1c
> +#define CSR_HPMCOUNTER29       0xc1d
> +#define CSR_HPMCOUNTER30       0xc1e
> +#define CSR_HPMCOUNTER31       0xc1f
>  #define CSR_CYCLEH             0xc80
>  #define CSR_TIMEH              0xc81
>  #define CSR_INSTRETH           0xc82
> +#define CSR_HPMCOUNTER3H       0xc83
> +#define CSR_HPMCOUNTER4H       0xc84
> +#define CSR_HPMCOUNTER5H       0xc85
> +#define CSR_HPMCOUNTER6H       0xc86
> +#define CSR_HPMCOUNTER7H       0xc87
> +#define CSR_HPMCOUNTER8H       0xc88
> +#define CSR_HPMCOUNTER9H       0xc89
> +#define CSR_HPMCOUNTER10H      0xc8a
> +#define CSR_HPMCOUNTER11H      0xc8b
> +#define CSR_HPMCOUNTER12H      0xc8c
> +#define CSR_HPMCOUNTER13H      0xc8d
> +#define CSR_HPMCOUNTER14H      0xc8e
> +#define CSR_HPMCOUNTER15H      0xc8f
> +#define CSR_HPMCOUNTER16H      0xc90
> +#define CSR_HPMCOUNTER17H      0xc91
> +#define CSR_HPMCOUNTER18H      0xc92
> +#define CSR_HPMCOUNTER19H      0xc93
> +#define CSR_HPMCOUNTER20H      0xc94
> +#define CSR_HPMCOUNTER21H      0xc95
> +#define CSR_HPMCOUNTER22H      0xc96
> +#define CSR_HPMCOUNTER23H      0xc97
> +#define CSR_HPMCOUNTER24H      0xc98
> +#define CSR_HPMCOUNTER25H      0xc99
> +#define CSR_HPMCOUNTER26H      0xc9a
> +#define CSR_HPMCOUNTER27H      0xc9b
> +#define CSR_HPMCOUNTER28H      0xc9c
> +#define CSR_HPMCOUNTER29H      0xc9d
> +#define CSR_HPMCOUNTER30H      0xc9e
> +#define CSR_HPMCOUNTER31H      0xc9f
>
>  #define CSR_SSTATUS            0x100
>  #define CSR_SIE                        0x104
> --
> 2.33.1
>
