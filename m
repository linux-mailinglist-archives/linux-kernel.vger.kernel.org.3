Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70D054ED0D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379081AbiFPWFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378572AbiFPWFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:05:00 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91DE61630
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:04:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so1373082pjm.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=l7bNYgy+kj8u/jxC0moNwUt1/A1dWzpe6enKDLs3CYw=;
        b=vbp6VGbXIF+ANmagPv6oY9KhOIlXhEJ/vbaTYawbBSJUALwdTygMrXNi6hIbI2uVtA
         WDsDi0e7k+bgkXHlj45ijFbhfBjcycXF6UY5ZYfJ+MWZ0wn3tkcFEABG0WRFtdpVTpDX
         dGC0zHuucnNwJXo2U+7H90bxpNRp37Lp8v/wgZajKi09AnZ+nq6wN2ICLne/E6Qc4ASE
         pz3iw3f4no4zX/fQLqTUVnjjtSDz7V7RuU90fOB9lkGOpQrVPY6R1GnVjSjudzsMpJqq
         HTWXNrG2csc19lOCRuYMGtROF1jKTVT0wTQZTFK1pICfVcZrImaZdHtzr8mmIBtaKS8M
         xP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=l7bNYgy+kj8u/jxC0moNwUt1/A1dWzpe6enKDLs3CYw=;
        b=wQUUITfDU5OsYKs+6ofdVcHn7Filjt5xnFApQhh0lO85JHFZK5jdrYzOjC9BUlokbM
         WxA+TkOyRc/+BNB8Hi/by1qhkRZIOaxY31ZG8kEX6XtqvOffTX4/IPJOHfkmqJCtZAnm
         kgQeT2TtKXD53iBpI12pXU/e91AH2wLHUnlJFM6QS6J80KlXhGb/qhY2yhh2+wGgw4z+
         GRNPrnQFeG0fBg/rSBDdQ8A0eqcyyApsEkepyvdCp/f74dns1WhmU+OZzJimJO67GAUy
         Ro5/LjWuhPfATdD7Q3Av11HzJ+SmSXtGS6jV6/6xWjN7XdaPVT+eyiyBELi7mH2aRSeA
         9WwQ==
X-Gm-Message-State: AJIora9wKgFy1D5XlAOQxv5VbKc0EJcSVu+O/hryv2mIWeuN446SuniB
        5s7kYi+gypto9zREFcECg/ku9Q==
X-Google-Smtp-Source: AGRyM1u/yXpwyrUF4jgUMyqRVFRAoXSg7gMnc5yFVQgEn/9sJrmjQsFr4WOYlU3Q3XtOqdWvT2kljA==
X-Received: by 2002:a17:902:9348:b0:167:8e92:272f with SMTP id g8-20020a170902934800b001678e92272fmr6779739plp.77.1655417091611;
        Thu, 16 Jun 2022 15:04:51 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id r24-20020a638f58000000b00401a7b4f137sm2311093pgn.41.2022.06.16.15.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 15:04:50 -0700 (PDT)
Date:   Thu, 16 Jun 2022 15:04:50 -0700 (PDT)
X-Google-Original-Date: Thu, 16 Jun 2022 13:10:07 PDT (-0700)
Subject:     Re: [PATCH v2 0/2] introduce unified static key mechanism for ISA ext
In-Reply-To: <20220522153543.2656-1-jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        atishp@atishpatra.org, anup@brainfault.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang@kernel.org
Message-ID: <mhng-ea1ebe26-82ad-4a9d-b024-f6d79a0cb699@palmer-ri-x1c9>
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

On Sun, 22 May 2022 08:35:41 PDT (-0700), jszhang@kernel.org wrote:
> Currently, riscv has several extensions which may not be supported on all
> riscv platforms, for example, FPU and so on. To support unified kernel
> Image style, we need to check whether the feature is supported or not.
> If the check sits at hot code path, the performance will be impacted a
> lot. static key can be used to solve the issue. In the past, FPU
> support has been converted to use static key mechanism. I believe we
> will have similar cases in the future.
>
> Since v1:
>   - fix typo, thank Atish
>   - remove riscv_isa_have_key_extension() instead use the isa ext keys
>     directly as pointed out by Atish.
>
> Jisheng Zhang (2):
>   riscv: introduce unified static key mechanism for ISA extensions
>   riscv: switch has_fpu() to the unified static key mechanism
>
>  arch/riscv/include/asm/hwcap.h     | 25 +++++++++++++++++++++++++
>  arch/riscv/include/asm/switch_to.h |  4 ++--
>  arch/riscv/kernel/cpufeature.c     | 14 +++++++-------
>  3 files changed, 34 insertions(+), 9 deletions(-)

Thanks, this is on for-next.
