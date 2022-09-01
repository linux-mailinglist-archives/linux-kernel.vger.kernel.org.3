Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA7A5A99F4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbiIAOTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbiIAOTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:19:20 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2B03A4A8;
        Thu,  1 Sep 2022 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662041955; x=1693577955;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=N31b7BupwGEoU9ErDwflGUAKB637elD1wNkAbd+oWQw=;
  b=Ws9OTQvKf6VRjprTZWvoUSHxgil6O8yp0PuBKch/4Y41pM82uHUuvkn/
   gQcKjaJJ3ULZg3BFhJC5ft/o6+9+uHUxy7EcilsiHU++ZRL7Jk+PsMS4Y
   6qtwHzliaMI8QPw1vmNRFMb0XXlzfDxOAGnWCdlLz5XIDqLNrrUuXnasm
   c=;
X-IronPort-AV: E=Sophos;i="5.93,281,1654560000"; 
   d="scan'208";a="1050337274"
Subject: Re: [PATCH v3 11/19] hwmon: (mr75203) add VM pre-scaler support
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-a31e1d63.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 14:17:59 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-a31e1d63.us-east-1.amazon.com (Postfix) with ESMTPS id 80800829E3;
        Thu,  1 Sep 2022 14:17:56 +0000 (UTC)
Received: from EX19D013UWA003.ant.amazon.com (10.13.138.202) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 1 Sep 2022 14:17:47 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWA003.ant.amazon.com (10.13.138.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Thu, 1 Sep 2022 14:17:47 +0000
Received: from [192.168.93.228] (10.85.143.172) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Thu, 1 Sep 2022 14:17:41 +0000
Message-ID: <917126b6-3acc-48df-77d2-0a725e7475d6@amazon.com>
Date:   Thu, 1 Sep 2022 17:17:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <talel@amazon.com>,
        <hhhawa@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <ronenk@amazon.com>, <itamark@amazon.com>, <shellykz@amazon.com>,
        <shorer@amazon.com>, <amitlavi@amazon.com>, <almogbs@amazon.com>,
        <dkl@amazon.com>, "Farber, Eliav" <farbere@amazon.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-12-farbere@amazon.com>
 <Yw9N6sr+k/4lcmT7@smile.fi.intel.com>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <Yw9N6sr+k/4lcmT7@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/2022 3:02 PM, Andy Shevchenko wrote:
> On Tue, Aug 30, 2022 at 07:22:04PM +0000, Eliav Farber wrote:
>> +static int pvt_get_pre_scaler(struct device *dev, struct pvt_device 
>> *pvt)
>> +{
>> +     const struct device_node *np = dev->of_node;
>> +     u32 total_channels = pvt->vm_channels.total;
>> +     u32 channel;
>> +     u8 *pre_scaler_ch_list;
>> +     int i, ret, num_ch;
>> +
>> +     /* Set default pre-scaler value to be 1. */
>> +     for (i = 0; i < total_channels; i++)
>> +             pvt->vd[i].pre_scaler = PRE_SCALER_X1;
>> +
>> +     /* Get number of channels configured in 
>> "moortec,vm-pre-scaler". */
>> +     num_ch = of_property_count_u8_elems(np, "moortec,vm-pre-scaler");
>
> of_ ?!
>
Replaced of_property_count_u8_elems() with
device_property_count_u8().

>> +     if (num_ch <= 0)
>> +             return 0;
>> +
>> +     pre_scaler_ch_list = kcalloc(total_channels,
>> +                                  sizeof(*pre_scaler_ch_list), 
>> GFP_KERNEL);
>> +     if (!pre_scaler_ch_list)
>> +             return -ENOMEM;
>> +
>> +     /* Get list of all channels that have pre-scaler of 2. */
>> +     ret = device_property_read_u8_array(dev, "moortec,vm-pre-scaler",
>> +                                         pre_scaler_ch_list, num_ch);
>> +     if (ret)
>> +             goto out;
>> +
>> +     for (i = 0; i < num_ch; i++) {
>> +             channel = pre_scaler_ch_list[i];
>
>> +
>
> Unnecessary blank line.

Blank line removed.


>> +             if (channel >= total_channels) {
>> +                     dev_err(dev,
>> +                             "invalid channel (%u) in pre-scaler 
>> list\n",
>> +                             channel);
>> +                     ret = -EINVAL;
>
>> +                     goto out;
>
> Wouldn't
>
>                        break;
>
> suffice? (I understand the point, up to you)
I prefer to exit the moment I detect a problem.
For now I can use a break but in the future someone else can add new code
in between that will set ret to 0 and instead of failing driver flow will
continue with incomplete pre-scaler value.
So I prefer keeping it as it.

--
Best regards, Eliav
