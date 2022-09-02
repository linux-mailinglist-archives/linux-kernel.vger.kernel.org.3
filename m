Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5595AAE14
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 14:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbiIBMFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 08:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbiIBMFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 08:05:37 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED79080378;
        Fri,  2 Sep 2022 05:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662120331; x=1693656331;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=Kp+LcxvVb62XzWaO7NWZJLTNmVEgDZQ/vduYeweJ8hc=;
  b=ZCONu4vV5L0+hE+Cm9lAvLtttKpDOqPskOmQ2srAEEMG9k3TZZuDag1a
   /+Jh3dFFn5coishgTdgllKSXOFo9p2hc26ok0M5253CBudlF03GjDgrUw
   BvwEBHjdA5hU+rWK/lSe/tgiek8sU8WM6NZJYie6luJg/kX0LYW5oQtSE
   M=;
X-IronPort-AV: E=Sophos;i="5.93,283,1654560000"; 
   d="scan'208";a="126163125"
Subject: Re: [PATCH v3 09/19] hwmon: (mr75203) add VM active channel support
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-2d7489a4.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 12:05:06 +0000
Received: from EX13D34EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-2d7489a4.us-east-1.amazon.com (Postfix) with ESMTPS id 21A274800F1;
        Fri,  2 Sep 2022 12:05:02 +0000 (UTC)
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D34EUB003.ant.amazon.com (10.43.166.189) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Fri, 2 Sep 2022 12:05:01 +0000
Received: from [192.168.149.164] (10.85.143.177) by mail-relay.amazon.com
 (10.43.60.234) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Fri, 2 Sep 2022 12:04:56 +0000
Message-ID: <83567278-45dd-faf9-f19f-9167026a8e42@amazon.com>
Date:   Fri, 2 Sep 2022 15:04:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
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
 <20220830192212.28570-10-farbere@amazon.com>
 <Yw9KcvaFzCcPw7qw@smile.fi.intel.com>
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <Yw9KcvaFzCcPw7qw@smile.fi.intel.com>
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

On 8/31/2022 2:48 PM, Andy Shevchenko wrote:
> On Tue, Aug 30, 2022 at 07:22:02PM +0000, Eliav Farber wrote:
>> Add active channel support per voltage monitor.
>> The number of active channels is read from the device-tree.
>> When absent in device-tree, all channels are assumed to be used.
>>
>> This shall be useful to expose sysfs only for inputs that are connected
>> to a voltage source.
>>
>> Setting number of active channels to 0, means that entire VM sensor is
>> not used.
>
> ...
>
>> +struct voltage_device {
>> +     u32 vm_map;     /* Map channel number to VM index */
>> +     u32 ch_map;     /* Map channel number to channel index */
>> +};
>> +
>> +struct voltage_channels {
>> +     u32 total;      /* Total number of channels in all VMs */
>> +     u8 max;         /* Maximum number of channels among all VMs */
>> +};
>
> Why not convert them to kernel doc?
>
Fixed in v4.


>> +     ret = device_property_read_u8_array(dev, 
>> "moortec,vm-active-channels",
>> +                                         vm_active_ch, vm_num);
>> +     if (ret) {
>> +             /*
>> +              * Incase vm-active-channels property is not defined,
>> +              * we assume each VM sensor has all of its channels
>> +              * active.
>> +              */
>> +             for (i = 0; i < vm_num; i++)
>> +                     vm_active_ch[i] = ch_num;
>
> NIH memset().

Fixed in v4.


>> +             pvt->vm_channels.max = ch_num;
>> +             pvt->vm_channels.total = ch_num * vm_num;
>> +     } else {
>> +             for (i = 0; i < vm_num; i++) {
>> +                     if (vm_active_ch[i] > ch_num) {
>> +                             dev_err(dev, "invalid active channels: 
>> %u\n",
>> +                                     vm_active_ch[i]);
>> +                             return -EINVAL;
>> +                     }
>> +
>> +                     pvt->vm_channels.total += vm_active_ch[i];
>> +
>> +                     if (vm_active_ch[i] > pvt->vm_channels.max)
>> +                             pvt->vm_channels.max = vm_active_ch[i];
>> +             }
>> +     }
>
> ...
>
>> +     k = 0;
>> +     for (i = 0; i < vm_num; i++)
>> +             for (j = 0; j < vm_active_ch[i]; j++) {
>> +                     pvt->vd[k].vm_map = vm_idx[i];
>> +                     pvt->vd[k].ch_map = j;
>
>> +                     k++;
>
> How is it different from moving this outside the inner loop as
>
>        k += vm_active_ch[i];
>
> ?

k is used inside the inner loop, so increasing it outside the inner loop
will result in a different incorrect setting of vm_map and ch_map.

>> +             }
>
> Missed outer {}.

Fixed in v4.


--
Regards, Eliav

