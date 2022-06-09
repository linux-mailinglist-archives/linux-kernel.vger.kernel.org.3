Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AAA5450B0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344446AbiFIPXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344489AbiFIPXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:23:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869F5B18;
        Thu,  9 Jun 2022 08:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654788208; x=1686324208;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=OqFF6qDwLOh06Q07Wxi7YuzZhtAUWXJ5RHWWW3Dj/IY=;
  b=VeUiBiKw+Eaxyb83yq9NpxMX1jKSB5jl+LTcZSlT4+U7fnss6cr7aivv
   DxG0fUpDg0Zs9sRb+ZGdLVnJgr1VRWxbr4lLkuoQHMVaL8AIRnSx3Sz7d
   BYpfM+phMKhY3gTldLAmsTJIl+f2vaz96NiI6GZhwlgNm8ME9rYn+/HAA
   DiEcdKNJZpACESyJWmvVbBPd5qn47oGHP2iojYvZAuoU5Ibg3dB91m3ZC
   WeYBSLh/2Azl+RNXcZbezgpRRIg8He7Rm1tQUYqyIS25jz1QZaLMSuXE4
   u+EbH3Vv7Jm9GZQHgpr6/1vq4BiUBWi1K0f0iZCId9vv8BVPEXNrfTsXW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="257747930"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="257747930"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:23:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="585630710"
Received: from jeremywe-mobl3.amr.corp.intel.com (HELO [10.209.173.145]) ([10.209.173.145])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:23:26 -0700
Message-ID: <97757ee1-2525-4e97-855e-da6fb66f01ae@linux.intel.com>
Date:   Thu, 9 Jun 2022 10:22:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v4 1/2] soundwire: qcom: Add flag for software clock
 gating check
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org, vkoul@kernel.org
References: <1654785023-1667-1-git-send-email-quic_srivasam@quicinc.com>
 <1654785023-1667-2-git-send-email-quic_srivasam@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <1654785023-1667-2-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/22 09:30, Srinivasa Rao Mandadapu wrote:
> Validate software clock gating required or not and do software
> clock gating on hclk if soundwire is operational and keep it
> running by adding flag in private data structure.
> This is to avoid conflict between older architectures,
> where software clock gating is not required and on latest
> architectues, where software clock gating is mandatory.

architectures.

> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index a3fccf0..8e163da 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -181,6 +181,7 @@ struct qcom_swrm_ctrl {
>  struct qcom_swrm_data {
>  	u32 default_cols;
>  	u32 default_rows;
> +	bool sw_clk_gate_required;
>  };
>  
>  static const struct qcom_swrm_data swrm_v1_3_data = {
> @@ -1311,6 +1312,15 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  			return PTR_ERR(ctrl->mmio);
>  	}
>  
> +	if (data->sw_clk_gate_required) {
> +		ctrl->audio_cgcr = devm_reset_control_get_exclusive(dev, "swr_audio_cgcr");
> +		if (IS_ERR(ctrl->audio_cgcr)) {

You need to handle the NULL case, devm_reset_control_get_exclusive() can
return ERR_OR_NULL

https://elixir.bootlin.com/linux/latest/source/drivers/reset/core.c#L1045

> +			dev_err(dev, "Failed to get cgcr reset ctrl required for SW gating\n");
> +			ret = PTR_ERR(ctrl->audio_cgcr);
> +			goto err_init;
> +		}
> +	}
> +
>  	ctrl->irq = of_irq_get(dev->of_node, 0);
>  	if (ctrl->irq < 0) {
>  		ret = ctrl->irq;
> @@ -1336,10 +1346,6 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  	ctrl->bus.compute_params = &qcom_swrm_compute_params;
>  	ctrl->bus.clk_stop_timeout = 300;
>  
> -	ctrl->audio_cgcr = devm_reset_control_get_exclusive(dev, "swr_audio_cgcr");
> -	if (IS_ERR(ctrl->audio_cgcr))
> -		dev_err(dev, "Failed to get audio_cgcr reset required for soundwire-v1.6.0\n");
> -
>  	ret = qcom_swrm_get_port_config(ctrl);
>  	if (ret)
>  		goto err_clk;
