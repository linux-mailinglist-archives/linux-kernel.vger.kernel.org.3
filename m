Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C384EE46A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbiCaXFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiCaXFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:05:08 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A80384
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:03:19 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id l129so949741pga.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=2CCcpvh2XGWbPM9M/zpJ8AlaZY9fUK8zkZbsqG9HonQ=;
        b=c+4JbtLZYQfpp4UUgiLn3PRoYFBp+b8pB/W22noI8XHsYu2tKZTpcijcrwlgpONvdZ
         C8hXgdKeRLr296aZiEjBMD4bps+jh+QWTYiMLzKZDm/kQ4kMhrpUcLmJqclVGbGIIiTR
         IKhmrBgq9FOwVWkZcBdUe27S23txXiKM/M7d4M9LdmIR9uDRc3bzmz2fmhbwsMwdqJUV
         uhqhsYaPoKK4AneGaXXDun/VrVJK/c6YeELYU8wf0XoXxva4WRij1vNphunQ56c07TDY
         FgJELbeMNeiARCVqD8ATyh2c2VZunm9SR6tsr9HDK7Q5RkAvBfi93io8IHinEX0AJege
         qcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=2CCcpvh2XGWbPM9M/zpJ8AlaZY9fUK8zkZbsqG9HonQ=;
        b=GlppMajYlT+52S16YoprQjRBNaApYjg6rim9Vw7jHUGEs2hGbCCAlZSsiGYK49utxF
         t8nslZ4kIXCmyy1YE+ASs+5zaIjC3WkDbnqjXq+WKJYMnhjKuH5KPl7ncwv37kLaBhmu
         Q45cPx/YMrMSMJk8ehxHmX0WAHWssHFgUrhTW+Z/VbaxHU4UbMsq/mxQrDJzA6eC/ovH
         pyCkulLRu6Nel1vRlqusxR0rmBS1s3qm6CW0/420lznfeGm0hEjuMzCTpIPCZ6c8lMBm
         Hq3D2F/EsoVsvBHRDF99agoP6EVKxHn7mn7sNZMelZGB0mlJU/umF0vj4ksYKPbw4qxW
         ilDA==
X-Gm-Message-State: AOAM531EMm+3jPSV/47+9kemL25qOxuGVu+Rfsq7QUFvfeBlaLRlJD9j
        jomjCuhdSG9P5D064hhB8vTlHzcWSPEXgA==
X-Google-Smtp-Source: ABdhPJwSN9YSkiKKWl6PHeYQKi/nk8XbJ4c2EzJfl0Ti/Mqi8zawqKbBU3ZPhgP71CyixCULa+DM+Q==
X-Received: by 2002:a05:6a00:13a4:b0:4fd:acb9:8ea4 with SMTP id t36-20020a056a0013a400b004fdacb98ea4mr7401523pfg.85.1648767798489;
        Thu, 31 Mar 2022 16:03:18 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b124-20020a633482000000b00382347caeeasm392635pga.22.2022.03.31.16.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 16:03:17 -0700 (PDT)
Date:   Thu, 31 Mar 2022 16:03:17 -0700 (PDT)
X-Google-Original-Date: Thu, 31 Mar 2022 16:02:53 PDT (-0700)
Subject:     Re: [PATCH] riscv: cpu.c: don't use kernel-doc markers for comments
In-Reply-To: <20220328220417.25675-1-rdunlap@infradead.org>
CC:     linux-kernel@vger.kernel.org, rdunlap@infradead.org, lkp@intel.com,
        Atish Patra <atishp@rivosinc.com>, anup@brainfault.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rdunlap@infradead.org
Message-ID: <mhng-2a49da2a-fd67-4655-9302-3f44030b7863@palmer-mbp2014>
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

On Mon, 28 Mar 2022 15:04:17 PDT (-0700), rdunlap@infradead.org wrote:
> Repair kernel-doc build warnings caused by using "/**" kernel-doc
> markers for comments that are not in kernel-doc format:
>
> cpu.c:89: warning: cannot understand function prototype: 'struct riscv_isa_ext_data isa_ext_arr[] = '
> cpu.c:114: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Atish Patra <atishp@rivosinc.com>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> ---
>  arch/riscv/kernel/cpu.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- linux-next-20220328.orig/arch/riscv/kernel/cpu.c
> +++ linux-next-20220328/arch/riscv/kernel/cpu.c
> @@ -69,7 +69,7 @@ int riscv_of_parent_hartid(struct device
>  		.uprop = #UPROP,				\
>  		.isa_ext_id = EXTID,				\
>  	}
> -/**
> +/*
>   * Here are the ordering rules of extension naming defined by RISC-V
>   * specification :
>   * 1. All extensions should be separated from other multi-letter extensions
> @@ -110,7 +110,7 @@ static void print_isa_ext(struct seq_fil
>  	}
>  }
>
> -/**
> +/*
>   * These are the only valid base (single letter) ISA extensions as per the spec.
>   * It also specifies the canonical order in which it appears in the spec.
>   * Some of the extension may just be a place holder for now (B, K, P, J).

Thanks, this is on for-next (still for this merge window for me).
