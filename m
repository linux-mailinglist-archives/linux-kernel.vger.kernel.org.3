Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360C64F71AB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 03:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbiDGBpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 21:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbiDGBoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 21:44:37 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2320D1226E1;
        Wed,  6 Apr 2022 18:41:53 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id q19so3698023pgm.6;
        Wed, 06 Apr 2022 18:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OOMAfdi8D5EciZ02glPhlmpRgH66ew4WPzL5EDA2QJY=;
        b=Z791tYA6TNVIW3YGkEphF+I4hP02mwTPc+2B0nG1717AE3f3/lVLDkbFrzCefMaQ1a
         PTLvLfGLTt2LBu5AU6wUOq8QRl2Eu/diz4r2wtYxAbWKB0YaNB3ZopHroD6on/u7Q/Lw
         Gn24QLtQs9T6p6dNf6okTWosueuf8D+VAA++nBWcQUe9NKfD8hiILvBPVwWl3fI7r7HD
         J3ysgfoKbjSrd/B21ryRnsibDrpIH8pEBy+HsowTgv2QOF0yJBCCKbOpK/gbcS5nMFGs
         38kW2NOM1b2/W1uvRfEssd454x8l+ueJfxB+PEnsQdMDgGv08wsDO0jmunEjSWLXCw3C
         jdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OOMAfdi8D5EciZ02glPhlmpRgH66ew4WPzL5EDA2QJY=;
        b=WFq1NhT/BJYhGUhpqVUWGNQJA6eh0exSDRd1lALpQaiswNODcl1aPGxzbVNNt+ep31
         if49Y03bapm//HD1i2bxKeybnoCGWrWotBkyeQ2rdbGMFxfrSRGHf/X/1v0EjXkELQlx
         oxI686xwahtRYgZY6oZChDjQYeBfDKnrkNl8Fm6JgOKuEgXwyNqXa9qsti55arkIlmuE
         VB8ZqZ4Qj5uaItd6KT8jn7X1bwaab0makSIjdB1DJC3YBRn7jL8yA89Mi/0/yuieLowH
         IG4VDsx864lwGt5kNVT9J/abFr3KhPAjNoAJkkrx9FNJjT1/dpPAubAFUtYSTzwwBVZK
         SGkA==
X-Gm-Message-State: AOAM531G4IcpCmx5aei1RnIlWiB5MdDLAq3DTy+zPWKUPeNrCE6iI54t
        xwbjKtGSke1o6h59yogY8bY=
X-Google-Smtp-Source: ABdhPJzsOCvxtL4tJ1+aiT8bXf9mdB/oFcWv5YQ7cYdVBiyLPDWJbCu5KcSrziyfwmCxC6QNJnKNQA==
X-Received: by 2002:a63:3185:0:b0:39c:c854:34ae with SMTP id x127-20020a633185000000b0039cc85434aemr469773pgx.13.1649295712626;
        Wed, 06 Apr 2022 18:41:52 -0700 (PDT)
Received: from [10.11.37.162] ([103.84.139.54])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090a630a00b001c685cfd9d1sm6720441pjj.20.2022.04.06.18.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 18:41:52 -0700 (PDT)
Message-ID: <732eed82-18eb-c57b-fca1-e1f33f1f0499@gmail.com>
Date:   Thu, 7 Apr 2022 09:41:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] usb: usbip: fix a refcount leak in stub_probe()
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, khoroshilov@ispras.ru
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220406061713.18938-1-hbh25y@gmail.com>
 <4341150b-195c-a896-1f6a-8715bbb539e2@linuxfoundation.org>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <4341150b-195c-a896-1f6a-8715bbb539e2@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. I will send a v2.

On 2022/4/7 02:13, Shuah Khan wrote:
> On 4/6/22 12:17 AM, Hangyu Hua wrote:
>> usb_get_dev is called in stub_device_alloc. When stub_probe fails after
>> that, usb_put_dev needs to be used.
>>
> 
> Thank you for the patch. Please include details on how you found
> this problem.
> 
> Nit: Change this to:
> 
> usb_get_dev() is called in stub_device_alloc(). When stub_probe() fails
> after that, usb_put_dev() needs to be called to release the reference.
> 
>> Fix this by moving usb_put_dev() to sdev_free
>>
> 
> Nit: Change this to:
> 
> Fix this by moving usb_put_dev() to sdev_free error path handling.
> 
>> Fixes: 3ff67445750a ("usbip: fix error handling in stub_probe()")
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>> ---
>>   drivers/usb/usbip/stub_dev.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
>> index d8d3892e5a69..3c6d452e3bf4 100644
>> --- a/drivers/usb/usbip/stub_dev.c
>> +++ b/drivers/usb/usbip/stub_dev.c
>> @@ -393,7 +393,6 @@ static int stub_probe(struct usb_device *udev)
>>   err_port:
>>       dev_set_drvdata(&udev->dev, NULL);
>> -    usb_put_dev(udev);
>>       /* we already have busid_priv, just lock busid_lock */
>>       spin_lock(&busid_priv->busid_lock);
>> @@ -408,6 +407,7 @@ static int stub_probe(struct usb_device *udev)
>>       put_busid_priv(busid_priv);
>>   sdev_free:
>> +    usb_put_dev(udev);
>>       stub_device_free(sdev);
>>       return rc;
>>
> 
> With the above addressed:
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> thanks,
> -- Shuah
