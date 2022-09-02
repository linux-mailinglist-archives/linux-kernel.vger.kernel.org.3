Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CC15AABD0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbiIBJuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbiIBJul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:50:41 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C1A3C8C3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:50:35 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id az27so1597473wrb.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=6m9i/YdC17oU5bWU5Nzi6bcvOSQonOoItkoL6SM80y0=;
        b=I60SNYse1k+1KUciSMADRTx4OhCmqmIaHVnumZp4iIatz/OM7uw/eExyQSE0QB0QSf
         Triqqa28BSdrnFA4nMxHRssXWwQDyJIhQLDlfM+fmMvN6YrmQp/tPG32JLsThN4vCz7N
         /mhjez1zuBOXht8GazgaPHwAoTkB1qGaJ4MD1hRf81DDHb/MjMwG6ze9NGc/B7FthDiN
         SKISFIeYjVjlZXrw43I9e099GWWryvR3HIndYVWFXy8HJ+AvNwG4RAXwxExNRVjyAMdB
         Nm4QL3dQmajabtO1Q9bky2yihw2pdGYY/DWbdALBupezlgRHPyIagAw8VFHFjKPck702
         0T8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=6m9i/YdC17oU5bWU5Nzi6bcvOSQonOoItkoL6SM80y0=;
        b=bJ0+am2r97H56HnrjszyhNW09gzNfgGwhARh4APXluWNji3JETAZ15G58AfazLJkxX
         k0+AAYfiioyydgfqoLVje4rQ9TlerS8IMlukcDO8ZahBoMyuQM2Sw9SlyoeRNe5nK3kq
         t4PElQcz56F1Vi/on8OtT0aNHZ8cmYZDlR6gXGATaa+iD/U9w7jorH5j0DuCpMBJaRTx
         m8dc4YO0AsP6mM5EpIS3Zk6ZoCrRr2r7tx8e1PWY2IDej1kEWfCde9dpsn50goHqFSo9
         OjhBIyPgmRzTRlvS7gxU1V2d0csXM463t/DiFkRXOHrgDy6XKdTn6R+MeAYZLVUt431t
         IKNQ==
X-Gm-Message-State: ACgBeo1ISsnAzUF9uGQg68ShzquF3BPxX8W5k1VBgdvwMW3AT1whEYHQ
        oTw8nn6o0UsZwxibe4Vg0v6QzA==
X-Google-Smtp-Source: AA6agR4rmLi+seS1O0PEpKug73BsNm2A2qb7kETj9vlCiD5QnmtKOSPBQ2qyNhnBjen3DR7zu0b5iA==
X-Received: by 2002:adf:eb4c:0:b0:220:6aaf:ef5e with SMTP id u12-20020adfeb4c000000b002206aafef5emr16244619wrn.488.1662112234024;
        Fri, 02 Sep 2022 02:50:34 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003a31fd05e0fsm17483957wms.2.2022.09.02.02.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:50:33 -0700 (PDT)
Date:   Fri, 2 Sep 2022 11:50:32 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        guoren@kernel.org, apatel@ventanamicro.com, atishp@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] riscv: cleanup svpbmt cpufeature probing
Message-ID: <20220902095032.h3yrady6lxmqqwvy@kamzik>
References: <20220901222744.2210215-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901222744.2210215-1-heiko@sntech.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 12:27:41AM +0200, Heiko Stuebner wrote:
> This can also do without the ifdef and use IS_ENABLED instead and
> for better readability, getting rid of that switch also seems
> waranted.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/kernel/cpufeature.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 553d755483ed..764ea220161f 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -253,16 +253,13 @@ void __init riscv_fill_hwcap(void)
>  #ifdef CONFIG_RISCV_ALTERNATIVE
>  static bool __init_or_module cpufeature_probe_svpbmt(unsigned int stage)
>  {
> -#ifdef CONFIG_RISCV_ISA_SVPBMT
> -	switch (stage) {
> -	case RISCV_ALTERNATIVES_EARLY_BOOT:
> +	if (!IS_ENABLED(CONFIG_RISCV_ISA_SVPBMT))
>  		return false;
> -	default:
> -		return riscv_isa_extension_available(NULL, SVPBMT);
> -	}
> -#endif
>  
> -	return false;
> +	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> +		return false;
> +
> +	return riscv_isa_extension_available(NULL, SVPBMT);
>  }
>  
>  static bool __init_or_module cpufeature_probe_zicbom(unsigned int stage)
> -- 
> 2.35.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
