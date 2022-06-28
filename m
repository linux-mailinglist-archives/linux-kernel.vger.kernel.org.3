Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C1955E8F8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347592AbiF1PLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344795AbiF1PLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:11:51 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1A22B1B8;
        Tue, 28 Jun 2022 08:11:50 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 9so12489999pgd.7;
        Tue, 28 Jun 2022 08:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KUFnNCP2qlNjHtD4AiTI9saDwprZ4IAPldwxrtQI5Ew=;
        b=It7JvXcb+DrS9llz4xotMV3doV+AzSNat0zMprM/cgaDS5YS39EMWcgek8CKNaUgbJ
         Vf2D48ZuGOVHEvx5KLPYfKcLOndMZ6UMyfMD2r2hBYYVJxZmL/YtgQRsezQm2832tpyp
         kzD3Eu+UvPhUQu6MCj0LskRO91azPB1X78UEBUnczmlf466ID3JFngK+S/ifEvnx14eh
         OERxk5Brus6sui4rjfUs1oRvGl7b68CcOHnsntDbbqwWCYNkV8rPTLUTvdOEiVDG8zAg
         QqithnhpNRJcLqZ3xq/h79cTrgB7lSJaovQlyot0RTwt1eixRN/ZDSZ2nk7UG77pB2DM
         u8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KUFnNCP2qlNjHtD4AiTI9saDwprZ4IAPldwxrtQI5Ew=;
        b=54OMFam0myD/ymO/vWBFzy1IaeQA6rR0AOFT+orse+cwcrjZ3sy/7lGnlnuZ8tf2Gh
         EdDwnStNjGDgrNY5xe3PDXYK4OZU4ka1EA+KKB/Il8moPacgjk4qCK2IOIw31/8ini2k
         mGXIbj0E4hg8cID82n81QhDCGPCmoHgWI+uPZDo/D4jqzOBwH9Zvm34rV19TYFIJsqyf
         oA9oGObgCp9eWtGL0Xqq0QBxKu+VFJO4BuA8q5SelrRibinI6uA7KSjen/tH4jkarS+N
         BhBGQTyFLUqG+FCKvoud36A/XAHzn0naNDlj3FWPQq8dSnmZg+QqimDfY/DYaG8rLEZL
         ByPA==
X-Gm-Message-State: AJIora8dhaeT6Pdx7OSEoqMnO3v0JCuKmZhRW8zGGs7uevD4S8t1Inrt
        NkltMA1zsh/sdZaDnAT6YT8=
X-Google-Smtp-Source: AGRyM1smO8kllyhLtsXgJ6ED7TiXmy5EdOy18QGZDkgS+8mUElWHTLXhuzZqN7NZD4cbRG8NjGkRlA==
X-Received: by 2002:aa7:9814:0:b0:527:da1e:a0d6 with SMTP id e20-20020aa79814000000b00527da1ea0d6mr976356pfl.71.1656429109954;
        Tue, 28 Jun 2022 08:11:49 -0700 (PDT)
Received: from [192.168.66.3] (p912131-ipoe.ipoe.ocn.ne.jp. [153.243.13.130])
        by smtp.gmail.com with ESMTPSA id cj15-20020a056a00298f00b0052559bd12aasm9540308pfb.61.2022.06.28.08.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 08:11:49 -0700 (PDT)
Message-ID: <8c95e3d7-cff6-c56e-e197-fdd0911d81aa@gmail.com>
Date:   Wed, 29 Jun 2022 00:11:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] HID: amd_sfh: Ignore uninitialized device
Content-Language: en-US
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220626081339.7243-1-akihiko.odaki@gmail.com>
 <b17f4e85-8a35-65ab-34de-0978bdc4cfea@amd.com>
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <b17f4e85-8a35-65ab-34de-0978bdc4cfea@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/06/28 23:42, Limonciello, Mario wrote:
> On 6/26/2022 03:13, Akihiko Odaki wrote:
>> Lenovo ThinkPad C13 Yoga has AMD Sensor Fusion Hub, but it is not used
>> because Chrome OS EC Sensor Hub is used instead. The system therefore
>> never loads the firmware for MP2 and MP2 does not work. It results in
>> AMD_P2C_MSG3 register to have -1 as its value.
>>
>> Without this change, the driver interprets the value as it supports all
>> sensor types and exposes them, which confuses a userspace program,
>> iio-sensor-proxy, and makes it to use the non-functioning sensors
>> instead of functioning sensors exposed via Chrome OS EC Sensor Hub.
>>
>> Check the version bits included in AMD_P2C_MSG3 register and ignore the
>> device if all of the bits are set.
>>
> 
> Have you already confirmed this failure happens in 5.19-rc1 or later as 
> well?  I would think that b5d7f43e97dabfa04a4be5ff027ce7da119332be 
> should have fixed it.

Yes. I confirmed it with 78ca55889a549a9a194c6ec666836329b774ab6d.

b5d7f43e97dabfa04a4be5ff027ce7da119332be deals with the case where it 
advertises v2 but it doesn't in my case.

Regards,
Akihiko Odaki

> 
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
>> ---
>>   drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c 
>> b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
>> index dadc491bbf6b..4137e5da77ad 100644
>> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
>> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
>> @@ -271,6 +271,8 @@ static void mp2_select_ops(struct amd_mp2_dev 
>> *privdata)
>>       case V2_STATUS:
>>           privdata->mp2_ops = &amd_sfh_ops_v2;
>>           break;
>> +    case 15:
>> +        break;
>>       default:
>>           privdata->mp2_ops = &amd_sfh_ops;
>>           break;
>> @@ -317,6 +319,8 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, 
>> const struct pci_device_id *i
>>           return -ENOMEM;
>>       mp2_select_ops(privdata);
>> +    if (!privdata->mp2_ops)
>> +        return -ENODEV;
>>       rc = amd_sfh_irq_init(privdata);
>>       if (rc) {
> 

