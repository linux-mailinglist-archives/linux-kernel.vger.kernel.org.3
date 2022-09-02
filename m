Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641645AABC5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiIBJuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbiIBJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:49:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21D42F2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:49:56 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso1111114wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=5jgqKei2zXKIzWLNZrfShPq80y4Jd5xdvtwvka6rR5g=;
        b=gT4EYfkdJm6NNpuDd4QvJP+nWZB5+2rUmtLF8NrqqGX362cCUM0dUYepuvZ4IBt1YY
         KLYKIhjg1nlbX/LI2CsJbapnfqaRK+k3Cm4saCElj/cmisJhs6/ahVX6sDWTEDJYideI
         7uuFSY4Z4X+RDwuhkIzZ/t56PKjWrie0B+w13SyjHi57HZcuLSu/YPbQdAuOFtRVZNDt
         pPxdLJ8gQV8S2z2TgSyc2yzzxjvxbmSxuBM43tAW24Q2Wezr9S1FQ6Mt73S/mCQyiHWO
         kCfuydMlfsjg6/pBsiUO7VCszMaSnD2aU+9n1GMK7XcCvpD5B0aQYgk+BaKc/MsA0Wr/
         viFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5jgqKei2zXKIzWLNZrfShPq80y4Jd5xdvtwvka6rR5g=;
        b=xlfzExLuWfZjxlPCsSJwQNio8OGRbr7OqhCjNuaYcV1mQz4hxjQibGPoal7nGsnR/r
         GYKoXZ4CzivpmoChcfqqDRhWVDAbidc7y+TGOaWhSZRmbcu40A3S3fHSdQjB8Wo8oOSr
         bqOM9f9cySVWFfya3ibGiEs54fhKMU0bf+AuM7EToO9MY4uefV3DIVFK+EmMUj+1EjAQ
         Jk2ReefP8DxymM5eN7ksJsB8Nv7C3o8QTt/epGyBj1mOtdcPsyaTtcvuCJ/MG++1RTYl
         ZMo7CwWXnbiq8iFf2lh80NUI782m2S7cB7v1U7kpWXhRf1vKX6bBeHSlfO+Zzy6ZVrC2
         c8Gw==
X-Gm-Message-State: ACgBeo3odfUYqmCArZEXXBNh3v4/Qn5hW1V17DmOH7fzANkmiYdXYuBn
        ZhwhYrDBdC8dYjMQN6ZXDDJM0A==
X-Google-Smtp-Source: AA6agR43cZGDFm+PQO3dwQr4fi68wE9MYBX9MebvlYdc9RdgxwtO1X/wxn+rVFo3orUQpfZifHJ3FQ==
X-Received: by 2002:a05:600c:4f10:b0:3a5:f8c8:a5b5 with SMTP id l16-20020a05600c4f1000b003a5f8c8a5b5mr2235058wmq.34.1662112195250;
        Fri, 02 Sep 2022 02:49:55 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id e2-20020a056000120200b0022529d3e911sm1066172wrx.109.2022.09.02.02.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:49:55 -0700 (PDT)
Date:   Fri, 2 Sep 2022 11:49:54 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        guoren@kernel.org, apatel@ventanamicro.com, atishp@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] riscv: drop some idefs from CMO initialization
Message-ID: <20220902094954.xu4y6kradqrtd2jz@kamzik>
References: <20220901222744.2210215-1-heiko@sntech.de>
 <20220901222744.2210215-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901222744.2210215-2-heiko@sntech.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 12:27:42AM +0200, Heiko Stuebner wrote:
> Wrapping things in #ifdefs makes the code harder to read
> while we also have IS_ENABLED() macros to do this in regular code
> and the extension detection is not _that_ runtime critical.
> 
> So define a stub for riscv_noncoherent_supported() in the
> non-CONFIG_RISCV_DMA_NONCOHERENT case and move the code to
> us IS_ENABLED.
> 
> Suggested-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/errata/thead/errata.c    |  7 +++----
>  arch/riscv/include/asm/cacheflush.h |  2 ++
>  arch/riscv/kernel/cpufeature.c      | 22 +++++++++-------------
>  3 files changed, 14 insertions(+), 17 deletions(-)
>


Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
