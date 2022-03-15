Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E69B4D92D8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 04:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344573AbiCODLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 23:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbiCODLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 23:11:03 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED093EB89
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 20:09:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i6so21774wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 20:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LEEwRw8+0oWuduV8yqxbjfqDtS7mxY03eu7dCRX8Jmk=;
        b=D73mRn9qJPT/lNMgz1PI6Ul2I3MQY+JMoB5S5t1vU3cz1uquuRX5ykZbF6gV0j2b07
         V4pxr9+sP5cj+BxujKLiC6XGCmpy0EFHXZL4XLtrY+9EEHdzeePt3EeCbhxBna5uRtUO
         +w9hzl8kSyToqOLNNU/4fCsHPuhg9vfeFQvXt58KVAB5X07oPtgH35or2cG297J/sUVO
         g1tHrGS+bsejIDsGIerLDZAk3KKVaX8NrmKqkj4v0dzBL3ppuqbIr2TE3T6kAEHKpMjJ
         1RyLzDplSxFbkNpJNDghAMLKx81gQx2cNm1UHEAbIM7FyaABoDbW9NGo6W/zJYTH2e7Y
         uE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LEEwRw8+0oWuduV8yqxbjfqDtS7mxY03eu7dCRX8Jmk=;
        b=M+fRFyVZ11VEFDI6cMuqLk4NKigWJMdYwVJgZwXjJLZ+eGrRdDR9g/uiTvtkIFMdYU
         Wr0yVDglX5ASNgLP/yBo0/EWeoqLUWlelHyreZWHuJvxgQiMX2UMsTYoDxiwh/gE0ioh
         nwBoE/gBeiBykCLVKEG0UO15En+wJ3OhGBHvikWDitwu9ejkT0x4kPPgx2xhJao5xoK1
         lmV78zpNL7+FvrK28UrHLGDumeGdtVu2kEUuK8Bt10sGj5xpm1K2kiS253ERnHkKVWnu
         rXdRpDL6MvwAy+4kXtA89vY9wVjm26lhTgjF4Y+GENWo8EFwS8FHLJPN62+ClzHOutoM
         4nQA==
X-Gm-Message-State: AOAM533XVuvzHeGA4YYk/Ml0ZTjyznmyXcdz5WNimfKqxcGEMDsLw9xO
        L/cPIYzaSi22uvU1I3BALb1Jh7dukRN4XSLGdNs3NQ==
X-Google-Smtp-Source: ABdhPJxMLszud/s52lgLbocLUt//aWIhTSEqW5XvUnf3pW3nxpRuNWQiJaZxYVdb1AqBk7JLjx7cPIYSElDxkulSEyo=
X-Received: by 2002:a05:600c:3c9c:b0:389:cc3b:9462 with SMTP id
 bg28-20020a05600c3c9c00b00389cc3b9462mr1529325wmb.105.1647313790542; Mon, 14
 Mar 2022 20:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220314203845.832648-1-atishp@rivosinc.com> <20220314203845.832648-6-atishp@rivosinc.com>
In-Reply-To: <20220314203845.832648-6-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 15 Mar 2022 08:39:37 +0530
Message-ID: <CAAhSdy0E=UssRZN1NwmvOMcxVHhDDghU1_w2PuZEAYkuDcmqag@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] RISC-V: Do no continue isa string parsing without
 correct XLEN
To:     Atish Patra <atishp@rivosinc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        DTML <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 2:09 AM Atish Patra <atishp@rivosinc.com> wrote:
>
> The isa string should begin with either rv64 or rv32. Otherwise, it is
> an incorrect isa string. Currently, the string parsing continues even if
> it doesnot begin with current XLEN.
>
> Fix this by checking if it found "rv64" or "rv32" in the beginning.
>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kernel/cpufeature.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 3455fdfd680e..a43c08af5f4b 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -84,6 +84,7 @@ void __init riscv_fill_hwcap(void)
>         for_each_of_cpu_node(node) {
>                 unsigned long this_hwcap = 0;
>                 DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
> +               const char *temp;
>
>                 if (riscv_of_processor_hartid(node) < 0)
>                         continue;
> @@ -93,6 +94,7 @@ void __init riscv_fill_hwcap(void)
>                         continue;
>                 }
>
> +               temp = isa;
>  #if IS_ENABLED(CONFIG_32BIT)
>                 if (!strncmp(isa, "rv32", 4))
>                         isa += 4;
> @@ -100,6 +102,9 @@ void __init riscv_fill_hwcap(void)
>                 if (!strncmp(isa, "rv64", 4))
>                         isa += 4;
>  #endif
> +               /* The riscv,isa DT property must start with rv64 or rv32 */
> +               if (temp == isa)
> +                       continue;
>                 bitmap_zero(this_isa, RISCV_ISA_EXT_MAX);
>                 for (; *isa; ++isa) {
>                         const char *ext = isa++;
> --
> 2.30.2
>
