Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C8154BE6F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344811AbiFNXoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345892AbiFNXnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:43:47 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21654B1C5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655250225; x=1686786225;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BGwa4gt3lsrX6CmPrlwJtniUfIkDciPU/F/Ed6lDhtM=;
  b=Bw5FNIZ2EqMJNjteZo3wEFw4smB4cljwktix2n1H0fE+PAdHEXBmKDnI
   pRSZBD56YXhJ6EWjEpNwkouxrVlpWLprzHvz7n3hFks1Ta+wFYynrm4ul
   jTbHSSYUT9UyIcpIIgAZ+M7GkoGHoyoXo8Pk/JiAR3Nei+/m15HobRjH1
   P3AEA3GdPjf2BaHiq0N9QZ/WklGDsa7y7fGnklC+0XLWvW3TS6nWHp9ac
   EW/ndKGJms51AatCafgLFaQ3fwtRohzdEa8xaUyUBZbfjUuBrOTZlEkc1
   Zhi5l7dRPL06Txy3/k40jChjU70sDoBFrEPBM3lnqmG+IqvUaByU+wpaY
   g==;
X-IronPort-AV: E=Sophos;i="5.91,300,1647273600"; 
   d="scan'208";a="203166660"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2022 07:43:43 +0800
IronPort-SDR: P2WDHJL+4V/ql7z246Pd5WpjIwiObQgoMoa8wuqzKlP8lJ73uip6vOp5sDIbILr5qGzRdjWGBd
 39MjWkfXV/Od0J2g1XZau5v/m3u3MFxmL9E9fGkVFiC9EbzKujIFCJ+vmBJ9da9c8k/I8+AK4U
 0ul3qfFO2C7+lwv86IaHaGEZyqwIDHdGQOQsSvohQsoC0GBMIYhaCv9YwPoWeEyyYmAtYkmGCB
 BB8oJBKXiuVHfaJEFRHE6K4dqEgPcjiRDUTZ0KCSrzCxQfa+oP5AU+kUKAAGb3mB4sCCm0rEC9
 3PO7LVAAP2hmkUQutjej0BZQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 16:02:19 -0700
IronPort-SDR: 8uDc2INJSTCKe/qvBFBl/nD7CEoVwqXT9UJsYEXPOHowSHobe5Drg6nowJ4WV+ITzKg4llEzer
 ggHiRGWFSBM8W7QoVRQSNYvki9ckObUuvyByCeOhhw4amiEUkSEg6mzYTwk9wyTdgIfaNrODZT
 wscGJ20h7rOZpKKtUd86xFahQYgVHWhN+y2TbDUjHb8wlVVoiWL7xZnkMaXaWrzmjIPZhcBCjS
 kZx96GBArNfE72n+kunNgppuRqFu9eRpJUkKy/PbxcAvK0DSo7wTHHbr3L426rpdipOpXVJfjf
 9zg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 16:43:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LN4l35qYkz1SVp8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:43:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655250223; x=1657842224; bh=BGwa4gt3lsrX6CmPrlwJtniUfIkDciPU/F/
        Ed6lDhtM=; b=OkGVH4FCLA92mLoNpUkCBUX+TI5SgnG6FXXGNhqotYEwl8NGoVA
        WbeUTp37w0LuwxBWJx4HUiloGLisn4DroOSw/dufIv4nLykk6F3nvwLYA3qWMnnK
        G2GwviFTrTjGmDIQyPMktq2iypx4DXa95BpFdchan611KQSDTdE7UBbAJdlxBcsD
        Kdh7ZHr7vZpAsGgt3n8q/LUEX6L68oWslEDnMSPeugC2BtyHu79NqQtRqG13e91m
        Uuidp+27MZ5mArLeIMyeQjvSWZMhAjVRYzxyF/pqhIF4iDsbhrjWE7GW6s0Vm6GY
        MBWaniTTQzZLlaF+a9IKVMRq5I1MmGZAcgg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oYYLHfBr74ly for <linux-kernel@vger.kernel.org>;
        Tue, 14 Jun 2022 16:43:43 -0700 (PDT)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LN4l057nKz1Rvlc;
        Tue, 14 Jun 2022 16:43:40 -0700 (PDT)
Message-ID: <e36bba7e-d78d-27b4-a0e2-9d921bc82f5d@opensource.wdc.com>
Date:   Wed, 15 Jun 2022 08:43:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC v2 03/18] scsi: core: Implement reserved command
 handling
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        hare@suse.de, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-4-git-send-email-john.garry@huawei.com>
 <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com>
 <9e89360d-3325-92af-0436-b34df748f3e2@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <9e89360d-3325-92af-0436-b34df748f3e2@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 03:20, Bart Van Assche wrote:
> On 6/13/22 00:01, Damien Le Moal wrote:
>> On 6/9/22 19:29, John Garry wrote:
>>> +	/*
>>> +	 * This determines how many commands the HBA will set aside
>>> +	 * for internal commands. This number will be added to
>>> +	 * @can_queue to calcumate the maximum number of simultaneous
>>
>> s/calcumate/calculate
>>
>> But this is weird. For SATA, can_queue is 32. Having reserved commands,
>> that number needs to stay the same. We cannot have more than 32 tags.
>> I think keeping can_queue as the max queue depth with at most
>> nr_reserved_cmds tags reserved is better.
>>
>>> +	 * commands sent to the host.
>>> +	 */
>>> +	int nr_reserved_cmds;
> 
> +1 for Damien's request. I also prefer to keep can_queue as the maximum
> queue depth, whether or not nr_reserved_cmds has been set.

For non SATA drives, I still think that is a good idea. However, for SATA,
we always have the internal tag command that is special. With John's
change, it would have to be reserved but that means we are down to 31 max
QD, so going backward several years... That internal tag for ATA does not
need to be reserved since this command is always used when the drive is
idle and no other NCQ commands are on-going.

So the solution to all this is a likely a little more complicated if we
want to keep ATA max QD to 32.

> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research
