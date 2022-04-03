Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D7A4F0C8E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 22:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354855AbiDCUxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 16:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiDCUxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 16:53:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C076439152
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 13:51:42 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id yy13so16166577ejb.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 13:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7Tmp7Qk6hIQcTiejJhaTNRuWS2H8gg+y1/8Tdq0ds1M=;
        b=mHU2wFp8KmRopqLXFNr4SiOKp4DEUNB46yAuTRbiSLgj48wFuFIhjd1U9yCJX6/Wj0
         bNq2EeArJQz2HDOLH8OKqzJ34f3SgooqsL8Xu6hQ1GPU5MJ0D1w+tB/ZTxakrYU3tQdT
         RT8xC6awlLoUMr3xwPQFRpW0FtmvFJifTGU9+urOwus2NkmAnN11EJ5v5xVRmDAZ5iLy
         F0s8CJ8w79B9bLV4lWB7ImDeIHJ1rSuNvda3S7dkrzr9zGE6/eyXQQg7JeeQvri6c0FI
         BnjkcelYJfc7xRImqRUSCSRlLCeEgLfl1KKX6NNVkNnKGmyC1imO1aVI0J4+BMBNtDh7
         nfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7Tmp7Qk6hIQcTiejJhaTNRuWS2H8gg+y1/8Tdq0ds1M=;
        b=bA0wHVfzvU+rXsAIMUJBmObbUFfk2DpWq1QCZ+V99vQYlE7b3B6xI+sAUwWNHQ+qBC
         2RUi4/osymLHe1QofqPbSq+f6OS9UMWGzKFlIhaag5NWdfmn2bN6nIihKHK8Wsu8bjGN
         MMhMODOzOYcGW0LPs3rSwpxj63FT4mq/RxQ/UJOV/FeRokSFbAY6K1uS7B03vpP3cQ3F
         Q9veH10j2skVqUJGqKv80uUyG5WMevx2Fuvx4ZrFKlBS8p3vkgeqgbBRQDn6cKo8RNEg
         cBvJAjeOPztE4/mFp2juuHuJ59GY8cd6EBN+AsYlm7icX45vT1fBy+WPbajMW+Rr7Bu8
         56Sw==
X-Gm-Message-State: AOAM531jIvAO6WbX4sT63r3aPcA5rNL3SmxElM9oCVD30fxu+SFsUcTE
        3tyS9yz3g24va5G0PA8hCmk=
X-Google-Smtp-Source: ABdhPJz5mB7+/vEpLnVULd+FoXFZLSy9eGh3SNyp7jen+znctk+iCpkcCXo6XJw1ersbomYGdgzqoQ==
X-Received: by 2002:a17:907:1b21:b0:6e7:f3ec:c920 with SMTP id mp33-20020a1709071b2100b006e7f3ecc920mr579621ejc.341.1649019101223;
        Sun, 03 Apr 2022 13:51:41 -0700 (PDT)
Received: from [192.168.0.151] (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id hp12-20020a1709073e0c00b006e02924bf20sm3514169ejc.117.2022.04.03.13.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 13:51:40 -0700 (PDT)
Message-ID: <942c0fbd-f8b2-4cae-dd21-79bc55c54902@gmail.com>
Date:   Sun, 3 Apr 2022 22:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: staging: r8188eu: how to handle nested mutex under spinlock
Content-Language: en-US
To:     Pavel Skripkin <paskripkin@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
 <4412825.cEBGB3zze1@leap> <26ac4c2d-91cf-656d-2b7e-21a95e500e70@gmail.com>
 <2029549.KlZ2vcFHjT@leap> <7d3d23c3-1839-3e6a-27bf-85bad384e5e4@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <7d3d23c3-1839-3e6a-27bf-85bad384e5e4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/22 15:02, Pavel Skripkin wrote:
> Hi Fabio,
> 
> On 4/3/22 15:55, Fabio M. De Francesco wrote:
>> On domenica 3 aprile 2022 14:45:49 CEST Pavel Skripkin wrote:
>>> Hi Fabio,
>>>
>>> On 4/3/22 15:37, Fabio M. De Francesco wrote:
>>> >> > >> > drivers/staging/r8188eu/core/rtw_pwrctrl.c:379
>>> >> > >> >        if (pwrpriv->ps_processing) {
>>> >> >            while (pwrpriv->ps_processing && 
>>> rtw_get_passing_time_ms(start) <= 3000)
>>> >> >                msleep(10);
>>> >> >        }
>>> >> > >> >> Hm, just wondering, shouldn't we annotate load from >> 
>>> pwrpriv->ps_processing with READ_ONCE() inside while loop?
>>> >> IIUC compiler might want to cache first load into register and we 
>>> will >> stuck here forever.
>>> > > You're right. This can be cached. In situations like these one 
>>> should use
>>> > barriers or other API that use barriers implicitly (completions, 
>>> for example).
>>> >
>>> Not sure about completions, since they may sleep.
>>
>> No completions in this special context. They for _sure_ might sleep. I 
>> was
>> talking about general cases when you are in a loop and wait for status 
>> change.
>>
>>>
>>> Also, don't think that barriers are needed here, since this code just 
>>> waiting for observing value 1. Might be barrier will slightly speed 
>>> up waiting thread, but will also slow down other thread
>>
>> Here, I cannot help with a 100% good answer. Maybe Greg wants to say 
>> something
>> about it?
>>
> 
> IMO, the best answer is just remove this loop, since it does nothing. Or 
> redesign it to be more sane
> 
> It waits for ps_processing to become 0 for 3000 ms, but if 3000 ms 
> expires... execution goes forward like as ps_processing was 0 from the 
> beginning
> 
> Maybe it's something hw related, like wait for 3000 ms and all will be 
> ok. Can't say...
> 

Hi Pavel,

same with the loop that follows:

	/* System suspend is not allowed to wakeup */
	if (pwrpriv->bInSuspend) {
		while (pwrpriv->bInSuspend &&
		       (rtw_get_passing_time_ms(start) <= 3000 ||
		       (rtw_get_passing_time_ms(start) <= 500)))
				msleep(10);
	}

I just waits 500ms if pwrpriv->bInSuspend is true. Additionaly the
<= 3000 has no effect here because of the ored <= 500.

Even worse the comment seems misleading because pwrpriv->bInSuspend 
indicates usb autosuspend but not system suspend.

regards,
Michael
