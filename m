Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DC957B254
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbiGTIIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiGTIIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:08:48 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9495940BE8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:08:46 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id E4l9oj5oSjNN8E4l9odm4p; Wed, 20 Jul 2022 10:08:44 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 20 Jul 2022 10:08:44 +0200
X-ME-IP: 90.11.190.129
Message-ID: <cc9c9eda-3a7d-6eeb-1c44-c01c0057af8b@wanadoo.fr>
Date:   Wed, 20 Jul 2022 10:08:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: trancevibrator: simplify tv_probe
Content-Language: en-US
To:     dzm91@hust.edu.cn
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mudongliangabcd@gmail.com
References: <20220720072346.33511-1-dzm91@hust.edu.cn>
 <604f2d3f-659c-3312-d69f-c133aec275ca@wanadoo.fr>
 <CAD-N9QUKWsRHWme+fQ8KtBXKFB=cU8spa0eu3u4iVXuOE3x5cw@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAD-N9QUKWsRHWme+fQ8KtBXKFB=cU8spa0eu3u4iVXuOE3x5cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 20/07/2022 à 09:56, Dongliang Mu a écrit :
> On Wed, Jul 20, 2022 at 3:46 PM Christophe JAILLET
> <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org> wrote:
>>
>> Le 20/07/2022 à 09:23, Dongliang Mu a écrit :
>>> From: Dongliang Mu <mudongliangabcd-Re5JQEeQqe8AvxtiuMwx3w-XMD5yJDbdMToUJ55TTLPZA@public.gmane.org.org>
>>>
>>> The function tv_probe does not need to invoke kfree when the
>>> allocation fails. So let's simplify the code of tv_probe.
>>> Another change is to remove a redundant space.
>>>
>>> Signed-off-by: Dongliang Mu <mudongliangabcd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> ---
>>>    drivers/usb/misc/trancevibrator.c | 13 +++----------
>>>    1 file changed, 3 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/usb/misc/trancevibrator.c b/drivers/usb/misc/trancevibrator.c
>>> index 26baba3ab7d7..30d4d774d448 100644
>>> --- a/drivers/usb/misc/trancevibrator.c
>>> +++ b/drivers/usb/misc/trancevibrator.c
>>> @@ -84,29 +84,22 @@ static int tv_probe(struct usb_interface *interface,
>>>    {
>>>        struct usb_device *udev = interface_to_usbdev(interface);
>>>        struct trancevibrator *dev;
>>> -     int retval;
>>>
>>>        dev = kzalloc(sizeof(struct trancevibrator), GFP_KERNEL);
>>> -     if (!dev) {
>>> -             retval = -ENOMEM;
>>> -             goto error;
>>> -     }
>>> +     if (!dev)
>>> +             return -ENOMEM;
>>>
>>>        dev->udev = usb_get_dev(udev);
>>>        usb_set_intfdata(interface, dev);
>>>
>>>        return 0;
>>
>> Hi,
>>
>> looks like:
>>
>> error:
>>          kfree(dev);
>>          return retval;
>>
>> at the end of the function can be removed as-well.
>>
> 
> My patch actually removes them.

Sorry for the noise.

My mailer or newsgroup server sometimes plays me some tricks and only 
displays partial message :(.

CJ

> 
>> Just my 2c.
>>
>> CJ
> 

