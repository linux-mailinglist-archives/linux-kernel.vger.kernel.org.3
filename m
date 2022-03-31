Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAFD4EE2A3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbiCaU37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbiCaU34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:29:56 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A4F2414EB
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:28:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so580555pjm.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=bnq3RGPMzBMV/g9aWknvx9FGXd6IFr5H5AAWOs4ymHk=;
        b=1uYsPp4Tl1AUltqW3P44nhWS7GvP4CJgKOhn+4VSW6tjebojOna8+DqcXGZ9k0L/qg
         /kFWpO1A9VCxXURXGLxWREhOlFDrf7SGsxEcHzf+/1uE2v7LBC1dWVqweOKhApxLgw9D
         amggZOnWK8/4wpWGOGhiK4cjY2SQMXyCD0VEruU0dGq6NnWYK88rwYoSegTMJzw1+tk3
         HxcB/8JTpf60c1hpvFHq7hYKJ2LX9yB1v55R/v8Dni9DydCTumhK63hi5FUT8HXbvn5w
         bDcJd/qTfwfOiArpTbcdXfkKKBEw5RYSV5PG8FRRIY48vM4BJn5dkI4bFNb4KeQt435X
         zj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=bnq3RGPMzBMV/g9aWknvx9FGXd6IFr5H5AAWOs4ymHk=;
        b=ozqmi4Rf4ZAo9WUMw5Z/cf7sJ54/J45QjWUKmdjkv0kGyO9ES1HSfRXPhU8P1OGS9g
         AAxsRkVIHFF4cyLZLsHSOCrFDrZD6p9Hw2LeOCKyjLtAs/Wf5cSR7OOagi+1bqAFpzBF
         qhlDU2WK+YGdOwZI/V8l4TxoFZ6mZ16HihrUxMT8zUccSolvQ16CQEpoM5BudbghEr7j
         iEYwnm6kVwwhl1L9bc1QJyAjCsCAUG3OkpoZUo/lHg+WjS65Mtzyo7XZR2FAJL16Vzad
         FFhYlDBFbuBVbunLg6NJ4Ycj/Fsjy+dGYnX3JV3GdPepOFLh4u8m4EDGaGboOs/Mj5eY
         JbUw==
X-Gm-Message-State: AOAM533q5DR91stSwnJI8Bw9aLQTBVoy0R6ABnhSEeSSbfkR73dYDnmI
        h45Sxsqm76DGXk8fh0GFjwW3d5imCozMNA==
X-Google-Smtp-Source: ABdhPJz8WAGQPMzQnR1/kKYbzZSKsNbVNJ28AVKuGN4my5flJHiGhwEnQ3iZcV5Chnf26dEqytnXVg==
X-Received: by 2002:a17:902:f544:b0:154:5ecb:eb24 with SMTP id h4-20020a170902f54400b001545ecbeb24mr7143398plf.11.1648758487456;
        Thu, 31 Mar 2022 13:28:07 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090a390d00b001c995e0a481sm203407pjb.30.2022.03.31.13.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 13:28:06 -0700 (PDT)
Date:   Thu, 31 Mar 2022 13:28:06 -0700 (PDT)
X-Google-Original-Date: Thu, 31 Mar 2022 13:04:31 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Declare per cpu boot data as static
In-Reply-To: <20220323171726.1303706-1-atishp@rivosinc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
        lkp@intel.com, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        anup@brainfault.org, damien.lemoal@wdc.com,
        devicetree@vger.kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski@canonical.com, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <atishp@rivosinc.com>
Message-ID: <mhng-00dae2b9-e45c-43c7-a67d-75c937215a19@palmer-mbp2014>
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

On Wed, 23 Mar 2022 10:17:26 PDT (-0700), Atish Patra wrote:
> The per cpu boot data is only used within the cpu_ops_sbi.c. It can
> be delcared as static.
>
> Fixes: 9a2451f18663 ("RISC-V: Avoid using per cpu array for ordered booting")
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/kernel/cpu_ops_sbi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
> index dae29cbfe550..7f2ad008274f 100644
> --- a/arch/riscv/kernel/cpu_ops_sbi.c
> +++ b/arch/riscv/kernel/cpu_ops_sbi.c
> @@ -21,7 +21,7 @@ const struct cpu_operations cpu_ops_sbi;
>   * be invoked from multiple threads in parallel. Define a per cpu data
>   * to handle that.
>   */
> -DEFINE_PER_CPU(struct sbi_hart_boot_data, boot_data);
> +static DEFINE_PER_CPU(struct sbi_hart_boot_data, boot_data);
>
>  static int sbi_hsm_hart_start(unsigned long hartid, unsigned long saddr,
>  			      unsigned long priv)

Thanks, this is on for-next.
