Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0F44BB974
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiBRMwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:52:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiBRMwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:52:47 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54DA2B31A4;
        Fri, 18 Feb 2022 04:52:30 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 539721F469B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188749;
        bh=tGSf/pth4T/62+a3wtoLcmdEh6+MDWX12/pzQsxIz+0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lBjwh7yJuYAoaAT+I6wUQ2YXt8niYeOxV/bGvQpiOq4KemuD4k6omY4dhN8nZd8SM
         yDk9tq3tXaUEaPUbNNhw1CHDWAVmWfpuMeEpL6JBprCAqF1bJvyudHHVjpHk89b+i4
         PJYhPTEVccobQNSR5iS5aZlN7zLFDYBwbSgolvbi0SAnKi33bUYyX7/CwL/e0+v/H2
         MFQOx36w1EG4gkYLgCueqgDhhDyjnEfwHqxa6dBQ7zVjcXvsIlC8BLz3QMGjjU/aOM
         OcwIAWkkIYi1CXSM4/+vqcKT4fX6lxT39bzrHaTLoUGza+jUwNC/ZYbNo45HItl2pN
         in1BAZHn/9hDQ==
Message-ID: <81cd0888-b202-feae-1c54-99ad2ef3f8cb@collabora.com>
Date:   Fri, 18 Feb 2022 13:52:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 21/34] iommu/mediatek: Add PCIe support
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, xueqi.zhang@mediatek.com,
        yen-chang.chen@mediatek.com, mingyuan.ma@mediatek.com,
        yf.wang@mediatek.com, libo.kang@mediatek.com,
        chengci.xu@mediatek.com
References: <20220217113453.13658-1-yong.wu@mediatek.com>
 <20220217113453.13658-22-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220217113453.13658-22-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/02/22 12:34, Yong Wu ha scritto:
> Currently the code for of_iommu_configure_dev_id is like this:
> 
> static int of_iommu_configure_dev_id(struct device_node *master_np,
>                                       struct device *dev,
>                                       const u32 *id)
> {
>         struct of_phandle_args iommu_spec = { .args_count = 1 };
> 
>         err = of_map_id(master_np, *id, "iommu-map",
>                         "iommu-map-mask", &iommu_spec.np,
>                         iommu_spec.args);
> ...
> }
> 
> It supports only one id output. BUT our PCIe HW has two ID(one is for
> writing, the other is for reading). I'm not sure if we should change
> of_map_id to support output MAX_PHANDLE_ARGS.
> 
> Here add the solution in ourselve drivers. If it's pcie case, enable one
> more bit.
> 
> Not all infra iommu support PCIe, thus add a PCIe support flag here.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

