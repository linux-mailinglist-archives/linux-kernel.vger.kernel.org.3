Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271AD52363B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245150AbiEKOxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245135AbiEKOxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:53:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268B51F35C6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:53:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D3AD41F4305D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652280824;
        bh=hiCszEOEiRWDy9PmZfFtMkSpl4zM/nh6AVy0EHkIDYQ=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=asNGWawcKO386eoV6Ik3dXldZywT8oDuTlXksokpIIRR4gEyOav/D+tb4Juwr+k4y
         Qx+rYNtLFhqMtdSQGxu2vUOcTonxYINTbtNnjoBS/yQLEEI13gfvNtYIZuqr7YSCYN
         CxG5n9KstAMaivz0dLSG8XxRt7c2mm+yeMKgVOj8ugrKBs7QwuqDQCBCfamauVy14W
         R47VUmrSRn6eleE+bFO5EP2wWBxNxVcpnGnyq8MTs34Wd3SAlUU5VdMv9+im2UjnkH
         QnJWN+7n9mcg3M0eAeLcLIEl42peP7r99nhPHNgkgjWeHpMQzZV1nT7DlDooTn005z
         55mJoc85Lt5sw==
Message-ID: <26273bf5-c4a4-da9d-d722-da3880a27ce4@collabora.com>
Date:   Wed, 11 May 2022 16:53:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 3/4] iommu/mediatek: Validate number of phandles
 associated with "mediatek,larbs"
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com, chengci.xu@mediatek.com,
        youlin.pei@mediatek.com, anan.sun@mediatek.com,
        xueqi.zhang@mediatek.com, Guenter Roeck <groeck@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220511064920.18455-1-yong.wu@mediatek.com>
 <20220511064920.18455-4-yong.wu@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220511064920.18455-4-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/05/22 08:49, Yong Wu ha scritto:
> From: Guenter Roeck <groeck@chromium.org>
> 
> Fix the smatch warnings:
> drivers/iommu/mtk_iommu.c:878 mtk_iommu_mm_dts_parse() error: uninitialized
> symbol 'larbnode'.
> 
> If someone abuse the dtsi node(Don't follow the definition of dt-binding),
> for example "mediatek,larbs" is provided as boolean property, the code may
> crash. To fix this problem and improve the code safety, add some checking
> for the invalid input from dtsi, e.g. checking the larb_nr/larbid valid
> range, and avoid "mediatek,larb-id" property conflicts in the smi-larb
> nodes.
> 
> Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

