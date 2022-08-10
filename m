Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467FA58F410
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiHJWBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiHJWBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:01:40 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30AD7539B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:01:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id f30so14533059pfq.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=cXkIXWAtOObzXLLs0JK1VS3v3NYatO+E+AbHXcyxbO8=;
        b=epkd/T3Sdy5WWIAzTsY+RIvIBGCV2pdijlqKEcTRVkcZP2zB4m395tw25c0sfpf8Pf
         qySOZhCgTGtGPbmg5nxge5SjbUwEzi6dhMlwHjce9ku5R8wNIbMzI8Pvcu1vZGAKanyz
         aYcV5hO2V3gxd9Ac8QDwmdx1uOwnShq4GsxCHyeOCPxmTAd8y13dOhMKgRhUb5IeSqFY
         0dBLcoDpuc4l+jIg+MX8++iRWItA0wM1l5M+MHh01SoaLz58ZbLa03nofWSNTx5/5/HB
         GnHMfrV9a/7vzRi8sUbzLzxqDkbMspNbSaxg1kpYGxN1UcJ7a4nm0D09tro/3ICQqY8x
         Q7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=cXkIXWAtOObzXLLs0JK1VS3v3NYatO+E+AbHXcyxbO8=;
        b=AoXwqB7Ngo6LocqA2vVOEDw/4aPRFNGetuGjv8OZ2O7PemYjTSZkkTCbX9WJYHl8ER
         oFGnyaeC969Czt/2+6Kbz6CEM5mlLRgZHyqPXO8BXK8CZIL++5tu7Dp3UuncSr1M7Mb9
         3uEB4DuReRUlEAz3Uz4DxiB6ke1BanQSYRXBcKkX9j7R9U8b6GK+m8k2w5KATjJ0Fx9D
         IBvnKfHvlaHcJWBwFccL7Wfu5HDMwDnfnWMTT/24sYg93RRRcF30qm1YuiIV6prELxnz
         HaQrU6ReJnToqINNVjXrS/R7Wv2YrvKnrGU3k6m3RRa/sZjU36/gbIH/yQslzdh87I+u
         P9ZA==
X-Gm-Message-State: ACgBeo0EiYjEB10F6F99iNzUjAJR3Bn2jYglgrquoPqMeyJRrRZHMkY4
        bDf7xdbEsKWP8m3Fc4AkVAPatg==
X-Google-Smtp-Source: AA6agR5tV2c8wULAW9sAh62jzI6dSdkw2SZ+vNp159CGu9SfmAaGbNovIy6f1pGSJm/qnAUDLQfAMg==
X-Received: by 2002:a65:6494:0:b0:419:9527:2a69 with SMTP id e20-20020a656494000000b0041995272a69mr24315484pgv.80.1660168899103;
        Wed, 10 Aug 2022 15:01:39 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y8-20020a634948000000b004129741dd9dsm10228669pgk.51.2022.08.10.15.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 15:01:38 -0700 (PDT)
Date:   Wed, 10 Aug 2022 15:01:38 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Aug 2022 14:19:00 PDT (-0700)
Subject:     Re: [PATCH -next] riscv: lib: uaccess: fix CSR_STATUS SR_SUM bit
In-Reply-To: <20220615014714.1650349-1-chenlifu@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        akira.tsukamoto@gmail.com, jszhang@kernel.org,
        wangkefeng.wang@huawei.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, alankao@andestech.com,
        chenlifu@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     chenlifu@huawei.com
Message-ID: <mhng-a84e0f82-f7c1-4f91-9cc1-70e3dd9d7e4e@palmer-mbp2014>
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

On Tue, 14 Jun 2022 18:47:14 PDT (-0700), chenlifu@huawei.com wrote:
> Since commit 5d8544e2d007 ("RISC-V: Generic library routines and assembly")
> and commit ebcbd75e3962 ("riscv: Fix the bug in memory access fixup code"),
> if __clear_user and __copy_user return from an fixup branch,
> CSR_STATUS SR_SUM bit will be set, it is a vulnerability, so that
> S-mode memory accesses to pages that are accessible by U-mode will success.
> Disable S-mode access to U-mode memory should clear SR_SUM bit.
>
> Fixes: 5d8544e2d007 ("RISC-V: Generic library routines and assembly")
> Fixes: ebcbd75e3962 ("riscv: Fix the bug in memory access fixup code")
>
> Signed-off-by: Chen Lifu <chenlifu@huawei.com>
> ---
>  arch/riscv/lib/uaccess.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
> index 8c475f4da308..ec486e5369d9 100644
> --- a/arch/riscv/lib/uaccess.S
> +++ b/arch/riscv/lib/uaccess.S
> @@ -173,11 +173,11 @@ ENTRY(__asm_copy_from_user)
>  	ret
>
>  	/* Exception fixup code */
>  10:
>  	/* Disable access to user memory */
> -	csrs CSR_STATUS, t6
> +	csrc CSR_STATUS, t6
>  	mv a0, t5
>  	ret
>  ENDPROC(__asm_copy_to_user)
>  ENDPROC(__asm_copy_from_user)
>  EXPORT_SYMBOL(__asm_copy_to_user)
> @@ -225,10 +225,10 @@ ENTRY(__clear_user)
>  	j 3b
>
>  	/* Exception fixup code */
>  11:
>  	/* Disable access to user memory */
> -	csrs CSR_STATUS, t6
> +	csrc CSR_STATUS, t6
>  	mv a0, a1
>  	ret
>  ENDPROC(__clear_user)
>  EXPORT_SYMBOL(__clear_user)

Thanks, this is on for-next (still for 5.20).
