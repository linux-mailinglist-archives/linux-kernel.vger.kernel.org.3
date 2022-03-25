Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782614E6C21
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357569AbiCYBkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357656AbiCYBiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:38:02 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB40C4E1C;
        Thu, 24 Mar 2022 18:35:59 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s8so5278518pfk.12;
        Thu, 24 Mar 2022 18:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WSmPxGJ/N7m7s9FWn/fQPHj0JdOPw5DvEWrlHtWBPrg=;
        b=edf5U20/ypl1s0QUEduTspO0hQ5vh1Q+YbkR1ka8gs/+/8aez6YiAy7wEds7JDXXA6
         HA+vN6IF6TX54BcLNtiJGNNXjfzlqaXNGExfEqtVJ6bTPwpRws2lAhQPRUygaijqyEDD
         9rjT/ve10XP9NuNcCFq45qpBjbxuivzlCC7Nwiys1rlYeAJee0q+mac3vM/UCJVxfE6v
         jjOG2zCOGLn6EgjnQ7MDS2tjNC6kslpc31qBsaJp3YJrGeV54TE4FhHiUOrfts0FCtgx
         LkNRjL2/Es/7ALV+2BfAYoZkwvBnP8eOOiVwCmBX5edRMVoXZSUhuKPrhLoznWleTVNR
         H3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WSmPxGJ/N7m7s9FWn/fQPHj0JdOPw5DvEWrlHtWBPrg=;
        b=BYvniatOirKU5KGUkKabK/XUU284eNkEPnyrQgh9fcfoZAUE5Qq3lBnZns0BBQk2tf
         PuF4MPDjcQHEmcq0wmaEG9xe0FZtatU3DpqoKuRKaj5qcciAdgD0n7UWDUAq8tUbr3CC
         g3TJbIyhzjkJg/a/yzfOmsffhlS2UOlVP0l7UABjdUpT2NEusZnwRi4RSaSG/MV9Qe7U
         taYlcHipF1QrNjLCazEL8tszvK+C7WHu8BmBAVIDjEuJUY4jqh3jXsKwZ/MiPLlIjtBT
         KWTLZgVZYW8lzVxuvMXZYgGaVDBtuvpIrBbxtp7HlR9e3m+u0NvYWd1Jm1ZqpIbmOgnq
         LjKw==
X-Gm-Message-State: AOAM531R8VshGiqorp1kNroPstkM5wtpBlrcZDdzOODYnk2gHVejHV72
        cZjN8SgNE3/rpJ9ILm1oYcQ3oun0O7mxFA==
X-Google-Smtp-Source: ABdhPJw5I4DkJYCIuR9VjsCjtBnR9PNDzO5pPcEFbOpeUjmtJ0QtZfLdv7QEcJl8k9Bj4r6rXxhl1g==
X-Received: by 2002:a63:1223:0:b0:381:32e6:e56b with SMTP id h35-20020a631223000000b0038132e6e56bmr6004022pgl.375.1648172158830;
        Thu, 24 Mar 2022 18:35:58 -0700 (PDT)
Received: from [10.11.37.162] ([103.84.139.54])
        by smtp.gmail.com with ESMTPSA id p4-20020a056a0026c400b004fac03b0423sm4763711pfw.178.2022.03.24.18.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 18:35:58 -0700 (PDT)
Message-ID: <e86106b6-b7a5-ee6f-4865-151353c68ec7@gmail.com>
Date:   Fri, 25 Mar 2022 09:35:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] media: uvc_video: fix bit overflow in uvc_probe_video
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220324091308.44799-1-hbh25y@gmail.com>
 <Yjx3laKM9Ah+1PRC@pendragon.ideasonboard.com>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <Yjx3laKM9Ah+1PRC@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. I will do it.

On 2022/3/24 21:52, Laurent Pinchart wrote:
> Hi Hangyu,
> 
> Thank you for the patch.
> 
> On Thu, Mar 24, 2022 at 05:13:08PM +0800, Hangyu Hua wrote:
>> probe->dwMaxPayloadTransferSize is a 32bit value, but bandwidth is 16bit. This
>> may lead to a bit overflow.
>>
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>> ---
>>   drivers/media/usb/uvc/uvc_video.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
>> index 1b4cc934109e..cc4878373aa7 100644
>> --- a/drivers/media/usb/uvc/uvc_video.c
>> +++ b/drivers/media/usb/uvc/uvc_video.c
>> @@ -383,7 +383,7 @@ int uvc_probe_video(struct uvc_streaming *stream,
>>   	struct uvc_streaming_control *probe)
>>   {
>>   	struct uvc_streaming_control probe_min, probe_max;
>> -	u16 bandwidth;
>> +	u32 bandwidth;
>>   	unsigned int i;
>>   	int ret;
>>   
>> @@ -422,7 +422,7 @@ int uvc_probe_video(struct uvc_streaming *stream,
>>   			break;
>>   
>>   		bandwidth = probe->dwMaxPayloadTransferSize;
>> -		if (bandwidth <= stream->maxpsize)
>> +		if (bandwidth <= (u32)stream->maxpsize)
> 
> The cast to u32 isn't needed, it's implicit.
> 
> This could actually be written
> 
> 	if (probe->dwMaxPayloadTransferSize <= stream->maxpsize)
> 
> The bandwidth local variable can be dropped. Could you submit a v2 with
> this change ?
> 
>>   			break;
>>   
>>   		if (stream->dev->quirks & UVC_QUIRK_PROBE_MINMAX) {
> 
