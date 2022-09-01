Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA445A9B94
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiIAP00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiIAP0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:26:14 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F86048EA3;
        Thu,  1 Sep 2022 08:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662045912; x=1693581912;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=ThCcDc02Fnh0N75Y6vq9PwesblySqNiNxskJBN7lQ4U=;
  b=GFA/tvJU6WRLkpIsT5WYRhqGyJYbRH8EgfXanO0RdHZkBoPts2btoSBz
   ZKIS7fCk/cK5N1HFVkARVcvvzhjmUIyncYRmkrLUza1YFXH1jLccm2CCA
   /eerQG4cmNI9tAxKGRFKPN4jJQKskoRAFCf5x2bXLbCAfyzpIXGmachoV
   Q=;
Subject: Re: [PATCH v3 02/19] hwmon: (mr75203) fix VM sensor allocation when "intel,
 vm-map" not defined
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-7a21ed79.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 15:25:00 +0000
Received: from EX13D37EUA003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-7a21ed79.us-east-1.amazon.com (Postfix) with ESMTPS id C9F0F22005B;
        Thu,  1 Sep 2022 15:24:57 +0000 (UTC)
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX13D37EUA003.ant.amazon.com (10.43.165.7) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 1 Sep 2022 15:24:56 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.12; Thu, 1 Sep 2022 15:24:56 +0000
Received: from [192.168.93.228] (10.85.143.172) by mail-relay.amazon.com
 (10.43.60.234) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Thu, 1 Sep 2022 15:24:51 +0000
Message-ID: <ceef1c33-1af5-53d1-5e5b-5aeb5d2679ca@amazon.com>
Date:   Thu, 1 Sep 2022 18:24:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <jdelvare@suse.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <talel@amazon.com>,
        <hhhawa@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <ronenk@amazon.com>, <itamark@amazon.com>, <shellykz@amazon.com>,
        <shorer@amazon.com>, <amitlavi@amazon.com>, <almogbs@amazon.com>,
        <dkl@amazon.com>, <andriy.shevchenko@intel.com>,
        "Farber, Eliav" <farbere@amazon.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-3-farbere@amazon.com>
 <cddebb5a-3b83-e89d-db00-9a59ddbd6741@roeck-us.net>
 <84a68eff-be64-71ce-1533-1e228d3da2a4@amazon.com>
 <71d6d57c-2165-5fe3-515d-9395022921e2@roeck-us.net>
 <2f5c5828-87b9-f3d2-e3d3-0200adbe830c@amazon.com>
 <20220901144434.GB3477025@roeck-us.net>
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20220901144434.GB3477025@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/2022 5:44 PM, Guenter Roeck wrote:
> On Thu, Sep 01, 2022 at 11:39:58AM +0300, Farber, Eliav wrote:
>> On 8/31/2022 2:48 PM, Guenter Roeck wrote:
>> > On 8/30/22 22:49, Farber, Eliav wrote:
>> > > On 8/31/2022 8:36 AM, Guenter Roeck wrote:
>> > > > On 8/30/22 12:21, Eliav Farber wrote:
>> > > > > Bug fix - in case "intel,vm-map" is missing in device-tree
>> > > > > ,'num' is set
>> > > > > to 0, and no voltage channel infos are allocated.
>> > > > >
>> > > > > Signed-off-by: Eliav Farber <farbere@amazon.com>
>> > > > > ---
>> > > > >   drivers/hwmon/mr75203.c | 28 ++++++++++++----------------
>> > > > >   1 file changed, 12 insertions(+), 16 deletions(-)
>> > > > >
>> > > > > diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
>> > > > > index 046523d47c29..0e29877a1a9c 100644
>> > > > > --- a/drivers/hwmon/mr75203.c
>> > > > > +++ b/drivers/hwmon/mr75203.c
>> > > > > @@ -580,8 +580,6 @@ static int mr75203_probe(struct
>> > > > > platform_device *pdev)
>> > > > >       }
>> > > > >
>> > > > >       if (vm_num) {
>> > > > > -             u32 num = vm_num;
>> > > > > -
>> > > > >               ret = pvt_get_regmap(pdev, "vm", pvt);
>> > > > >               if (ret)
>> > > > >                       return ret;
>> > > > > @@ -594,30 +592,28 @@ static int mr75203_probe(struct
>> > > > > platform_device *pdev)
>> > > > >               ret = device_property_read_u8_array(dev, 
>> "intel,vm-map",
>> > > > > pvt->vm_idx, vm_num);
>> > > > >               if (ret) {
>> > > > > -                     num = 0;
>> > > > > +                     /*
>> > > > > +                      * Incase intel,vm-map property is not
>> > > > > defined, we
>> > > > > +                      * assume incremental channel numbers.
>> > > > > +                      */
>> > > > > +                     for (i = 0; i < vm_num; i++)
>> > > > > + pvt->vm_idx[i] = i;
>> > > > >               } else {
>> > > > >                       for (i = 0; i < vm_num; i++)
>> > > > >                               if (pvt->vm_idx[i] >= vm_num ||
>> > > > > - pvt->vm_idx[i] == 0xff) {
>> > > > > -                                     num = i;
>> > > > > + pvt->vm_idx[i] == 0xff)
>> > > > >                                       break;
>> > > >
>> > > > So all vm_idx values from 0x00 to 0xfe would be acceptable ?
>> > > > Does the chip really have that many registers (0x200 + 0x40 +
>> > > > 0x200 * 0xfe) ?
>> > > > Is that documented somewhere ?
>> > > According to the code vm_num is limited to 32 because the mask is
>> > > only 5 bits:
>> > >
>> > > #define VM_NUM_MSK    GENMASK(20, 16)
>> > > #define VM_NUM_SFT    16
>> > > vm_num = (val & VM_NUM_MSK) >> VM_NUM_SFT;
>> > >
>> > > In practice according to the data sheet I have:
>> > > 0 <= VM instances <= 8
>> > >
>> > Sorry, my bad. I misread the patch and thought the first part of
>> > the if statement was removed.
>> >
>> > Anyway, what is the difference between specifying an vm_idx value of
>> > 0xff and not specifying anything ? Or, in other words, taking the dt
>> > example, the difference between
>> >        intel,vm-map = [03 01 04 ff ff];
>> > and
>> >        intel,vm-map = [03 01 04];
>>
>> The actual number of VMs is read from a HW register:
>>     ret = regmap_read(pvt->c_map, PVT_IP_CONFIG, &val);
>>     ...
>>     vm_num = (val & VM_NUM_MSK) >> VM_NUM_SFT;
>>
>> Also, using:
>>     ret = device_property_read_u8_array(dev, "intel,vm-map", vm_idx,
>>                         vm_num);
>> in the driver will fail if vm_num > sizeof array in device-tree.
>>
>> So, if for example vm_num = 5, but you will want to map only 3 of them
>> you most set property to be:
>>     intel,vm-map = [03 01 04 ff ff];
>> otherwise if you set:
>>     intel,vm-map = [03 01 04];
>> it will assume the property doesn't, and will continue the flow in code
>> as if it doesn’t exist (which is not what the user wanted, and before my
>> fix also has a bug).
>
> There should be some error handling to catch this case (ie if the number
> of entries does not match the expected count), or if a value in the array
> is larger or equal to vm_num. Today the latter is silently handled as end
> of entries (similar to 0xff), but that should result in an error.
> This would avoid situations like
>        intel,vm-map = [01 02 03 04 05];
> ie where the person writing the devicetree file accidentally entered
> index values starting with 1 instead of 0. A mismatch between vm_num
> and the number of entries in the array is silently handled as if there
> was no property at all, which is at the very least misleading and
> most definitely unexpected and should also result in an error.


I assume it is possible to tell according to the return value, if property
doesn’t exist at all, or if it does exists and size of array in
device-tree is smaller than vm_num.
In [PATCH v3 17/19] Andy wrote that “code shouldn't be a YAML validator.
Drop this and make sure you have correct DT schema” so I’m a bit confused
if code should validate “intel,bm-map” or if it is the user responsibility.
As this property was not added by me, I prefer not to fix it as part of
this series of patches.


> Also, what happens if the devicetree content is something like the
> following ? Would that be valid ?
>        intel,vm-map = [00 01 01 01 01 01];

If device-tree content would be:
     intel,vm-map = [00 01 01 01 01 01];
and assuming 16 channels for each VM, the hwmon sub-system will expose 90
sysfs to read voltage values.
In practice 16 – 31, 32 – 47, 48 – 63, 64 – 89 will all report the same
input signals for VM1.

--
Regards, Eliav
