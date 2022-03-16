Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0370B4DA8E2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 04:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353139AbiCPD0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 23:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244144AbiCPD0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 23:26:46 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721775EDD5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 20:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647401131; x=1678937131;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L+GnZzY8M0I/XRz/k9rzvsh5D6u1YS3DpH4vtLZOaiI=;
  b=Y8z65EOBjtJKrB+Oi1Dp3+fSuxdOTKsSi0MxywuTq4bqoATHfBoq+Qyy
   3wYuvFAtUa/L2R6rJRnkTmwbYlAqON7lCJ5tXVQUs2J1GmDV0pT2GgKL0
   /n4MOoMgSWqPF6/BHAPOudXBz9M3/AMaiYU4hMNZsrXsyOYTM/BnTgypD
   GSH/4LBF9wT65YbEhXKCibZbucS/YXTELIcYkTV6iF4w6UDxt2Mf3fRk6
   9abmY66MebZvKpdu81MAArAh8WvwtetQECbzAVMt4qUdVq+dJZp8ypg/O
   qRD6XxSUNe/VK91uE3W+3zL3ana6MDcMnGY+z79xXalm6LRUO2/pEWUWb
   g==;
X-IronPort-AV: E=Sophos;i="5.90,185,1643644800"; 
   d="scan'208";a="200308294"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 11:25:29 +0800
IronPort-SDR: A0sWm8HV4+zzb5y4rixzdI1P5ZHtGQgnhHG9uG87V2mzCCcO4/UDQfAaZb5JGxhgk1vaPRyCHm
 V8yQ9npBE2XyuswKrfuHGRgVlVWro9hJe+md3YaTZh5udgRNoZb9IjzehqHkqkoudL5+GZorql
 iEZStJW8BjaIwZVK+UUjr8hGP3PzZ4xBoj7eMy/8XhHmxBKeYOuu6H5jkLTyMVVCmZsxy40sCG
 0hSLEoICp+0DrUom2KrBNl6UixwySot8ZTvlFQmJklYDLgCbvfjxbrgYoB9mOL74mAN0Pqkhdd
 vsOsM6NAX8Bdhy6BrbpM0tyP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 19:57:35 -0700
IronPort-SDR: yXk9F8rGb3w72AzITIWpEz38XWzQIr5G0N5NCDok/nXzAgPueEjr34EueuzKr+7/H6Pj232Kdm
 LgV6xWl/5Pbv5spB1Rlz49f7Gh/Z/JCZ0K89OQqlNjWjog9u1ODU3t6xt/E4Nf85KZyVdXSWQQ
 6qTBSVE0k/Wq2PxoxBZR33u4hGp66bTHspLuVIry6mFsfYrcG7UfBVF39cnZoumjs537z/DiUd
 NCksHu2QiO5R2nCKd+/ofMr591vPk8vvyGCfUeY3kSrvgbivuAfk2KxiSuIPlkZsGTvr1bJqc4
 Yg8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 20:25:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KJFyy1Td0z1SVp6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 20:25:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647401129; x=1649993130; bh=L+GnZzY8M0I/XRz/k9rzvsh5D6u1YS3DpH4
        vtLZOaiI=; b=a6NP6rfIbYKzzCdD1KCkb1ko1cxXGtEsXBSKDXag/ihDMR6kKkB
        9KrODKR34lwODKPtD+QyqndXHqPKD2pVjATqX5Hk7gMdrbX6kkZPoPeQv8QrUFFe
        m7a/w5hqhz4l84CWpO8qMdSbpJy6wiK/P0PHVGeeot3T+vnW0bcr6QJdHxkUY3kY
        Q4Zcs8i4CryFHIPwSTENzlOwk9pveuWkfEkii3EUJ3uVQGihT2/PZne7JWQZOodj
        7hIamjK/t6e9WdUJ5KG5cmdUS1a5ySU0eTSxH6CnGf9eGBTHvGHEWFXMnDegDVhD
        MVb/yMSTiX7uJAMCexghRZa85mDAS37rCBA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CG45mOyLgSBg for <linux-kernel@vger.kernel.org>;
        Tue, 15 Mar 2022 20:25:29 -0700 (PDT)
Received: from [10.225.163.101] (unknown [10.225.163.101])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KJFyv5Vlhz1Rvlx;
        Tue, 15 Mar 2022 20:25:27 -0700 (PDT)
Message-ID: <b77e681d-d180-7434-1675-1fcb10ef4abf@opensource.wdc.com>
Date:   Wed, 16 Mar 2022 12:25:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 0/2] scsi/libata: A potential tagging fix and improvement
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, bvanassche@acm.org,
        ming.lei@redhat.com, hch@lst.de, hare@suse.de
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.wilck@suse.com
References: <1647340746-17600-1-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1647340746-17600-1-git-send-email-john.garry@huawei.com>
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

On 3/15/22 19:39, John Garry wrote:
> Two loosely related patches are included:
> 
> - Fix for scsi_realloc_sdev_budget_map(). I noticed that the budget token
>   for scsi commands was way in excess of the device queue depth, so I
>   think we need to fix the sbitmap depth. I need to test this more.
> 
> - libata change to use scsi command budget token for qc tag for SAS host.
>   I marked this as RFC as for SAS hosts I don't see anything which
>   guarantees that the budget size is <= 32 always.
>   For libsas hosts we resize the device depth to 32 in the slave configure
>   callback, but this seems an unreliable approach since not all hosts may
>   call this.
>   In addition, I am worried that even if we resize the device depth
>   properly in the slave config callback, we may still try to alloc qc tag
>   prior to this - in lun scan, for example.
>   So we need a way to guarantee that the device queue depth is <= 32
>   always, which I would be open to suggestions for.
> 
> John Garry (2):
>   scsi: core: Fix sbitmap depth in scsi_realloc_sdev_budget_map()
>   libata: Use scsi cmnd budget token for qc tag for SAS host
> 
>  drivers/ata/libata-core.c |  5 +++--
>  drivers/ata/libata-sata.c | 21 ++++-----------------
>  drivers/ata/libata-scsi.c |  2 +-
>  drivers/ata/libata.h      |  4 ++--
>  drivers/scsi/scsi_scan.c  |  5 +++++
>  include/linux/libata.h    |  1 -
>  6 files changed, 15 insertions(+), 23 deletions(-)
> 

I tested this and it is working fine for me. This actually solves the QD
not changing problem I had detected with the pm80xx driver.
Now, doing this:

# cat /sys/block/sde/device/queue_depth
32
# echo 16 > /sys/block/sde/device/queue_depth
# cat /sys/block/sde/device/queue_depth
16

is working as expected.

See my comments on patch 2 for getting final ack and tested tags :)

-- 
Damien Le Moal
Western Digital Research
