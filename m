Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195E34CBEFD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbiCCNkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiCCNkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:40:12 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF91E02D1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 05:39:27 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22385Y9M022391;
        Thu, 3 Mar 2022 07:38:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=JAW0fd/250Z2ZV4LwtY5UFwBqx1Nr8e/Nox+ORPT4xU=;
 b=n5VeAkk+Q7i1oO6OwNXDgJN3qKercMxKQDP6zJ1ajaCETX4GfrLuluymxmDMcuPJiu7O
 GAUrlY77z/YP5dZeYyB8UeN/igmXlMCaOolA0pbb4sdFUy+wsRABMZyQgpBXOEd/jFe3
 w9gefAR/S9zxXkXcgRAq3LCBmakVG0uzNnkAT7hmc1pua0yQfekQIOJiuenf4G5mBtO4
 5U2qTdrh7nc7jkcrBe59z1OUpAjwUo6oIOhBwTSQFc8gxyTow5F8ak/q5+LXW2BV4XZG
 DmBv/MWF7I5JoVc65XKVoNcQvnLZGd7VjyzW6fMjkJV7vh0aZU89j7UKcSy4zar/lhcW VA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ejsv20cd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Mar 2022 07:38:36 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 13:38:34 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 3 Mar 2022 13:38:34 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6B4107C;
        Thu,  3 Mar 2022 13:38:34 +0000 (UTC)
Date:   Thu, 3 Mar 2022 13:38:34 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm8350: Handle error for wm8350_register_irq
Message-ID: <20220303133834.GO38351@ediswmail.ad.cirrus.com>
References: <20220303082154.264114-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220303082154.264114-1-jiasheng@iscas.ac.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: HO9RCg_y3zgzSZioCpvPZkwTLQZigB_i
X-Proofpoint-ORIG-GUID: HO9RCg_y3zgzSZioCpvPZkwTLQZigB_i
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 04:21:54PM +0800, Jiasheng Jiang wrote:
> As the potential failure of the wm8350_register_irq(),
> it should be better to check it and return error if fails.
> Also, use 'free_' in order to avoid the same code.
> 
> Fixes: a6ba2b2dabb5 ("ASoC: Implement WM8350 headphone jack detection")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  sound/soc/codecs/wm8350.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
> index 15d42ce3b21d..0c70bbfbedb5 100644
> --- a/sound/soc/codecs/wm8350.c
> +++ b/sound/soc/codecs/wm8350.c
> @@ -1483,7 +1483,7 @@ static  int wm8350_component_probe(struct snd_soc_component *component)
>  	ret = devm_regulator_bulk_get(wm8350->dev, ARRAY_SIZE(priv->supplies),
>  				 priv->supplies);
>  	if (ret != 0)
> -		return ret;
> +		goto err;

I would probably just leave this as a return, nothing is gained
changing it to a goto.

>  
> +	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CODEC_JCK_DET_R,
>  			    wm8350_hpr_jack_handler, 0, "Right jack detect",
>  			    priv);
> -	wm8350_register_irq(wm8350, WM8350_IRQ_CODEC_MICSCD,
> +	if (ret != 0)
> +		goto free_JCK_DET_L;

Probably better to use non-caps here, having caps in a label is a
little unusual.

Otherwise I think this looks fine.

Thanks,
Charles
