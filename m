Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27A358C5C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242361AbiHHJmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbiHHJmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:42:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C66192FA
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659951721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uj248HLnJNRaX5rTH7HQxIt9kmX8zKegEfM70AZmklY=;
        b=QKPitSd25Hvos10lGiscCp1tLSz3oA677RNE0rk65QJLi/0RhBV3ZXGtFCy0zSAl4aURTk
        WENsuieEi3guq7sprYP5flieVlbsQqmgrb0ehD85ZBkj5VzR4xCdGhtpgYhDIvEpcu11NM
        VBy6X9EZpsuYJQIlLntDnExoSZdfyc4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-wt7kTqbkOkK7lpwgqyMGaQ-1; Mon, 08 Aug 2022 05:41:59 -0400
X-MC-Unique: wt7kTqbkOkK7lpwgqyMGaQ-1
Received: by mail-ed1-f71.google.com with SMTP id t13-20020a056402524d00b0043db1fbefdeso5348033edd.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 02:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=uj248HLnJNRaX5rTH7HQxIt9kmX8zKegEfM70AZmklY=;
        b=WFnVxuHiRUSkvkSvez64BCH+Z7A+8BjUQRCCo9LuTxBg2h5E85LGoUZq2W7gyi+9k4
         YTL5JpKkI1wxbLOY3vsB/n+rO2kriQaBDXLeimQFoXURKcf+wLFsLDPx31YtnPWwWrEn
         QW39tbkUsjOYhHJ2Az0EY+mwegN5pNwIq9FZWMnDXXq5QHt8xzh9aIzAmk5kOZSmpHZe
         9xFQxKD8NMJsJpPmiVkQPKdJGjN8I/qPSnFyIeovFVzYz+yU1Ad0VSkiizmgvu9PYoGc
         vUroMl2qhWHI9ZLz7EyHmcTZrxLQHdxY1Q0VdI+dlK9XyueFrFQFGIsp32Qe2E1dWb46
         2/BQ==
X-Gm-Message-State: ACgBeo0gGM6FTn+Zjv8oE6eiNRCcBG6WspRVnyX8bf504oZL1SZas7Be
        R0/4YWLbHxiQPHnnfTC8HqUxLvmZymIMqggu9WZff9M5lq3ZczEIpDNuFiaGf4tgNumBgyfttLV
        PzU7PTZ7r4eXpgJQsoCzHQ0oO
X-Received: by 2002:a05:6402:3550:b0:43d:e475:7d2f with SMTP id f16-20020a056402355000b0043de4757d2fmr17144220edd.166.1659951717839;
        Mon, 08 Aug 2022 02:41:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR61kk7pzgC+AMgsXt4zJTmHHKURrwHOzA6+WuObY+VtXh+o7d8n0Eg8HLFXF8lOv1sIcDFG/g==
X-Received: by 2002:a05:6402:3550:b0:43d:e475:7d2f with SMTP id f16-20020a056402355000b0043de4757d2fmr17144203edd.166.1659951717678;
        Mon, 08 Aug 2022 02:41:57 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id o25-20020a509b19000000b0043d8d0ba6a3sm4338686edi.85.2022.08.08.02.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 02:41:56 -0700 (PDT)
Message-ID: <598d8186-b07e-5ece-210e-83689791b85a@redhat.com>
Date:   Mon, 8 Aug 2022 11:41:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] HID: HID-rmi - ignore to rmi_hid_read_block after system
 resumes.
Content-Language: en-US
To:     Marge Yang <Marge.Yang@tw.synaptics.com>,
        margeyang <marge.yang@synaptics.corp-partner.google.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
Cc:     "derek.cheng@tw.synaptcs.com" <derek.cheng@tw.synaptcs.com>,
        Vincent Huang <Vincent.huang@tw.synaptics.com>
References: <1659949639-3127-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
 <7507e07a-5094-f129-b75a-69cc32147543@redhat.com>
 <PH0PR03MB5848811A9EC856635CD1E519A3639@PH0PR03MB5848.namprd03.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <PH0PR03MB5848811A9EC856635CD1E519A3639@PH0PR03MB5848.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/8/22 11:36, Marge Yang wrote:
> Hi Hans,
> 	For Synaptics FW design, the interrupt GPIO will be pulled down after RMI driver reads this command(Report ID:0x0A).
> "Dark resume" test case on Chromebook device will detect another interrupt (not finger data) during the process of resume function.
> "Dark resume" test case will fail.
> Hence, this issue should happen on RMI mode of all Synaptics devices

Ok I see.

In that case this change is ok, but please store the ignoreonce flag inside the
rmi_transport_dev struct  (inside the xport) instead of making it a global variable.

Regards,

Hans



> 
> Thanks
> Marge Yang
> 
> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com> 
> Sent: Monday, August 8, 2022 5:16 PM
> To: margeyang <marge.yang@synaptics.corp-partner.google.com>; dmitry.torokhov@gmail.com; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; benjamin.tissoires@redhat.com
> Cc: Marge Yang <Marge.Yang@tw.synaptics.com>; derek.cheng@tw.synaptcs.com; Vincent Huang <Vincent.huang@tw.synaptics.com>
> Subject: Re: [PATCH] HID: HID-rmi - ignore to rmi_hid_read_block after system resumes.
> 
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> Hi,
> 
> On 8/8/22 11:07, margeyang wrote:
>> From: Marge Yang <marge.yang@synaptics.corp-partner.google.com>
>>
>> The interrupt GPIO will be pulled down once after RMI driver reads 
>> this command(Report ID:0x0A).
>> It will cause "Dark resume test fail" for chromebook device.
>> Hence, TP driver will ignore rmi_hid_read_block function once after 
>> system resumes.
> 
> This sounds like it is an issue in one specific touchpad model, yet you are changing the code to ignore the first readblock call on resume on *all* models ?
> 
> Regards,
> 
> Hans
> 
> 
>>
>> Signed-off-by: Marge 
>> Yang<marge.yang@synaptics.corp-partner.google.com>
>> ---
>>  drivers/hid/hid-rmi.c | 16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c index 
>> 311eee599ce9..236a38bfcf9a 100644
>> --- a/drivers/hid/hid-rmi.c
>> +++ b/drivers/hid/hid-rmi.c
>> @@ -101,7 +101,7 @@ struct rmi_data {
>>  };
>>
>>  #define RMI_PAGE(addr) (((addr) >> 8) & 0xff)
>> -
>> +int ignoreonce;
>>  static int rmi_write_report(struct hid_device *hdev, u8 *report, int 
>> len);
>>
>>  /**
>> @@ -203,7 +203,13 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
>>               if (ret < 0)
>>                       goto exit;
>>       }
>> -
>> +     if (ignoreonce == 1) {
>> +             dev_err(&hdev->dev,
>> +                     "ignoreonce (%d)\n",
>> +                     ignoreonce);
>> +             ignoreonce = 0;
>> +             goto exit;
>> +     }
>>       for (retries = 5; retries > 0; retries--) {
>>               data->writeReport[0] = RMI_READ_ADDR_REPORT_ID;
>>               data->writeReport[1] = 0; /* old 1 byte read count */ @@ 
>> -468,8 +474,12 @@ static int rmi_post_resume(struct hid_device *hdev)
>>       ret = hid_hw_open(hdev);
>>       if (ret)
>>               return ret;
>> -
>> +     // Avoid to read rmi_hid_read_block once after system resumes.
>> +     // The interrupt will be pulled down
>> +     // after RMI Read command(Report ID:0x0A).
>> +     ignoreonce = 1;
>>       ret = rmi_reset_attn_mode(hdev);
>> +     ignoreonce = 0;
>>       if (ret)
>>               goto out;
>>
> 

