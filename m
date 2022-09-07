Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6436A5AFB9B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiIGFP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 01:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIGFP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 01:15:57 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D108F696E0;
        Tue,  6 Sep 2022 22:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662527757; x=1694063757;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=FsnQRMSSi7+hfFZnWHCqd2bxO6iA2QpxOKTtr1OPJwo=;
  b=CtaA0HPvfzugS/GJzITilxJRqQC7QJHt84R7uJQSEuE99wlNnhf04qZx
   rHmXngREjvw326Ty07AFCnUojx6WdSc1HxSwj/sJwiyA/6psWEF1OagtA
   exqHTkQQuGNAmpl5QZzhDYmJUls3DoXFWMrseR3iB6FduKR2s9MNJpxyB
   w=;
X-IronPort-AV: E=Sophos;i="5.93,295,1654560000"; 
   d="scan'208";a="223930458"
Subject: Re: [PATCH v4 06/21] hwmon: (mr75203) fix multi-channel voltage reading
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-54c9d11f.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 05:15:42 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-54c9d11f.us-east-1.amazon.com (Postfix) with ESMTPS id D0AD2C08AE;
        Wed,  7 Sep 2022 05:15:40 +0000 (UTC)
Received: from EX19D013UWB004.ant.amazon.com (10.13.138.62) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 7 Sep 2022 05:15:40 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX19D013UWB004.ant.amazon.com (10.13.138.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.12; Wed, 7 Sep 2022 05:15:40 +0000
Received: from [192.168.96.145] (10.85.143.173) by mail-relay.amazon.com
 (10.43.62.224) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Wed, 7 Sep 2022 05:15:37 +0000
Message-ID: <229f0e46-0123-3ffb-d737-0749ffba4e13@amazon.com>
Date:   Wed, 7 Sep 2022 08:15:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, "Farber, Eliav" <farbere@amazon.com>
References: <20220906083356.21067-1-farbere@amazon.com>
 <20220906083356.21067-7-farbere@amazon.com>
 <YxdU6hiwblhT2I5u@smile.fi.intel.com>
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <YxdU6hiwblhT2I5u@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/2022 5:10 PM, Andy Shevchenko wrote:
> On Tue, Sep 06, 2022 at 08:33:41AM +0000, Eliav Farber wrote:
>> Fix voltage allocation and reading to support all channels in all VMs.
>> Prior to this change allocation and reading were done only for the first
>> channel in each VM.
>> This change counts the total number of channels for allocation, and 
>> takes
>> into account the channel offset when reading the sample data register.
>
> ...
>
>> +             total_ch = ch_num * vm_num;
>> +             in_config = devm_kcalloc(dev, total_ch + 1,
>>                                        sizeof(*in_config), GFP_KERNEL);
>
> Strictly speaking this should be `size_add(size_mul(...) ...)` 
> construction
> from overflow.h.
>
>                total_ch = size_mul(ch_num, vm_num);
>                in_config = devm_kcalloc(dev, size_add(total_ch, 1),
>                                         sizeof(*in_config), GFP_KERNEL);
>
> Alternatively before doing all these, add a check
>
>                if (array3_size(ch_num, vm_num, sizeof(*in_config)) < 
> SIZE_MAX - sizeof(*in_config))
>                        return -EOVERFLOW;
>
> But this is a bit monstrous. Seems like the above looks and feels better.
>
> Also for backporting purposes perhaps it's fine to do without using 
> those macro
> helpers. 
According to the driver code total_ch is a u32 variable while vm_num
and ch_num are both limited to a value of 31:

#define VM_NUM_MSK GENMASK(20, 16)
#define VM_NUM_SFT 16
#define CH_NUM_MSK GENMASK(31, 24)
#define CH_NUM_SFT 24

In addition the PVT Controller Series 3+ Specification mentions that
the actual maximum values are even smaller – 8 for vm_num and 16 for
ch_num.
Therefore we are very far from a scenario of an overflow.
Do you still think overflow protection in necessary?

--
Thanks, Eliav
