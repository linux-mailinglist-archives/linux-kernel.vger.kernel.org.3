Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14C15A96A5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbiIAMXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiIAMW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:22:57 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D0898D14;
        Thu,  1 Sep 2022 05:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662034977; x=1693570977;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=85gR77OmGyIW5C5Jto08sz9YSHFvUHf+ehDzrjpitbM=;
  b=V+k50UAxxTwWR+UyRHOifp244mkK6m+qZPjfN1tLWUMv6/Ph3oOeIcL8
   F8JheJQNxVv0jp4mt66ZnKE8EdhI+BiypqJolYGpW+mbrtGVIELbdy4Kj
   hOBOZQsCsKVDAiS7cqUaANQLcC4g4mJgo2NyBCsB+MCvcQzjPeKOTdl0s
   w=;
X-IronPort-AV: E=Sophos;i="5.93,280,1654560000"; 
   d="scan'208";a="239930101"
Subject: Re: [PATCH v3 13/19] hwmon: (mr75203) modify the temperature equation
 according to series 5 datasheet
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-1801e169.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:22:44 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-1801e169.us-west-2.amazon.com (Postfix) with ESMTPS id A8A13C0920;
        Thu,  1 Sep 2022 12:22:42 +0000 (UTC)
Received: from EX19D013UWA001.ant.amazon.com (10.13.138.253) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 1 Sep 2022 12:22:42 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWA001.ant.amazon.com (10.13.138.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Thu, 1 Sep 2022 12:22:42 +0000
Received: from [192.168.93.228] (10.85.143.172) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Thu, 1 Sep 2022 12:22:36 +0000
Message-ID: <8ced7839-a66d-e281-6e07-fe3d591681fd@amazon.com>
Date:   Thu, 1 Sep 2022 15:22:35 +0300
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
 <20220830192212.28570-14-farbere@amazon.com>
 <Yw9OwUUD/t9DESQb@smile.fi.intel.com>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <Yw9OwUUD/t9DESQb@smile.fi.intel.com>
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

On 8/31/2022 3:06 PM, Andy Shevchenko wrote:
> On Tue, Aug 30, 2022 at 07:22:06PM +0000, Eliav Farber wrote:
>> Modify the equation and coefficients used to convert the digital output
>> to temperature according to series 5 of the Moortec Embedded Temperature
>> Sensor (METS) datasheet:
>> T = G + H * (n / cal5 - 0.5) + J * F
>>
>> Where:
>> *) G = 60, H = 200, cal5 = 4094, J = -0.1.
>> *) F = frequency clock in MHz.
>> *) n is the digital output.
>>
>> In code, the G, H and J coefficients are multiplied by a factor of 1000
>> to get the temperature in milli-Celsius.
>> Final result is clamped in case it exceeds min/max thresholds.
>>
>> Change is done since it is not clear where the current equation and
>
> not clear -> unclear
>
Fixed.

>> coefficients came from.
>
> ...
>
>> +#define PVT_TEMP_MIN         -40000
>> +#define PVT_TEMP_MAX         125000
>
> Unit suffix? _mC perhaps would be enough.

Fixed. Added _mC suffix as you suggested.

--
Thanks, Eliav

