Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555C54ED0D6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 02:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352082AbiCaA2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 20:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiCaA2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 20:28:40 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BECA4924D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648686411; x=1680222411;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MAEmACm8JL0agnrolT58m2LejPScBLQM6qttzu2LRgs=;
  b=nzvHa8hhZe9WIZrm5TlHysIrGHekMVTdx+sDv6gQHdUDI55A0DpAYTBD
   CahojdvgrvlFgQsseWOLBlwisCvljF/DT49tY753Kqsnm0HI+Eww+oAFb
   ETnrpls4H6y5+FLbXhrn+0HjvxC3qgBo4biXZvKXz1oLxHVi0cNzLcTTy
   XI7w9hrjAjVFwIAtBxfjFdoNg15TmXFYODsTYyqUD7VEfzI9ww2gRiPpP
   9dRSATxODNjZQGNnEW20g8lbYk3/HZo+1U5qR8pv5sBC7SqaFX79edmv8
   gzKTIuA7BMwOjDgWCsu3OhDlxNvYgYepAOfUdOhST0nNZpvbv5Jqt3kRD
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,223,1643644800"; 
   d="scan'208";a="300837321"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2022 08:26:50 +0800
IronPort-SDR: t+c/7tc89PAMYOTirKCmzN6xT22w4/5WAHrhJBon/yNX2IxnYAXpaPDdYWXGwo+VgLBpp8cgxc
 /QYYy7N2n9zXf+3LqQKGRgjsm8Zs9OPg9obwAPgpsUV9CXxOEzGqSLBKc5J11MxdR5VDnTufdm
 KRMDVHqUDMzFgmNWCeJ2jgnj5MzG3q7tHXiJSldnzPNgGZB5z44tX/DHJ4uQ+tlMSTJvjP4ycC
 RguT2T2u9HlGYiiuPFB0WvlPk3t+0rYEjh6MYc8pzLW2BPELGBI1cyFie2uUvwdQmPCSx6pFM7
 A452a0CnjOUKUguBGZ4rIMoA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2022 16:58:31 -0700
IronPort-SDR: 78wzCWGi71Rks5AYX2JLUzDO9l3Yb00daox0xx3BSRGzr2KLpFO/zNN1kip1dz7BRznUYIyD5M
 6FNW3Ky62hBtucPsF6gvv/IZt+5CXEE/+m5wdtUKBvuA+nksMG6hVXTKYrWgl/mvzJj8o/8pir
 nMwf/FzqvnA/4bFA+JE7vGdfjzhsQWc1mapTQkuvVJ26zAN4wEN+J/51VPgUaVfnFKn8wMUDYY
 v0F8olQKF7IiX1fsgNIKZo0/rS8N/XS+SJWZRkTm4mIMZRYRkhHCezMDQ10Id7WF8i03LzeUXF
 rLA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2022 17:26:50 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KTPHs6QvCz1SVp2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:26:49 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648686409; x=1651278410; bh=MAEmACm8JL0agnrolT58m2LejPScBLQM6qt
        tzu2LRgs=; b=qxj2JM1oqz6ef2yg3vL9qh1vgfRq6qU0Di8N8SBh1TcBte6a++U
        ZpHWB4ue5q9sorZiD0QV/xA0QJhQFI1PBrGLF6w9gvBARO3ZTfDktkrA2KlEMc36
        8lFNT17fn5TbSOEiIo6DFExIUQ+SXrOnEMTkCdxTgBT1rWvgB0CU3/VtuwtHyLEp
        WZ3sFad7gbszGMoySo5S9xqlscKX9u0AWrbY2CKfuNWmYROhVRITYiNvNAFnGJEB
        +a6vwYKZmmU48PBIFYYc+9rDUqaoLSsV8HkXl04m70aaC+G8r84sj5Be43AVn8vP
        tFgpawLFR/EIlSx0sGB3VpfBDCJkQDG/6SQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UTWwcb1g4D-3 for <linux-kernel@vger.kernel.org>;
        Wed, 30 Mar 2022 17:26:49 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KTPHp5RGLz1Rvlx;
        Wed, 30 Mar 2022 17:26:46 -0700 (PDT)
Message-ID: <d8a35bea-f4a0-b54d-9d2a-d1cc9b3d3e53@opensource.wdc.com>
Date:   Thu, 31 Mar 2022 09:26:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/3] RISC-V: K210 defconfigs: Drop redundant MEMBARRIER=n
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, heinrich.schuchardt@canonical.com,
        atishp@atishpatra.org, mchitale@ventanamicro.com,
        alexandre.ghiti@canonical.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
References: <20220330234739.1956-1-palmer@rivosinc.com>
 <20220330234739.1956-2-palmer@rivosinc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220330234739.1956-2-palmer@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 08:47, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> As of 93917ad50972 ("RISC-V: Add support for restartable sequence") we
> have support for restartable sequences, which default to enabled.  These
> select MEMBARRIER, so disabling it is now redundant.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> ---
> 
> I'm not actually sure this is the right way to go: presumably the K210
> defconfigs had MEMBARRIER=n for a reason (maybe just size?), so we might
> actually want to move to RSEQ=n instead?  As usual: I don't test on the
> K210, so I'm not exactly sure what the constraints are.

Not sure either. It is like this now because I think this was the default
at the time the config was created.

Niklas,

Can you test this please ?

> ---
>  arch/riscv/configs/nommu_k210_defconfig        | 1 -
>  arch/riscv/configs/nommu_k210_sdcard_defconfig | 1 -
>  arch/riscv/configs/nommu_virt_defconfig        | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
> index 3f42ed87dde8..2438fa39f8ae 100644
> --- a/arch/riscv/configs/nommu_k210_defconfig
> +++ b/arch/riscv/configs/nommu_k210_defconfig
> @@ -21,7 +21,6 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  # CONFIG_AIO is not set
>  # CONFIG_IO_URING is not set
>  # CONFIG_ADVISE_SYSCALLS is not set
> -# CONFIG_MEMBARRIER is not set
>  # CONFIG_KALLSYMS is not set
>  CONFIG_EMBEDDED=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
> diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
> index af64b95e88cc..9a133e63ae5b 100644
> --- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
> +++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
> @@ -13,7 +13,6 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  # CONFIG_AIO is not set
>  # CONFIG_IO_URING is not set
>  # CONFIG_ADVISE_SYSCALLS is not set
> -# CONFIG_MEMBARRIER is not set
>  # CONFIG_KALLSYMS is not set
>  CONFIG_EMBEDDED=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
> diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
> index e1c9864b6237..5269fbb6b4fc 100644
> --- a/arch/riscv/configs/nommu_virt_defconfig
> +++ b/arch/riscv/configs/nommu_virt_defconfig
> @@ -19,7 +19,6 @@ CONFIG_EXPERT=y
>  # CONFIG_AIO is not set
>  # CONFIG_IO_URING is not set
>  # CONFIG_ADVISE_SYSCALLS is not set
> -# CONFIG_MEMBARRIER is not set
>  # CONFIG_KALLSYMS is not set
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_COMPAT_BRK is not set


-- 
Damien Le Moal
Western Digital Research
