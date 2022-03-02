Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577234C9A4D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 02:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbiCBBPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 20:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiCBBP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 20:15:28 -0500
X-Greylist: delayed 647 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Mar 2022 17:14:45 PST
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22685457B9;
        Tue,  1 Mar 2022 17:14:45 -0800 (PST)
Received: from [172.16.12.69] (unknown [58.22.7.114])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 56030800204;
        Wed,  2 Mar 2022 09:03:56 +0800 (CST)
Message-ID: <242bae88-5dde-f005-6580-6024d51e0700@rock-chips.com>
Date:   Wed, 2 Mar 2022 09:03:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Cc:     shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: host: dw-mmc-rockchip: avoid logspam when cd-broken
Content-Language: en-GB
To:     Peter Geis <pgwipeout@gmail.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
References: <20220228223642.1136229-1-pgwipeout@gmail.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20220228223642.1136229-1-pgwipeout@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUlKS0tKN1dZLVlBSVdZDwkaFQgSH1lBWUNNSBlWS0pPSkNPSE
        gZGRgaVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktITUpVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PQw6Iww6MT5RGkwDLxUuARlI
        DiNPC0tVSlVKTU9NSkNIS0hNQ0NNVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlCTkg3Bg++
X-HM-Tid: 0a7f4827b6c1b03akuuu56030800204
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

在 2022/3/1 6:36, Peter Geis 写道:
> The dw_mmc-rockchip driver drops a large amound of logspam constantly
> when the cd-broken flag is enabled.
> Set the warning to be debug ratelimited in this case.
> 

May I know which platform did you use?

> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>   drivers/mmc/host/dw_mmc-rockchip.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index 95d0ec0f5f3a..d0ebf0afa42a 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -50,8 +50,13 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>   		cclkin = ios->clock * RK3288_CLKGEN_DIV;
>   
>   	ret = clk_set_rate(host->ciu_clk, cclkin);
> -	if (ret)
> -		dev_warn(host->dev, "failed to set rate %uHz\n", ios->clock);
> +	if (ret) {
> +		/* this screams when card detection is broken */
> +		if (host->slot->mmc->caps & MMC_CAP_NEEDS_POLL)
> +			dev_dbg_ratelimited(host->dev, "failed to set rate %uHz\n", ios->clock);
> +		else
> +			dev_warn(host->dev, "failed to set rate %uHz\n", ios->clock);
> +	}
>   
>   	bus_hz = clk_get_rate(host->ciu_clk) / RK3288_CLKGEN_DIV;
>   	if (bus_hz != host->bus_hz) {
