Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AF54ED3C9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiCaGOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiCaGOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:14:00 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EA33A194
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648707133; x=1680243133;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E4a1RRyooAoRtkFYAYlHloSeUaE2XqLLxFYZcQCPt6c=;
  b=e0Va/G8Qg+kwlaGXD9gNvlsYQOfXM2KmY5UDvgb37P0+43FD8ayiRNEO
   kJY4kMz07wLORnaVXJDzLKCjptGs8km1MT9yDzNTTyBsrkopeXSziJ+RK
   e+bF1TwQaO+izxXkyA4O8kf3PQccSUuOLevabExtPQIl21SNj6itgwPvh
   bNe4f/RJDeiZ5OOSgy2NKyL2equ2Maa4mRofAyzT1aSdihCwPxA6sn9Le
   T9r+VlPxuuEB9fq57W6YjBwR3ckuswO3dqVk2yuxdU2dFrbyBTLRYdrgl
   Y9YS8UvYgbb0SpieDHIK1AJwzVJlmgo28rcMqKA3FadXK5XkACCy9nmXZ
   w==;
X-IronPort-AV: E=Sophos;i="5.90,224,1643644800"; 
   d="scan'208";a="308660664"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2022 14:12:13 +0800
IronPort-SDR: RDcW8Tp/GQM9lVQ4XcYkDCehjks9U4Em2lAqBlR5ePbRmIaBFcWcQOXk7oZ7pW93m9pIhV6K/5
 z85b4cGg/txShm7tFb+pAj2oHoikSDg3EqKXcoIdyhWU3DIM6ySyGe3r7VVfvc0eBSxwYE6T4N
 pEO3O08STjZzY00QNNw6dOWRigX4dHcfyzOtx3H+Ufp00bN4L/i66xEtsNO26+9IMICD4cU9Gm
 UQZ/DRQTwyTIBsnzKbbc9AVLeH+nd+E6FW3JPnKknFyO9n/lfH2WD5lT8xOHk41QPrlNNWAlVI
 ZrTawPZjLb/P8TRanXmiltu8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2022 22:43:02 -0700
IronPort-SDR: QygthwkCBcqe7wuk238SFy5a1Jpgr5YFU7NGlSWMv9I46wnvuI6bcV9B63hCij4uRcJft+Ss6E
 rDGH0Ig6B3Hlg4kn0W6QDkV0HFcJJYhgGC1F0S5AQS8ykE0ceFqv7jFptOwxXWZSETorbc1rKg
 bIS2Fg5PMBv3t5dxcofY0X/4ttlcaP1cP9B56+487apQ0DGt5RBnZwqtZ0GHJCwnNuDpEPNszE
 Vcip8Ns1NEhs5eqETW3WayamGXq5bSXkfSeiBiINOG8bOZJF0njPC3SnL61k7jQRbQxamgYJEu
 SLI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2022 23:12:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KTXyN6k6Hz1SVp3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:12:12 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648707131; x=1651299132; bh=E4a1RRyooAoRtkFYAYlHloSeUaE2XqLLxFY
        ZcQCPt6c=; b=gWtcSn7NvzuQQr95xCNGk1BJkK97C5Yc5A2RIYeHVL+u1oaqB9A
        7fYbd1k4A9mJzGnGHgfIUEvOYMFkMZN+mytC31RtTAeyLPyfhezM5lhgVjI2nvUV
        r7t8NX4rkQ8+XK/MNqqgzLs10Dwuj/MO+df981VmLErhDywVE2txNS2rHNF3gSaq
        kr1qMNvpKtwxJMjAjdERCcguG9G7BGRQDAOaw59Hzoz9K0toIF3mL+69W9/uOUEP
        UTLOzxJUlq2ehFJEHMp7zXzEedLoRpbPBaRCacrfSTldun2YtW+8Bu/rJkCqZyFo
        cwPaiIxHn3qo/wAT2U1yMbgI/kiqu0IqYJg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qFb8j2KTsrTi for <linux-kernel@vger.kernel.org>;
        Wed, 30 Mar 2022 23:12:11 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KTXyL4460z1Rvlx;
        Wed, 30 Mar 2022 23:12:10 -0700 (PDT)
Message-ID: <9cdf5eb3-201d-254e-1404-54522131eeb0@opensource.wdc.com>
Date:   Thu, 31 Mar 2022 15:12:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: filesystem corruption with "scsi: core: Reallocate device's
 budget map on queue depth change"
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Martin Wilck <martin.wilck@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YkQsumJ3lgGsagd2@arighi-desktop>
 <f7bacce8-b5e5-3ef1-e116-584c01533f69@huawei.com>
 <YkQ9KoKb+VK06zXi@arighi-desktop>
 <08717833-19bb-8aaa-4f24-2989a9f56cd3@huawei.com>
 <263108383b1c01cf9237ff2fcd2e97a482eff83e.camel@linux.ibm.com>
 <YkRfrjgNpD+S2WpN@T590>
 <ba090f1b-a767-46a1-5728-82d9c587ef3c@opensource.wdc.com>
 <YkUOip75R8DH613s@T590>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YkUOip75R8DH613s@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 11:14, Ming Lei wrote:
> On Thu, Mar 31, 2022 at 07:30:35AM +0900, Damien Le Moal wrote:
>> On 3/30/22 22:48, Ming Lei wrote:
>>> On Wed, Mar 30, 2022 at 09:31:35AM -0400, James Bottomley wrote:
>>>> On Wed, 2022-03-30 at 13:59 +0100, John Garry wrote:
>>>>> On 30/03/2022 12:21, Andrea Righi wrote:
>>>>>> On Wed, Mar 30, 2022 at 11:38:02AM +0100, John Garry wrote:
>>>>>>> On 30/03/2022 11:11, Andrea Righi wrote:
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> after this commit I'm experiencing some filesystem corruptions
>>>>>>>> at boot on a power9 box with an aacraid controller.
>>>>>>>>
>>>>>>>> At the moment I'm running a 5.15.30 kernel; when the filesystem
>>>>>>>> is mounted at boot I see the following errors in the console:
>>>>>
>>>>> About "scsi: core: Reallocate device's budget map on queue depth
>>>>> change" being added to a stable kernel, I am not sure if this was
>>>>> really a fix  or just a memory optimisation.
>>>>
>>>> I can see how it becomes the problem: it frees and allocates a new
>>>> bitmap across a queue freeze, but bits in the old one might still be in
>>>> use.  This isn't a problem except when they return and we now possibly
>>>> see a tag greater than we think we can allocate coming back. 
>>>> Presumably we don't check this and we end up doing a write to
>>>> unallocated memory.
>>>>
>>>> I think if you want to reallocate on queue depth reduction, you might
>>>> have to drain the queue as well as freeze it.
>>>
>>> After queue is frozen, there can't be any in-flight request/scsi
>>> command, so the sbitmap is zeroed at that time, and safe to reallocate.
>>>
>>> The problem is aacraid specific, since the driver has hard limit
>>> of 256 queue depth, see aac_change_queue_depth().
>>
>> 256 is the scsi hard limit per device... Any SAS drive has the same limit
>> by default since there is no way to know the max queue depth of a scsi
>> disk.So what is special about aacraid ?
>>
> 
> I meant aac_change_queue_depth() sets hard limit of 256.
> 
> Yeah, for any hba driver which implements its own .change_queue_depth(),
> there may be one hard limit there.
> 
> So I still don't understand why you mention '256 is the scsi hard limit per
> device', and where is the code? If both .cma_per_lun and .can_queue are > 256
> and the driver uses default scsi_change_queue_depth() and sdev->tagged_supported
> is true, then user is free to change queue depth via /sys/block/$SDN/device/queue_depth
> to > 256. It is same for SAS, see sas_change_queue_depth().
> 
> Also I am pretty sure some type of scsi device is capable of supporting >256 queue
> depth, include sas, and sas usually has big queue depth.

Correct. The 256 hard limit comes from the old parallel scsi transport
which had only 8 bits for the tag value. Other SCSI transports do have
more bits for tags, allowing higher maximum.

That said, the scsi stack limits the max queue depth to 1024 (see
scsi_device_max_queue_depth(), and most drivers set can_queue to 256 or
less by default.

> 
> 
> Thanks,
> Ming
> 


-- 
Damien Le Moal
Western Digital Research
