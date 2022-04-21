Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF28509E3D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388681AbiDULGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388672AbiDULF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:05:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D502CE05;
        Thu, 21 Apr 2022 04:03:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 073BB1F4471A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650538985;
        bh=sy+rLNXQIKyW8TFbG6ILeSEG7iS/CKP/Coz25Rxsaxo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cGnzw226WVcrPOtDKpi7ieE4O90YrxM6i8OqPW0jVQeClyXNKGrSfT2+6s7PXpOkO
         4e110iF67BFrPXaLvasAQviKky1wjbwLJi5+XqpeSz/pipobHg0LrwZ2IMShaY8CGI
         2LkBzX4cprcTZJM58VI5QGU7ZvPNggePY7zYW/Blb8IMMXqB0Q580JrSS8sd6XZm/r
         toneZW/LvOIrWOtWs0/doztF+TBek/o9cYpoFtaGnTGL81u+6bjWbzahPNwdXd0RAa
         uZ0UI7lKvqD0Mi09vujcwzbXtL5wls9wS6AXo8nIokQqXHhyYnR4FvtVh4oFvFFdKt
         JTjBaQnnGbIOw==
Message-ID: <7658c8e4-596b-abfc-9255-854c16f920a7@collabora.com>
Date:   Thu, 21 Apr 2022 13:03:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] media: platform: mtk-mdp: Fix mdp_ipi_comm structure
 alignment
Content-Language: en-US
To:     minghsiu.tsai@mediatek.com
Cc:     houlong.wei@mediatek.com, andrew-ct.chen@mediatek.com,
        mchehab@kernel.org, matthias.bgg@gmail.com, hans.verkuil@cisco.com,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, acourbot@chromium.org, irui.wang@mediatek.com
References: <20220307155653.460910-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220307155653.460910-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/03/22 16:56, AngeloGioacchino Del Regno ha scritto:
> The mdp_ipi_comm structure defines a command that is either
> PROCESS (start processing) or DEINIT (destroy instance); we
> are using this one to send PROCESS or DEINIT commands from Linux
> to an MDP instance through a VPU write but, while the first wants
> us to stay 4-bytes aligned, the VPU instead requires an 8-bytes
> data alignment.
> 
> Keeping in mind that these commands are executed immediately
> after sending them (hence not chained with others before the
> VPU/MDP "actually" start executing), it is fine to simply add
> a padding of 4 bytes to this structure: this keeps the same
> performance as before, as we're still stack-allocating it,
> while avoiding hackery inside of mtk-vpu to ensure alignment
> bringing a definitely bigger performance impact.
> 
> Fixes: c8eb2d7e8202 ("[media] media: Add Mediatek MDP Driver")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Hello,
is there any issue with this patch?

Regards,
Angelo

> ---
> 
> This patch has been tested on Acer Chromebook R 13 (MT8173 Elm) on Debian Sid.
> 
> This is an alternative solution to the mtk-vpu approach, found here:
> https://lore.kernel.org/all/20210920170408.1561-1-dafna.hirschfeld@collabora.com
> 
>   drivers/media/platform/mtk-mdp/mtk_mdp_ipi.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_ipi.h b/drivers/media/platform/mtk-mdp/mtk_mdp_ipi.h
> index 2cb8cecb3077..b810c96695c8 100644
> --- a/drivers/media/platform/mtk-mdp/mtk_mdp_ipi.h
> +++ b/drivers/media/platform/mtk-mdp/mtk_mdp_ipi.h
> @@ -40,12 +40,14 @@ struct mdp_ipi_init {
>    * @ipi_id        : IPI_MDP
>    * @ap_inst       : AP mtk_mdp_vpu address
>    * @vpu_inst_addr : VPU MDP instance address
> + * @padding       : Alignment padding
>    */
>   struct mdp_ipi_comm {
>   	uint32_t msg_id;
>   	uint32_t ipi_id;
>   	uint64_t ap_inst;
>   	uint32_t vpu_inst_addr;
> +	uint32_t padding;
>   };
>   
>   /**


-- 
AngeloGioacchino Del Regno
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718
