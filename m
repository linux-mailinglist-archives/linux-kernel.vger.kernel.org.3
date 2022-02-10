Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6044B0FEB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242009AbiBJONg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:13:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237901AbiBJONe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:13:34 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E981D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:13:36 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id z7so4409381ilb.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FTAdirp5u7kTPPTGGN6xaNHqqgo+3Ngm4ug8TFgRbao=;
        b=NXxgxLaGF5+w3dAUHgP2M1xT8dNGrVXDIfLw2d9aAp3zn4ve9J+lzs73YNobNypHTA
         yfbuFMac6Zdeo9iXFLeyRWqzfM7zNDbdmbPqPyYi9fsvPBfkf6Vdj+74DSM8wM5HgadH
         DODEHzBNXeYw7VmiWueDAfqATbSOu+CkntoIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FTAdirp5u7kTPPTGGN6xaNHqqgo+3Ngm4ug8TFgRbao=;
        b=g9NWT2g/JLK7Mw1i9ZRp01AUdidRj1ZYlSLYW+irm9vJmQnd/HaKqRs9sDEEDpoXQb
         7upFAY7P3GJQSa+QKwUPes6C7AbyfYO+vpIJyHz1eCWobjGe3mW7FyzHnk4byo8i0NKw
         adLekQtqF7FGy5JjHUV+pBr/2lPZQTFcWqbmulHj+RsaGbWH29vMRFHYqGn/1JVtYwhV
         9MUFOmfYTGWYGP2hxPaOZxKvzOnLgGj7BznpGJeZDPeQnBre3pSosznJ+yXJysjMHZ7W
         6oLtx/vc85eArtVjsei9zlZDpkX1ZL34/aGyg6z/GmHN8i+4JcmwFY9Kqb9ERWivPn7F
         btBg==
X-Gm-Message-State: AOAM530QM7MdwSketnZYYmBHLTgEDckMvsMME4Lgdyy8jdHZtLyMYBBs
        HGbfGEjksuH7QmFTx2njhlbVsw==
X-Google-Smtp-Source: ABdhPJwDBBWJKOGCBNeiFKJ0MK8ImMpMu2FRLOjiWecOhD52Iay9AOmBJc34TV8aSZHSnhOMJ0k66Q==
X-Received: by 2002:a05:6e02:1949:: with SMTP id x9mr4198030ilu.269.1644502415395;
        Thu, 10 Feb 2022 06:13:35 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id e5sm9302582ilq.9.2022.02.10.06.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 06:13:35 -0800 (PST)
Subject: Re: [PATCH] usbip: vudc: Make use of the helper macro LIST_HEAD()
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220209032813.38703-1-cai.huoqing@linux.dev>
 <8c8bcf5b-bbda-55e0-6a61-35bfafbafb78@linuxfoundation.org>
 <20220210023714.GA7791@chq-T47>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b4f2bdf3-9584-0dd5-f4e2-fae97018fcfc@linuxfoundation.org>
Date:   Thu, 10 Feb 2022 07:13:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220210023714.GA7791@chq-T47>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 7:37 PM, Cai Huoqing wrote:
> On 09 2月 22 09:00:37, Shuah Khan wrote:
>> On 2/8/22 8:28 PM, Cai Huoqing wrote:
>>> Replace "struct list_head head = LIST_HEAD_INIT(head)" with
>>> "LIST_HEAD(head)" to simplify the code.
>>>
>>> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
>>> ---
>>>    drivers/usb/usbip/vudc_main.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/usbip/vudc_main.c b/drivers/usb/usbip/vudc_main.c
>>> index 678faa82598c..d43252b77efd 100644
>>> --- a/drivers/usb/usbip/vudc_main.c
>>> +++ b/drivers/usb/usbip/vudc_main.c
>>> @@ -26,7 +26,7 @@ static struct platform_driver vudc_driver = {
>>>    	},
>>>    };
>>> -static struct list_head vudc_devices = LIST_HEAD_INIT(vudc_devices);
>>> +static LIST_HEAD(vudc_devices);
>>>    static int __init init(void)
>>>    {
>>>
>>
>> Explain why this change simplifies the code and also add a comment
>> above LIST_HEAD
> LIST_HEAD() help to clean up the code "struct list_head vudc_devices =
> ". we only to care the variable 'vudc_devices',
>>

How does LIST_HEAD() make it simpler. It does that I am sure. I am looking
for you to explain how it does in the change log.

thanks,
-- Shuah
