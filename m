Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E2F589684
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 05:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbiHDDUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 23:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238639AbiHDDT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 23:19:58 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9345E30C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 20:19:57 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id v13so6799817vke.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 20:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JEJULrzPwdNHQ/ggnVhsmc574+1cmbi28gF+VqoMdE8=;
        b=ItzlZ6X4RZlRxPA+fabyikpNA4YcicwUY0cHPfuM5fV5YqCUytGaKaK02kZX26BTM3
         HC8BswlviJMjctrZXbCTD2+thmqvKuLAQnLGotp+RVxDY01bOYAmVr3+tcOc7Yv55gqE
         oqsC7lyK4jfcQke1f+jNKxtnbavpN6gQPiRr/jEXSPeFqoaiMvwsO/PTpyDlqdlPNScO
         zIrQkSw5vo81od6o6OxRWpfOb6PgifQqqP4rCOzLEPWL5GQaepZnbvkE+8JU4hH+HfN4
         RZS1zZp9bHye/GY29utpcHi0ykhJ1zxMUsrAzmz5TswEJUOSO2CxReB7LhMFg73kA3HJ
         06Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JEJULrzPwdNHQ/ggnVhsmc574+1cmbi28gF+VqoMdE8=;
        b=QzhLRy3pMOW1fJ1BdrX/pQywAPZFRZKFQPZTJvwgSgWZMVI4Gj9SgoJUXYHVThVU/U
         boephkA5vGN1KAz/4jsq1+etaKGDpwBLgmupOyidmc/VfBkjSVQi7DMS7wtn4Y4A9R/j
         BxqYc691mN/PKgMVv9b4xuOte745ibB3ngIDP/x0QMB88XjauVMrwBJlmRuWGx4HJ5dl
         bGXBaORnHIEqT6zNoHy3p4A/W1aVBW6nXm2ARpv4BLSQ17CYoqopO8/7reLYjxFXB0Te
         +Jyhgl35AtZiL/CbNJ9DpcrvsHLGL6aVPdthJ0zmy/vlcfSYMFsNxCTIInpImDki/YAO
         K+BQ==
X-Gm-Message-State: ACgBeo1khHCgOBIpN+5NIx+lWzz9+gbasN2KCVu/DoKIzGH+MLIJP/0p
        1008jWhuFiN/rcNpkljiWRpSbLK9m73wfPA+POZbpH5QV8I=
X-Google-Smtp-Source: AA6agR6bH+ek1y8K4AkXf/Y74zT5MSmemJUfzKo66bH1768Q3KVDwlOYLRz6o3ECUoJFFiKUohxftcesm2tIu0ufDPM=
X-Received: by 2002:a1f:b248:0:b0:377:aa0c:941 with SMTP id
 b69-20020a1fb248000000b00377aa0c0941mr5792434vkf.37.1659583196085; Wed, 03
 Aug 2022 20:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220804025457.213979-1-chenhuacai@loongson.cn>
In-Reply-To: <20220804025457.213979-1-chenhuacai@loongson.cn>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 4 Aug 2022 11:19:41 +0800
Message-ID: <CAAhV-H7J=mofWtm99pSzvcByLxf3-in1BkopBFSYh1hF0_dQ6w@mail.gmail.com>
Subject: Re: [PATCH] irqchip/loongson-eiointc: Fix a build warning
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc,

Other build warnings reported by lkp due to the missing CONFIG_ACPI in
randconfig. So they will be fixed by adjusting arch/loongarch/Kconfig
and going through loongarch tree. Thanks.

Huacai

On Thu, Aug 4, 2022 at 10:54 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> Make acpi_get_vec_parent() be a static function, to avoid:
> drivers/irqchip/irq-loongson-eiointc.c:289:20: warning: no previous prototype for 'acpi_get_vec_parent'
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/irqchip/irq-loongson-eiointc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
> index 317467857478..bffb7b3128e8 100644
> --- a/drivers/irqchip/irq-loongson-eiointc.c
> +++ b/drivers/irqchip/irq-loongson-eiointc.c
> @@ -290,7 +290,7 @@ static void acpi_set_vec_parent(int node, struct irq_domain *parent, struct acpi
>         }
>  }
>
> -struct irq_domain *acpi_get_vec_parent(int node, struct acpi_vector_group *vec_group)
> +static struct irq_domain *acpi_get_vec_parent(int node, struct acpi_vector_group *vec_group)
>  {
>         int i;
>
> --
> 2.31.1
>
