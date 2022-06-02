Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9171A53B330
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 07:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiFBF5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 01:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiFBF52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 01:57:28 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4699965D23
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 22:57:25 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w21so3926632pfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 22:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=eCxEx+lGKntTG7Fb8tQyhburmQhM2/HBYS9YgGU41Xc=;
        b=edIKWMrX1gHLqKaFFQg3AuQnb/ENAgn6yaiyBB5RU1h8WL7s78CjgBV8+TMSixJl+v
         XJqxry4JLFf0bQ8lAPAcuO9GuwjT7Baa39Wnu/CqWFDHiymb0Q4gk5phbYwIzshjlq61
         w9wxqtjJXJ/WDtrGeHQJ9TFn0rGeqayHbNLfvBHBDoftA//VRHcI2G/4m5xFAkguwZGA
         RejZ0N3djpuQH5KcDr8bcTtigJO+6T9y66N1RMJfhqlDIBJQ+LQPfhnFjUSS19gSKsdH
         G2F/FSq+boEJH0ukdCyM9I/BtYHkIoX0/HG/xWdJENzvptRByHTHILfNPfrbBbm2bNMK
         bVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=eCxEx+lGKntTG7Fb8tQyhburmQhM2/HBYS9YgGU41Xc=;
        b=UEPBtaFt4QYx9ygE/kVitzW8yKb5cXV3KxC4KWPbTAJTf6h/B98svGZjAYyybtWrDh
         F8Yt6LfkwbpRCkAjVgwO0siPNxi9cb1KTibMfqrOsEazzmdkCMyJEugDClAbOTfsm5KI
         J8nOjUsoYDXDLUBY8HXfOFnvGOZxNyqQ3qNlogegdiGxDrP1rNM2Pz4vECkPI1q9TE0Y
         60KhqkwmRukd2xwePlOgVNtgdA90058t52Svik9TE6daeNhQY4sfwsKjZRdc2RIsbmzM
         5SGPKuzKi7D+VVV+EnR42Xv0bAGDl0glbQyR7TX6WgIqQ3PyGeqn8aa9Ieil+g9YLW8M
         xTIg==
X-Gm-Message-State: AOAM531s+HsCFqMBMp5ztOhfGT6E0bCaByQr0EjaOwySlJ1PdF1KAhoH
        NiEX4ictOmP/2MVP+gBOzwIfow==
X-Google-Smtp-Source: ABdhPJwTM+tBIHInbx5RKvyF5S2E6WESh5R2YOu2NgwnGGh45y+xb7slw3W2Zxikj/QtLGmUateXog==
X-Received: by 2002:a63:e603:0:b0:3fb:c191:9b65 with SMTP id g3-20020a63e603000000b003fbc1919b65mr2808347pgh.12.1654149444846;
        Wed, 01 Jun 2022 22:57:24 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id f82-20020a623855000000b005184031963bsm2517317pfa.85.2022.06.01.22.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 22:57:24 -0700 (PDT)
Date:   Wed, 01 Jun 2022 22:57:24 -0700 (PDT)
X-Google-Original-Date: Wed, 01 Jun 2022 22:14:14 PDT (-0700)
Subject:     Re: [PATCH] riscv: move errata/ and kvm/ builds to arch/riscv/Kbuild
In-Reply-To: <20220511184408.2751850-1-masahiroy@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     masahiroy@kernel.org
Message-ID: <mhng-4c843db6-5d0a-4b89-a724-9d141b08f1c1@palmer-ri-x1c9>
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

On Wed, 11 May 2022 11:44:08 PDT (-0700), masahiroy@kernel.org wrote:
> Commit 909548d6c578 ("riscv: add arch/riscv/Kbuild") intended that
> subdirectories in arch/riscv/ would be added in arch/riscv/Kbuild.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/riscv/Kbuild   | 2 ++
>  arch/riscv/Makefile | 3 ---
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/Kbuild b/arch/riscv/Kbuild
> index fb3397223d52..525ef2482253 100644
> --- a/arch/riscv/Kbuild
> +++ b/arch/riscv/Kbuild
> @@ -2,6 +2,8 @@
>
>  obj-y += kernel/ mm/ net/
>  obj-$(CONFIG_BUILTIN_DTB) += boot/dts/
> +obj-$(CONFIG_RISCV_ERRATA_ALTERNATIVE) += errata/
> +obj-$(CONFIG_KVM) += kvm/
>
>  # for cleaning
>  subdir- += boot
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 7d81102cffd4..fd9fda67c038 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -103,9 +103,6 @@ endif
>
>  head-y := arch/riscv/kernel/head.o
>
> -core-$(CONFIG_RISCV_ERRATA_ALTERNATIVE) += arch/riscv/errata/
> -core-$(CONFIG_KVM) += arch/riscv/kvm/
> -
>  libs-y += arch/riscv/lib/
>  libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a

Thanks, this is on for-next.  There was a conflict with the 
CONFIG_RISCV_ERRATA_ALTERNATIVE removal that I had to fix up, looks 
pretty easy but LMK if anything went wrong.

Thanks!
