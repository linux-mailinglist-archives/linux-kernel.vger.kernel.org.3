Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8202C4AE87B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241252AbiBIEML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347379AbiBIDn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:43:58 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC9BC0401C4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644377670; x=1675913670;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=ECyKNZsrCiAEyEZui/Gdj3P39GeKJgI9x3cOLnB6b1I=;
  b=NtABWkB8uJKJwVIX3GXFHrh6qqu052xkVEjmxKz653hq3V97kFQHcrp/
   5z+W8lGu6XgLwQpukmSpr+9DDcLs9cQAQvREbZlnd8NGjlbFN5lQDg7lB
   qwx2LRj2/c8wiCfDbWFw+cSaZucfcR/EkKwwyUPHUPrN9THv5mTIKE+g3
   6WwseJfk0xorfjgJVRMpTmM11eJgB8frA6EiM7lcYyeeuk6rotW/NF9EG
   TrftntaAe7+do03F8sF+fiQF5eQVpoqparHqnSq68ACfz9//f0a8+WL/j
   XSvnKL+MiPieiW76ftYuSAV+vhu07Z/IsQntm5hlcWS8XbRCTKV9eJFGp
   g==;
X-IronPort-AV: E=Sophos;i="5.88,354,1635177600"; 
   d="scan'208";a="191411787"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2022 11:34:28 +0800
IronPort-SDR: xaQrfv+ia8wzXo+suWcHIC3HwlVLcmM00Di+W8pFSYp/K3B4BIDI3Yf+EVz4yTxaMr5Nl97g22
 6BWeGbWMJoz+NgbuGd4JJTTBikg+9D6SgXDU6MDJpoGjvcw5wFBWTiYGw3bkIGibdo0vjiK3N6
 e2QBdR5tiYtp1GA+IbGrQzps837in/UHSImcMXpRT09tKARFNmdnQJFEoiy4jvXCqAioJe/fcT
 BkLiB7y9d14CaoQMBafEsb0Kkm5X63Tr329nxlKQANZnDLvXyQWOWUPiIBeFB/MgJvFSK228eI
 1KS1ewyvDOoZfm5n4MvscS4o
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 19:07:28 -0800
IronPort-SDR: cApmr9vNjwkwMgD2J0tso2EY7822opmtZN8GZA16BH0lJy6x7AIg0IVHnMiRBGk83fPktd9k/L
 HZSXm4WpM0VUqadc3NEbWvuWCT2MooALnjWaN6tCNYgTnATN1C3mwmPvZ1+wAZPN9NXGfTBEht
 5zuEM06zn5SCMNRJUdjKZ+ZEXaJhldni6vBAfNghGGE6HisHNgnFnMcxr/aMHA1AS835IVVdGi
 Bjz0N4WckmM6t/e2mGkYDk+AE4rR4M6uEhbxvsk2j+F0eCoE/GAzv5zovDYM/MSMU/VNhsCxBD
 LlA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 19:34:29 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JtlqS4VPPz1SVp5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:34:28 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644377667; x=1646969668; bh=ECyKNZsrCiAEyEZui/Gdj3P39GeKJgI9x3c
        OLnB6b1I=; b=YXp/9r3fixxNDIKmKPOYx3RrHjtLqJJIN+Ni5/IZLSK3Pd7t1ym
        ef3ynXSz0cM16OUsbc1TxHb2H1K6L9CxECfRDIzbP5sA2OHf9tmQK0IPe4yRjcXq
        NRYeKtiGZWhxTxvtO8nAG/MSiC1a4rWgTFETD7aE2RpbskOzdAuqAhYDlgK/iw9r
        0TcETHhaJLHuuFKvV8HMhH0pphtbLrm3uD0qWmp4HN2J8JFNOIX13JNv6Q86QIh5
        MlHdDqm/rYDm/YLOEllVzPwT9aShMxXl/W4iS+0EKRCNPRsXh/nG0O+c4PG8EiLW
        j3JtpHxQsXHPdBpFad8FYbtPJ/rBKSOP6Dg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6XwcasC8GnU9 for <linux-kernel@vger.kernel.org>;
        Tue,  8 Feb 2022 19:34:27 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JtlqQ1rVMz1Rwrw;
        Tue,  8 Feb 2022 19:34:26 -0800 (PST)
Message-ID: <8d7d36e6-66ac-a318-dfce-6d5b01b51f3c@opensource.wdc.com>
Date:   Wed, 9 Feb 2022 12:34:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH] scsi: csiostor: replace snprintf with sysfs_emit
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Joe Perches <joe@perches.com>, davidcomponentone@gmail.com,
        jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, bvanassche@acm.org,
        yang.guang5@zte.com.cn, jiapeng.chong@linux.alibaba.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
References: <d711ec5a5f416204079155666d2de49d43070897.1644287527.git.yang.guang5@zte.com.cn>
 <148a5448-71f1-4f39-834b-eb9283de0bfb@opensource.wdc.com>
 <f4b63b5a4177e38dd80f102f87bbec3ea77d9fe8.camel@perches.com>
 <0093948e-a408-61dd-3b51-524b6d112e35@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <0093948e-a408-61dd-3b51-524b6d112e35@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/02/09 12:16, Damien Le Moal wrote:
> On 2022/02/09 12:12, Joe Perches wrote:
>> On Wed, 2022-02-09 at 11:36 +0900, Damien Le Moal wrote:
>>> On 2/9/22 09:40, davidcomponentone@gmail.com wrote:
>>>> From: Yang Guang <yang.guang5@zte.com.cn>
>>>>
>>>> coccinelle report:
>>>> ./drivers/scsi/csiostor/csio_scsi.c:1433:8-16:
>>>> WARNING: use scnprintf or sprintf
>>>> ./drivers/scsi/csiostor/csio_scsi.c:1369:9-17:
>>>> WARNING: use scnprintf or sprintf
>>>> ./drivers/scsi/csiostor/csio_scsi.c:1479:8-16:
>>>> WARNING: use scnprintf or sprintf
>>>>
>>>> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
>> []
>>>> diff --git a/drivers/scsi/csiostor/csio_scsi.c b/drivers/scsi/csiostor/csio_scsi.c
>> []
>>>> @@ -1366,9 +1366,9 @@ csio_show_hw_state(struct device *dev,
>>>>  	struct csio_hw *hw = csio_lnode_to_hw(ln);
>>>>  
>>>>  	if (csio_is_hw_ready(hw))
>>>> -		return snprintf(buf, PAGE_SIZE, "ready\n");
>>>> +		return sysfs_emit(buf, "ready\n");
>>>>  	else
>>>> -		return snprintf(buf, PAGE_SIZE, "not ready\n");
>>>> +		return sysfs_emit(buf, "not ready\n");
>>>
>>> While at it, you could remove the useless "else" above.
>>
>> Or not.  It's fine as is.  It's just a style preference.
> 
> It is. I dislike the useless line of code in this case :)
> 
>>
>> Another style option would be to use a ?: like any of
>>
>> 	return sysfs_emit(buf, "%sready\n", csio_is_hw_ready(hw) ? "" : "not ");
>> or
>> 	return sysfs_emit(buf, "%s\n", csio_is_hw_ready(hw) ? "ready" : "not ready");
>> or
>> 	return sysfs_emit(buf, csio_is_hw_ready(hw) ? "ready\n" : "not ready\n");
> 
> That is nice and can make that
> 	
> 	return sysfs_emit(buf, "%sready\n", csio_is_hw_ready(hw) ? "" : "not ");

Oops. You did have that one listed... Read too quickly...

> 
> too :)
> 


-- 
Damien Le Moal
Western Digital Research
