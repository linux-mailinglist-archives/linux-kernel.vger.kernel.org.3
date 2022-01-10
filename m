Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB294897D0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245050AbiAJLpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245047AbiAJLnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:43:52 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9CFC034000;
        Mon, 10 Jan 2022 03:43:50 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 820AD1F41050
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641815029;
        bh=uuV0Epzk3gnedbGM5nYSmM92AIVHPp2psXKWjNKXehw=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=WREfHH3VNKZ3seg60JNQO3Fi3Dk/N7tcQ33MIfJeskUq2VJAqGKk7Udgz2sEjQp3i
         2e80eQSixi7eeAV7Z3NXxPVYylvhsRvqbKuPqa0kUNUmu1EaUr6zhIr7+a781648fM
         aPvHxOL7meGaspCUQ6woaS8+t74/0YJ40zPraeA1IIhSwNsXO8IcFS9jery6X4QaLi
         uG1Vo3JZ8TysSP1YaDmpUyWSlcUYSS6V5K6u8v/Eqwt/B+gasmiKhbD3B7k/IX2GhP
         H2kj3+sN9R20jQnWhJ91HGAX9m/pUlEs7W2zp6XBkzfnjV7VtTkXwSgEZx795Ii7nT
         JDU+TlY+gNUXQ==
Subject: Re: [PATCH v2 3/5] iommu/mediatek: Remove the power status checking
 in tlb flush all
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        iommu@lists.linux-foundation.org, Yong Wu <yong.wu@mediatek.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:MEDIATEK IOMMU DRIVER" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        linux-media@vger.kernel.org, sebastian.reichel@collabora.com
References: <20211208120744.2415-1-dafna.hirschfeld@collabora.com>
 <20211208120744.2415-4-dafna.hirschfeld@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <10ca4eae-2959-a697-6818-308e04f88e14@collabora.com>
Date:   Mon, 10 Jan 2022 12:43:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211208120744.2415-4-dafna.hirschfeld@collabora.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/12/21 13:07, Dafna Hirschfeld ha scritto:
> From: Yong Wu <yong.wu@mediatek.com>
> 
> To simplify the code, Remove the power status checking in the
> tlb_flush_all, remove this:
>     if (pm_runtime_get_if_in_use(data->dev) <= 0)
> 	    continue;
> 
> The mtk_iommu_tlb_flush_all is called from
> a) isr
> b) tlb flush range fail case
> c) iommu_create_device_direct_mappings
> 
> In first two cases, the power and clock are always enabled.
> In the third case tlb flush is unnecessary because in a later patch
> in the series a full flush from the pm_runtime_resume callback is added.
> 
> In addition, writing the tlb control register when the iommu is not resumed
> is ok and the write is ignored.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> [refactor commit log]
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
