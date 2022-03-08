Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A044D1649
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244316AbiCHLbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiCHLbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:31:33 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924EF3FD96
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646739037; x=1678275037;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=FfySqN0vQa4ttzZHSXEhhQ3ALTvA9lNDII7nXpWIblk=;
  b=U8rzKHNYjTsRYwrs7GJcPeXlo4I63PIkKzhiRmKTJt4KNVJ88RyMVh8L
   +N8gdxbSNmtYDoNwzX5+AnaGVHRJ5H1LfR6WOh4ZKzmvVu8y5R6ogPri6
   11ogS0k8GK5wAplADUH6k54ji21iFE7FtPTON1WESNRWzkRFRnZLw2oJh
   ovwULfLkXMTWu9tUMTo1d5BcW0qFbSfMYPeMgrJY/NxcTINttBAzHUXXz
   GgA4jNqP5tvSMyzbCyMzAc5ib2gfSRPJmUnffNQDPrgB+Rt8i91HjaHgv
   unQcA7zzLfFEgTZF/EIICRtg93n84+gbM9ftR3KPWKJUCiX72QczU5BO0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="341093265"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="341093265"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 03:30:37 -0800
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="687893094"
Received: from nsedoc-mobl.ger.corp.intel.com (HELO [10.251.218.162]) ([10.251.218.162])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 03:30:33 -0800
Message-ID: <886a7712-ffdc-4d0c-fde5-5498b84e416c@linux.intel.com>
Date:   Tue, 8 Mar 2022 13:30:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] ASoC: SOF: Add missing of_node_put() in imx8m_probe
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220308023325.31702-1-linmq006@gmail.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20220308023325.31702-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/03/2022 04:33, Miaoqian Lin wrote:
> The device_node pointer is returned by of_parse_phandle()  with refcount
> incremented. We should use of_node_put() on it when done.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> Fixes: afb93d716533 ("ASoC: SOF: imx: Add i.MX8M HW support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  sound/soc/sof/imx/imx8m.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
> index 788e77bcb603..60251486b24b 100644
> --- a/sound/soc/sof/imx/imx8m.c
> +++ b/sound/soc/sof/imx/imx8m.c
> @@ -224,6 +224,7 @@ static int imx8m_probe(struct snd_sof_dev *sdev)
>  	}
>  
>  	ret = of_address_to_resource(res_node, 0, &res);
> +	of_node_put(res_node);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to get reserved region address\n");
>  		goto exit_pdev_unregister;

-- 
Péter
