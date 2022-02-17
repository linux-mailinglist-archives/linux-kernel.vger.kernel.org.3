Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413CA4BA062
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240558AbiBQMwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:52:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240554AbiBQMwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:52:18 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF9711A30;
        Thu, 17 Feb 2022 04:52:03 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21HCNFEV030051;
        Thu, 17 Feb 2022 06:51:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=hbRL+GXRFDweLRaYt0Z5YOa4T9eSAOcGOHkpzVK4Cn4=;
 b=Isa/yu2W8XnNGKd+4kFtY2O7KAfNckBrerQ+EWIDJTc8NfO7sIgvTUjrO3lUQTNFPKL9
 P5wKX8+ECBmE9L+a/ZcNhv0hQdNK/I/xK/69zOkxXI1BWj+xHB3EK9PutC835YRqj6OO
 RUevkZAWVNeqT4fuuTW//FItD7Q/4v8stE/Vosw+JViyX/RvSKxJyKx7FO84AeFrU4lE
 DbU7t59cHeeVqu7NhCFGbffUvRhwpkTLuxVKtmtRKicL3W52GKrM8B1C7k1tc7bpODdP
 0KT/R2Ydc1VCd/1OeGDcSqX/o/u9/UlPjPdwxiORA2dsDvszToWPogFoIk+SXGFzXS0w tA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3e8nyda699-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Feb 2022 06:51:52 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 12:51:51 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 17 Feb 2022 12:51:51 +0000
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.199])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AE88146B;
        Thu, 17 Feb 2022 12:51:50 +0000 (UTC)
Subject: Re: [PATCH 2/2] ASoC: audio_graph_card2: Add support for variable
 slot widths
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>
References: <20220216171408.265605-1-rf@opensource.cirrus.com>
 <20220216171408.265605-3-rf@opensource.cirrus.com>
 <87a6eq49yq.wl-kuninori.morimoto.gx@renesas.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <0ba5f63c-44a4-1949-60dd-f5debd706caa@opensource.cirrus.com>
Date:   Thu, 17 Feb 2022 12:51:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87a6eq49yq.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: COEC_n5rfu52TJYRPUMDIj3hJP3bf618
X-Proofpoint-ORIG-GUID: COEC_n5rfu52TJYRPUMDIj3hJP3bf618
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2022 00:23, Kuninori Morimoto wrote:
> 
> Hi Richard
> 
> Thank you for your patch.
> One comment from me.
> 
>>   struct asoc_simple_dai {
>>   	const char *name;
>>   	unsigned int sysclk;
>> @@ -26,6 +31,9 @@ struct asoc_simple_dai {
>>   	unsigned int rx_slot_mask;
>>   	struct clk *clk;
>>   	bool clk_fixed;
>> +	struct asoc_simple_tdm_width_map *tdm_width_map;
>> +	int n_tdm_widths;
>> +	struct snd_soc_dai *dai;
>>   };
> (snip)

(snip)

> (snip)
>> @@ -386,6 +479,8 @@ static int asoc_simple_init_dai(struct snd_soc_dai *dai,
>>   	if (!simple_dai)
>>   		return 0;
>>   
>> +	simple_dai->dai = dai;
> 
> Indeed the relationship between asoc_simple_dai and snd_soc_dai are
> very mystery, and current utils is using confusable naming.
> We want to have some better solution about there.
> 
> Having snd_soc_dai pointer inside asoc_simple_dai itself is not bad idea.
> But we can get snd_soc_dai pointer without it.
> 
> Please check asoc_simple_dai_init().
> Not tested, but we can replace the code like this ?
> 
> =>	struct snd_soc_dai *dai;
> 
> 	for_each_prop_dai_codec(props, i, pdai) {
> =>		dai = asoc_rtd_to_codec(rtd, i);
> 		ret = asoc_simple_set_tdm(dai, pdai, params);
> 		if (ret < 0)
> 			return ret;
> 	}
> 
> 
I first thought about doing it like that. But I was not sure whether it
is safe to assume [i] is the same entry for both arrays. If it is ok,
then I can use that and do not need to add the snd_soc_dai * to struct
asoc_simple_dai.

I will look at this and send a V2 set if it is ok.
