Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAF659ED58
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiHWUdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbiHWUdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:33:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3775EDFA
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 13:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661285426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+7iAMKHtdXu9z0MTdle32b1UeMeq5lRWDcKx/It/fg4=;
        b=GLK1WmLLrSQZqX5YVNuqAuldMgyi0B2c3Vq17BSvcuRbqO9ziME1IIed6qSkL4P4D1kMvf
        cNd+eMRPYudSb4UUIzdqtu3+KyqKTyydt5dA1l1UJ9L8qi1maZxNceVsGBSZrL6YM7R5CZ
        Ekw3jP7kxj+T3kExWHQkXhil21LUIdE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-iwWnW2iyO_mcPr9g9bAMTg-1; Tue, 23 Aug 2022 16:10:25 -0400
X-MC-Unique: iwWnW2iyO_mcPr9g9bAMTg-1
Received: by mail-qt1-f198.google.com with SMTP id v5-20020ac873c5000000b003434ef0a8c7so11523772qtp.21
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 13:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=+7iAMKHtdXu9z0MTdle32b1UeMeq5lRWDcKx/It/fg4=;
        b=2bgWjOryf+khO3cm1lSb+R+exY3Bv6fMvzTCHVk2Uq7HQGdpnznCkkQy7H+hccH0So
         dGjzqGS+bPl0ohm3LsWnTPYZ6XLbimXfj/DC2MngiA03A8qolBAVge7dt02jCSUY9LAT
         DEO2r/upgIA8PTrPKnHf3ZN2krWiMD6MKPXSkbwkGH8VAdB+3OKwOJphVckpYWWBQ+Vw
         rz8gjtub9OKOE4V2HoVAfSRic/xF2CEHq2wplwavAwgVwHdu0yH93EfPltDU31ppRWmL
         XwcHmfTKs+WmO3ncMyKZYmXQFlzQBHzG+kN5gzTtDRkGpokP/XKmowrTKtlNDovTQncW
         DkBw==
X-Gm-Message-State: ACgBeo3oJcfto++ZO2/92/p41pVYVsPBcSzNa9MTjdevjrqHFu8h8zUZ
        QkJIX0F4GjHyDaU1hGfgOZlHgyRz5FMdKPMPizJ30uk5IfvPvf8cug8/FWlMY72r8eYOM0f2Dzn
        80WbhJrc3XgSXXzo+M0PfS/cK
X-Received: by 2002:a05:620a:1426:b0:6bb:268c:1c67 with SMTP id k6-20020a05620a142600b006bb268c1c67mr16889766qkj.298.1661285423050;
        Tue, 23 Aug 2022 13:10:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7zuv1FNgQbuVrh/MyAlgy5crcT/se2nlOqj0FR4tj1MFeaTCBjTR30cA1Po9i67MXuVDsHIQ==
X-Received: by 2002:a05:620a:1426:b0:6bb:268c:1c67 with SMTP id k6-20020a05620a142600b006bb268c1c67mr16889742qkj.298.1661285422647;
        Tue, 23 Aug 2022 13:10:22 -0700 (PDT)
Received: from halaneylaptop ([2600:1700:1ff0:d0e0::48])
        by smtp.gmail.com with ESMTPSA id j10-20020ac8664a000000b0033fc75c3469sm10761716qtp.27.2022.08.23.13.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 13:10:21 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:10:19 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Parikshit Pareek <quic_ppareek@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: introduce sa8540p-ride dts
Message-ID: <20220823201019.5oidhwy6m36lpzmc@halaneylaptop>
References: <20220812165453.11608-1-quic_ppareek@quicinc.com>
 <20220812165453.11608-4-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220812165453.11608-4-quic_ppareek@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Parikshit,

On Fri, Aug 12, 2022 at 10:24:53PM +0530, Parikshit Pareek wrote:
> Create new dts file specific for Qdrive board based on sa8540p chipset.
> Introduce common dtsi file sa8295p-adp.dtsi, to be included for adp and
> Qdrive board.
> 
> This is quite similar to SA8295 ADP development board. Main differences
> are related to connectors, and interface cards, like USB external ports,
> ethernet-switch, and PCIe switch etc.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |  1 +
>  arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 1d86a33de528..6175889160e5 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -51,6 +51,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sa8540p-adp-ride.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
> new file mode 100644
> index 000000000000..4922ffae553f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Limited
> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "sa8540p-adp.dtsi"
> +
> +/ {
> +	model = "Qualcomm SA8540 ADP";
> +	compatible = "qcom,sa8540p-adp-ride", "qcom,sa8540p";
> +};
> -- 
> 2.17.1
> 

I took this for a spin, and just wanted to highlight a few things that
cause this not to work on linux-next (tag: next-20220818) out of the box:

    1. Without clk_ignore_unused, or some of the suggestions over at
       https://lore.kernel.org/lkml/20220623142837.3140680-1-bmasney@redhat.com/T/#m36071f00fc38ddbfa7a7962c7643c9bb7d95e654
       the main UFS (ufs_mem_hc) fails

    2. Current linux-next fails to enable rpmh regulators:
       https://lore.kernel.org/all/20220822193153.zn2oxljmd76awqot@halaneylaptop/
       (not really an issue with the dts unless its decided that input
       supplies need to be described, which I don't think is going to
       happen, but I wanted to highlight it in case someone else plays
       with this)

    3. ufs_card_hc being enabled fails and locks up the system with
       the below, I couldn't figure out what the problem was with that
       unfortunately and ended up disabling it:

            [    2.464934] ufshcd-qcom 1da4000.ufs: Controller enable failed
            [    2.470832] ufshcd-qcom 1da4000.ufs: link startup failed 1
            [    2.476466] ufshcd-qcom 1da4000.ufs: UFS Host state=0
            [    2.481654] ufshcd-qcom 1da4000.ufs: outstanding reqs=0x0 tasks=0x0
            [    2.488082] ufshcd-qcom 1da4000.ufs: saved_err=0x0, saved_uic_err=0x0
            [    2.494691] ufshcd-qcom 1da4000.ufs: Device power mode=1, UIC link state=0
            [    2.501745] ufshcd-qcom 1da4000.ufs: PM in progress=0, sys. suspended=0
            [    2.508529] ufshcd-qcom 1da4000.ufs: Auto BKOPS=0, Host self-block=0
            [    2.515049] ufshcd-qcom 1da4000.ufs: Clk gate=1
            [    2.519703] ufshcd-qcom 1da4000.ufs: last_hibern8_exit_tstamp at 0 us, hibern8_exit_cnt=0
            [    2.528086] ufshcd-qcom 1da4000.ufs: last intr at 1792180 us, last intr status=0x404
            [    2.536030] ufshcd-qcom 1da4000.ufs: error handling flags=0x0, req. abort count=0
            [    2.543709] ufshcd-qcom 1da4000.ufs: hba->ufs_version=0x300, Host capabilities=0x1587031f, caps=0x3cf
            [    2.553166] ufshcd-qcom 1da4000.ufs: quirks=0x0, dev. quirks=0x0
            [    2.559330] ufshcd-qcom 1da4000.ufs: clk: core_clk, rate: 300000000
            [    2.565757] ufshcd-qcom 1da4000.ufs: clk: core_clk_unipro, rate: 300000000
            [    2.572835] host_regs: 00000000: 1587031f 00000000 00000300 00000000
            [    2.579360] host_regs: 00000010: 01000000 00010217 00000000 00000000
            [    2.585882] host_regs: 00000020: 00000000 00000000 00000000 00000000
            [    2.592395] host_regs: 00000030: 00000008 00000000 00000000 00000000
            [    2.598922] host_regs: 00000040: 00000000 00000000 00000000 00000000
            [    2.605436] host_regs: 00000050: 00000000 00000000 00000000 00000000
            [    2.611961] host_regs: 00000060: 00000000 00000000 00000000 00000000
            [    2.618475] host_regs: 00000070: 00000000 00000000 00000000 00000000
            [    2.624997] host_regs: 00000080: 00000000 00000000 00000000 00000000
            [    2.631518] host_regs: 00000090: 00000000 00000001 00000000 00000000
            [    2.638049] ufshcd-qcom 1da4000.ufs: No record of pa_err
            [    2.643497] ufshcd-qcom 1da4000.ufs: No record of dl_err
            [    2.648945] ufshcd-qcom 1da4000.ufs: No record of nl_err
            [    2.654394] ufshcd-qcom 1da4000.ufs: No record of tl_err
            [    2.659844] ufshcd-qcom 1da4000.ufs: No record of dme_err
            [    2.665387] ufshcd-qcom 1da4000.ufs: No record of auto_hibern8_err
            [    2.671727] ufshcd-qcom 1da4000.ufs: No record of fatal_err
            [    2.677451] ufshcd-qcom 1da4000.ufs: link_startup_fail[0] = 0x1 at 2375025 us
            [    2.684773] ufshcd-qcom 1da4000.ufs: link_startup_fail: total cnt=1
            [    2.691208] ufshcd-qcom 1da4000.ufs: No record of resume_fail
            [    2.697100] ufshcd-qcom 1da4000.ufs: No record of suspend_fail
            [    2.703087] ufshcd-qcom 1da4000.ufs: dev_reset[0] = 0x0 at 1683266 us
            [    2.709699] ufshcd-qcom 1da4000.ufs: dev_reset: total cnt=1
            [    2.715419] ufshcd-qcom 1da4000.ufs: No record of host_reset
            [    2.721231] ufshcd-qcom 1da4000.ufs: No record of task_abort
            [    2.727050] HCI Vendor Specific Registers 00000000: 0000012c 00000000 00000000 00000000
            [    2.735255] HCI Vendor Specific Registers 00000010: 00014142 00000000 00000001 1c00052c
            [    2.743470] HCI Vendor Specific Registers 00000020: 3f011300 40030000 00000000 00000000
            [    2.751681] HCI Vendor Specific Registers 00000030: 00000000 00000000 00000000 00000000
            [    2.759916] UFS_UFS_DBG_RD_REG_OCSC 00000000: 00000000 00000000 00000000 00000000
            [    2.767591] UFS_UFS_DBG_RD_REG_OCSC 00000010: 00000000 00000000 00000000 00000000
            [    2.775262] UFS_UFS_DBG_RD_REG_OCSC 00000020: 00000000 00000000 00000000 00000000
            [    2.782935] UFS_UFS_DBG_RD_REG_OCSC 00000030: 00000000 00000000 00000000 00000000
            [    2.790609] UFS_UFS_DBG_RD_REG_OCSC 00000040: 00000000 00000000 00000000 00000000
            [    2.798283] UFS_UFS_DBG_RD_REG_OCSC 00000050: 00000000 00000000 00000000 00000000
            [    2.805958] UFS_UFS_DBG_RD_REG_OCSC 00000060: 00000000 00000000 00000000 00000000
            [    2.813636] UFS_UFS_DBG_RD_REG_OCSC 00000070: 00000000 00000000 00000000 00000000
            [    2.821310] UFS_UFS_DBG_RD_REG_OCSC 00000080: 00000000 00000000 00000000 00000000
            [    2.828990] UFS_UFS_DBG_RD_REG_OCSC 00000090: 00000000 00000000 00000000 00000000
            [    2.836664] UFS_UFS_DBG_RD_REG_OCSC 000000a0: 00000000 00000000 00000000 00000000
            [    2.844357] UFS_UFS_DBG_RD_EDTL_RAM 00000000: 6b77f2be fbf9fff6 bffe79bd fffdf9ff
            [    2.852030] UFS_UFS_DBG_RD_EDTL_RAM 00000010: ffffbf7f efff9f6f fadddcfd dfffffbf
            [    2.859705] UFS_UFS_DBG_RD_EDTL_RAM 00000020: d7bffbfd fdfdffff 7ddfb79f bbfffcff
            [    2.867381] UFS_UFS_DBG_RD_EDTL_RAM 00000030: fb7e1fbc fbfdddbf bfef73fd fbdf5edf
            [    2.875053] UFS_UFS_DBG_RD_EDTL_RAM 00000040: f2fffffe 3ffdf7ff b6acf9ef ffffef4f
            [    2.882728] UFS_UFS_DBG_RD_EDTL_RAM 00000050: dfe7bb26 b3fffd7f bdfd67df f7ffbfff
            [    2.890402] UFS_UFS_DBG_RD_EDTL_RAM 00000060: df77dffd f33ed7ed ffefdf7f 9fffffff
            [    2.898072] UFS_UFS_DBG_RD_EDTL_RAM 00000070: bd7ffdbe beffdede bff7f3e7 ffb3f7cf
            [    2.905811] UFS_UFS_DBG_RD_DESC_RAM 00000000: ffbbe7ee 003fffff bf5ffff6 003f7bfd
            [    2.913483] UFS_UFS_DBG_RD_DESC_RAM 00000010: 3ffdfbfd 003ce7fe dff7df5d 002eb73b
            [    2.921158] UFS_UFS_DBG_RD_DESC_RAM 00000020: fdfff9f9 003f1d90 dfffefcf 00377fff
            [    2.928830] UFS_UFS_DBG_RD_DESC_RAM 00000030: fbdfbfdf 0037dbf6 dbdb7fef 003afebc
            [    2.936504] UFS_UFS_DBG_RD_DESC_RAM 00000040: 6f7beeef 002ffebd ff7cffff 0037fef2
            [    2.944175] UFS_UFS_DBG_RD_DESC_RAM 00000050: e7fbfdff 003fb7fb d77ffeff 002bff7f
            [    2.951847] UFS_UFS_DBG_RD_DESC_RAM 00000060: ffbfff8d 00173fef 9edf7ff7 003ff4df
            [    2.959522] UFS_UFS_DBG_RD_DESC_RAM 00000070: ff7bff9f 002fefff fd25feff 0036e2bc
            [    2.967196] UFS_UFS_DBG_RD_DESC_RAM 00000080: ffbffff7 003dfee9 97efcfbb 003bff74
            [    2.974868] UFS_UFS_DBG_RD_DESC_RAM 00000090: cfeb7fff 002dfffe f7bf7fff 003ff7bf
            [    2.982542] UFS_UFS_DBG_RD_DESC_RAM 000000a0: efbffef7 0036bf7e f7ffbff7 003ffbfd
            [    2.990223] UFS_UFS_DBG_RD_DESC_RAM 000000b0: bbf3f7f7 003fa7ff f95fb6ff 0037fbfb
            [    2.997899] UFS_UFS_DBG_RD_DESC_RAM 000000c0: f7bffdff 003fdb6a fbfeffff 001fff7a
            [    3.005573] UFS_UFS_DBG_RD_DESC_RAM 000000d0: eefef3ff 003ffffe 7afe7ff7 002ffb9f
            [    3.013244] UFS_UFS_DBG_RD_DESC_RAM 000000e0: fb36ffe2 0027f71d 7f7d1d33 003e7adf
            [    3.020918] UFS_UFS_DBG_RD_DESC_RAM 000000f0: 7efdf47f 003fdbff f32fffbf 003bfabe
            [    3.028591] UFS_UFS_DBG_RD_DESC_RAM 00000100: bffbfbff 0028622d bf7afbfd 00397fef
            [    3.036264] UFS_UFS_DBG_RD_DESC_RAM 00000110: fffe7fff 003fbf2f db7e4ddd 002e9cd8
            [    3.043938] UFS_UFS_DBG_RD_DESC_RAM 00000120: ff7eefff 003fb6ef dffde7f7 002fb12f
            [    3.051624] UFS_UFS_DBG_RD_DESC_RAM 00000130: fffaeff3 001bffff 7fb7dfff 001ffbeb
            [    3.059304] UFS_UFS_DBG_RD_DESC_RAM 00000140: bfbfffff 000ddfd9 7b3fb3cf 002fffdb
            [    3.066979] UFS_UFS_DBG_RD_DESC_RAM 00000150: bb73ffff 003feffd fbedff73 0035eefd
            [    3.074648] UFS_UFS_DBG_RD_DESC_RAM 00000160: ffd6feeb 003ffdf9 efffddf7 002fffbf
            [    3.082330] UFS_UFS_DBG_RD_DESC_RAM 00000170: 7ffdffff 003d7ffa bf2e7fef 002f7dff
            [    3.090003] UFS_UFS_DBG_RD_DESC_RAM 00000180: 3fbff3bf 002ff9fb 9a95e77d 003bdfeb
            [    3.097684] UFS_UFS_DBG_RD_DESC_RAM 00000190: 8a8751ff 003fffff cbd77da9 001deffe
            [    3.105357] UFS_UFS_DBG_RD_DESC_RAM 000001a0: effd7eef 0031df7e df3f77dc 0037e5ff
            [    3.113032] UFS_UFS_DBG_RD_DESC_RAM 000001b0: 663ffeff 003f71f7 ecfffffd 003fffbf
            [    3.120708] UFS_UFS_DBG_RD_DESC_RAM 000001c0: fefffbff 0019fffe f7fdffaf 003e77e7
            [    3.128388] UFS_UFS_DBG_RD_DESC_RAM 000001d0: b7f5ffff 002ddfbe ffea77ff 003d6bff
            [    3.136066] UFS_UFS_DBG_RD_DESC_RAM 000001e0: ffbf7d7f 003bf9dc dfb3ffdf 003bbbed
            [    3.143737] UFS_UFS_DBG_RD_DESC_RAM 000001f0: fdff6bdd 001b7f7e dfbfdf3d 0037dfb7
            [    3.151450] UFS_UFS_DBG_RD_PRDT_RAM 00000000: d9301bfc 00088119 8f8668e5 0000c2af
            [    3.159123] UFS_UFS_DBG_RD_PRDT_RAM 00000010: 1816aac1 000826c0 8ba734e7 000c2140
            [    3.166796] UFS_UFS_DBG_RD_PRDT_RAM 00000020: c296aa6d 000c8683 e9463ee2 00075bdd
            [    3.174467] UFS_UFS_DBG_RD_PRDT_RAM 00000030: 65047194 00031100 e7e03f12 000211c6
            [    3.182149] UFS_UFS_DBG_RD_PRDT_RAM 00000040: e5a7d2c8 0005ec51 cef1ba70 000129f8
            [    3.189821] UFS_UFS_DBG_RD_PRDT_RAM 00000050: 7d096588 000abd58 b1d38219 000ab8c5
            [    3.197495] UFS_UFS_DBG_RD_PRDT_RAM 00000060: 2dc190b0 0008ae03 b2572cf3 000bfac6
            [    3.205166] UFS_UFS_DBG_RD_PRDT_RAM 00000070: 483c5ac9 00080882 579ea134 000d7b8d
            [    3.212841] UFS_UFS_DBG_RD_PRDT_RAM 00000080: 012196b5 000c7d9c 7af89b3f 000cf5f2
            [    3.220516] UFS_UFS_DBG_RD_PRDT_RAM 00000090: 2f688eb6 00005e30 9a6d57b5 000bb5a9
            [    3.228196] UFS_UFS_DBG_RD_PRDT_RAM 000000a0: e5524cec 000249ca ddf1fbea 0004bbb9
            [    3.235871] UFS_UFS_DBG_RD_PRDT_RAM 000000b0: c01320eb 00043e82 9b505d84 000690dd
            [    3.243546] UFS_UFS_DBG_RD_PRDT_RAM 000000c0: aaa008e5 00086133 2d4b77dd 0009b37f
            [    3.251219] UFS_UFS_DBG_RD_PRDT_RAM 000000d0: 490e4ee2 00030d03 06f08c53 000c2def
            [    3.258895] UFS_UFS_DBG_RD_PRDT_RAM 000000e0: ceb34062 000308e0 60e1e7c5 000e5cee
            [    3.266569] UFS_UFS_DBG_RD_PRDT_RAM 000000f0: c7d11030 0000cac1 e73f7ae2 00055e6e
            [    3.274265] UFS_DBG_RD_REG_UAWM 00000000: 00000000 0fe00000 00000004 f4000102
            [    3.281602] UFS_DBG_RD_REG_UARM 00000000: 00000000 00000000 00000001 00000001
            [    3.288949] UFS_DBG_RD_REG_TXUC 00000000: 00000000 00000000 00000000 00000000
            [    3.296274] UFS_DBG_RD_REG_TXUC 00000010: 00000000 00000000 00000000 00000000
            [    3.303590] UFS_DBG_RD_REG_TXUC 00000020: 00000000 00000000 00000000 00000000
            [    3.310917] UFS_DBG_RD_REG_TXUC 00000030: 00000000 00000000 00000000 00000000
            [    3.318237] UFS_DBG_RD_REG_TXUC 00000040: 00000000 00000000 00000000 00000000
            [    3.325555] UFS_DBG_RD_REG_TXUC 00000050: 00000000 00000000 00000000 00000000
            [    3.332876] UFS_DBG_RD_REG_TXUC 00000060: 00000000 00000000 00000000 00000000
            [    3.340199] UFS_DBG_RD_REG_TXUC 00000070: 00000000 00000000 00000000 00000000
            [    3.347519] UFS_DBG_RD_REG_TXUC 00000080: 00000000 00000000 00000000 00000000
            [    3.354836] UFS_DBG_RD_REG_TXUC 00000090: 00000000 00000000 00000000 00000000
            [    3.362158] UFS_DBG_RD_REG_TXUC 000000a0: 00000000 00000000 00000000 00000000
            [    3.369480] UFS_DBG_RD_REG_TXUC 000000b0: 00000001 00000000 00000000 00000004
            [    3.376810] UFS_DBG_RD_REG_RXUC 00000000: 00000000 00000000 00000000 00000004
            [    3.384128] UFS_DBG_RD_REG_RXUC 00000010: 00000000 00000000 00000000 00000000
            [    3.391448] UFS_DBG_RD_REG_RXUC 00000020: 00000000 00000000 00000000 00000000
            [    3.398766] UFS_DBG_RD_REG_RXUC 00000030: 00000000 00000000 00000000 00000000
            [    3.406087] UFS_DBG_RD_REG_RXUC 00000040: 00000000 00000000 00000000 00000000
            [    3.413400] UFS_DBG_RD_REG_RXUC 00000050: 00000000 00000000 00000000 00000001
            [    3.420722] UFS_DBG_RD_REG_RXUC 00000060: 00000000 00000000 00000004
            [    3.427264] UFS_DBG_RD_REG_DFC 00000000: 00000000 00000000 00000000 00000000
            [    3.434493] UFS_DBG_RD_REG_DFC 00000010: 00000000 00000000 00000000 00000000
            [    3.441723] UFS_DBG_RD_REG_DFC 00000020: 00000000 00000000 00000000 00000000
            [    3.448959] UFS_DBG_RD_REG_DFC 00000030: 00000000 00000000 00000000 00000000
            [    3.456192] UFS_DBG_RD_REG_DFC 00000040: ffffffff 00000000 00000000
            [    3.462642] UFS_DBG_RD_REG_TRLUT 00000000: 00000000 00000000 00000000 00000000
            [    3.470056] UFS_DBG_RD_REG_TRLUT 00000010: 00000000 00000000 00000000 00000000
            [    3.477462] UFS_DBG_RD_REG_TRLUT 00000020: 00000000 00000000 00000000 00000000
            [    3.484872] UFS_DBG_RD_REG_TRLUT 00000030: 00000000 00000000 00000000 00000000
            [    3.492287] UFS_DBG_RD_REG_TRLUT 00000040: 00000000 00000000 00000000 00000000
            [    3.499693] UFS_DBG_RD_REG_TRLUT 00000050: 00000000 00000000 00000000 00000000
            [    3.507098] UFS_DBG_RD_REG_TRLUT 00000060: 00000000 00000000 00000000 00000000
            [    3.514503] UFS_DBG_RD_REG_TRLUT 00000070: 00000000 00000000 00000000 00000000
            [    3.521910] UFS_DBG_RD_REG_TRLUT 00000080: 00000000 00000000
            [    3.527727] UFS_DBG_RD_REG_TMRLUT 00000000: 00000000 00000000 00000000 00000000
            [    3.535224] UFS_DBG_RD_REG_TMRLUT 00000010: 00000000 00000000 00000000 00000000
            [    3.542723] UFS_DBG_RD_REG_TMRLUT 00000020: 00000000
            [    3.548212] ------------[ cut here ]------------
            [    3.552955] gcc_ufs_card_axi_clk status stuck at 'off'
            [    3.552970] WARNING: CPU: 1 PID: 119 at drivers/clk/qcom/clk-branch.c:91 clk_branch_wait+0x144/0x160
            [    3.567626] Modules linked in:
            [    3.570769] CPU: 1 PID: 119 Comm: kworker/u17:0 Not tainted 6.0.0-rc1-next-20220818+ #10
            [    3.579076] kworker/u17:0[119] cmdline: �o�`{���p�>	
            [    3.584171] Hardware name: Qualcomm SA8540 ADP (DT)
            [    3.589183] Workqueue: ufs_clk_gating_1 ufshcd_ungate_work
            [    3.594826] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
            [    3.601966] pc : clk_branch_wait+0x144/0x160
            [    3.606352] lr : clk_branch_wait+0x144/0x160
            [    3.610737] sp : ffff8000093ebc40
            [    3.614145] x29: ffff8000093ebc40 x28: ffffa17b620c82e8 x27: ffff1ffb82aa5228
            [    3.621472] x26: ffff1ffb82aa5248 x25: ffffa17b620d7750 x24: 0000000000000001
            [    3.628802] x23: ffffa17b62074b70 x22: 0000000000000001 x21: ffffa17b615f8e00
            [    3.636128] x20: 0000000000000000 x19: ffffa17b6307bc60 x18: ffffffffffffffff
            [    3.643454] x17: 707573202c64656c x16: 62616e65203a6568 x15: ffff8000893eb857
            [    3.650781] x14: 0000000000000000 x13: 6f27207461206b63 x12: 7574732073757461
            [    3.658108] x11: 00000000ffff7fff x10: 00000000ffff7fff x9 : ffffa17b60f5654c
            [    3.665435] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 : 00000000002bffa8
            [    3.672762] x5 : 0000000000007fff x4 : 0000000000000000 x3 : 0000000000000000
            [    3.680089] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff1ffb828fe900
            [    3.687419] Call trace:
            [    3.689931]  clk_branch_wait+0x144/0x160
            [    3.693963]  clk_branch2_enable+0x34/0x40
            [    3.698082]  clk_core_enable+0x70/0x210
            [    3.702021]  clk_enable+0x30/0x50
            [    3.705431]  ufshcd_setup_clocks+0x130/0x41c
            [    3.709819]  ufshcd_ungate_work+0x98/0x1b4
            [    3.714024]  process_one_work+0x1f0/0x454
            [    3.718146]  worker_thread+0x24c/0x4ec
            [    3.721993]  kthread+0xcc/0xd0
            [    3.725134]  ret_from_fork+0x10/0x20
            [    3.728814] ---[ end trace 0000000000000000 ]---
            [    3.733574] ufshcd-qcom 1da4000.ufs: ufshcd_setup_clocks: core_clk prepare enable failed, -16
            [   28.185810] watchdog: BUG: soft lockup - CPU#5 stuck for 26s! [kworker/u16:0:8]

Thanks,
Andrew

