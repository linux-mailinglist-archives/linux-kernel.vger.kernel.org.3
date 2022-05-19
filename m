Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D745F52DAFB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242161AbiESROB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiESRN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:13:58 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C833EF38;
        Thu, 19 May 2022 10:13:57 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t25so10253816lfg.7;
        Thu, 19 May 2022 10:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1GeQ5CSfJvGigHltvLwr+/AMpvXxe8TkHFBpsFCMoGA=;
        b=TdBvBWDVEWL3pcu5nLPBl1EPC9H3IL+noe3T6LeZbzPC+5+ZtDKWACysqyNI780fWM
         EhinHkcK54Yf/Wem4gND/KaOZYrl4IN6Plq4hdKSnifZQMadrC76DEGDmLAIzJBI8G9y
         9IEO//urXsmPhCujWmwznefmJHEbO4qxrubFZxqumGRAV/rV2+D0saKwPYQOR4rXV3ci
         FGWCZhM0Op2SnucUsqIndcf1tkMuKplscukgF9ehlYhoowmhV4IRBo70D+sFTMY/EmHC
         aQ9XGMtq5dOT2NzxGhrl8zJDcCXvk3BPAudrj1qJOHUDStKl1MbKNwgGNdjMX/5X1ko3
         i94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1GeQ5CSfJvGigHltvLwr+/AMpvXxe8TkHFBpsFCMoGA=;
        b=S4QfKnqwfFQT002NKhcNaHzotiP1Tw42CIEDnO/wboG4u4fQNm/Vte8IPK3OCAAlwm
         ZNom+0gkqIIU+YCbwbEVd5Z2C7if21bNxgKLie+XSZObaGC9VDs5VtMZK9eY/C4/tRfT
         UGxiKmhR6MTZvWKwcwbmUHaeSY6A5ISeVXvD+ZvGY3WKxUpOSQHpnZrKyH4/Acceuvw/
         YEDzBcPB+LxqVQPacnmOs//FzLpbpLZivM4CiOOowbVTiqT0yQHdYhaJWTTW1rg6i15S
         WsUGnnxiGZAfYbKeSQOFAe+RKMXQIQeFPeRI4hi8PWoZ7bqB28HImydIU82M7H1sIEiJ
         GS6g==
X-Gm-Message-State: AOAM532o7vgbdfH1GgIdNWS5M2Qcjo7nlsXsgt429JpgYUVMetqqhtIx
        8F2z7Hy6J7E3v887anGm60rx/j1rFgqoFohl
X-Google-Smtp-Source: ABdhPJyeM7zKyblXi+FfpBs3SWxkUhNENi6qL8LyFA+FOTtWR1NBOXVw8jN+jy2LSZKo4k65BBCP+A==
X-Received: by 2002:a05:6512:16a7:b0:445:862e:a1ba with SMTP id bu39-20020a05651216a700b00445862ea1bamr3942866lfb.85.1652980435336;
        Thu, 19 May 2022 10:13:55 -0700 (PDT)
Received: from [192.168.0.110] ([217.115.104.30])
        by smtp.gmail.com with ESMTPSA id c25-20020ac25319000000b0047255d210e6sm347685lfh.21.2022.05.19.10.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 10:13:54 -0700 (PDT)
Message-ID: <36a83342-6c30-73a1-7759-971d2134420a@gmail.com>
Date:   Thu, 19 May 2022 20:13:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] usb: core: Call disconnect() only if it is provided by
 driver
Content-Language: en-US-large
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220519132900.4392-1-dimich.dmb@gmail.com>
 <YoZKFrzirES9+f39@kroah.com> <3da73dd6-24c3-1870-f0bc-f8040826576b@gmail.com>
 <YoZybf0hq5LmwzKY@kroah.com>
From:   Dmytro Bagrii <dimich.dmb@gmail.com>
In-Reply-To: <YoZybf0hq5LmwzKY@kroah.com>
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

On 19.05.22 19:38, Greg KH wrote:
> On Thu, May 19, 2022 at 06:27:17PM +0300, Dmytro Bagrii wrote:
>> On 19.05.22 16:45, Greg KH wrote:
>>> On Thu, May 19, 2022 at 04:29:00PM +0300, Dmytro Bagrii wrote:
>>>> A driver may use devres allocations. Disconnect handler is not needed in
>>>> this case. Allow such driver to leave .disconnect field uninitialized in
>>>> struct usb_driver instead of providing empty stub function.
>>>>
>>>> Signed-off-by: Dmytro Bagrii <dimich.dmb@gmail.com>
>>>> ---
>>>>  drivers/usb/core/driver.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
>>>> index 355ed33a2179..d7fe440b033c 100644
>>>> --- a/drivers/usb/core/driver.c
>>>> +++ b/drivers/usb/core/driver.c
>>>> @@ -455,7 +455,8 @@ static int usb_unbind_interface(struct device *dev)
>>>>  	if (!driver->soft_unbind || udev->state == USB_STATE_NOTATTACHED)
>>>>  		usb_disable_interface(udev, intf, false);
>>>>  
>>>> -	driver->disconnect(intf);
>>>> +	if (driver->disconnect)
>>>> +		driver->disconnect(intf);
>>>>  
>>>>  	/* Free streams */
>>>>  	for (i = 0, j = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
>>>> -- 
>>>> 2.36.1
>>>>
>>>
>>> What in-kernel driver has this issue and does not have a disconnect
>>> callback?
>>
>> I don't see such in-kernel USB drivers yet.
> 
> Great, then all is well.  We can not make kernel changes for out-of-tree
> drivers for obvious reasons.
> 
> When you submit your driver, we will be glad to consider this change.
> But as others changed, odds are your driver is incorrect and should have
> a disconnect call.  Unless it is a very simple driver that could be done
> instead in userspace with usbfs/libusb?

Ok, i agree, my propoposed change is premature.
Of course, i'm checking the driver for memory, refcounts and other
resources leakage during development and not going to publish it until make
sure it works correctly.
There are some limitations with libusb in my case, e.g. it is unable to
bind existing in-tree drivers to a bus provided by hardware over USB.
Thank you for explanation.

-- 
Best Regards,
Dmytro Bagrii.
