Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B45478808
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhLQJrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:47:14 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:59462 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229874AbhLQJrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:47:13 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BH7VDG4027623;
        Fri, 17 Dec 2021 03:46:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=3k0NdkEM+b3Vmv/jNu9YwAZ5aPOV8hy9c94hsdHkoj4=;
 b=O6PaKYMJB9vjvl7wcy1pWHj4P0faJMuF0dMqMltSrHWwGAVfYMOmuBbnX+LAkRZz5F6V
 v8Q9FhsZ3KePzhwjj8/kUnNCZqxk+5tBKmfkgN9V1JLOhup6g2vhlFOz8H84URzxqrg/
 SSlHtymU1eC56t0RReJdC0N1X8Oh/uxWBtxq3LG3XuIcrutoz5ta5Vszhl8eTIUXVLOo
 XnjIthvAFp/agnroLt0MsyrmGdnkn4xp4sNN3HiJffg3NfC6GbkVPcA73vVKZbmVh/PW
 /RyvuYkYTPuNDtlIQgUVHzSKKEyHl2e5aRh2uVSaAKFrYXfqwDjdeR3LclB/oGN/nrgU FQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cymsc2b1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Dec 2021 03:46:11 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 09:46:09 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 17 Dec 2021 09:46:09 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F2DD8B10;
        Fri, 17 Dec 2021 09:46:08 +0000 (UTC)
Date:   Fri, 17 Dec 2021 09:46:08 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>,
        <shengjiu.wang@nxp.com>, <daniel.baluta@nxp.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: potential use of error pointer
Message-ID: <20211217094608.GT18506@ediswmail.ad.cirrus.com>
References: <20211217031333.493777-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211217031333.493777-1-jiasheng@iscas.ac.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: J6QOU-sQ0H4BXgBQ4mDiiuRrtxDn9pJ6
X-Proofpoint-ORIG-GUID: J6QOU-sQ0H4BXgBQ4mDiiuRrtxDn9pJ6
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 11:13:33AM +0800, Jiasheng Jiang wrote:
> The return value of devm_clk_get() needs to be checked.
> To avoid use of error pointer in case of the failure of alloc.
> 
> Fixes: d74e9e7090ae ("ASoC: wm8962: Add device tree binding")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  sound/soc/codecs/wm8962.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index 34080f497584..66693bf17763 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -3540,6 +3540,8 @@ static int wm8962_set_pdata_from_of(struct i2c_client *i2c,
>  		}
>  
>  	pdata->mclk = devm_clk_get(&i2c->dev, NULL);
> +	if (IS_ERR(pdata->mclk))
> +		return -ENOMEM;

The value was checked later, so the code was mostly fine and what
bugs there were have already been fixed:

044c11401443 ("ASoC: wm8962: Convert to devm_clk_get_optional")

Thanks,
Charles
