Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852B04AF8C6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbiBIRuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiBIRut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:50:49 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3F4C0613C9;
        Wed,  9 Feb 2022 09:50:52 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id r27so3269819oiw.4;
        Wed, 09 Feb 2022 09:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=gC34qLnBgCo9feYyVVLxVtmeO/7MUjN69gDKe+4Rb2M=;
        b=WCaMTO/bVpIwPYXwn07zmiZRhVh+LUzR3Lgf5RQHB/KQmovntZcaMMgSlXrfhU24fg
         EZll0YoCRoztDvcboG4AN9lY/ciwKtZ0QxPd02X9uNUqzzu/zrPd2lE3/zpqrW/AGqkO
         1mTdwHbZFhFMuak5shCCiDof/pvJ68rkaQDMtma0Oc7QZFemqBqlhWSRnjZJZZjxeVI8
         H71fh1wlGqdVQcFsDZYi77HS7BcRVmvy310Wza+K6xO5sIMmjh5Omp1hb3R9qm5iqGS3
         lXo/bvpyTiGvEN6nCECHb8f/MoicGdobyI2LHXDp5jN3fcwzxj9FZk3bEAcbJdi6vIgT
         oeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=gC34qLnBgCo9feYyVVLxVtmeO/7MUjN69gDKe+4Rb2M=;
        b=2FTTpdMUMUm18cByYq+7JbjkMlBsGt3Kxh35CUsQ5G8AZlSnqSTob53KU6FLTDeqsb
         ArC34EDqZh6V8WLmvFe/kWHDeB3v2ghTZerkodc1oXqIukimAaZTHOjb/TVR3ybvN+CD
         hK1CYKVvL/rsPtE0UG4H8ILFtkdTtYwhKky6scu1ARuvw1eddwn4Ot2Q2c1xRFxlFqpq
         z40PRFP9baWt8JXH6zsXjiEZgyIGL1doRmt4nc/yOWwH5+mjp8IG7ekKJewFrhsmXFxo
         KO8T1JbDuAOkhH1XVyjHODL9QqYUsd5JTZdsbh5XQ1PzVfygcB4WVKsLEDj7vz1gKdeU
         EPZw==
X-Gm-Message-State: AOAM5317kKU54a/dgBIm85TmmEdo/o3jVNMZPem09CoAzcM19Fb1RpNl
        qpuK7fVaA+l83fcS+APSLgM=
X-Google-Smtp-Source: ABdhPJxcWkHWNFQS6nhcBDl7n7JPql/gG7nO3d6ZkEP/oMjOboygk886qnKhgGisxAYVK2CuIUGkLQ==
X-Received: by 2002:a05:6808:1590:: with SMTP id t16mr1761606oiw.232.1644429051634;
        Wed, 09 Feb 2022 09:50:51 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r41sm6107035oap.2.2022.02.09.09.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 09:50:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e2aec7c6-2d73-6446-89c9-797850f9402f@roeck-us.net>
Date:   Wed, 9 Feb 2022 09:50:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Potin Lai <potin.lai@quantatw.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>
References: <20220208082026.4855-1-potin.lai@quantatw.com>
 <20220208112226.9108-1-potin.lai@quantatw.com>
 <20220208112226.9108-3-potin.lai@quantatw.com>
 <1acc1733-da53-6255-5cad-15f79850f44f@roeck-us.net>
 <fed6bad9-bf9b-90b5-57fd-083401f6c990@quantatw.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/2] usb: typec: fusb302: add support of
 supported_pd_rev
In-Reply-To: <fed6bad9-bf9b-90b5-57fd-083401f6c990@quantatw.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/22 19:34, Potin Lai wrote:
> 
> Guenter Roeck 於 2022/2/8 下午 11:22 寫道:
>> On 2/8/22 03:22, Potin Lai wrote:
>>> Add support for passing supported PD rev to TCPM.
>>> If "supported-pd-rev" property exist, then return supported_pd_rev as
>>> defined value in DTS, otherwise return PD_MAX_REV
>>>
>>> Example of DTS:
>>>
>>> fusb302: typec-portc@22 {
>>>      compatible = "fcs,fusb302";
>>>      reg = <0x22>;
>>>      ...
>>>      supported-pd-rev=<1>; // PD_REV20
>>>      ...
>>> };
>>>
>>
>> The new property needs to be documented. However, I am not entirely sure
>> I understand why it is needed. Wouldn't the supported PD revision
>> be a chip (fusb302) specific constant ? If so, why does it need a
>> devicetree property ? I think that needs some additional explanation.
>>
>> Thanks,
>> Guenter
>>
> 
> My initially intend was adding flexibility for developer to decided which PD revision
> they want to use for negotiation.
> 

I may be missing something, but I don't think that "flexibility for developer
to decide which PD revision they want to use for negotiation" is entirely appropriate.
This should be a chip property, not something a developer should decide. As written,
the code does accept PC version 3 for FUSB302 by default, which seems odd and unusual.
If the chip supports PD version 3, why artificially limit it to earlier PD revisions ?

I think this requires a detailed description of the use case. Is fusb302 indeed not able
to support a specific version of the power delivery specification ? If yes,
what is the limitation, and why would it need to be configurable with a devicetree
property ?

Thanks,
Guenter

> I saw your reply in another patch,  I agree with you, it will be simple and consistent if
> move "supported-pd-rev" to tcpm fwnode as other capabilities.
> 
> Just want to double confirm, is "usb-connector.yaml" right place to put documentation
> if adding "supported-pd-rev" in fwnode?
> 
> Thanks,
> Potin
> 
>>> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
>>> ---
>>>   drivers/usb/typec/tcpm/fusb302.c | 20 ++++++++++++++++++++
>>>   1 file changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
>>> index 72f9001b0792..8cff92d58b96 100644
>>> --- a/drivers/usb/typec/tcpm/fusb302.c
>>> +++ b/drivers/usb/typec/tcpm/fusb302.c
>>> @@ -109,6 +109,9 @@ struct fusb302_chip {
>>>       enum typec_cc_status cc2;
>>>       u32 snk_pdo[PDO_MAX_OBJECTS];
>>>   +    /* supported pd rev */
>>> +    u32 supported_pd_rev;
>>> +
>>>   #ifdef CONFIG_DEBUG_FS
>>>       struct dentry *dentry;
>>>       /* lock for log buffer access */
>>> @@ -1056,6 +1059,13 @@ static int tcpm_pd_transmit(struct tcpc_dev *dev, enum tcpm_transmit_type type,
>>>       return ret;
>>>   }
>>>   +static u32 tcpm_supported_pd_rev(struct tcpc_dev *dev)
>>> +{
>>> +    struct fusb302_chip *chip = container_of(dev, struct fusb302_chip,
>>> +                         tcpc_dev);
>>> +    return chip->supported_pd_rev;
>>> +}
>>> +
>>>   static enum typec_cc_status fusb302_bc_lvl_to_cc(u8 bc_lvl)
>>>   {
>>>       if (bc_lvl == FUSB_REG_STATUS0_BC_LVL_1230_MAX)
>>> @@ -1129,6 +1139,7 @@ static void init_tcpc_dev(struct tcpc_dev *fusb302_tcpc_dev)
>>>       fusb302_tcpc_dev->set_roles = tcpm_set_roles;
>>>       fusb302_tcpc_dev->start_toggling = tcpm_start_toggling;
>>>       fusb302_tcpc_dev->pd_transmit = tcpm_pd_transmit;
>>> +    fusb302_tcpc_dev->supported_pd_rev = tcpm_supported_pd_rev;
>>>   }
>>>     static const char * const cc_polarity_name[] = {
>>> @@ -1683,6 +1694,7 @@ static int fusb302_probe(struct i2c_client *client,
>>>       struct fusb302_chip *chip;
>>>       struct i2c_adapter *adapter = client->adapter;
>>>       struct device *dev = &client->dev;
>>> +    struct device_node *np = dev->of_node;
>>>       const char *name;
>>>       int ret = 0;
>>>   @@ -1756,6 +1768,14 @@ static int fusb302_probe(struct i2c_client *client,
>>>           dev_err(dev, "cannot request IRQ for GPIO Int_N, ret=%d", ret);
>>>           goto tcpm_unregister_port;
>>>       }
>>> +
>>> +    if (of_property_read_u32(np, "supported-pd-rev",
>>> +                &chip->supported_pd_rev) < 0) {
>>> +        chip->supported_pd_rev = PD_MAX_REV;
>>> +    } else if (chip->supported_pd_rev > PD_MAX_REV) {
>>> +        chip->supported_pd_rev = PD_MAX_REV;
>>> +    }
>>
>> The else part is also checked in the tcpm code and thus seems
>> to be redundant.
>>
>>> +
>>>       enable_irq_wake(chip->gpio_int_n_irq);
>>>       i2c_set_clientdata(client, chip);
>>

