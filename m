Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D916E46EA61
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbhLIOzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbhLIOzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:55:50 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CA0C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 06:52:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 19D251F46A5C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639061535; bh=+X4qc0MHZgIQKkLg3q3gABPukA4A7ooEBBpVESi636k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DCd2+0AbpWvH9uGgn66Q+FpYzgAr1vK5bnGaOJ4L1uDk2Ig6G9f8bfzJAoGnEbMkF
         UaaqoPUVo4h9mvV6FRVjBrwYybgxCXXoIUXUMqiHu0AmoDIS9Dh6PDIIdMPJth+/6v
         0N48/QdUY3hRS3uEFZTBcPh+VqrY6uGVn6rNQgVpwjA0lQ+iLxXfPYYHUsfKbl+iJ0
         SVtjwDn3GocO2WzfK26zkOikP5yGgErDdX4CDWccrO/eT4s37X7Q3P9K61U+hFuRep
         k69Gp7WWTEGl8glycQbfppxOu00qctBQTfmFDS6C3vYXMq9AuQjng2WH1eVHeV470e
         FKp2elH02CErA==
Subject: Re: [PATCH] mailbox: mtk-cmdq: Silent EPROBE_DEFER errors for clks
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20211209065948.1796663-1-hsinyi@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <4080b8a4-5256-5680-1d70-017f2fed5117@collabora.com>
Date:   Thu, 9 Dec 2021 15:52:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211209065948.1796663-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/12/21 07:59, Hsin-Yi Wang ha scritto:
> Silent the error if it's EPROBE_DEFER for clks.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>   drivers/mailbox/mtk-cmdq-mailbox.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 

Hello! Thanks for the patch!
However, there's something to improve...

> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index a8845b162dbf..087fb7334166 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -573,7 +573,10 @@ static int cmdq_probe(struct platform_device *pdev)
>   				cmdq->clocks[alias_id].id = clk_names[alias_id];
>   				cmdq->clocks[alias_id].clk = of_clk_get(node, 0);
>   				if (IS_ERR(cmdq->clocks[alias_id].clk)) {
> -					dev_err(dev, "failed to get gce clk: %d\n", alias_id);
> +					dev_err_probe(dev,
> +						PTR_ERR(cmdq->clocks[alias_id].clk),
> +						"failed to get gce clk: %d\n",
> +						alias_id);

You can just return dev_err_probe(...)

>   					return PTR_ERR(cmdq->clocks[alias_id].clk);

...so this return gets removed.

>   				}
>   			}
> @@ -582,7 +585,8 @@ static int cmdq_probe(struct platform_device *pdev)
>   		cmdq->clocks[alias_id].id = clk_name;
>   		cmdq->clocks[alias_id].clk = devm_clk_get(&pdev->dev, clk_name);
>   		if (IS_ERR(cmdq->clocks[alias_id].clk)) {
> -			dev_err(dev, "failed to get gce clk\n");
> +			dev_err_probe(dev, PTR_ERR(cmdq->clocks[alias_id].clk),
> +				"failed to get gce clk\n");
>   			return PTR_ERR(cmdq->clocks[alias_id].clk);

Same here:
return dev_err_probe(dev, PTR_ERR(cmdq->clocks[alias_id].clk),
		     "failed to get gce clk\n");

>   		}
>   	}
> 

Regards,
- Angelo
