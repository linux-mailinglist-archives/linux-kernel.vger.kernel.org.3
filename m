Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F524592BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242475AbiHOKr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 06:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241189AbiHOKrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:47:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369001F615;
        Mon, 15 Aug 2022 03:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D10AB610A0;
        Mon, 15 Aug 2022 10:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FA8C433D6;
        Mon, 15 Aug 2022 10:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660560466;
        bh=Z+B7ZCuu32c79i/JZjsPK9ikebKrv3lEhiGMQUYzpTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jUAh7v2a6ThnqbRQRSuRr8JyDUlf45K0SA1/KOCOhjI0SA7biZCxUi+Bva9+SJSjJ
         MfXTX47nM5/j7/GTYc5zR3WDj38owqfJcGUoc/t7562sW/bfLAYtABTz6BU++Vu6Bf
         0+ALC0M4I+Z5YixObAyhG3v0k4nf1PDwqK/PfHEE=
Date:   Mon, 15 Aug 2022 12:47:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     will@kernel.org, mark.rutland@arm.com, Frank.li@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, zhangshaokun@hisilicon.com,
        agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, khuong@os.amperecomputing.com,
        john.garry@huawei.com, jonathan.cameron@huawei.com,
        yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: Change WARN_ON() to dev_err() on
 irq_set_affinity() failure
Message-ID: <YvokT+ZQQMlEAga8@kroah.com>
References: <20220815092815.11597-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815092815.11597-1-yangyicong@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 05:28:15PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The WARN_ON() on irq_set_affinity() failure is misused according to the [1]
> and may crash people's box unintentionally. This may also be redundant since
> in the failure case we may also trigger the WARN and dump the stack in the
> perf core[2] for a second time.
> 
> So change the WARN_ON() to dev_err() to just print the failure message.
> 
> [1] https://github.com/torvalds/linux/blob/master/include/asm-generic/bug.h#L74
> [2] https://github.com/torvalds/linux/blob/master/kernel/events/core.c#L313

Please point to git.kernel.org links, we do not control github.com and
it's random mirrors.

> 
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> [https://lore.kernel.org/lkml/YuOi3i0XHV++z1YI@kroah.com/]
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/perf/arm-ccn.c                   | 5 +++--
>  drivers/perf/arm_dmc620_pmu.c            | 3 ++-
>  drivers/perf/arm_smmuv3_pmu.c            | 6 ++++--
>  drivers/perf/fsl_imx8_ddr_perf.c         | 3 ++-
>  drivers/perf/hisilicon/hisi_pcie_pmu.c   | 6 ++++--
>  drivers/perf/hisilicon/hisi_uncore_pmu.c | 6 ++++--
>  drivers/perf/qcom_l2_pmu.c               | 8 ++++++--
>  drivers/perf/xgene_pmu.c                 | 6 ++++--
>  8 files changed, 29 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
> index 728d13d8e98a..83abd909ba49 100644
> --- a/drivers/perf/arm-ccn.c
> +++ b/drivers/perf/arm-ccn.c
> @@ -1210,8 +1210,9 @@ static int arm_ccn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>  		return 0;
>  	perf_pmu_migrate_context(&dt->pmu, cpu, target);
>  	dt->cpu = target;
> -	if (ccn->irq)
> -		WARN_ON(irq_set_affinity(ccn->irq, cpumask_of(dt->cpu)));
> +	if (ccn->irq && irq_set_affinity(ccn->irq, cpumask_of(dt->cpu)))
> +		dev_err(ccn->dev, "Failed to set interrupt affinity\n");
> +
>  	return 0;

Why are you returning with no error, if an error happened?

Same everywhere else, you need to explain this in your changelog text.

thanks,

greg k-h
