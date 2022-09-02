Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4DE5AABC8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbiIBJuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbiIBJuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:50:22 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B021A396
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:50:08 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id d12-20020a05600c34cc00b003a83d20812fso1090380wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Al0u2EnKXEN1We5y1Vdc99pOhODJDsfB1Amsd4z1Fik=;
        b=V8x+m18r1y+Aw5UDzSjg125HFeFtgIqdv9xxGxYLwCcbCzpbBH8FhFYgO2+4SOD5HZ
         I1jwfeN+FfI8OLdlxK61jB2IMF/T83Tzweekx0WiMTLoP6OwYflBNBXKILLqqVuv39Wq
         ArsnwoyhWZi111CPt2s5QCmNFvum+J/G1g3nY8Xac6/l2bw0St/OpFnEf2nq3DK90sXu
         hASysSwGlj6QCpOOk0rdARSt/BKTmLKv8pA6kS1sWvOA9DJPHOtotKOylFRLR56CGkU1
         JGg4pufW9kmhy7vUZaabhbnk59U5slaR4Ch2AwGXzqEwIoX2b/I1WxYMKUsBAfbQh10Q
         9HSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Al0u2EnKXEN1We5y1Vdc99pOhODJDsfB1Amsd4z1Fik=;
        b=3j2Fnl/L91pCITyE6GttIcjnyTgyrozSBcsWYXt5TdkZEeVKDRExgbEBUD8BPiNIl+
         YlZSM23N/mnMnq7ZN5fxOhKKBYwyG/pXQxjqYCVSMA/FDOro8cAnoyFm2L/fKF9bulKn
         oLTlsTiN9QhKTNTNok+S2NFQE+/epv3QvVtQUoRyhC02GI3Bv7g3gExKynY2iQ8BTr0i
         VclJ7vM+SnZZpHITeBnllyriXHe8hpgtRK1Ic75dOtED+V9GbX4bby9tI+HtoxQuhn3u
         eF0XVq8BwZCUhG6AefJw6W+IcsgCt9N9X+pRonj8Porj2HDDZ/MBJcHjMDbBEWTeVTX2
         katg==
X-Gm-Message-State: ACgBeo07qrSJE5FCXeLWZSRnQ2y8iUEAeLruPNwSI35WsoX1Anz3oQ4O
        bEb7I1qrZNkBxBkutPl8Pb16Ag==
X-Google-Smtp-Source: AA6agR4xNc4ZeI5upz/fIRrD5ia2s1reCgd23iplWkpSjKHxsrYNVdUvoMyJ+ILBVSCr0th7052S3A==
X-Received: by 2002:a05:600c:3508:b0:3a6:10a9:8115 with SMTP id h8-20020a05600c350800b003a610a98115mr2304045wmq.164.1662112206863;
        Fri, 02 Sep 2022 02:50:06 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4141000000b002258413c310sm1091598wrq.88.2022.09.02.02.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:50:06 -0700 (PDT)
Date:   Fri, 2 Sep 2022 11:50:05 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        guoren@kernel.org, apatel@ventanamicro.com, atishp@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] riscv: use BIT macros in t-head errata init
Message-ID: <20220902095005.gbxsrrllfis3yi5g@kamzik>
References: <20220901222744.2210215-1-heiko@sntech.de>
 <20220901222744.2210215-3-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901222744.2210215-3-heiko@sntech.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 12:27:43AM +0200, Heiko Stuebner wrote:
> Using the appropriate BIT macro makes the code better readable.
> 
> Suggested-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/errata/thead/errata.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index bffa711aaf64..a6f4bd8ccf3f 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -49,10 +49,10 @@ static u32 thead_errata_probe(unsigned int stage,
>  	u32 cpu_req_errata = 0;
>  
>  	if (errata_probe_pbmt(stage, archid, impid))
> -		cpu_req_errata |= (1U << ERRATA_THEAD_PBMT);
> +		cpu_req_errata |= BIT(ERRATA_THEAD_PBMT);
>  
>  	if (errata_probe_cmo(stage, archid, impid))
> -		cpu_req_errata |= (1U << ERRATA_THEAD_CMO);
> +		cpu_req_errata |= BIT(ERRATA_THEAD_CMO);
>  
>  	return cpu_req_errata;
>  }
> -- 
> 2.35.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
