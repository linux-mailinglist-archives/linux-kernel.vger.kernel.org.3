Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CDC5A5DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiH3IQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiH3IQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:16:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A54B7B78F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:16:07 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3A4296601E8E;
        Tue, 30 Aug 2022 09:16:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661847366;
        bh=RhuI1yWgn6gBmBPlwuNO0blBF1o/qMPbrqYFzGXSElc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I9oUDCAEb9L0xz0DoNFHbqEET2qL1Ufphb+wJ8rP9EgCO/z/ANEHOT9UkG/LBRDwS
         oITPjXyUNlvIFwVc0RFlLK7qJTFrzAs/gnFnDEEupkCPEGCi8oandZaRei1xIHsPuH
         ulV+22EC5nFoI2olm6FomJ9ebFU0CWHsvsOWbWCfBtVBk/iTuLbJgRHAGeQXmBnVDx
         s3/Z4e1iZ8Nao3dY6kaf9UTPqO26x0gZXuj4ae7GCqLWy6YdTttt77s9R6h1tBrOyI
         krCPKCybm6XUoR/GTi+V/oLbpPD//aIOO+fh/uB1T7BpRsqLxY2AFD4+NsVmd5JVQ7
         ocVQ9+UvWrGCg==
Message-ID: <b681d321-8fc9-90c0-70e7-18d1f970b572@collabora.com>
Date:   Tue, 30 Aug 2022 10:16:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 5/6] iommu/mediatek: Improve safety for mediatek,smi
 property in larb nodes
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com, chengci.xu@mediatek.com,
        youlin.pei@mediatek.com, anan.sun@mediatek.com,
        xueqi.zhang@mediatek.com, Guenter Roeck <groeck@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220824064306.21495-1-yong.wu@mediatek.com>
 <20220824064306.21495-6-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220824064306.21495-6-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/08/22 08:43, Yong Wu ha scritto:
> No functional change. Just improve safety from dts.
> 
> All the larbs that connect to one IOMMU must connect with the same
> smi-common. This patch checks all the mediatek,smi property for each
> larb, If their mediatek,smi are different, it will return fails.
> Also avoid there is no available smi-larb nodes.
> 
> Suggested-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

