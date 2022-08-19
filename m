Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E78959980F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347400AbiHSI6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240235AbiHSI57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:57:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE85EF9D3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660899477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2w8jYOkfWJo7z3O8bLfVSfTQ42HXpptZtq532HevaI=;
        b=IR5EpwQZtlSVROk2x4kH3V59l55hWO7ya6DT9Tc67OqOU+gvme5/XfZLrSiia352c7Y/zE
        GhdH+njnMt0SybQ5B3TAcXW4XNwiw1uTFjmV0iewXa02dGKpGWs6si/LSEj2G6GENdLJRD
        K0fSaRjxGDEqTXwF7n2wKCuY82FfhTY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-563-G9m7NbT0Ndeh96k3_aZDFw-1; Fri, 19 Aug 2022 04:57:56 -0400
X-MC-Unique: G9m7NbT0Ndeh96k3_aZDFw-1
Received: by mail-ej1-f70.google.com with SMTP id ho13-20020a1709070e8d00b00730a655e173so1280359ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=q2w8jYOkfWJo7z3O8bLfVSfTQ42HXpptZtq532HevaI=;
        b=Fwj8Kh6BKeI9oJ684GlCIqm4a7zeNkLjNGgHFMw4dDdjlftbrX0mRk20XsTMUtTdgx
         +R/LAoPVu5MBajf5f0CdlsoPnnJz7sJgRZ3RNKGmCr9lhZ6VYTzR+GLLUbvtO+FqkGzY
         IKBmtWrMD813uDHv4fxTpXYwsO5s51abvAn4mO14ilnGGyFjZEBnqTAd/SsHtUMA2+4V
         D4esaL8R/PwzXY79QRQOWXPKHa+y3DVAQ2yYQkVNcjzB4YzO5uhZk5icvaeeY7GpQns5
         vKQU4Z0gLhEYZt6es9rGozD2pjzk1Th8yroCee49BOLBf+HNStR6aj8qaaYYMfRRpl5D
         qTXg==
X-Gm-Message-State: ACgBeo39MQ0W6spHiobRYocJXFsv8seoLodo9f4M8BcPn44CoCcgYvKX
        My0+H6jQjrq61jFG3RWBzoKEokCXzPZFKYATbw8hZ04esH2yWWLE/4Ggu3qBq16u7NVNx34oJp/
        NBSnh932Wz1tB+jT62U8Jrsfb
X-Received: by 2002:aa7:d7d0:0:b0:445:bd03:bc90 with SMTP id e16-20020aa7d7d0000000b00445bd03bc90mr5237459eds.238.1660899475486;
        Fri, 19 Aug 2022 01:57:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6vj0qaw7x1Kk4XYb15VpFwG+0VHIE072SvwkHNuWUQsWDP3kUiw4vK+sCTi0mwzerTMKBrNQ==
X-Received: by 2002:aa7:d7d0:0:b0:445:bd03:bc90 with SMTP id e16-20020aa7d7d0000000b00445bd03bc90mr5237448eds.238.1660899475237;
        Fri, 19 Aug 2022 01:57:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id q25-20020a170906145900b007307d099ed7sm1980683ejc.121.2022.08.19.01.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 01:57:54 -0700 (PDT)
Message-ID: <44119dc8-5e17-b27d-75f2-80f590728604@redhat.com>
Date:   Fri, 19 Aug 2022 10:57:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] platform: move from strlcpy with unused retval to strscpy
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Divya Bharathi <divya.bharathi@dell.com>,
        Prasanth Ksr <prasanth.ksr@dell.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dell.Client.Kernel@dell.com,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>
References: <20220818210058.7229-1-wsa+renesas@sang-engineering.com>
 <CAHp75VeM2q7wdnREoenyYpJ-tso2G6M-uyGFJGjPGL8hfUmzhQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VeM2q7wdnREoenyYpJ-tso2G6M-uyGFJGjPGL8hfUmzhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/19/22 08:22, Andy Shevchenko wrote:
> On Fri, Aug 19, 2022 at 12:06 AM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
>>
>> Follow the advice of the below link and prefer 'strscpy' in this
> 
> We refer to the functions like this: strscpy() (note no quote marks).
> 
>> subsystem. Conversion is 1:1 because the return value is not used.
>> Generated by a coccinelle script.
> 
> I assume you are experimenting with coccinelle, so I have no objection
> to the change, but in PDx86 we usually want to have one patch per
> driver. Can you split?

Actually, although we do in general split patches per driver
as Andy says, this one is so small / simple that I'm happy to
merge it as is. I'll pick this up during my next round of
merges coming Monday.

> You also may add
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks for the review.

Regards,

Hans




> to each of them.
> 
>> Link: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> ---
>>  drivers/platform/surface/surface3_power.c          | 2 +-
>>  drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 2 +-
>>  drivers/platform/x86/intel/chtwc_int33fe.c         | 6 +++---
>>  drivers/platform/x86/thinkpad_acpi.c               | 4 ++--
>>  4 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/platform/surface/surface3_power.c b/drivers/platform/surface/surface3_power.c
>> index 444ec81ba02d..4c53d116d59b 100644
>> --- a/drivers/platform/surface/surface3_power.c
>> +++ b/drivers/platform/surface/surface3_power.c
>> @@ -519,7 +519,7 @@ static int mshw0011_probe(struct i2c_client *client)
>>         i2c_set_clientdata(client, data);
>>
>>         memset(&board_info, 0, sizeof(board_info));
>> -       strlcpy(board_info.type, "MSHW0011-bat0", I2C_NAME_SIZE);
>> +       strscpy(board_info.type, "MSHW0011-bat0", I2C_NAME_SIZE);
>>
>>         bat0 = i2c_acpi_new_device(dev, 1, &board_info);
>>         if (IS_ERR(bat0))
>> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
>> index 636bdfa83284..0a6411a8a104 100644
>> --- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
>> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
>> @@ -270,7 +270,7 @@ void strlcpy_attr(char *dest, char *src)
>>         size_t len = strlen(src) + 1;
>>
>>         if (len > 1 && len <= MAX_BUFF)
>> -               strlcpy(dest, src, len);
>> +               strscpy(dest, src, len);
>>
>>         /*len can be zero because any property not-applicable to attribute can
>>          * be empty so check only for too long buffers and log error
>> diff --git a/drivers/platform/x86/intel/chtwc_int33fe.c b/drivers/platform/x86/intel/chtwc_int33fe.c
>> index c52ac23e2331..1ea989df513c 100644
>> --- a/drivers/platform/x86/intel/chtwc_int33fe.c
>> +++ b/drivers/platform/x86/intel/chtwc_int33fe.c
>> @@ -270,7 +270,7 @@ cht_int33fe_register_max17047(struct device *dev, struct cht_int33fe_data *data)
>>         }
>>
>>         memset(&board_info, 0, sizeof(board_info));
>> -       strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
>> +       strscpy(board_info.type, "max17047", I2C_NAME_SIZE);
>>         board_info.dev_name = "max17047";
>>         board_info.fwnode = fwnode;
>>         data->battery_fg = i2c_acpi_new_device(dev, 1, &board_info);
>> @@ -361,7 +361,7 @@ static int cht_int33fe_typec_probe(struct platform_device *pdev)
>>         }
>>
>>         memset(&board_info, 0, sizeof(board_info));
>> -       strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
>> +       strscpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
>>         board_info.dev_name = "fusb302";
>>         board_info.fwnode = fwnode;
>>         board_info.irq = fusb302_irq;
>> @@ -381,7 +381,7 @@ static int cht_int33fe_typec_probe(struct platform_device *pdev)
>>         memset(&board_info, 0, sizeof(board_info));
>>         board_info.dev_name = "pi3usb30532";
>>         board_info.fwnode = fwnode;
>> -       strlcpy(board_info.type, "pi3usb30532", I2C_NAME_SIZE);
>> +       strscpy(board_info.type, "pi3usb30532", I2C_NAME_SIZE);
>>
>>         data->pi3usb30532 = i2c_acpi_new_device(dev, 3, &board_info);
>>         if (IS_ERR(data->pi3usb30532)) {
>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
>> index 22d4e8633e30..8dad0428a83c 100644
>> --- a/drivers/platform/x86/thinkpad_acpi.c
>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>> @@ -7623,9 +7623,9 @@ static int __init volume_create_alsa_mixer(void)
>>         data = card->private_data;
>>         data->card = card;
>>
>> -       strlcpy(card->driver, TPACPI_ALSA_DRVNAME,
>> +       strscpy(card->driver, TPACPI_ALSA_DRVNAME,
>>                 sizeof(card->driver));
>> -       strlcpy(card->shortname, TPACPI_ALSA_SHRTNAME,
>> +       strscpy(card->shortname, TPACPI_ALSA_SHRTNAME,
>>                 sizeof(card->shortname));
>>         snprintf(card->mixername, sizeof(card->mixername), "ThinkPad EC %s",
>>                  (thinkpad_id.ec_version_str) ?
>> --
>> 2.35.1
>>
> 
> 

