Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEDA4F71C8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 03:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbiDGB5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 21:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237626AbiDGB5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 21:57:32 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF3D56214;
        Wed,  6 Apr 2022 18:55:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s11so3585729pla.8;
        Wed, 06 Apr 2022 18:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DrQ8myrgq6MEVkmz5TpFrXmjtowwa39P+bCoekdBxVE=;
        b=Vvs78fDjKnaTzkc8DhazEaySnLMRglZMdQ3ymE8ruclCpJVzrkAVc91eZjE+A98x3Y
         HFWHe7Cwvh51UiWhqa3NNA9Rg7AMMwN96GuthD1Hyl/1Ufoz9btW4l6MqV6AT2r5n/h4
         23JDCL39aoVF/mvJYWRvEAvFQtCA9mLL+qMLuDthH6G6ectZx+NnCjl7xIHRxJn63Lfi
         0HmGzKeT5KPVrXozKmFqg8tzRkbU75PORW6FElYzGeyBng7k8Ut846CBC6XWsSGXXlqe
         wqMZXP4j8kxtJ90VPCzJ2hBW1jmzfAX+DR7gdpX4CrdXCkM3WbZtvE+D/l1tiPEOerLY
         kNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DrQ8myrgq6MEVkmz5TpFrXmjtowwa39P+bCoekdBxVE=;
        b=nP2PIobYzoioV5JkpxpoDufXHc5WPVmBFyhtkvVPJ/QrQr2+EM7yh4SbVkrSH3LBay
         +6WeVi//bkaeNCaBCVrpNqRsywTDdwDMjiQAg0esORPXyCZtAQeqhbxjBWUu4Mq2eh3r
         aePCcBgjs6iDXTzF9L4yKo4G7F2K+ctbbvAX7oOvaCGff0b2ue4WJTfzA8gon5VSD4n5
         kI0mLDJK+0pPpRmnGD60yip2yN3K84jHuCRqq9gUTmgkqwElgl79BikZ63Gedr058/kC
         F9VfDeOinqfES7Pfof5BZya//xRgSgBg1tut4S/vvHKYI6TPf3ScYMuZHAt3G6m9N9JB
         0q1Q==
X-Gm-Message-State: AOAM530GtXkwfy8s8qyH8KgEJ4bBvQEU7+FpZRFTT7caa41AFTYkcF5v
        3GmEd83q/bRbyzctpusTRUnQZGWc7fmtZiqD
X-Google-Smtp-Source: ABdhPJxKB65n6mZAXewuN0v0uyKShCuBNBqEvPZKwquEMGoLROfaAZaGaEC19y2Wl5u0T9MEh53usg==
X-Received: by 2002:a17:903:124a:b0:154:c860:6d52 with SMTP id u10-20020a170903124a00b00154c8606d52mr11597409plh.159.1649296529212;
        Wed, 06 Apr 2022 18:55:29 -0700 (PDT)
Received: from [10.11.37.162] ([103.84.139.54])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090a6c9000b001c993d935e7sm7012202pjj.56.2022.04.06.18.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 18:55:28 -0700 (PDT)
Message-ID: <4d0652cd-e3ca-4319-b012-142a110efe15@gmail.com>
Date:   Thu, 7 Apr 2022 09:55:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] usb: misc: fix improper handling of refcount in
 uss720_probe()
Content-Language: en-US
To:     Oliver Neukum <oneukum@suse.com>, gregkh@linuxfoundation.org,
        mudongliangabcd@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220406073349.22203-1-hbh25y@gmail.com>
 <f90522c4-f7d6-3068-9789-8c6d893f2768@suse.com>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <f90522c4-f7d6-3068-9789-8c6d893f2768@suse.com>
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

Oh, i sorry. Thank you for your reminder. I will remake a patch carefully.

On 2022/4/6 19:47, Oliver Neukum wrote:
> 
> 
> On 06.04.22 09:33, Hangyu Hua wrote:
>> usb_put_dev shouldn't be called when uss720_probe succeeds because of
>> priv->usbdev. At the same time, priv->usbdev shouldn't be set to NULL
>> before destroy_priv in uss720_disconnect because usb_put_dev is in
>> destroy_priv.
> 
> Hi,
> 
> I am sorry, but that's a clear NACK.
>> @@ -754,13 +753,13 @@ static void uss720_disconnect(struct usb_interface *intf)
>>   	usb_set_intfdata(intf, NULL);
>>   	if (pp) {
>>   		priv = pp->private_data;
>> -		priv->usbdev = NULL;
>>   		priv->pp = NULL;
>>   		dev_dbg(&intf->dev, "parport_remove_port\n");
>>   		parport_remove_port(pp);
>>   		parport_put_port(pp);
>>   		kill_all_async_requests_priv(priv);
>>   		kref_put(&priv->ref_count, destroy_priv);
>> +		priv->usbdev = NULL;
> 
> That is a clear use after free The patch is no good in this state..
> 
>      HTH
>          Oliver
> 
