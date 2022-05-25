Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EE153376B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 09:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244359AbiEYHfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 03:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbiEYHff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 03:35:35 -0400
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [221.176.66.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB3B454BDE
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 00:35:30 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3])
        by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5628ddc3e068-037c0;
        Wed, 25 May 2022 15:35:27 +0800 (CST)
X-RM-TRANSID: 2ee5628ddc3e068-037c0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.26.114] (unknown[10.42.68.12])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee2628ddc3e16d-c8e67;
        Wed, 25 May 2022 15:35:27 +0800 (CST)
X-RM-TRANSID: 2ee2628ddc3e16d-c8e67
Subject: Re: [PATCH] ASoC: stm32: sai: Use
 of_device_get_match_data()tosimplify code
To:     Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Mark Brown <broonie@kernel.org>
Cc:     arnaud.pouliquen@foss.st.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, alsa-devel@alsa-project.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220519124235.21100-1-tangbin@cmss.chinamobile.com>
 <69d5cef3-57c0-9bc7-a83b-a85ef1c4cf29@foss.st.com>
 <YovZAf4S0XphBsco@sirena.org.uk>
 <3fb8d7f8-4506-3b28-22cb-863bda1f21c8@cmss.chinamobile.com>
 <d5ab354a-eb10-d31c-d55e-46a4c4d1a4ce@foss.st.com>
From:   tangbin <tangbin@cmss.chinamobile.com>
Message-ID: <cd375914-a3e6-37c7-4a16-551937006f92@cmss.chinamobile.com>
Date:   Wed, 25 May 2022 15:36:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d5ab354a-eb10-d31c-d55e-46a4c4d1a4ce@foss.st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier：

On 2022/5/24 22:30, Olivier MOYSAN wrote:
> Hi Tang,
>
> On 5/24/22 03:44, tangbin wrote:
>> Hi Mark & Olivier：
>>
>> On 2022/5/24 2:57, Mark Brown wrote:
>>> On Mon, May 23, 2022 at 03:28:48PM +0200, Olivier MOYSAN wrote:
>>>
>>>> The current patch requires a change in the driver.
>>>> Either changing STM_SAI_x_ID enums, or replacing data by a struct.
>>>> For instance:
>>>> struct stm32_sai_comp_data {
>>>>     unsigned int id;
>>>> }
>>>> struct stm32_sai_comp_data stm32_sai_comp_data_a = {
>>>>     .id = STM_SAI_A_ID;
>>>> }
>>>> struct of_device_id stm32_sai_sub_ids[] = {
>>>>     .data = &stm32_sai_comp_data_a},
>>>> }
>>> Either approach works for me (or a revert for that matter).
>>
>>      Thanks for your advice, I was thoughtless.
>>
>>      I think change the date of STM_SAI_x_ID maybe simple. But if we 
>> don't change the id,
>>
>> what about add a "#define" like the line 47:
>>
>> #define STM_SAI_IS_SUB(x) ((x)->id == STM_SAI_A_ID || (x)->id == 
>> STM_SAI_B_ID)
>>
>> then in the judgement, wu use:
>>
>>      sai->id = (uintptr_t)of_device_get_match_data(&pdev->dev);
>>
>>      if (!STM_SAI_IS_SUB(sai))
>>
>>              return -EINVAL;
>>
>>
>> if you think that's ok, I will send patch v2 for you .
>>
>
> If we allow null value in STM_SAI_IS_SUB(sai) check, we can miss real 
> NULL pointer error from of_device_get_match_data().
>
> The simplest way is to change STM_SAI_x_ID enums I think.
> But honnestly, I feel more comfortable to let the driver unchanged.
>
Oh，you are right, I am sorry.

Please forget this patch, I'm sorry to have wasted your time.

But I saw some codes is useless in the line 48 & line 49, I think we can 
remove it.

If you think so, I will send this patch for you.


Thanks

Tang Bin


> BRs
> Olivier
>
>> Thanks
>>
>> Tang Bin
>>
>>


