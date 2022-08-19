Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9335159A382
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351112AbiHSRqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354895AbiHSRpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:45:44 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD03B105213
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:09:53 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id p128so5409005oif.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=1M77VSUpHBdJuUWHFqZxpANGXLDy3KTKNScQlSKbJdw=;
        b=aI7IOaWMzXerBLtn/yA++X6Xa61OTxWBkbbMvNVBzqCiLV2LwKGTB9/nO1m4WU97Vd
         7LfrRux4dkuqSm90eKKFUUnElWo7YRaIR4BG9CO0NXs/mJig8JFSHdz2vRD2KZ0PmiBz
         UFD0GzM3at1fWBunNVITUdVzxU1NPJ5FLAAMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=1M77VSUpHBdJuUWHFqZxpANGXLDy3KTKNScQlSKbJdw=;
        b=WVkisHZgxtzj5pRHwvEaaJst2qfS82FVnqzGLP7B6wFcsfUzqrwRG0BkHvNh5n5Jek
         GODio/ju8cyIIccipPLFR2qHbwh4oGiwyWmje5/U85yE5W2sp3xCec8RTZb/a74Y668+
         Sbqvxnm4oS+UZfhD8ugQt2awAkJg1mhp6KbR86kswbSK2AsDDO37h6WKGS8YFsnxXRgl
         mz4BPGdz6lsqC98+mHWiotVfx1Gw9anCql9bAsvjs4zlC4EWttNzHdGKlu9skljYzXtv
         LZ4xWMt939w51PMQuXOsUuZTgrY30EiRaUCKqse357q1p2FjLYoxbl8vF0gUNXYTOqgq
         i/SQ==
X-Gm-Message-State: ACgBeo3PnynBoqUEn6tC/t+TarEl8yLFsoy/9f2SGkjq3e1VvyZ9ETUz
        UIMZCLu+Dj8ln3VDMGM9mb7XttbEbKdk+w==
X-Google-Smtp-Source: AA6agR5iZZJbAl076hf1lC6WhLSavxW7q0wcpxah1mrhQ6OOlPXJUqTLvAVYq4ZpFRfr1PTvl1nhBQ==
X-Received: by 2002:a05:6808:488:b0:344:d066:5177 with SMTP id z8-20020a056808048800b00344d0665177mr3744941oid.210.1660928993062;
        Fri, 19 Aug 2022 10:09:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x19-20020a4a6213000000b004320b0cc5acsm1036958ooc.48.2022.08.19.10.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 10:09:52 -0700 (PDT)
Subject: Re: [PATCH] usbip: add USBIP_URB_* URB transfer flags
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        mailhol.vincent@wanadoo.fr, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hongren Zenithal Zheng <i@zenithal.me>,
        Alan Stern <stern@rowland.harvard.edu>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220816215711.55025-1-skhan@linuxfoundation.org>
 <Yv9J2d1bVe7Xntxu@kroah.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f2cf1fad-143f-f09b-0874-7e68c675697c@linuxfoundation.org>
Date:   Fri, 19 Aug 2022 11:09:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <Yv9J2d1bVe7Xntxu@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/22 2:29 AM, Greg KH wrote:
> 
> Overall, nice work, thanks for adding this, minor comments below:
> 
> On Tue, Aug 16, 2022 at 03:57:11PM -0600, Shuah Khan wrote:
>> USBIP driver packs URB transfer flags in PDUs that are exchanged
> 
> What is a "PDU"?

Protocol Data Unit - I will expand or reword to drop it.

[snip]

>>   +-----------+--------+---------------------------------------------------+
>>   | 0x14      | 4      | transfer_flags: possible values depend on the     |
>>   |           |        | URB transfer_flags (refer to URB doc in           |
> 
> You can drop the second "URB" here, as it's an USBIP document being
> referred to, right?

This refers to USB URB document. I can rephrase it to USBIP_URB transfer flags
as it is the API now.

>>   
>> +		/* Unpack the pdu to an urb (map USBIP_URB_* to URB_* flags) */
> 
> No need to mention the mapping everywhere in these comments as the
> function handles that.
> 

These comments were primarily added for making sure right mapping is done.
Will remove them.


>> +	}
>> +	pr_debug("%s: flag = %u map_flags = %u\n", __func__,
>> +		 flags, map_flags);
> 
> When using pr_debug (or dev_dbg()), you already have access to the
> __func__ in the output automatically, so there's never a need to add it
> again, it would just show up twice.
> 

Good point.

> Also, this should be dev_dbg(), as it's a driver, and you have access to
> the device being handled (well, it needs to be passed to the
> function...)
> 

I am going to delete these - debug message isn't really needed.

>> +
>> +	return map_flags;
>> +}
>> +
>> +static unsigned int usbip_to_urb(unsigned int flags)
>> +{
>> +	unsigned int map_flags = 0;
>> +	int loop;
>> +
>> +	for (loop = 0; loop < NUM_USBIP_FLAGS; loop++) {
>> +		if (flags & flag_map[loop].usbip_flag)
>> +			map_flags |= flag_map[loop].urb_flag;
>> +	}
>> +	pr_debug("%s: flag = %u map_flags = %u\n", __func__,
>> +		 flags, map_flags);
> 
> Same debug comment as above.

Same as above. I will just delete the message.

> 

>> + * As a result of coying the transfer flags, they now have become part
> 
> "coying"?  :)

Thanks for catching this :)

> 
>> + * of the API. Any changes to kernel flags now impact the USBIP user-space.
>> + * In addition, it will be compatibility problem between server and client.
>> + * These defines aren't directly referenced and it is an obscure usage
>> + * hidden away in the packets.
> 
> No need to mention the history here, just say "here are the flags for
> the transfer types"
> 

Will do.

> 
>> + *
>> + * Add code to translate the values between the numbers used in userspace
>> + * and the numbers used in the kernel. This will help with any future
>> + * changes to kernel flags breaking the API.
> 
> There's no code being added in this uapi file, so you might want to
> reword all of this.  Possibly by removing most of it, as the history
> here might not be necessary to document.
> 

Will do.

thanks for the review. Will send v2.

thanks,
-- Shuah

