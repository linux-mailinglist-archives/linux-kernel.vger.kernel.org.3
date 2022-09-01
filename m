Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BDB5A983E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiIANPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbiIANOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:14:40 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6516BCF1;
        Thu,  1 Sep 2022 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662037982; x=1693573982;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=K4Ki6DT09Ff4lH/DOomelev8LgCFLE5AfE5kHY7YHSs=;
  b=szngYYs9DgKIoZ5PF+sbjdxFt9wtqPiEIdd0167mUar8Yzs8FPJXOLCz
   5MHjPmSsKocE0xAARQlF0Z+flsqniPJ+1Hoyj0Dv78AxBbyTZcamA3UtW
   kaZyuJ+Vu/m1Z8DL+nYAtwqNF4bvCqB0aJCyuANI5s/KJzpSWTiv99wEj
   I=;
X-IronPort-AV: E=Sophos;i="5.93,280,1654560000"; 
   d="scan'208";a="125767607"
Subject: Re: [PATCH v3 06/19] hwmon: (mr75203) fix multi-channel voltage reading
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-1box-2b-3386f33d.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 13:12:43 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-1box-2b-3386f33d.us-west-2.amazon.com (Postfix) with ESMTPS id 26F10A279D;
        Thu,  1 Sep 2022 13:12:41 +0000 (UTC)
Received: from EX19D013UWA001.ant.amazon.com (10.13.138.253) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 1 Sep 2022 13:12:40 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWA001.ant.amazon.com (10.13.138.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Thu, 1 Sep 2022 13:12:40 +0000
Received: from [192.168.93.228] (10.85.143.172) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Thu, 1 Sep 2022 13:12:34 +0000
Message-ID: <319ee468-dcdc-51c1-38a3-b67d5048000e@amazon.com>
Date:   Thu, 1 Sep 2022 16:12:34 +0300
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
 <20220830192212.28570-7-farbere@amazon.com>
 <Yw8t8v9rdeR4wAIK@smile.fi.intel.com>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <Yw8t8v9rdeR4wAIK@smile.fi.intel.com>
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

On 8/31/2022 12:46 PM, Andy Shevchenko wrote:
> On Tue, Aug 30, 2022 at 07:21:59PM +0000, Eliav Farber wrote:
>> Fix voltage allocation and reading to support all channels in all VMs.
>> Prior to this change allocation and reading were done only for the first
>> channel in each VM.
>> This change counts the total number of channels for allocation, and 
>> takes
>> into account the channel offset when reading the sample data register.
>
> ...
>
>>       struct pvt_device *pvt = dev_get_drvdata(dev);
>>       struct regmap *v_map = pvt->v_map;
>>       u32 n, stat;
>> -     u8 vm_idx;
>> +     u8 vm_idx, ch_idx;
>
> Can you keep it sorted by line length?

Fixed.

>>       int ret;
>
> ...
>
>>       const struct hwmon_channel_info **pvt_info;
>> -     u32 ts_num, vm_num, pd_num, val, index, i;
>> +     u32 ts_num, vm_num, pd_num, ch_num, val, index, i;
>
> Ditto. 
Fixed.

--
Thanks, Eliav
