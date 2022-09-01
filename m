Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8DB5A8ED7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiIAGyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiIAGyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:54:51 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF514FDB;
        Wed, 31 Aug 2022 23:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662015288; x=1693551288;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=1SVd+phahoUIGBOGlWxPC1ufcvnAsdeeOKE5nHDZHUE=;
  b=WRCVwYpybIuTmwNE6Lpa4cV3qpzRNKGAVc94zTDIg+KxDvleXxlZ6GUl
   rAPUfVt9M5CW5aV/NB8OsMGOrX1/Y0wNY/UUUVBDltUnJsWVswpRzVjV8
   ehqhMHZIFhUe/PbgFFb4VFtyvoojTwAJP/ju/Fogs/vw6Ozq554iQIXo7
   4=;
X-IronPort-AV: E=Sophos;i="5.93,280,1654560000"; 
   d="scan'208";a="222563956"
Subject: Re: [PATCH v3 18/19] hwmon: (mr75203) add debugfs to read and write
 temperature coefficients
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-828bd003.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 06:54:32 +0000
Received: from EX13D40EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-828bd003.us-east-1.amazon.com (Postfix) with ESMTPS id 9F02E80BA7;
        Thu,  1 Sep 2022 06:54:28 +0000 (UTC)
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D40EUB003.ant.amazon.com (10.43.166.128) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 1 Sep 2022 06:54:27 +0000
Received: from [192.168.93.228] (10.85.143.172) by mail-relay.amazon.com
 (10.43.62.224) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Thu, 1 Sep 2022 06:54:22 +0000
Message-ID: <646af681-38b0-1268-3798-c5434ca30bee@amazon.com>
Date:   Thu, 1 Sep 2022 09:54:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
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
 <20220830192212.28570-19-farbere@amazon.com>
 <Yw9Qq+PIfxgXRIK2@smile.fi.intel.com>
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <Yw9Qq+PIfxgXRIK2@smile.fi.intel.com>
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

On 8/31/2022 3:14 PM, Andy Shevchenko wrote:
> On Tue, Aug 30, 2022 at 07:22:11PM +0000, Eliav Farber wrote:
>> This change adds debugfs to read and write temperature sensor 
>> coefficients
>> - g, h, j and cal5.
>>
>> The coefficients can vary between product and product, so it can be very
>> useful to be able to modify them on the fly during the calibration
>> process.
>>
>> e.g.:
>>
>> cat /sys/kernel/debug/940f23d0000.pvt/ts_coeff_cal5
>> 4096
>>
>> echo 83000 > sys/kernel/debug/940f23d0000.pvt/ts_coeff_g
>
> ...
>
>> +     pvt->dbgfs_dir = debugfs_create_dir(dev_name(dev), NULL);
>
>> +     if (!pvt->dbgfs_dir) {
>> +             dev_err(dev, "Failed to create dbgfs_dir\n");
>> +             return -EINVAL;
>> +     }
>
> No, just don't check the return value of debugfs API calls.
>
Do you mean that I should just do:
debugfs_create_dir(dev_name(dev), NULL);
Can you please explain why it's OK to ignore the return value?

>> +     debugfs_create_file("ts_coeff_h", 0644, pvt->dbgfs_dir, pvt,
>> +                         &pvt_ts_coeff_h_fops);
>> +     debugfs_create_file("ts_coeff_g", 0644, pvt->dbgfs_dir, pvt,
>> +                         &pvt_ts_coeff_g_fops);
>> +     debugfs_create_file("ts_coeff_j", 0644, pvt->dbgfs_dir, pvt,
>> +                         &pvt_ts_coeff_j_fops);
>> +     debugfs_create_file("ts_coeff_cal5", 0644, pvt->dbgfs_dir,  pvt,
>> +                         &pvt_ts_coeff_cal5_fops);
>
> debugfs has helpers for POD types, use them and shrink your code by ~80%.
>
Fixed for v4.
I used debugfs_create_u32() for ts_coeff_h, ts_coeff_g and ts_coeff_j.
For ts_coeff_cal5 I still use debugfs_create_file() because I must make
sure it is not set to 0.

>> +     ret = devm_add_action_or_reset(dev, devm_pvt_ts_dbgfs_remove, 
>> pvt);
>> +     if (ret) {
>> +             dev_err(dev, "failed to add action to remove pvt dbgfs 
>> (%d)\n",
>> +                     ret);
>> +             return ret;
>> +     }
>> +
>> +     return 0;
>
> return devm_add_...
Fixed for v4.

--
Thanks, Eliav
