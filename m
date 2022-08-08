Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9194F58C6F2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbiHHKus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbiHHKu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:50:29 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF67313F7F;
        Mon,  8 Aug 2022 03:50:27 -0700 (PDT)
Received: from [167.98.27.226] (helo=[10.35.5.6])
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1oL0Kz-001qai-Fh; Mon, 08 Aug 2022 11:50:21 +0100
Message-ID: <6fd64502-6061-f14f-b8c4-b19ab6e26dd5@codethink.co.uk>
Date:   Mon, 8 Aug 2022 11:50:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] soc/tegra: pmc: Add IO Pad table for tegra234
Content-Language: en-GB
To:     Petlozu Pravareshwar <petlozup@nvidia.com>, jonathanh@nvidia.com,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        dmitry.osipenko@collabora.com, ulf.hansson@linaro.org,
        kkartik@nvidia.com, cai.huoqing@linux.dev, spatra@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220805104100.3098200-1-petlozup@nvidia.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20220805104100.3098200-1-petlozup@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2022 11:41, Petlozu Pravareshwar wrote:
> Add IO PAD table for tegra234 to allow configuring dpd mode
> and switching the pins to 1.8V or 3.3V as needed.
> 
> In tegra234, DPD registers are reorganized such that there is
> a DPD_REQ register and a DPD_STATUS register per pad group.
> This change accordingly updates the PMC driver.
> 
> Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> ---
>   drivers/soc/tegra/pmc.c | 116 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 112 insertions(+), 4 deletions(-)


snip

>   /**
> @@ -1546,6 +1560,14 @@ static int tegra_io_pad_get_dpd_register_bit(struct tegra_pmc *pmc,
>   	if (pad->dpd == UINT_MAX)
>   		return -ENOTSUPP;
>   
> +	if (pmc->soc->has_reorg_hw_dpd_reg_impl) {
> +		*mask = BIT(pad->dpd);
> +		*status = pmc->soc->regs->reorg_dpd_status[pad->reg_index];
> +		*request = pmc->soc->regs->reorg_dpd_req[pad->reg_index];
> +
> +		goto done;
> +	}
> +
>   	*mask = BIT(pad->dpd % 32);
>   
>   	if (pad->dpd < 32) {
> @@ -1556,6 +1578,7 @@ static int tegra_io_pad_get_dpd_register_bit(struct tegra_pmc *pmc,
>   		*request = pmc->soc->regs->dpd2_req;
>   	}
>   
> +done:
>   	return 0;
>   }
>   
> @@ -3132,6 +3155,7 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
>   	.num_pmc_clks = 0,
>   	.has_blink_output = true,
>   	.has_usb_sleepwalk = true,
> +	.has_reorg_hw_dpd_reg_impl = false,
>   };

I don't think you need to set false values in these blocks, the
default should be false.



-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
