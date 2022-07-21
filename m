Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B112D57C8FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiGUKal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiGUKai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:30:38 -0400
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D27E10EF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:30:36 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id ETRwooD4R0UP7ETRwooLQW; Thu, 21 Jul 2022 12:30:34 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 21 Jul 2022 12:30:34 +0200
X-ME-IP: 90.11.190.129
Message-ID: <a29ea047-4935-4893-108b-f29f46971272@wanadoo.fr>
Date:   Thu, 21 Jul 2022 12:30:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ASoC: qcom: q6dsp: Fix an off-by-one in
 q6adm_alloc_copp()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     alsa-devel@alsa-project.org,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>
References: <0fca3271649736053eb9649d87e1ca01b056be40.1658394124.git.christophe.jaillet@wanadoo.fr>
 <20220721100042.GL2338@kadam>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220721100042.GL2338@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21/07/2022 à 12:00, Dan Carpenter a écrit :
> On Thu, Jul 21, 2022 at 11:02:22AM +0200, Christophe JAILLET wrote:
>> find_first_zero_bit() returns MAX_COPPS_PER_PORT at max here.
>> So 'idx' should be tested with ">=" or the test can't match.
>>
>> Fixes: 7b20b2be51e1 ("ASoC: qdsp6: q6adm: Add q6adm driver")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   sound/soc/qcom/qdsp6/q6adm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
>> index 01f383888b62..1530e98df165 100644
>> --- a/sound/soc/qcom/qdsp6/q6adm.c
>> +++ b/sound/soc/qcom/qdsp6/q6adm.c
>> @@ -217,7 +217,7 @@ static struct q6copp *q6adm_alloc_copp(struct q6adm *adm, int port_idx)
>>   	idx = find_first_zero_bit(&adm->copp_bitmap[port_idx],
>>   				  MAX_COPPS_PER_PORT);
>>   
>> -	if (idx > MAX_COPPS_PER_PORT)
>> +	if (idx >= MAX_COPPS_PER_PORT)
>>   		return ERR_PTR(-EBUSY);
> 
> Harshit asked me to write a Smatch check to prevent this bug in the
> future.  I got his email before I got your patch.  :P  Attached.

Well, well, well...
Easy to say afterwards. You got 58 mins to write it. :).

> 
> sound/soc/qcom/qdsp6/q6adm.c:220 q6adm_alloc_copp() warn: impossible find_next_bit condition
> 
> I'll probably try to make this check more generic, but even the simple
> find_first_zero_bit() version will probably find bugs in the future and
> it was pretty simple to write.

You could add find_last_bit(), find_next_zero_bit_le() and 
find_next_bit_le().

> 
> regards,
> dan carpenter
> 
> 

A reduced version of mine was:

@@
expression e1, e2;
statement S;
@@
(
*   e1 = find_first_bit(...);
|
*   e1 = find_last_bit(...);
|
	[... snip ...]
)
     ...
     if (e1 > e2)
         S


(and it takes only a few seconds to scan the whole kernel :) )
