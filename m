Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BFA4ED287
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiCaEPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiCaENs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:13:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556362BC4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 20:51:31 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id h19so19769503pfv.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 20:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=su81uPGLPlEfo3kKBvUrtbr7Q1bO5QHvXSGg8dkL+fQ=;
        b=GYdBweRk6GWXxrgZswn1g1wP5TqlOb2xYijX08he5T593LHNvihsBdxclepFnR7wPA
         EFDojWqpJICiiOKuQB//cisuhUNkO2u5FfDMfQ7xraDnZxIEaXhE6D+qkAGFe35j0/rl
         RO1qQO2LmKibxy7DGGirkpOSCxRw8dZ1qqwkj5cP30AjJuMIpCmQTXt3dxGQDeMiEtGh
         d5Q45bU3pivpOU71UsQ4SeFHJOX5d+mhVbGaKTWoO3ihezhVAZ1Mq0dvBZ4CY44+2+zJ
         Rnop+XYoeO70UTzueOxVxj/wtrVhWM9hBdPQqsaCO5lfOkdCgm02VVu0RnVDsDwNYnXW
         NNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=su81uPGLPlEfo3kKBvUrtbr7Q1bO5QHvXSGg8dkL+fQ=;
        b=K4q3urMARJXHZnT9UW4hsXeY4UbNAbdw009UDd+71z6FHufYJptSl1AJAmo3V6BNRI
         Q0Y75822jNBPNmhvkixstihly4zwn7R7jfKh1X2yRBbMEvA/z09XyvsHuPfKt3c+nAPR
         nlBQSx3FofTkPL8EDlUpT9jUTY1c44jOVg2l9p7qUxTbUMdMuq5d+gboA8KZOO90Jc+J
         Gvr18ilhGXxiEkPk/TcuyqKgv7Ne2SQpAoDv1TvzmBfN7TBrElCqZe32MsZHsrV0ZdOG
         k7o7W4F1VM7ZIecGA5G49cTqoYdRycq+o9UJCvvPpvTcMH3ttX5cfeC2V9sgt0Fd5nti
         8p9A==
X-Gm-Message-State: AOAM53218vwZBuP4evAOPIHxVaXLoXR9GyVB+vkLma3XGksBFwDDuMAf
        ycYJrNfHU0L9dZIYS/Z0qafDrjsIfowBzQ==
X-Google-Smtp-Source: ABdhPJxn9RkJDNkJxLQzGDRKo5bfKfQwmmRCBZ37Qr3/YIQ4rdiA5g9/oIepoLeX5+Fe6RYyeS5Nqw==
X-Received: by 2002:a65:6d87:0:b0:374:2525:dcb0 with SMTP id bc7-20020a656d87000000b003742525dcb0mr8997668pgb.248.1648696554441;
        Wed, 30 Mar 2022 20:15:54 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id w9-20020a056a0014c900b004fb2ca5f6d7sm17801820pfu.136.2022.03.30.20.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 20:15:53 -0700 (PDT)
Date:   Wed, 30 Mar 2022 20:15:53 -0700 (PDT)
X-Google-Original-Date: Wed, 30 Mar 2022 20:15:50 PDT (-0700)
Subject:     Re: [PATCH v8 0/4] Determine the number of DMA channels by 'dma-channels' property
In-Reply-To: <cover.1648461096.git.zong.li@sifive.com>
CC:     robh+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-6ddf988e-9f86-4f3e-8b6a-6be65f384829@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2022 02:52:21 PDT (-0700), zong.li@sifive.com wrote:
> The PDMA driver currently assumes there are four channels by default, it
> might cause the error if there is actually less than four channels.
> Change that by getting number of channel dynamically from device tree.
> For backwards-compatible, it uses the default value (i.e. 4) when there
> is no 'dma-channels' information in dts.
>
> This patch set contains the dts and dt-bindings change.
>
> Changed in v8:
>  - Rebase on master
>  - Remove modification of microchip-mpfs.dtsi
>  - Rename DMA node name of fu540-c000.dtsi
>
> Changed in v7:
>  - Rebase on tag v5.17-rc7
>  - Modify the subject of patch
>
> Changed in v6:
>  - Rebase on tag v5.17-rc6
>  - Change sf_pdma.chans[] to a flexible array member.
>
> Changed in v5:
>  - Rebase on tag v5.17-rc3
>  - Fix typo in dt-bindings and commit message
>  - Add PDMA versioning scheme for compatible
>
> Changed in v4:
>  - Remove cflags of debug use reported-by: kernel test robot <lkp@intel.com>
>
> Changed in v3:
>  - Fix allocating wrong size
>  - Return error if 'dma-channels' is larger than maximum
>
> Changed in v2:
>  - Rebase on tag v5.16
>  - Use 4 as default value of dma-channels
>
> Zong Li (4):
>   dt-bindings: dma-engine: sifive,fu540: Add dma-channels property and
>     modify compatible
>   riscv: dts: Add dma-channels property and modify compatible
>   riscv: dts: rename the node name of dma
>   dmaengine: sf-pdma: Get number of channel by device tree
>
>  .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 19 +++++++++++++--
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  5 ++--
>  drivers/dma/sf-pdma/sf-pdma.c                 | 24 ++++++++++++-------
>  drivers/dma/sf-pdma/sf-pdma.h                 |  8 ++-----
>  4 files changed, 38 insertions(+), 18 deletions(-)

Thanks, these are on for-next.
