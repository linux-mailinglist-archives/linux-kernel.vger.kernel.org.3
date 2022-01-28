Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478FA49F8BA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348226AbiA1LuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:50:11 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:62546 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348220AbiA1LuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643370609; x=1674906609;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FZtNYr/2rF3NjA50l9+zzQuYk8TMRrNhiex1zVOhi64=;
  b=R/BhW1RhUPFD5wvMAltpaM+9IF9OQleZnJ+r5yWOgtrlIepcCpoJeg8A
   lC1zeZ5oU9xgKOA/aNCSAWP3c6Kvv+7Eiv9E4h72LIYZFldRo2F0qCpr8
   +sijcBl/dfbW4CHHQQXsQSrG+pY4XRtpuYb/hgoZ73bNRiBV+UakuH38n
   VZeeGvlsw/odtwXO2wVR0YguRzeW9JAoQ40wFbliB++aPxR5zeK9Diqzy
   /hnJ0jgpmuBGkK8cl6anrqI4/b80uSXduJueSU4S4D75mLjfhvOyw5SXi
   HFxydOklsIT4YffiVcJAur86hfnnhb6b/yt6K3mk0F3p7bl3p+GYECJ4O
   A==;
X-IronPort-AV: E=Sophos;i="5.88,323,1635177600"; 
   d="scan'208";a="303511239"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2022 19:50:08 +0800
IronPort-SDR: mlt+ZnP8ckhIWOaeLrGFW/Odsd3tOaWKHNdVIvg8nkhxCRuulw3czHgHcoSH3nT0v6LaB1WFTV
 kF+7BDp14pA1eklTkhN55iUe2Xz4yGS7Q6XW/uhoE6LCuqGZ6H60mGJeEt6RxQH8hwHQ2NaXEL
 YF1uFPmD4FhuGhDw+Qx4n3tpK4x4uo89Fh1pjsERDQedbtujKEWk8TcTqMHcSThjnIwh3xjNH4
 eKsg1auwlKNnC51Q38TZWFdTmgaEEE99dMn2WP5/HSmwgiZQBRzAimfXv2pQ1oS3/Nyv1W5Rq+
 fQRcQmbNYLD7HfGSWwjbUddc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 03:23:26 -0800
IronPort-SDR: /vMZg9+8eKzCezEkATdrJ2gbGWjYhW/TUYhpSyDoBknyeLilsap32EM7NRUouSvzEz8QNBTPAu
 qkWJUX2hYPKVCsTgRGd+QrPhtIhLDMAvE1y9+peCceNIi3nQ4PDiPtjCer/CHqb3l6l8VYkKPf
 fZiPxAKNoCM2Su9ru9yHBR7zqHBfhFTTcpfnQ6qKz2hBz2q7heLVMtJoRMnf8UVC3HScsfc4G4
 fyu7odppTJbQf8Vs4Xb3RySIdN0SvC8mDatImVGIeMmJcc1YSw4ogpiiKP9MDYVuUAvBsVShBU
 K5U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 03:50:10 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JlbNw5NBBz1SHwl
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:50:08 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643370607; x=1645962608; bh=FZtNYr/2rF3NjA50l9+zzQuYk8TMRrNhiex
        1zVOhi64=; b=nUW/x3r2dElQgO0BK8fYjdTPguSZDHWKMRpyL6GS3mCBX6LTKr9
        Iji9rrJyHRmq3wZpjrZiiUOE3fjhM0y1xo5pZIlUP31oEX2ckfsjDikY6bNTGm84
        JVJumVUW2a0l7tVX5Vol8y4u9IqRb0HEFf+goKzYRJhbfAIvhkv9kfUcmWf3Zk3P
        uRuPduXJ8Vs+VRTuV3zu+QXBfUHMvgK/1EywxgP7O18dwNodLb6C9j6eFzTU7aZ5
        9IOnL5vKmde3Piepf5Nv4je+tXnradScqBiWNDQgMZoPuYADeDTi123nf5Wial9o
        qQIHrzbDQvgOEu3iCJMt/idO+rsKS0hc7XA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8UzJXfk5S2f6 for <linux-kernel@vger.kernel.org>;
        Fri, 28 Jan 2022 03:50:07 -0800 (PST)
Received: from [10.225.163.58] (unknown [10.225.163.58])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JlbNt2Rs8z1RvlN;
        Fri, 28 Jan 2022 03:50:06 -0800 (PST)
Message-ID: <3621c7db-0b73-d7eb-f987-45ec59a6c738@opensource.wdc.com>
Date:   Fri, 28 Jan 2022 20:50:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: pata_platform: Fix a NULL pointer dereference in
 __pata_platform_probe()
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Alexander Shiyan <shc_work@mail.ru>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220124164525.53068-1-zhou1615@umn.edu>
 <YfPBb4gHDkr76xPT@kroah.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YfPBb4gHDkr76xPT@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 19:11, Greg KH wrote:
> On Tue, Jan 25, 2022 at 12:45:25AM +0800, Zhou Qingyang wrote:
>> In __pata_platform_probe(), devm_kzalloc() is assigned to ap->ops and
>> there is a dereference of it right after that, which could introduce a
>> NULL pointer dereference bug.
>>
>> Fix this by adding a NULL check of ap->ops.
>>
>> This bug was found by a static analyzer.
>>
>> Builds with 'make allyesconfig' show no new warnings,
>> and our static analyzer no longer warns about this code.
>>
>> Fixes: f3d5e4f18dba ("ata: pata_of_platform: Allow to use 16-bit wide data transfer")
>> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
>> ---
> 
> As stated in the past, please do not make contributions to the Linux
> kernel until umn.edu has properly resolved its development issues.

Aouch. My apologies. I forgot about this. Thank you for the reminder.

> 
>> The analysis employs differential checking to identify inconsistent 
>> security operations (e.g., checks or kfrees) between two code paths 
>> and confirms that the inconsistent operations are not recovered in the
>> current function or the callers, so they constitute bugs. 
>>
>> Note that, as a bug found by static analysis, it can be a false
>> positive or hard to trigger. Multiple researchers have cross-reviewed
>> the bug.
>>
>>  drivers/ata/pata_platform.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
>> index 028329428b75..021ef9cbcbc1 100644
>> --- a/drivers/ata/pata_platform.c
>> +++ b/drivers/ata/pata_platform.c
>> @@ -128,6 +128,8 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
>>  	ap = host->ports[0];
>>  
>>  	ap->ops = devm_kzalloc(dev, sizeof(*ap->ops), GFP_KERNEL);
>> +	if (ap->ops)
>> +		return -ENOMEM;
> 
> This change seems to leak memory.  Damien, please revert it.

I fixed the patch when applying, so there is no leak. This is a genuine
(potential) bug fix. Must I revert ? Is the "no contribution from
umn.edu" an unbreakable rule ?

> 
> thanks,
> 
> greg k-h


-- 
Damien Le Moal
Western Digital Research
