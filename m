Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338BA559D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiFXP3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 11:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiFXP3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 11:29:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AED529801;
        Fri, 24 Jun 2022 08:29:32 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6632866017FA;
        Fri, 24 Jun 2022 16:29:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656084570;
        bh=QLIJRVIptCHxe8YA2obqLBI5SkwO2iKvXB+7BviNrXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R7Cbtu6iwOlYUJNrtTEjjeuyVABZb58IsLv6iv4aHnEjAV7+4X9OKEFgcpkT6JESk
         i/2VCZsY7/cbMsRcgf4dOTxx/3PSzWYVUP8jMMMQ4yyf7RCvrr+nWbUjSg7OhBBD4M
         Nc6GoM0YFzIqCElY4ata+my5gludPw2FJB1ZUA/coPcI/L9qfb9fjHRA22aqsTfUNA
         s4VQqHzTeL4lhivXY7A2kZQiaXKiXwNHDI19/JvInN+pjKDLjCqMbGOEJ2OSc5c92q
         uCZayN2p8ztKQ0BpwAbAbzBDwdw8Ze4K4XnBxRpsyOVsWmHb1H+SsfGgFBbv8nK9g4
         lEY+rGj9GpJ4A==
Date:   Fri, 24 Jun 2022 11:29:26 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Guodong Liu <guodong.liu@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 3/5] pinctrl: mediatek: add rsel setting on mt8192
Message-ID: <20220624152926.76hvymguryhfv4sq@notapiano>
References: <20220624133700.15487-1-guodong.liu@mediatek.com>
 <20220624133700.15487-4-guodong.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624133700.15487-4-guodong.liu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guodong,

thanks for the patch. Please see comments below.

On Fri, Jun 24, 2022 at 09:36:58PM +0800, Guodong Liu wrote:
> 1. I2C pins's resistance value can be controlled by rsel register.
> This patch provides rsel (resistance selection) setting on mt8192.
> 2. Also add the missing pull type array for mt8192 to document the
> pull type of each pin and prevent invalid pull type settings.
> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mt8192.c | 136 ++++++++++++++++++++++
>  1 file changed, 136 insertions(+)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8192.c b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
> index efabeb422aea..ffb0b04f0e3c 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt8192.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8192.c

<snip>

> +	MTK_PULL_PU_PD_TYPE,/*100* MTK_PULL_PU_PD_TYPE,/*101*/
> +	MTK_PULL_PU_PD_TYPE,/*102* MTK_PULL_PU_PD_TYPE,/*103*/
> +	MTK_PULL_PU_PD_TYPE,/*104* MTK_PULL_PU_PD_TYPE,/*105*/
> +	MTK_PULL_PU_PD_TYPE,/*106* MTK_PULL_PU_PD_TYPE,/*107*/
> +	MTK_PULL_PU_PD_TYPE,/*108* MTK_PULL_PU_PD_TYPE,/*109*/
> +	MTK_PULL_PU_PD_TYPE,/*110* MTK_PULL_PU_PD_TYPE,/*111*/
> +	MTK_PULL_PU_PD_TYPE,/*112* MTK_PULL_PU_PD_TYPE,/*113*/
> +	MTK_PULL_PU_PD_TYPE,/*114* MTK_PULL_PU_PD_TYPE,/*115*/
> +	MTK_PULL_PU_PD_TYPE,/*116* MTK_PULL_PU_PD_TYPE,/*117*/

The comments on pins 100 - 116 are missing the closing '/', effectively
commenting out pins 101 - 117 and leading to errors. Please fix this.

Other than that,

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
