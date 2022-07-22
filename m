Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC0157E7E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiGVUGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiGVUGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:06:53 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC27079ED7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:06:51 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f11so5433162plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=zLMtuNEKcomDL9En+iBTEL2RGFbAke6YE3hVmvEcPio=;
        b=Eig2NvAhLfj/vpfp9dGkC4QXb4hU/3IYvKdkRbtZYah9nJFIfw7QsduxCPs3GEAJgI
         Pq/geWl82IjlD+B8qljZf/fdO354mZpallnYP/YnAotuJ2oxrgu1tEgDT1g3Dz1bbweK
         +e9LaZaadoKuGVs7ehfKURTGuw2c2fgpmOG4q2hJw8UUU1EZ1PrcwOGOu9TdSuI+zWv7
         fRwpyB4vVBvp+aw3Bs3r3mIE3AeUHKLQ+T2sCg67aVvq/ET8zN3uQRzql8+n5zZD+Cg+
         VHEx4+FeBCF1vcf19ruV6MjlGoVX8DmicMdRsd/yCioaGLIkt51EobwFJNDsxoQKaJdv
         rn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=zLMtuNEKcomDL9En+iBTEL2RGFbAke6YE3hVmvEcPio=;
        b=YMt/SSP5Q5FSTXMP187xAk9/hp4LViW02BJyE9JFm88k1nuHy7CYpZI1ECwcpFYEWQ
         SWTgK5Vf0BrkZ0L7P/QcNO7rILF4iftf5+PjdR0JKedjP7t8ESNPmwYWiSCkVTV6wwu5
         Kr8DoG7aT92vAVDNZsu4Vv7f5ZzGnnJ8dBF+Bvam3Jyl9AXa/PSudqP/MvDoDMMBXJmi
         kePde/djUw8mEyUYkfUIp/4BWFoT2SEsgac4QlwMm//in3gte86XOYStvreQUByZ0L8X
         qfNjVvuZre78o6d2hhNCjPwhRlDq2Xi9iIHcCmAK0KCUWse22dP9ZUo5wh619m2pFnqy
         Zp7A==
X-Gm-Message-State: AJIora9KRCmM2Y3E3k38ySfJr7HiAksmB9c16OR+TK8xtWxNrFgSdX61
        lKYtz0VQhosiNZ6RjdsLShSWCKN55xhuOA==
X-Google-Smtp-Source: AGRyM1uX2FdOU6xdhlNSf3B6XRXhfVe67iGwEPo/S4uLCyT2clrlec8g1WtQC/6pvHoV17nvASPNDQ==
X-Received: by 2002:a17:902:ec91:b0:16c:29d7:5e90 with SMTP id x17-20020a170902ec9100b0016c29d75e90mr1512512plg.114.1658520411130;
        Fri, 22 Jul 2022 13:06:51 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id o7-20020a170902d4c700b0016cb98ab5b4sm4120255plg.153.2022.07.22.13.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 13:06:50 -0700 (PDT)
Date:   Fri, 22 Jul 2022 13:06:50 -0700 (PDT)
X-Google-Original-Date: Fri, 22 Jul 2022 13:02:58 PDT (-0700)
Subject:     Re: [PATCH] riscv: compat: vdso: Fix vdso_install target
In-Reply-To: <20220625154207.80972-1-emil.renner.berthing@canonical.com>
CC:     linux-riscv@lists.infradead.org, guoren@linux.alibaba.com,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     emil.renner.berthing@canonical.com
Message-ID: <mhng-f6f17824-3a4a-4461-9195-dec6695e03a1@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jun 2022 08:42:07 PDT (-0700), emil.renner.berthing@canonical.com wrote:
> When CONFIG_COMPAT=y the vdso_install target fails:
>
> $ make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- vdso_install
>   INSTALL vdso.so
> make[1]: *** No rule to make target 'vdso_install'.  Stop.
> make: *** [arch/riscv/Makefile:112: vdso_install] Error 2
>
> The problem is that arch/riscv/kernel/compat_vdso/Makefile doesn't
> have a vdso_install target, but instead calls it compat_vdso_install.
>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> ---
>  arch/riscv/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 34cf8a598617..5cfbef613e34 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -110,7 +110,7 @@ PHONY += vdso_install
>  vdso_install:
>  	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
>  	$(if $(CONFIG_COMPAT),$(Q)$(MAKE) \
> -		$(build)=arch/riscv/kernel/compat_vdso $@)
> +		$(build)=arch/riscv/kernel/compat_vdso compat_$@)
>
>  ifeq ($(KBUILD_EXTMOD),)
>  ifeq ($(CONFIG_MMU),y)

Sorry for missing this, it's on fixes.
