Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F09543812
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244559AbiFHPvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239819AbiFHPvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:51:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0689112FB05;
        Wed,  8 Jun 2022 08:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654703484; x=1686239484;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=J9gVhWmRkrARQ+vF0CS/Zkh9G25iczH9M7T6+0LTHwA=;
  b=oKkqBnP3wjW1YvdNq/BfTlcA49KaEjexypqPxpr8AlkXwOhTht/ORCAU
   r2HuKsa5O8bQ4hyd0/Ji9pZW5SSNrdAbapXqVCgk4rXJ5VlliTPG2Es/k
   +4gj+3IupNB+aXglY05Al13tojFQjRSfnlN6Fp47iiracc8hj0xeFsu8G
   yTVxboIMvUDP9Ps/HKgLqjglSpsjc6/SPoy/lvspUtIhOL9n28qq4CzpU
   aGIVZ4wakLcyaqxVaGgjMxJ+YdfhzCgZogmccesD1/tUc5dTtcxa62Vzq
   sSdHriM4/EYuEtBnSzwd9zzm6tjUcvxiOuYSC5sfvg4EruTrLgUiAsGqD
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="275706633"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="275706633"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 08:51:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="609715710"
Received: from pandeyvi-mobl1.amr.corp.intel.com (HELO [10.213.185.165]) ([10.213.185.165])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 08:51:19 -0700
Message-ID: <90a49c5c-7433-cec4-cb86-1424209a54e4@linux.intel.com>
Date:   Wed, 8 Jun 2022 10:39:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/2] soundwire: qcom: Add flag for software clock
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
References: <1654696929-20205-1-git-send-email-quic_srivasam@quicinc.com>
 <1654696929-20205-2-git-send-email-quic_srivasam@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <1654696929-20205-2-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/22 09:02, Srinivasa Rao Mandadapu wrote:
> Add flag in qcom_swrm_data private data structure for validating
> software colck gating control requirement.

typo: clock

> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index a3fccf0..38c3bf5 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -181,6 +181,7 @@ struct qcom_swrm_ctrl {
>  struct qcom_swrm_data {
>  	u32 default_cols;
>  	u32 default_rows;
> +	bool sw_clk_gate_required;

I would have used a different split between patches, where the flag and
functionality is introduced, and a second patch where this flag would be
set for a specific platform.

>  };
>  
>  static const struct qcom_swrm_data swrm_v1_3_data = {
