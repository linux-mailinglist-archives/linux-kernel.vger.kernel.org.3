Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D431D48AEAA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240788AbiAKNm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240778AbiAKNmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:42:24 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E2EC06173F;
        Tue, 11 Jan 2022 05:42:23 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id ED90A1F43CE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641908542;
        bh=VDeQBil7SvH4yhLcVBFps42iLaKsZvV+Npp785+S9gE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CukxjS8X5so9pw0JwyRff/isKd/L1VT4kkZuJa1RnP3JefA5K5SyYWbSa2y++pkcY
         k+Xkbv4ISBrHurP/H0pDSYVsb3NV+/cFWqgrqKQwyC+C0j7O46ayI9o8JheqD9LdjQ
         2/QvTYr4SJihNm6I0ni7IjQ4FcoVpMan0jgfD3vtHa5siTOW0sLPPyMjWSMj0JDfxA
         Of0yPofdqvP4wgPpoZ2gLVIP8Vq+kFKnisIBJFGLP0JEJxg0JhpROU3ipwEoZpVAIN
         JKtlHGuzs+HjHoP6/pU2Qw4V4ZcsXj86fUZTjhOUACUnNKlp0qH0gD8tf/Jg0QnGhn
         tYGGN/JlZJzCA==
Subject: Re: [PATCH 5/7] pinctrl: mediatek: paris: Drop extra newline in
 mtk_pctrl_show_one_pin()
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
References: <20220111112244.1483783-1-wenst@chromium.org>
 <20220111112244.1483783-6-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <82271a06-d9cb-efd0-57f1-b0bab847f826@collabora.com>
Date:   Tue, 11 Jan 2022 14:42:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220111112244.1483783-6-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/01/22 12:22, Chen-Yu Tsai ha scritto:
> The caller of mtk_pctrl_show_one_pin() is responsible for printing the
> full line. mtk_pctrl_show_one_pin(), called through mtk_pctrl_dbg_show(),
> should only produce a string containing the extra information the driver
> wants included.
> 
> Drop the extra newlines.
> 
> Fixes: 184d8e13f9b1 ("pinctrl: mediatek: Add support for pin configuration dump via debugfs.")
> Fixes: fb34a9ae383a ("pinctrl: mediatek: support rsel feature")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   drivers/pinctrl/mediatek/pinctrl-paris.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> index d259f075c62d..1bacabfbc183 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> @@ -639,12 +639,10 @@ ssize_t mtk_pctrl_show_one_pin(struct mtk_pinctrl *hw,
>   			pullup);
>   
>   	if (r1 != -1) {
> -		len += scnprintf(buf + len, buf_len - len, " (%1d %1d)\n",
> +		len += scnprintf(buf + len, buf_len - len, " (%1d %1d)",
>   			r1, r0);

Since you're doing also some nice cleanups, would you mind un-breaking the line
above? That'd be 82 columns, which is fine to have.

In any case:


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

>   	} else if (rsel != -1) {
> -		len += scnprintf(buf + len, buf_len - len, " (%1d)\n", rsel);
> -	} else {
> -		len += scnprintf(buf + len, buf_len - len, "\n");
> +		len += scnprintf(buf + len, buf_len - len, " (%1d)", rsel);
>   	}
>   
>   	return len;
> 
