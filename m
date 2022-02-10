Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78734B122D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243885AbiBJP6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:58:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243872AbiBJP6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:58:06 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2886FD81;
        Thu, 10 Feb 2022 07:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644508687; x=1676044687;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=nJFK6EQR25scnNWxpyGTRLOMBGca0iR6pOuAC+VH89M=;
  b=g7zfkK3lxIwZZA4G3PGyj9uDs6zC9Eves19pXZmlcmBUVNDBUCOolXm7
   dXnInhbR5hkgI7W72ZG/B5i1Bjy5e1dF6qT1+0+mrAbVyp2BOE7QjfMRw
   tzzzGmW2M4mCcErS51U979Fw54FWk1BXQLLeoTXqEA8t1Anc3KMM1sCpf
   98P6AuTED36VzUjBVdlX/d4m6dogaE6s8asVfcpW1UEoPJmbrHwOeew/C
   WR22YLSmPZvCmpOXgwpuxPBel45rVFD/3Qz+cWscHfQ/Fhr/zo/IyLPBg
   w+fRHtBnl3TvGr1ZsWYDmj/1tc6YLTt1HLH538zn6c/UP5/8tjavc+BPJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="247104613"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="247104613"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 07:57:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="541659783"
Received: from vchandol-mobl.gar.corp.intel.com (HELO [10.215.123.92]) ([10.215.123.92])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 07:57:45 -0800
Message-ID: <6b5b3d5b-68c9-3f04-d9b7-b58951f5557a@linux.intel.com>
Date:   Thu, 10 Feb 2022 21:27:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] hwmon: (pmbus) Clear pmbus fault/warning bits before read
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, iwona.winiarska@intel.com,
        jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220210124154.1304852-1-vikash.chandola@linux.intel.com>
 <46684682-a718-ca9a-b502-2031afd3a756@roeck-us.net>
From:   Vikash Chandola <vikash.chandola@linux.intel.com>
In-Reply-To: <46684682-a718-ca9a-b502-2031afd3a756@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/2022 8:14 PM, Guenter Roeck wrote:
> On 2/10/22 04:41, Vikash Chandola wrote:
>> pmbus fault and warning bits are not cleared by itself once fault/warning
>> condition is not valid anymore. As per pmbus datasheet faults must be
>> cleared by user.
>> Modify hwmon behavior to clear latched status bytes if any bit in status
>> register is high prior to returning fresh data to userspace. If
>> fault/warning conditions are still applicable fault/warning bits will be
>> set and we will get updated data in second read.
>>
>> Hwmon behavior is changed here. Now sysfs reads will reflect latest
>> values from pmbus slave, not latched values.
>> In case a transient warning/fault has happened in the past, it will no
>> longer be reported to userspace.
>>
> 
> 
> NACK.
> 
> Reporting that information is exactly the point of the current code.
> We _do_ want to report at least once that a problem occurred in the past,
> and only clear the warning flag(s) afterwards.
> 
> Guenter
> 
But as per current implementation we will continue to report fault even 
after fault condition is cleared. I could not find sysfs entry or any 
other means by which user/kernel can clear the faults/warnings after it 
is reported. Please point if I am missing anything.

>> Signed-off-by: Vikash Chandola <vikash.chandola@linux.intel.com>
>> ---
>>   drivers/hwmon/pmbus/pmbus_core.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c 
>> b/drivers/hwmon/pmbus/pmbus_core.c
>> index 776ee2237be2..1cc82d644079 100644
>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>> @@ -577,6 +577,15 @@ static int pmbus_get_status(struct i2c_client 
>> *client, int page, int reg)
>>           break;
>>       default:
>>           status = _pmbus_read_byte_data(client, page, reg);
>> +        if (status > 0) {
>> +            /*
>> +             * Status greater than 0 could mean that there was a 
>> fault/warning.
>> +             * Clear faults and do a second read to make sure we are 
>> not getting
>> +             * stale values.
>> +             */
>> +            pmbus_clear_fault_page(client, page);
>> +            status = _pmbus_read_byte_data(client, page, reg);
>> +        }
>>           break;
>>       }
>>       if (status < 0)
> 
