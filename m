Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED49B52D77E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbiESP13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbiESP1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:27:22 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F2B6FD3D;
        Thu, 19 May 2022 08:27:21 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u7so5949855ljd.11;
        Thu, 19 May 2022 08:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=06m0spO/zzT7LU0U7Sp7nFMRUJ5YbpK+1tdhabMSTrg=;
        b=Av2O2dirj8NHt4uyVji55uosaO+MsQVVdCzMtcCvghVkDNcAvvIUFYCAEvlowBuajK
         G0oQoe8zLVSV5qD/9QTgpgALw6w0lU+2WQlKsfB2/vJv/qSdWBFKjjTgGAbrttWCvSmo
         9pIFuhzbzA4lSVIkuJSLMN4rtoZorDILjvT/sewomISmLSxIIZKnraQ+dfbtZVMTRtPa
         YDyBVQcP8zYVLfkhYe2++N/9kbnhTLW2AYIi4NnfpCy1SCaM+nV0wGpYrZ9ZmP29Trdm
         kJT8rN7M4bDd3RWuP41mEZZwJOVg59QOBs6rqyk6wdf50Qta+UTQmWKFbNDUkOeXV0GT
         cdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=06m0spO/zzT7LU0U7Sp7nFMRUJ5YbpK+1tdhabMSTrg=;
        b=PLS8hECaTyI13M3LU+JYeK+qgndW1MPsr2ck8yzhIYKx0QQcIzW0y9TncAeda4M5VX
         Nqo1jBwGLJXHlZeZVGQLh+821WePsqXe+ud5zZPddm16dRQewEnEvgiQxOH9umpsCQne
         wX9rUmMvX4RVdZ+PKMo0rhpo85q8/uqfWxSUWEDQxQQyd+N12zchuVcNogHux62+Qwh3
         tKXqBYx/jM9GzaViSkYBohSUgGAMLWf2um1cjJl262S2GHghQztNMoii3lZ3s/HesseP
         K3wup0BHENlGEmwXuM6JPsZfXPEntzKVV6kh2VVJp1A7EEgPW6Jv4K00p7IfgXfEEHm3
         pbNw==
X-Gm-Message-State: AOAM531mCHHMgtCbzfrRg7tuXRMVxMtDWJ65RtMtFd8ir16T6XuG3KMF
        xjgy7k1VnYDj/5UbHXYx2Yw=
X-Google-Smtp-Source: ABdhPJycQoMAMgwtFAuDUm9PnuToJ4JHoO7595vkZwzeXp+GxefghHeI2b/2Od+cztFaKe8TnAHULg==
X-Received: by 2002:a2e:b5d1:0:b0:24f:331d:f9b6 with SMTP id g17-20020a2eb5d1000000b0024f331df9b6mr2988533ljn.302.1652974039835;
        Thu, 19 May 2022 08:27:19 -0700 (PDT)
Received: from [192.168.0.110] ([217.115.104.30])
        by smtp.gmail.com with ESMTPSA id d3-20020a05651221c300b0047255d21155sm318812lft.132.2022.05.19.08.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 08:27:19 -0700 (PDT)
Message-ID: <3da73dd6-24c3-1870-f0bc-f8040826576b@gmail.com>
Date:   Thu, 19 May 2022 18:27:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   Dmytro Bagrii <dimich.dmb@gmail.com>
Subject: Re: [PATCH] usb: core: Call disconnect() only if it is provided by
 driver
To:     Greg KH <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220519132900.4392-1-dimich.dmb@gmail.com>
 <YoZKFrzirES9+f39@kroah.com>
Content-Language: en-US-large
In-Reply-To: <YoZKFrzirES9+f39@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.05.22 16:45, Greg KH wrote:
> On Thu, May 19, 2022 at 04:29:00PM +0300, Dmytro Bagrii wrote:
>> A driver may use devres allocations. Disconnect handler is not needed in
>> this case. Allow such driver to leave .disconnect field uninitialized in
>> struct usb_driver instead of providing empty stub function.
>>
>> Signed-off-by: Dmytro Bagrii <dimich.dmb@gmail.com>
>> ---
>>  drivers/usb/core/driver.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
>> index 355ed33a2179..d7fe440b033c 100644
>> --- a/drivers/usb/core/driver.c
>> +++ b/drivers/usb/core/driver.c
>> @@ -455,7 +455,8 @@ static int usb_unbind_interface(struct device *dev)
>>  	if (!driver->soft_unbind || udev->state == USB_STATE_NOTATTACHED)
>>  		usb_disable_interface(udev, intf, false);
>>  
>> -	driver->disconnect(intf);
>> +	if (driver->disconnect)
>> +		driver->disconnect(intf);
>>  
>>  	/* Free streams */
>>  	for (i = 0, j = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
>> -- 
>> 2.36.1
>>
> 
> What in-kernel driver has this issue and does not have a disconnect
> callback?

I don't see such in-kernel USB drivers yet. I develop an out-of-tree driver
and use devres for all initialization including controllers registration
etc. For actions which aren't available with devm_*, e.g. URB allocation i
use devm_add_action_or_reset() for deinit. I realized my _disconnect()
function is empty, nothing to do there. All deinitialization is done during
usb interface release. If i leave .disconnect field uninitialized in struct
usb_driver, obviously i get NULL pointer dereference bug. Thus i decided
that allowing a driver not to provide disconnect() is a good idea, as it is
done for remove() in SPI and I2C subsystems.

-- 
Best Regards,
Dmytro Bagrii.


