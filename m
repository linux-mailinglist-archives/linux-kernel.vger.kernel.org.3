Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE31506B70
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351941AbiDSLxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351914AbiDSLwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:52:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D8A13F43;
        Tue, 19 Apr 2022 04:49:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5C0881F42293
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650368990;
        bh=r6OoFRF0ucAMfAcDbrXpKkVoip13W6nPZWDxs/jqu34=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MHicWKIVvPyXryi5j5G1lgxR2qQrHIMMb5/s++e8qSu56qaTAz63/Qm65bpr+z+5c
         6Mpg2j9JCJBewIONfXZ0w6ZRHVaa8CugNKrVr2eiJcbHSFc/cYVfu8BfEhIhRZRcJY
         ZAZNhXCrwc6F7xKHzAVoZgFrCP9gpcdl9Dhi4aRuE3+0sIoij5F2/A9hwPtIzX+lpg
         GRyqI8+EkPs23WtwzMuJV8Av8D9h+CgLdEo9kh8IPIJcnIndasDYNTq6w/CL4toflU
         /qw6xL8Tzt6Pli4EQ/9GQqiMISGObmpPwn8fD0YG/l5nZ3wrU5z05xBOd0MGNi7yl3
         CuuPiXLjd8kXw==
Message-ID: <cb56d23b-fb80-426f-cc30-50ef351b0ad6@collabora.com>
Date:   Tue, 19 Apr 2022 13:49:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] remoteproc: mediatek: allow reading firmware-name
 from DT
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20220414122140.6114-1-allen-kh.cheng@mediatek.com>
 <20220414122140.6114-3-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220414122140.6114-3-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/04/22 14:21, Allen-KH Cheng ha scritto:
> The SCP firmware blob differs between platforms and SoCs. We add
> support in the SCP driver for reading the path of firmware file from
> DT in order to allow these files to live in a generic file system
> (or linux-firmware).
> 
> The firmware-name property is optional and the code falls back to the
> old filename if the property isn't present.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>   drivers/remoteproc/mtk_scp.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index ee6c4009586e..82813d74e829 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -809,9 +809,14 @@ static int scp_probe(struct platform_device *pdev)
>   	struct mtk_scp *scp;
>   	struct rproc *rproc;
>   	struct resource *res;
> -	char *fw_name = "scp.img";
> +	const char *fw_name = "scp.img";
>   	int ret, i;
>   
> +	ret = of_property_read_string(pdev->dev.of_node, "firmware-name",
> +				      &fw_name);

Hello Allen,
the remoteproc subsystem provides a helper for that, please use it:

	ret = rproc_of_parse_firmware(&pdev->dev, 0, &fw_name);


> +	if (ret < 0 && ret != -EINVAL)
> +		return ret;

... this check is necessary, so you can keep this one.

Thanks,
Angelo


