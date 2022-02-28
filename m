Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F300B4C6E98
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbiB1NvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiB1NvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:51:22 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737385130C;
        Mon, 28 Feb 2022 05:50:43 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C45121F438C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646056242;
        bh=01LHGkJJ+DpNYyT1azd35ZIb6hFj6cZ6HVkPFWhLSpg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EVphFN2nlSfP7QnVMQPprWeHY3LGcr4CNLIyJwc93JAON0XRrHPUEBxJtTps4YWN/
         teZLX3YIek+zUtUDvBSoQrBSI/MMaewUqah04AgMl1Q2EoUcX49lKK3o3X3lDFTBeQ
         Ciwc4QZJbinmesi65g4Cksnl/DPy8HmKBYR1dBf3CG73Y2GP3KeK5HTIkqXRSKZgHR
         6g7KLIla/2XXP7PKHafiVilugVgEELIR4r3POzlUd375pz3+5AaS+yT3BOAkd7enBY
         wLsHX+VBenM5SuXKynOeeyhdGojSDhCTFd+XPt7gt+38YBVce7LBPgpfWq7bQghohU
         ob9f2ZHuNUTSg==
Message-ID: <7ba0ee87-c193-9834-d0b4-ff3e06ced82b@collabora.com>
Date:   Mon, 28 Feb 2022 14:50:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 00/34] MT8195 IOMMU SUPPORT
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>, Yong Wu <yong.wu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
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
 <YhzBSsn/zUlGg5JE@8bytes.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YhzBSsn/zUlGg5JE@8bytes.org>
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

Il 28/02/22 13:34, Joerg Roedel ha scritto:
> Hi Yong Wu,
> 
> On Thu, Feb 17, 2022 at 07:34:19PM +0800, Yong Wu wrote:
>> Yong Wu (34):
>>    dt-bindings: mediatek: mt8195: Add binding for MM IOMMU
>>    dt-bindings: mediatek: mt8195: Add binding for infra IOMMU
>>    iommu/mediatek: Fix 2 HW sharing pgtable issue
>>    iommu/mediatek: Add list_del in mtk_iommu_remove
>>    iommu/mediatek: Remove clk_disable in mtk_iommu_remove
>>    iommu/mediatek: Add mutex for m4u_group and m4u_dom in data
>>    iommu/mediatek: Add mutex for data in the mtk_iommu_domain
>>    iommu/mediatek: Adapt sharing and non-sharing pgtable case
>>    iommu/mediatek: Add 12G~16G support for multi domains
>>    iommu/mediatek: Add a flag DCM_DISABLE
>>    iommu/mediatek: Add a flag NON_STD_AXI
>>    iommu/mediatek: Remove the granule in the tlb flush
>>    iommu/mediatek: Always enable output PA over 32bits in isr
>>    iommu/mediatek: Add SUB_COMMON_3BITS flag
>>    iommu/mediatek: Add IOMMU_TYPE flag
>>    iommu/mediatek: Contain MM IOMMU flow with the MM TYPE
>>    iommu/mediatek: Adjust device link when it is sub-common
>>    iommu/mediatek: Allow IOMMU_DOMAIN_UNMANAGED for PCIe VFIO
>>    iommu/mediatek: Add a PM_CLK_AO flag for infra iommu
>>    iommu/mediatek: Add infra iommu support
>>    iommu/mediatek: Add PCIe support
>>    iommu/mediatek: Add mt8195 support
>>    iommu/mediatek: Only adjust code about register base
>>    iommu/mediatek: Just move code position in hw_init
>>    iommu/mediatek: Separate mtk_iommu_data for v1 and v2
>>    iommu/mediatek: Remove mtk_iommu.h
>>    iommu/mediatek-v1: Just rename mtk_iommu to mtk_iommu_v1
>>    iommu/mediatek: Add mtk_iommu_bank_data structure
>>    iommu/mediatek: Initialise bank HW for each a bank
>>    iommu/mediatek: Change the domid to iova_region_id
>>    iommu/mediatek: Get the proper bankid for multi banks
>>    iommu/mediatek: Initialise/Remove for multi bank dev
>>    iommu/mediatek: Backup/restore regsiters for multi banks
>>    iommu/mediatek: mt8195: Enable multi banks for infra iommu
> 
> This doesn't apply cleanly, can you please send a version rebased to
> v5.17-rc4?
> 
> Thanks,
> 
> 	Joerg

Hello Joerg,

this series depends on the following series:
https://patchwork.kernel.org/project/linux-mediatek/list/?series=592275

...which is also well tested and ready to be merged in.

Applying Yong's series without the mentioned series from Dafna would not work.


Thanks,
Angelo
