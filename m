Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5EA47480C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbhLNQ3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbhLNQ3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:29:24 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E57C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:29:24 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v16so1521133pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=F8tZTjHZ2yYRN1+Oex1t1Eoc2e/x1cydqgGYoHqswK8=;
        b=cswel/OaN5GDEddQIq4I2K+ubcGjJqWOxWC9f2jDmASgcA/ilqszRlMTXm9zjaJW+d
         U89llEIjBslM64rCcikMvCK4PI2bNIQcfFab2JhVTX8bFcACOFrtMztxsVpP8QddK7E2
         /nwoRLiz7iB0gss/dapd4H47nQGztvAU89mz9Fku05rS7TCMyzA4nqvSHoqwJ7V469vD
         nDA53TbvZ2MZMdmRO/F2fM7zL53+iPPhFb3Z7GPxRtHVFGtL+ihAno6e3UOW5Z51y3O7
         12KVCE+XHe0azHQULWYsdQWOHexxR3+xkJQIKRiyQSZWe9JJ6kx61KAUkTyYwyg74wQJ
         X8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=F8tZTjHZ2yYRN1+Oex1t1Eoc2e/x1cydqgGYoHqswK8=;
        b=fVAK0F+kqpo5sh3vCRFx86UWcpwB0lcfOVTcK8n1vsioi3I9XkfT0HoveQCi/h372O
         Bjs7SDrah9thdHGgWaKkmCBMDQn8+JBa3BpVNumoYJc6WwS7LCgBMdMnqWPbR8Hk3aKh
         bonNweCj4hSYAeuh5/UzBCAg7VF8hgwC4IQ3SiBs0PmOihs6RnPrKhMeC3+GTrZMHj4r
         etRYSwS7k1ZMlC3oDim7mdG0ylvoxAopS6h0I26cHJ1CI6aqzgpnVqRX6gay+5k8/uXb
         3WX48U0cHPONteX4FuI9lOkQ8jrW9dOJK3GOo/VBVMQCw/AsNiTQNTf7xYVi7jYvdaM1
         kZgA==
X-Gm-Message-State: AOAM530m1c3IBoYR/mhScXBtrq64cemQYZpd7Gvr64XsH8d1mEZgYBQf
        xxioYfu/K2VRShpIYOFmKFUg+Q==
X-Google-Smtp-Source: ABdhPJxreadDsRSfHcV9rVxes+7EwTLlJoBtYfZ9LcUbB4BFQCx9KbhdF7JA41d0ANFwXPxztbToGw==
X-Received: by 2002:a17:90a:fd96:: with SMTP id cx22mr6633392pjb.151.1639499363669;
        Tue, 14 Dec 2021 08:29:23 -0800 (PST)
Received: from localhost ([12.163.77.120])
        by smtp.gmail.com with ESMTPSA id z13sm314691pfj.160.2021.12.14.08.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:29:23 -0800 (PST)
Date:   Tue, 14 Dec 2021 08:29:23 -0800 (PST)
X-Google-Original-Date: Mon, 13 Dec 2021 18:18:38 PST (-0800)
Subject:     Re: [PATCH v9 04/17] riscv: Add new csr defines related to vector extension
In-Reply-To: <6013bd0c309cecf244a151b54ee73c0ebd391663.1636362169.git.greentime.hu@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     greentime.hu@sifive.com
Message-ID: <mhng-00f26944-35dd-413c-ad9e-4db8c8144c11@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Nov 2021 01:48:16 PST (-0800), greentime.hu@sifive.com wrote:
> Follow the riscv vector spec to add new csr numbers.
>
> [guoren@linux.alibaba.com: first porting for new vector related csr]
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Acked-by: Guo Ren <guoren@kernel.org>
> Co-developed-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> ---
>  arch/riscv/include/asm/csr.h | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 87ac65696871..069743102fac 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -24,6 +24,12 @@
>  #define SR_FS_CLEAN	_AC(0x00004000, UL)
>  #define SR_FS_DIRTY	_AC(0x00006000, UL)
>
> +#define SR_VS           _AC(0x00000600, UL) /* Vector Status */
> +#define SR_VS_OFF       _AC(0x00000000, UL)
> +#define SR_VS_INITIAL   _AC(0x00000200, UL)
> +#define SR_VS_CLEAN     _AC(0x00000400, UL)
> +#define SR_VS_DIRTY     _AC(0x00000600, UL)
> +
>  #define SR_XS		_AC(0x00018000, UL) /* Extension Status */
>  #define SR_XS_OFF	_AC(0x00000000, UL)
>  #define SR_XS_INITIAL	_AC(0x00008000, UL)
> @@ -31,9 +37,9 @@
>  #define SR_XS_DIRTY	_AC(0x00018000, UL)
>
>  #ifndef CONFIG_64BIT
> -#define SR_SD		_AC(0x80000000, UL) /* FS/XS dirty */
> +#define SR_SD		_AC(0x80000000, UL) /* FS/VS/XS dirty */
>  #else
> -#define SR_SD		_AC(0x8000000000000000, UL) /* FS/XS dirty */
> +#define SR_SD		_AC(0x8000000000000000, UL) /* FS/VS/XS dirty */
>  #endif
>
>  /* SATP flags */
> @@ -120,6 +126,12 @@
>  #define CSR_MIMPID		0xf13
>  #define CSR_MHARTID		0xf14
>
> +#define CSR_VSTART		0x8
> +#define CSR_VCSR		0xf
> +#define CSR_VL			0xc20
> +#define CSR_VTYPE		0xc21
> +#define CSR_VLENB		0xc22
> +
>  #ifdef CONFIG_RISCV_M_MODE
>  # define CSR_STATUS	CSR_MSTATUS
>  # define CSR_IE		CSR_MIE

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
