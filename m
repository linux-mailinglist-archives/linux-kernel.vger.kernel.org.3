Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9081D597FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 10:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbiHRIOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 04:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiHRIOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 04:14:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC37719AE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660810491; x=1692346491;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1pMu3yuAB0gQ8wwcQ/V5v3DSCGyeUtyrelY95YGU83k=;
  b=c7nYK41rKoCvjjQG8QfQni8lc5/zUZsK9ZKoQqUNvzgi8Vshcr8U6ILi
   CgB2FlFLzGFiPQXdCT4CBzwYDfNmPorGCViS+cH/mVYtFwCfSwEYYBZKi
   mNrJBKv7SqAOVU9Rvhs9BGPC9bnXNJDWs4UKB/95Odgs1T7sx0SPbVQIe
   fRYZ3NvJL+s/E5VqD21Lxmh7NjA3Qu2WQDGTLFUmHhz5+poIUncRGUz/I
   D8EHfE3f56JvHXR1OBP+C/0pSRLgIZB9s64eLpmSqXwFVRLQapr3d/h2h
   WpJlFs1pKKQ4RfE+gIGoUjvP6WKngd92nFT20P5Cful7sCHDkUT8xFgn+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="292697341"
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="292697341"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 01:14:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="604176061"
Received: from jiayiwan-mobl1.ccr.corp.intel.com (HELO [10.249.254.115]) ([10.249.254.115])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 01:14:48 -0700
Message-ID: <afcaffc6-aa07-d95f-6823-a858b53ee978@linux.intel.com>
Date:   Thu, 18 Aug 2022 11:14:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH -next] ASoC: SOF: ipc4-topology: fix wrong use of sizeof
 in sof_ipc4_widget_setup_comp_src()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        sound-open-firmware@alsa-project.org
Cc:     rander.wang@intel.com, pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com, broonie@kernel.org
References: <20220818081751.2407066-1-yangyingliang@huawei.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20220818081751.2407066-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/08/2022 11:17, Yang Yingliang wrote:
> It should be size of the struct sof_ipc4_src, not data pointer pass to
> sof_update_ipc_object().

Good find, thank you.

Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> Fixes: b85f4fc40d56 ("ASoC: SOF: add ipc4 SRC module support")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  sound/soc/sof/ipc4-topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
> index af072b484a60..c6abfaf5d532 100644
> --- a/sound/soc/sof/ipc4-topology.c
> +++ b/sound/soc/sof/ipc4-topology.c
> @@ -771,7 +771,7 @@ static int sof_ipc4_widget_setup_comp_src(struct snd_sof_widget *swidget)
>  		goto err;
>  
>  	ret = sof_update_ipc_object(scomp, src, SOF_SRC_TOKENS, swidget->tuples,
> -				    swidget->num_tuples, sizeof(src), 1);
> +				    swidget->num_tuples, sizeof(*src), 1);
>  	if (ret) {
>  		dev_err(scomp->dev, "Parsing SRC tokens failed\n");
>  		goto err;

-- 
Péter
