Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C5854DD0E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359705AbiFPIle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359695AbiFPIla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:41:30 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF0F5DA45
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 01:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655368889; x=1686904889;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q0nV+Y6VnyjEkRNkFfq754W33G/B/8foeyIm/WzodEc=;
  b=Yogodyi7KNgyIJjJrsyrhbQfEqcj+0c5I0AmlaLSapbr48V+2bqAsb/K
   C0n87GIbZOGf1gLFRmhiNU/7qdLO5x5WmvVy2NMnWBmuuB/D2skUoWrO7
   rlaSn4TKQwlKJtB45sPIP8FzCVIKfvDo715K+ZS7GSMJM2taMWCYNDLUy
   IXxyQyO8UQXC749HDd5pPictAu+sCj3qCT9vz/9+0tayWqk5VzeO5VyOz
   yfFHPsRAppNoBMNNBYSYugG43d/IxA3RWLvwEzOFCjNX7kRUwls1AVEgt
   X9MfwZRgltwWVixjRoGSWxIYHARQKuk+p0JzClo+wLC77m2n4t/IV8tay
   w==;
X-IronPort-AV: E=Sophos;i="5.91,304,1647273600"; 
   d="scan'208";a="307610373"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2022 16:41:27 +0800
IronPort-SDR: KkE3X+wqxNPJJYIW+aOtvxwr5e9yUtTsPQ+6kb1CmmULLN/VNzTCY+8UJMfmo/De4HvJqSBGfm
 GZG9aNYR5AVuDOHPAPZly5n3J6GJdmqntLjbO2agutUFkucfQx4dJeLtt3joWH/IBrRZf8pKhH
 UlYKdRyQkQM5HOawB9n0SCKqLVDdZX4Oe0kQQaH6YffEJuEJxKILMMH6dKZR0VhOhZFe8nnNCC
 7aTg0zXaOWhBNBeB+BWHkQpLlUmDsYcinZunwzgtLiVioRXC6vVS/aoZrhZlgyjMiSKCBPn7pL
 R8ZUCyo9EjSKPHYHxoiZXau2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 01:04:03 -0700
IronPort-SDR: UyddNqGWL7tyvheLYVlP0Gewmi/ERd3w+rdm9GNB7PZ3DUvB24V+H/wHkDTcwabFghve9ny9VH
 FN2pdCCWuhizQw567b5HhjHYTWEJ8aY0yMx3S8A7wmExRNKJaDxWRUTir5y8RWd11oYOkRKOK5
 TOQja7Xi3Pn95mFDGEJUXaPnAlBniJU+81KYbQ2wih/oif6hWpS646sGXNVKHqweLqmVYIE/7C
 Aly67XGF3x8BtAZSMBPPEt3pSrW15fmqjEyx8fh/aOcmzAqshIYsb5b6+y0IokNiy4oTiStn4C
 eQM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 01:41:27 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNwd23y1Nz1SHwl
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 01:41:26 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655368885; x=1657960886; bh=q0nV+Y6VnyjEkRNkFfq754W33G/B/8foeyI
        m/WzodEc=; b=lY2eNfwJepGYRRIkNfUhDQNf2aTX2nUbwF6BrJipPQ9yPTzMexN
        yJM+8bSHjUqGz9M6S9zi1R/EpGFwQ2oTpxi0zmUGxM/1OTCR0XDxJagn3rbAIQaK
        H/OoEJT2aeE33MlJEu2ZOgNobrdvsL8rPqkXBnd9t4mCdpmAYbeMmSRd5asXRp5i
        Ammxbmw055cUDp9a8K7e7esVWgx4k98tjKYBvFVbW/0BeXkao8AYTOHuV2AncjS6
        jyKA/cOQah/OPBC3Xf0uCux4EG16CBabME9+5FRIHEVO2P5t+No3UQI0NOKOAX53
        EdOHS5o/AloU8ZwV+w+HsqtEHWRzdz0USZA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id x1SKb50lHbee for <linux-kernel@vger.kernel.org>;
        Thu, 16 Jun 2022 01:41:25 -0700 (PDT)
Received: from [10.89.84.185] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.84.185])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNwcz1dffz1Rvlc;
        Thu, 16 Jun 2022 01:41:23 -0700 (PDT)
Message-ID: <98fa010d-3555-a82b-e960-f47aeeb38151@opensource.wdc.com>
Date:   Thu, 16 Jun 2022 17:41:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH RFC v2 03/18] scsi: core: Implement reserved command
 handling
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        hare@suse.de, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-4-git-send-email-john.garry@huawei.com>
 <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com>
 <9e89360d-3325-92af-0436-b34df748f3e2@acm.org>
 <e36bba7e-d78d-27b4-a0e2-9d921bc82f5d@opensource.wdc.com>
 <3a27b6ff-e495-8f11-6925-1487c9d14fa9@huawei.com>
 <c702f06e-b7da-92be-3c4f-5dd405600235@opensource.wdc.com>
 <ecfb0694-21b8-55b4-c9b8-5e738f59ce8d@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ecfb0694-21b8-55b4-c9b8-5e738f59ce8d@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/06/16 17:24, John Garry wrote:
> On 16/06/2022 03:47, Damien Le Moal wrote:
>>>> so going backward several years... That internal tag for ATA does not
>>>> need to be reserved since this command is always used when the drive is
>>>> idle and no other NCQ commands are on-going.
>>>
>>> So do you mean that ATA_TAG_INTERNAL qc is used for other commands 
>>> apart from internal commands?
>>
>> No. It is used only for internal commands. What I meant to say is that 
>> currently, internal commands are issued only on device scan, device 
>> revalidate and error handling. All of these phases are done with the 
>> device under EH with the issuing path stopped and all commands 
>> completed, 
> 
> If I want to allocate a request for an ATA internal command then could I 
> use 1x from the regular tags? I didn't think that this was possible as I 
> thought that all tags may be outstanding when EH kicks in. I need to 
> double check it.

When EH kicks in, the drive is in error mode and all commands are back to the
host. From there, you need to get the drive out of error mode with read log 10h
and then internal commands can be issued if needed. Then the aborted commands
that are not in error are restarted.

For the non-error case (revalidate), ap->ops->qc_defer() will make sure that NCQ
and non-NCQ commands are never mixed. Since all internal commands are non-ncq,
when an internal command is issued, there are necessarily no other commands
ongoing, but 32 NCQ commands may be waiting, without any free tag. The internal
command being non-NCQ can still proceed since it does not need a real device tag.

The joy of ATA...

> Even if it were true, not using a reserved tag for ATA internal command 
> makes things more tricky as this command requires special handling for 
> scsi blk_mq_ops and there is no easy way to identify the command as 
> reserved (to know special handling is required).

Yes. Having the ATA_TAG_INTERNAL tag as a reserved tag is fine. But from the
above, you can see that this is not really needed at all to make things work.
The management of ATA_TAG_INTERNAL as a reserve tag is really about getting your
API to simplify the code.

What I am thinking is that with your patches as is, it seems that we can never
actually reserve a real tag for ATA to do internal NCQ commands... We do not
really need that for now though, apart maybe for speeding up device revalidate.
Everytime that one runs, one can see a big spike in read/write IO latencies
because of the queue drain it causes.

And for CDL 0xD policy error handling, I may need a reserved NCQ tag... Still
trying to work out qc/tag reuse for now though.

> 
>> so no regular commands can be issued. Only internal ones, non 
>> NCQ, using the ATA_TAG_INTERNAL. So strictly speaking, we should not 
>> need to reserve that internal tag at all.
>>
> 
> Thanks,
> John
> 


-- 
Damien Le Moal
Western Digital Research
