Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B594A3C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 01:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344999AbiAaALu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 19:11:50 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45628 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiAaALs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 19:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643587906; x=1675123906;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e1hYU1I+vVLhl9q0BN15pQ9mwYUmagXv/5AZJcKqbCs=;
  b=hz7RBFNMuFyhhQpWQ+m3Nf86Tuo/+ja1dp8OwuA4MCsre84uk9RT8NPk
   Mt+9A0hNFzsLfSeIErIIPB5AlLi+7C078ATBhahXVjlQbzkZxa5v/qxkh
   4NUfGdK5+aFFgTuDOuBcCcr5qIKg0icPt92S6ocW75kUOR3C+ymU4LZIb
   dAqO2vp4HoqDJUsSphZMrTWbY39B49ZCw+7JU9M72tYKqUZVLG4ilEGU1
   iWxxdCwRx0HMpmTOTNqT6FsdkFCoa3DSnKwfPnWOdueRBsx7auE5Eaw3K
   SF6g8ClJ0V0Z+muR1wVdw6OP565ut6GNKKtGo7PBUVC0yKrRLkYIzDx1w
   A==;
X-IronPort-AV: E=Sophos;i="5.88,329,1635177600"; 
   d="scan'208";a="196559056"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2022 08:11:46 +0800
IronPort-SDR: fZPtDEAscoPrslB5Zlcff0hA6+i+8oHvKurc34bATaZEbcHBaSn3U2xZkgJG+NZbP5x/MaVmZk
 H1nvulCMOaDQWa+cC9gJs48QD5htX/eERPkdj7ax8ok+myiZh9DF6MKY4IivhGJWyDZ8JDMvMB
 uUq7fTxZriqzXngD38YfTcx1SPmJEf+PAFzfROW6TZNPq9wmdeYUgMvjNQxXCqFWGLliMy+IF/
 k+eOOBSj+ntXHVsICBvgv7suiBQ3vYBWB4HPY1w+MZ/jePZQGPCtgjOD88105WZW6v1VkX3TpJ
 2B4VWNiR/4Q1BYOcvB89y/gX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 15:43:48 -0800
IronPort-SDR: NPhEN7Z1gRBpuhZR+A/9plDqKspp9dpxEpbXGsmj7k78++uUXLZWN3BfmmBkCQL94gm3nxIOfL
 j7JgPOEdREksrYMFgYCa2b6DlvGwMBf06k4AHZhLn+1WAWhfArz83eFhrmi2tu/fVfUU8b4PKC
 +4B1A8b8ME1mi6PEKRbAF3Qz7mj2WFQ3qaQPbx2A7yuRKm1sJkvMgV+V0O/eqCfjTgae4PF/z5
 A4LQWiK83XCEyx46cTAlWmv6fWLKHvSmQN246TWe2QY/TcPy4Yiwjk2YhwB1HQdsIvO4Ssdvj0
 OvU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 16:11:48 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jn7lm1vqwz1SVp1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 16:11:48 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643587907; x=1646179908; bh=e1hYU1I+vVLhl9q0BN15pQ9mwYUmagXv/5A
        ZJcKqbCs=; b=iLknMg4L+BcxGdXrDTGelwkLRayJdvsOqGDwFXuJVBMYEm7QCuI
        7ZguU02e/35R3Zj/XoKth+C7mZR0UyyXS2RvRv3Gya17C27NUXa6/zv67Lt98VrL
        f/mqVkqZsV5qE5Cg063c4/4kJRKLDko0NFX0PZoHOEeb0x0YaULV7XGSzJIb1bEj
        +fYMBr5VSDeBzGpozRz+YsN1AXuFoQawRqtQzfKHMWUw6gKpIjsI4Xchuz0JUh58
        cIzZbQkVgsLN+E/0EA2H5U81QV7MaYA6huo46vxFvUBe+Vh+vDmuq8QbNxQB666k
        RmKTkUSCbFl9nFgbFN8/GFTBpBboEYFhPOw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ak3gOdm5TcTN for <linux-kernel@vger.kernel.org>;
        Sun, 30 Jan 2022 16:11:47 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jn7lj6DHxz1RvlN;
        Sun, 30 Jan 2022 16:11:45 -0800 (PST)
Message-ID: <b754032c-9a33-4920-f72f-472cd121df8f@opensource.wdc.com>
Date:   Mon, 31 Jan 2022 09:11:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH] ata: pata_platform: Fix a NULL pointer dereference in
 __pata_platform_probe()
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhou Qingyang <zhou1615@umn.edu>, kjlu@umn.edu,
        Alexander Shiyan <shc_work@mail.ru>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220124164525.53068-1-zhou1615@umn.edu>
 <YfPBb4gHDkr76xPT@kroah.com>
 <3621c7db-0b73-d7eb-f987-45ec59a6c738@opensource.wdc.com>
 <YfQSdJgi4x5hN3Ee@kroah.com>
 <45efc552-999b-c57b-5da1-0818893c031d@opensource.wdc.com>
 <YfTnatj5sNOswqFk@kroah.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <YfTnatj5sNOswqFk@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/01/29 16:06, Greg KH wrote:
> On Sat, Jan 29, 2022 at 09:12:19AM +0900, Damien Le Moal wrote:
>> On 1/29/22 00:57, Greg KH wrote:
>>> On Fri, Jan 28, 2022 at 08:50:04PM +0900, Damien Le Moal wrote:
>>>> On 1/28/22 19:11, Greg KH wrote:
>>>>> On Tue, Jan 25, 2022 at 12:45:25AM +0800, Zhou Qingyang wrote:
>>>>>> In __pata_platform_probe(), devm_kzalloc() is assigned to ap->ops and
>>>>>> there is a dereference of it right after that, which could introduce a
>>>>>> NULL pointer dereference bug.
>>>>>>
>>>>>> Fix this by adding a NULL check of ap->ops.
>>>>>>
>>>>>> This bug was found by a static analyzer.
>>>>>>
>>>>>> Builds with 'make allyesconfig' show no new warnings,
>>>>>> and our static analyzer no longer warns about this code.
>>>>>>
>>>>>> Fixes: f3d5e4f18dba ("ata: pata_of_platform: Allow to use 16-bit wide data transfer")
>>>>>> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
>>>>>> ---
>>>>>
>>>>> As stated in the past, please do not make contributions to the Linux
>>>>> kernel until umn.edu has properly resolved its development issues.
>>>>
>>>> Aouch. My apologies. I forgot about this. Thank you for the reminder.
>>>>
>>>>>
>>>>>> The analysis employs differential checking to identify inconsistent 
>>>>>> security operations (e.g., checks or kfrees) between two code paths 
>>>>>> and confirms that the inconsistent operations are not recovered in the
>>>>>> current function or the callers, so they constitute bugs. 
>>>>>>
>>>>>> Note that, as a bug found by static analysis, it can be a false
>>>>>> positive or hard to trigger. Multiple researchers have cross-reviewed
>>>>>> the bug.
>>>>>>
>>>>>>  drivers/ata/pata_platform.c | 2 ++
>>>>>>  1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
>>>>>> index 028329428b75..021ef9cbcbc1 100644
>>>>>> --- a/drivers/ata/pata_platform.c
>>>>>> +++ b/drivers/ata/pata_platform.c
>>>>>> @@ -128,6 +128,8 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
>>>>>>  	ap = host->ports[0];
>>>>>>  
>>>>>>  	ap->ops = devm_kzalloc(dev, sizeof(*ap->ops), GFP_KERNEL);
>>>>>> +	if (ap->ops)
>>>>>> +		return -ENOMEM;
>>>>>
>>>>> This change seems to leak memory.  Damien, please revert it.
>>>>
>>>> I fixed the patch when applying, so there is no leak.
>>>
>>> Really?  What happened to the memory that ata_host_alloc() created above
>>> this call?  How is that freed?
>>>
>>>> This is a genuine (potential) bug fix.
>>>
>>> As I tell others, how can kmalloc() ever fail here, so odd of this being
>>> a real bugfix are so low it's not funny.  So take these types of
>>> cleanups as a last-resort only after you have strongly validated that
>>> they are correct.  The current group of people trying to do these fixes
>>> have a horrible track-record and are getting things wrong way more than
>>> they should be.  And so it is worse having code that "looks" correct vs.
>>> something that is "obviously we need to handle this some day".
>>
>> I completely agree that this is not fixing any real bug reported in the
>> field. And as you say, an error here is more than unlikely. I accepted
>> the patch only on the ground of code correctness.
>>
>>>
>>>> Must I revert ?
>>>
>>> If it's buggy you should, see my above question about ata_host_alloc(),
>>> is there a cleanup path somewhere that I am missing?
>>
>> The resources allocated by ata_host_alloc() are attached to the device
>> (devres and drv_data) so they will be freed by ata_devres_release() when
>> the dev is dropped due to the probe error. I think the return that the
>> patch introduces is fine as is.
>>
>> If I am misunderstanding the devres handling, please let me know.
> 
> Where does the data allocated in ata_host_alloc() on this line:
> 	host = kzalloc(sz, GFP_KERNEL);
> 
> Get attached to a devres structure?
> 
> It's a kref-managed data structure (see the call to kref_init() a few
> lines down), and the memory will be freed if you release the last
> reference on the kref, but that has nothing to do with devres.
> 
> There's also the ports memory attached to the host structure as well,
> that is controlled by the lifetime of the kref, not a devres reference
> that I can see.
> 
> Or am I missing some link somewhere here?

Checking again, the path is not super obvious, but it is there:
ata_devres_release() calls ata_host_put(), which drops the kref on the ata_host
memory and will thus free it when the last ref on the dev is dropped.
ata_host_release() is used for that and this function does free everything,
including the port memory within the ata_host structure.

So in essence, the ata_host and ata_port resources are like devres. I wonder if
actually making them real devres would make the code cleaner and simpler.

I will dig into this more to make sure there is no memory leak. As Sasha pointed
out, it seems that the last ref on the dev is actually never dropped. So there
may be an actual memory leak on error but it was there already.


-- 
Damien Le Moal
Western Digital Research
