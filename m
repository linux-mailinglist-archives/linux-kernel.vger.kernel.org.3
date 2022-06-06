Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8AF53E7B3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbiFFJej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiFFJeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:34:37 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1411B9A70
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:34:36 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2567cllq030641;
        Mon, 6 Jun 2022 04:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=VUdD1guqD0Qi0LS/4B8LoHY2yPYYeCkOvTny4xFn5gY=;
 b=BwuNFseyfaRSx/dcP0/JROg2dLRovYkXcKjTTY6s6rq5ZBrQhXAIgtkyveoolIpuN09w
 Umbe3QhYmcop3blsgu+aNdkpB0Y8pQj2pWJ4VS9mvU9tn0dHwZlMqW9lZ08aQZnlqDeg
 wBV15jXyBucpCt7Ltcl+eB68pP1Ln/ALBfWX00Le4vjxWF9OxYH/bMZ/AvXFBk4ZFHSV
 IpVysORk++iAHg4m4iMDeJDmC5gwE6Sa8bvIrUl39K91TznaN5+fAS+F/f8KMh82qkHA
 sP0kPr76C6CP9z0bnl3sTf36cRwFrqkk3j/UtyvL4Kl17NesU9Uj1EeuLRLHeMAbahF9 uw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gg4t3sngc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 06 Jun 2022 04:33:44 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 6 Jun
 2022 10:33:42 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 6 Jun 2022 10:33:42 +0100
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.90.251.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0732AB10;
        Mon,  6 Jun 2022 09:33:42 +0000 (UTC)
Subject: Re: [PATCH] ASoC: wm_adsp: Remove redundant NULL check before
 release_firmware() call
To:     <cgel.zte@gmail.com>, <lgirdwood@gmail.com>
CC:     <broonie@kernel.org>, <perex@perex.cz>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220606013916.290387-1-chi.minghao@zte.com.cn>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <ab457b05-6a50-9852-5f12-fed1558fae46@opensource.cirrus.com>
Date:   Mon, 6 Jun 2022 10:33:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220606013916.290387-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9M7AEQigAU00T33Sv2cjvfVeyDHvpHo0
X-Proofpoint-ORIG-GUID: 9M7AEQigAU00T33Sv2cjvfVeyDHvpHo0
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2022 02:39, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> release_firmware() checks for NULL pointers internally so checking
> before calling it is redundant.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>   sound/soc/codecs/wm_adsp.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
> index 7973a75cac05..4c4344b21c2e 100644
> --- a/sound/soc/codecs/wm_adsp.c
> +++ b/sound/soc/codecs/wm_adsp.c
> @@ -739,12 +739,10 @@ static void wm_adsp_release_firmware_files(struct wm_adsp *dsp,
>   					   const struct firmware *coeff_firmware,
>   					   char *coeff_filename)
>   {
> -	if (wmfw_firmware)
> -		release_firmware(wmfw_firmware);
> +	release_firmware(wmfw_firmware);
>   	kfree(wmfw_filename);
>   
> -	if (coeff_firmware)
> -		release_firmware(coeff_firmware);
> +	release_firmware(coeff_firmware);
>   	kfree(coeff_filename);
>   }
>   
> 
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
