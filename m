Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6B2583C8C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbiG1Kvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbiG1Kvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:51:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D4122B12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:51:47 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F25036601B41;
        Thu, 28 Jul 2022 11:51:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659005506;
        bh=R6DrP5mpef+w1XUFgkLzJ6U/ghoD03zA8Xf+MFNAOAc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O73i4vDmw3pkVFHoi2sCJzIHc90Z2PqAvwnwQU6y6MIDHezyqaqxaNaXEaoz7d42H
         PcE7/+TcEbnr59TJ7f77zNp9WnMXONANeLrzZhhEtrZM6vBLxZsDYK6pia2JSg69eB
         JQezS3cUHtJ+yt9bTSwn/JeqWNaEtDv+1YOu7QbB26KtowyQjzx+uuFtis0UkzI3yF
         FYOz4hQiCIoHTThla09KbbwvUxhR4i4uAOwZ9sdHLfBuJTSRVVGCVcTvz9kbhIuTB1
         U2YFdZaXSGEp1UualKor4uQhTeiq3+p5sXdOLmteMIie+iz1jaz6xWx2Yj5LowSfdo
         A9Hz0795WCg7A==
Message-ID: <98eccbdd-3446-f44d-9278-79a4a60c1c18@collabora.com>
Date:   Thu, 28 Jul 2022 12:51:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] soc: mediatek: Let PMIC Wrapper and SCPSYS depend on OF
Content-Language: en-US
To:     Jean Delvare <jdelvare@suse.de>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chenglin Xu <chenglin.xu@mediatek.com>
References: <20220728112216.13b10689@endymion.delvare>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220728112216.13b10689@endymion.delvare>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/07/22 11:22, Jean Delvare ha scritto:
> With the following configuration options:
> CONFIG_OF is not set
> CONFIG_MTK_PMIC_WRAP=y
> CONFIG_MTK_SCPSYS=y
> we get the following build warnings:
> 
>    CC      drivers/soc/mediatek/mtk-pmic-wrap.o
> drivers/soc/mediatek/mtk-pmic-wrap.c:2138:34: warning: ‘of_pwrap_match_tbl’ defined but not used [-Wunused-const-variable=]
> drivers/soc/mediatek/mtk-pmic-wrap.c:1953:34: warning: ‘of_slave_match_tbl’ defined but not used [-Wunused-const-variable=]
>    CC      drivers/soc/mediatek/mtk-scpsys.o
> drivers/soc/mediatek/mtk-scpsys.c:1084:34: warning: ‘of_scpsys_match_tbl’ defined but not used [-Wunused-const-variable=]
> 
> Looking at the code, both drivers can only bind to OF-defined device
> nodes, so these drivers are useless without OF and should therefore
> depend on it.
> 

Hello Jean,

I would prefer that you solve this warning by removing of_match_ptr() from both
drivers instead.

Regards,
Angelo

> Developers or QA teams who wish to test-build the code can still do
> so by enabling CONFIG_OF, which is available on all architectures and
> has no dependencies.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/all/202207240252.ZY5hSCNB-lkp@intel.com/
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Chenglin Xu <chenglin.xu@mediatek.com>
> ---
>   drivers/soc/mediatek/Kconfig |    2 ++
>   1 file changed, 2 insertions(+)
> 
> --- linux-5.18.orig/drivers/soc/mediatek/Kconfig	2022-05-22 21:52:31.000000000 +0200
> +++ linux-5.18/drivers/soc/mediatek/Kconfig	2022-07-28 10:59:55.025131145 +0200
> @@ -37,6 +37,7 @@ config MTK_INFRACFG
>   config MTK_PMIC_WRAP
>   	tristate "MediaTek PMIC Wrapper Support"
>   	depends on RESET_CONTROLLER
> +	depends on OF
>   	select REGMAP
>   	help
>   	  Say yes here to add support for MediaTek PMIC Wrapper found
> @@ -46,6 +47,7 @@ config MTK_PMIC_WRAP
>   config MTK_SCPSYS
>   	bool "MediaTek SCPSYS Support"
>   	default ARCH_MEDIATEK
> +	depends on OF
>   	select REGMAP
>   	select MTK_INFRACFG
>   	select PM_GENERIC_DOMAINS if PM
> 


-- 
