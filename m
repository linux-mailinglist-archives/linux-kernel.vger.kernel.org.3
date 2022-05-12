Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0757E524471
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347866AbiELEog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347686AbiELEo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:44:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5F32AE01
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:44:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h16so4842591wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxm9sBcT1JV50HT4BCEDwPzwOlOzL6NEeugrpnzL0Jg=;
        b=panjBDErMFFeS1mpF1owMJAimp+H0bnPlz5Y2undu+JiEi0GPmaur6O4CzEKXus9v5
         Lw6Cqq1AX+NKjHUHxrSj6ibfkgpRNr9Ri/V4EWqF+kENnpoZCGkkphIgOPxwCL9ZHCTu
         fheb6cBnTch8v8xfGsOOxZrQKDn9XG5Kpi9J4rjbxJzuc0VnKVT/+zYJRJxOBYagb2mw
         /D9Lu9GITyoKqhvIzRsyqqLoDfJcIO9IUjmrsGNaT/3nMkXDsiRyPFYcSDkmxxTD5Osq
         mb3VFuEq6babUntnsclMHKP+QgSW/oHuit20EQTABbJI0zudfPflBr1yTSearkElGonP
         NFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxm9sBcT1JV50HT4BCEDwPzwOlOzL6NEeugrpnzL0Jg=;
        b=Rhuq7lC3TmSyhjqfCgD+kXqb80ZpRLrhah9SdJ41EJY1yOUAgVpCf1CuYK6o83nIkG
         kYVL5J1nucAKAiWK7O/OZEj4DhGPjrjPyOM7CtG+xT94Z1LT4tPDDXIq70nhVNdj3arE
         fsEes/3lq92xIf0a56NCfsc3MQyqM9yl4nxafZVltFuCChGBFetfvTm1/tgpa4oANRmZ
         jYJAWlrBbTA8cc6zjCde4DOfhScXV7Cvo9nNAEpYLYWV9VAR9GLA2qXpmLf+9bJ3pyn8
         KboPknhMlxcQDcLnCcECH+QcoOAwGvzGm/h859k+1A3BC4bXKH5uR6pxjDiZjcNj/eJF
         sYcA==
X-Gm-Message-State: AOAM533eozcKj32G/nCMQuJm/KwAfz9RRC+wizT53NnyyuHbBeTVehWJ
        Iz5WreybzNRbBWjyzxGFZYbyUIdDRxdMplg/hYwT3Q==
X-Google-Smtp-Source: ABdhPJzloFL8RAJGSh+cL9RNr8ybTq+w+uIZ+h1jRU55tsWHFmEuU068Wy0E4qfo4o4VW9DKpgQ7ocMtsolbEb1xNFE=
X-Received: by 2002:a5d:6c6b:0:b0:1ea:77ea:dde8 with SMTP id
 r11-20020a5d6c6b000000b001ea77eadde8mr25588160wrz.690.1652330664582; Wed, 11
 May 2022 21:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220511201107.2311757-1-atishp@rivosinc.com>
In-Reply-To: <20220511201107.2311757-1-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 12 May 2022 10:14:12 +0530
Message-ID: <CAAhSdy3mbGdK9LrLxZX0JL0mQxP5FrFUuneX1cQS2SABpO=7dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] RISC-V: Fix counter restart during overflow for RV32
To:     Atish Patra <atishp@rivosinc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 1:41 AM Atish Patra <atishp@rivosinc.com> wrote:
>
> Pass the upper half of the initial value of the counter correctly
> for RV32.
>
> Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index a1317a483512..24cea59612be 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -526,7 +526,7 @@ static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
>                         max_period = riscv_pmu_ctr_get_width_mask(event);
>                         init_val = local64_read(&hwc->prev_count) & max_period;
>                         sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx, 1,
> -                                 flag, init_val, 0, 0);
> +                                 flag, init_val, init_val >> 32, 0);

This should be under "#if __riscv_xlen == 32".

>                 }
>                 ctr_ovf_mask = ctr_ovf_mask >> 1;
>                 idx++;
> --
> 2.25.1
>

Apart from above, this looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
