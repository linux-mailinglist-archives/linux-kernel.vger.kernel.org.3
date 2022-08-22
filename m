Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8700B59BAD3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiHVIDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiHVICl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:02:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C142BB0E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:02:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n7so12150189wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=qfvk7aY5HgP2fwg3EbjPMxeYdfCR5gbK4JtKMjBePgU=;
        b=k5T1pyTjrnqdk47O1rzmQBh7nM1Wtzu+ui6GAXcFSuWj0tE4PH9d398xHcgnypAGsY
         cY9MT7L3YvV+SKrXw4dcc7mJqRcCmCro8BOvvhdme05fn0jT8sBzGqLuFrfYVEAHSa/t
         CSJ5/Q6kRKM4VMXpyIL7VyTGZzTWgkzbdw0qHoNgSrJfjZeXzJnfbCcaWs4CNsrBBNWA
         KRn2ZlN2TCC8SkNfImJ3p1MGqgT6A+qhrFdTafwtkRtyl7+gGCAE39nHb5bUp8hu1YSB
         Lurh++b06wTVBoH2AV1AL5udje0r3n7HWuXnFfjA/CSTOPF3CXaJc9BzyVKjSMR0gZAx
         JYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=qfvk7aY5HgP2fwg3EbjPMxeYdfCR5gbK4JtKMjBePgU=;
        b=g1z69YBvrZd87ohzFE8C5UlTYzkNlTE01fbV46B5Wfi1YYSb0gYPnUpb/UvTRuVGIv
         GerYdJPbGXu+esSk/h3nop3W2G4b7L0XQJqfhIF04MOuPK9GZ8lOlsY4QbNqTSIRSko6
         oFK1gzXTzdjUhygtr1gKkKh4aYlM9DwG7VMG+JwEaQBcvvUglov7U2XA9jBUDfE0OZhn
         +pJs0VNaBuHZ1zxV8kJIg/FoO5GGEJmdeA7foLdeisXKXTw8v6dZ7DxiSl9B9GyB+laC
         n2C4eVD8yfj3ow4yfVyTwP92t4jxYeDp08+ucS66zcN5EpkjIlAbrtRiSM7XTI2nCVYH
         vuGg==
X-Gm-Message-State: ACgBeo2/QfjMA9rfMfFi/TCfqTH3MisO44aylSkPscTlwadks7iYt0uf
        bA4OPTP5eJjyoBDd8qSbbbuoMg==
X-Google-Smtp-Source: AA6agR73Hx0m/e53/0Nz27DTWtP06P/S25zUjSJxOfyhh4hlwNgfzyBQ6bbtMruX1ytsdRu1C5bHpQ==
X-Received: by 2002:a5d:4703:0:b0:225:1fb8:860d with SMTP id y3-20020a5d4703000000b002251fb8860dmr10141827wrq.219.1661155333370;
        Mon, 22 Aug 2022 01:02:13 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id l24-20020a1c7918000000b003a5ca627333sm16573552wme.8.2022.08.22.01.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 01:02:13 -0700 (PDT)
Date:   Mon, 22 Aug 2022 10:02:11 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: enable THP_SWAP for RV64
Message-ID: <20220822080211.te3ifvu3xv4ye4p7@kamzik>
References: <20220821170559.840-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220821170559.840-1-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 01:05:59AM +0800, Jisheng Zhang wrote:
> I have a Sipeed Lichee RV dock board which only has 512MB DDR, so
> memory optimizations such as swap on zram are helpful. As is seen
> in commit d0637c505f8a ("arm64: enable THP_SWAP for arm64") and
> commit bd4c82c22c367e ("mm, THP, swap: delay splitting THP after
> swapped out"), THP_SWAP can improve the swap throughput significantly.
> 
> Enable THP_SWAP for RV64, testing the micro-benchmark which is
> introduced by commit d0637c505f8a ("arm64: enable THP_SWAP for arm64")
> shows below numbers on the Lichee RV dock board:
> 
> thp swp throughput w/o patch: 66908 bytes/ms (mean of 10 tests)
> thp swp throughput w/ patch: 322638 bytes/ms (mean of 10 tests)
> 
> Improved by 382%!
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ed66c31e4655..19088c750c7f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -45,6 +45,7 @@ config RISCV
>  	select ARCH_WANT_FRAME_POINTERS
>  	select ARCH_WANT_GENERAL_HUGETLB
>  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
> +	select ARCH_WANTS_THP_SWAP if TRANSPARENT_HUGEPAGE
>  	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
>  	select BUILDTIME_TABLE_SORT if MMU
>  	select CLONE_BACKWARDS
> -- 
> 2.34.1
>

That looks like a good idea to me.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
