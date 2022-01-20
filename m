Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B327F495407
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346388AbiATSR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244513AbiATSRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:17:25 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C412C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:17:25 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d12-20020a17090a628c00b001b4f47e2f51so7861692pjj.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=7jmbFAZoe/0Han6gI2djD1GVPo4KRWYjMtQ4Zw3deJU=;
        b=f+BELza4AuuQ23XiU8+1ewgvZtVFgJgiMiFbei874Hw+syDHOYNnHcUXQ4xpw/9R8k
         TPa4c2/5kDGNk+j8nvoxsG6zcJS0ApIHl6/R2CzzZ4PWJQNebwrumXyiOX2jiqDwcNT8
         LnKcRb31H8fkVVX9vChfpJAwxj6JajBBFIMIyBHk3/iJB/QwfHV66t0OrjFdXnS848Xj
         zB9rklLTeMbpa8rKQ9MAIzgYBvV7UhBXlqnTwqXaJS+/3yUwX1bt7txkGAqS5mC9DDQK
         W/86vBAnOUCHUDR9XVNVyjLJ9EW3S7zN3hiIR+pagNuVHQKWOcqG5LTpggTIXqCfnZnt
         mLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=7jmbFAZoe/0Han6gI2djD1GVPo4KRWYjMtQ4Zw3deJU=;
        b=oORDYuvS6uRZVMRN7QY7Fnt8Q1nNV9UtvFGn+IAFl+03kIxd0/uQiQPhdwYGxJAPMP
         LoccdBm5rr0DJ1DOsjJxuXIN5bMBy5Umc3gFC93edvdNiDMgeIMIvCnLa345Y0Aw0+Qu
         Eln5aO0zcXCMEuQhQadQSGVYutG5Go3ZG1xmg6TbZyoTyOmUKLZukFLZsJLQfssJokmW
         iEPKt3LK1ulJqiIioFJo2q1LJWUER8Kqoam2fzpGUsKx5C6wu6bIts9WcdPY4ZihYLEG
         aeOBOMrU99AaCqTyIfP85KvVRpP9/lyaDxWrwEdmj6wckK3gRXYhUsCzvhIkbl8A0hbY
         7Iyg==
X-Gm-Message-State: AOAM5318MxAd3taz9u3ofndKzKDHegTH1U+SqM8cNp07FQDIR3nLIEpZ
        ec+dElMrAgDFsrDollWfOmWHTg==
X-Google-Smtp-Source: ABdhPJxfyuHTlrcI/Y+aEdEmUiAgy8Du+WABE60SAYyyZx8a9UnJxCSygRQkFRFIvKDxFAWsOie3ag==
X-Received: by 2002:a17:902:a3c7:b0:14a:d8bf:4e09 with SMTP id q7-20020a170902a3c700b0014ad8bf4e09mr215164plb.62.1642702645044;
        Thu, 20 Jan 2022 10:17:25 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id i1sm2996512pgt.82.2022.01.20.10.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 10:17:24 -0800 (PST)
Date:   Thu, 20 Jan 2022 10:17:24 -0800 (PST)
X-Google-Original-Date: Thu, 20 Jan 2022 10:14:17 PST (-0800)
Subject:     Re: [PATCH] riscv: canaan: remove useless select of non-existing config SYSCON
In-Reply-To: <20211229192458.25138-1-lukas.bulwahn@gmail.com>
CC:     damien.lemoal@wdc.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     lukas.bulwahn@gmail.com
Message-ID: <mhng-d060c520-cef0-454b-b6b6-0c75282bf8e0@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2021 11:24:58 PST (-0800), lukas.bulwahn@gmail.com wrote:
> The config SYSCON never existed in the kernel repository; so, the select of
> that config in ./drivers/soc/canaan/Kconfig has no effect.
>
> Presumably, this was just some mistake, assuming some symmetry in handling
> and naming of configs that simply does not exist.
>
> Remove this useless select of a non-existing config.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  drivers/soc/canaan/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/soc/canaan/Kconfig b/drivers/soc/canaan/Kconfig
> index 853096b7e84c..2527cf5757ec 100644
> --- a/drivers/soc/canaan/Kconfig
> +++ b/drivers/soc/canaan/Kconfig
> @@ -5,7 +5,6 @@ config SOC_K210_SYSCTL
>  	depends on RISCV && SOC_CANAAN && OF
>  	default SOC_CANAAN
>          select PM
> -        select SYSCON
>          select MFD_SYSCON
>  	help
>  	  Canaan Kendryte K210 SoC system controller driver.

Thanks, this is on for-next.
