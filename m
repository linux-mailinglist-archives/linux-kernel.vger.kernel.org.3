Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE73573972
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbiGMO6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbiGMO6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:58:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DD63FA22;
        Wed, 13 Jul 2022 07:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657724293; x=1689260293;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=lTmAVQlD6Vx1Np35GsT5xt5v+z7aHOSMCs6G1835MVM=;
  b=OwA7VLKJdaEZAMYMkRUHBRyuNGDTJt622C03J5gcMLG50KLkxVfBSTB1
   JpRsE25y7yOvEDerF1OKP+7zdSk0bbzRSeYeAhEMLSXKJOMkcTWC2CJFI
   cSu5I48Pt0vPDAt54v0NnD9eE69Gv7DxngpmxykDv+8m+/NAlC7/MePb7
   NdRufhSz7v2YsbaB3/22CGGON0LY5vMSerWbOTzwcKtOkcZlYAAP0y6aX
   2321t+OCyX0/t00QggUwcuG6LAaJx3lIBpKzihas1HQVAV7sxPanMY1nA
   haDQlr1MkXV0pRtjQ2ONRHqe2quXhmppREdUhTKfl1yTZk78oQcH8ns9m
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="265020324"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="265020324"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 07:58:13 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="593017443"
Received: from melanief-mobl.amr.corp.intel.com (HELO [10.212.10.37]) ([10.212.10.37])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 07:58:11 -0700
Message-ID: <726124ab-53e4-5f3c-b0bb-124d129d3028@linux.intel.com>
Date:   Wed, 13 Jul 2022 09:58:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH v2] soundwire: qcom: Update error prints to debug prints
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        vkoul@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        quic_plai@quicinc.com, bgoswami@quicinc.com, perex@perex.cz,
        tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
References: <1657724067-19004-1-git-send-email-quic_srivasam@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <1657724067-19004-1-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/22 09:54, Srinivasa Rao Mandadapu wrote:
> Update error prints to debug prints to avoid redundant logging in kernel
> boot time, as these prints are informative prints in irq handler.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
> Changes since v1:
>     -- Remove redundant __func__ argument.
>     -- Replace dev_dbg with dev_dbg_ratelimited.
> 
>  drivers/soundwire/qcom.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 9df970e..976ae75 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -573,11 +573,10 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>  				break;
>  			case SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED:
>  			case SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS:
> -				dev_err_ratelimited(swrm->dev, "%s: SWR new slave attached\n",
> -					__func__);
> +				dev_dbg_ratelimited(swrm->dev, "SWR new slave attached\n");
>  				swrm->reg_read(swrm, SWRM_MCP_SLV_STATUS, &slave_status);
>  				if (swrm->slave_status == slave_status) {
> -					dev_err(swrm->dev, "Slave status not changed %x\n",
> +					dev_dbg(swrm->dev, "Slave status not changed %x\n",
>  						slave_status);
>  				} else {
>  					qcom_swrm_get_device_status(swrm);
