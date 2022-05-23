Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30690530757
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 03:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352091AbiEWBzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 21:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242207AbiEWBzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 21:55:21 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9C137A2A
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 18:55:20 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id bo5so12399007pfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 18:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=VBuGEekfhW36ZamTc8kfC9Ud28TI3GJRyBkADMSHALk=;
        b=hP5ItfvKy/VamMIj0OMEs9LREs6SAvpSf3VagPR0d/OXk31w9muOX5oJG/B+8l3+9T
         Ru0JyEfEHROS866aZzCge1fgJHCy3+m4aFhRai1+wBKumGSBgIUeruN/kWCvdl+ayqf4
         v+08bFBXRvbFOkRwl7PIWY47SaTUXNGKs1eR9kagenPMVMKN2ElWvFom532lwK3VsD00
         rxJq7uTkVJ0L1Jo3MhMZohq9+Yq/53WLXnKgHoTpX1h2V5rduWtIj0p2TUGLiSgfUznd
         US2y77FP8ghpyRKdzM+nivoIiQ+dLJZ0pQ66fSCyuh1Ije0Eoc1gAJTFZ/Ix4AKBT+Dx
         O9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=VBuGEekfhW36ZamTc8kfC9Ud28TI3GJRyBkADMSHALk=;
        b=Jrvb3dJ814U9CqTAO0yp9o6ghe+0dtfJOwsX58WcRIfehcklYIY2v/qRihPX19m+IM
         JjHaOjbIYaPy1pAp+KU4OASST/EXfkgIFBGJY89tOiLIwf/qBHWx2P7RTY/AAe3ZBgA5
         jr7/HicMQq3Q+atkBuAH1E53YT78okJ4rkQ9nBdhNdKwpLwJ3r8QpOj0GUdEPKk080iF
         CPrZaktm+EdXP+/A+wKvrwoZIAzA3KLMGG5mP/ffXPWa3jmjI4Smb7wN5beqxjuJTyIa
         asCS/QPZt2ITCNqvNSlDNwchgTmxtIkws/jGF7QPFMTDKvERNPK/15VLQ6Jc0zr7R3Au
         I42Q==
X-Gm-Message-State: AOAM531Usq6KKNLg2kbNXtXR9/+qGoHaYx+FMWDzA4ePezS0pFDSOya4
        7ntCGsVfSQnPPpsoYfezzqc=
X-Google-Smtp-Source: ABdhPJzgnvBYyRUoxgBtCbBVodKUaelFPWG4FA7tUsw6CR6KbjQOAAfvw8I3RXZTFeuGuaf2VebhLw==
X-Received: by 2002:a63:87c7:0:b0:3f9:c4d1:b550 with SMTP id i190-20020a6387c7000000b003f9c4d1b550mr10749783pge.310.1653270919909;
        Sun, 22 May 2022 18:55:19 -0700 (PDT)
Received: from [192.168.50.247] ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090a450d00b001df955c28f6sm5519102pjg.37.2022.05.22.18.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 18:55:19 -0700 (PDT)
Message-ID: <45ae7332-074e-cb76-2674-7431fc58b886@gmail.com>
Date:   Mon, 23 May 2022 09:55:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] hwtracing: stm: fix possible double free in
 stm_register_device()
Content-Language: en-US
From:   Hangyu Hua <hbh25y@gmail.com>
To:     alexander.shishkin@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, gregkh@linuxfoundation.org,
        mathieu.poirier@linaro.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220418081632.35121-1-hbh25y@gmail.com>
 <3e01d35c-e748-3e03-4417-8b7dea09075e@gmail.com>
In-Reply-To: <3e01d35c-e748-3e03-4417-8b7dea09075e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentel ping.

On 2022/5/5 09:29, Hangyu Hua wrote:
> Ping
> 
> On 2022/4/18 16:16, Hangyu Hua wrote:
>> put_device() will call stm_device_release() to free stm when
>> stm_register_device() fails. So there is no need to call vfree() again.
>>
>> Fix this by adding a return after put_device().
>>
>> Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System 
>> Trace Module devices")
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>> ---
>>   drivers/hwtracing/stm/core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
>> index 2712e699ba08..403b4f41bb1b 100644
>> --- a/drivers/hwtracing/stm/core.c
>> +++ b/drivers/hwtracing/stm/core.c
>> @@ -915,6 +915,7 @@ int stm_register_device(struct device *parent, 
>> struct stm_data *stm_data,
>>       /* matches device_initialize() above */
>>       put_device(&stm->dev);
>> +    return err;
>>   err_free:
>>       vfree(stm);
