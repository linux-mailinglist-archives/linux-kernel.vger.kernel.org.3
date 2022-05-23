Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6BA530AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiEWHeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiEWHdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:33:20 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFF0BCA0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653291195; x=1684827195;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LJ8/2FSDHURz0Zuhe/Qx3SaImInSLYq6abN68q4sCnc=;
  b=aL4u6Jd2Ijq1Zc4sSmYOdw3jeMsXmkOMdbVvnQf4i5olBXBcxt1HBq/f
   lg+nBQyfY+PzWsXiXSpk8Tu0geSW86v5Mmoc0af5vRVtV8Kwee69OPJ+h
   myAtHUJXfhotgw/UPp8i2FLl6cNCjgxPM/K2hUuRhlLznw5SDxk66OACS
   F6jQULhuBFV5cELBVrmfDvPUrPBUGq+tsafdq4DEVlwpK0pG1W7p9COA/
   /PZlYAzQyW28fXdYh1CtSnzcEKdQbjKEdb6JV0rfFZAWH9VhRoQSwpgxO
   /FD7acJ2sty2RTzMiMXh7TeZX89mRHVPtOC3V+Bt4dlI7thJ5aUqquYWd
   A==;
X-IronPort-AV: E=Sophos;i="5.91,245,1647273600"; 
   d="scan'208";a="199924557"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2022 15:33:12 +0800
IronPort-SDR: 6jwjYYfHkZII1kr8hQJLT6yLj15J7NxEsd8LcaCg5QVW81QeIMm9ufm1hTmPP8qO8+2DNsR6LK
 Bg0eRvpy+OzQ8O7dzrORdHQjMXIDCNiJqQgIkeOyIiQSz8cemozRgah7PxNCwv+LpJoSwBGBOQ
 xzLSnLuXv0CB2Zbyr+jjS1B/xPkbq7OVeILmqH+R7fM2oS48ksxz4UQMwBFSEBnBmx4LNb4VKe
 wWeQcqLBnxksTrSgajGHTmH0tiFVliwXpVrwv2fm70dwPSmhPNB2aSOq8x4I/EUoGVQxX1bxOB
 LskauPR/MvFpihntudyOSVIK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2022 23:52:46 -0700
IronPort-SDR: /Ye3luVd0VJ9n5PobFSZAuGDUChofHlRGhBNB/T4z2AkvMVSuujVwYgWpQbxVngfDZXOqQ+5YF
 NR/TJyyPdgOoBsZhg6tHYmMnhTZgG4fjsE9D9VL7bijjvK3mRIxeLG5JO6TpwSy+VV7ainFyYO
 1hvE9pQ8HKcx9186Jhb9nNSIwkFPNQ+3PG36XJkNlo3FN50APWQ+4Cep6p3QYw6cNb6wA4qJsL
 Rhlfflz4lmru1v35hdpsP5/9TS5m61LzlBNOB0os9HU7Dg6ejwFqKa04Dha8O+L5gKz08abWmQ
 jRc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 May 2022 00:33:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L68FM5xzqz1Rvlx
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:33:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653291190; x=1655883191; bh=LJ8/2FSDHURz0Zuhe/Qx3SaImInSLYq6abN
        68q4sCnc=; b=fbzRa9DHE20CwXRkfGCjdgl4Zx6hwQ1fI7gSJy9Vj9vrbyA+aoA
        Rw4pr+X1sm88OhK0n/MDZUOKzRM6+1XUPow3v38BNiuuWUVEjPBAs9JimtP0J1oa
        5enJzvjcWir1XMEjtGp0JTqRmXwbjRULL5fIoXkiLjsspkVa4jgTQ05LmTmyHnhR
        tAowXU1Vzw58oSBt7G62IYzQ0lpP7zWaJj51+rCw1WCpuu18fMc5yugLgsQ/CeJU
        id9aSljXegV2ggC4TO5fIgUiEHK+NcWIdCLYtpiMwg5m/PynMdAGy7CWYAxCpc+z
        CjoJdVpQWLUB4jwo/6+Bk7Cb0jybiv+eikw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fGUnr3Q80lLK for <linux-kernel@vger.kernel.org>;
        Mon, 23 May 2022 00:33:10 -0700 (PDT)
Received: from [10.89.85.73] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.73])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L68FJ4nptz1Rvlc;
        Mon, 23 May 2022 00:33:08 -0700 (PDT)
Message-ID: <6175fe49-f3e2-bfcb-2b97-b58763f1cf0e@opensource.wdc.com>
Date:   Mon, 23 May 2022 16:33:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 3/4] scsi: core: Cap shost max_sectors according to DMA
 optimum mapping limits
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, liyihang6@hisilicon.com,
        chenxiang66@hisilicon.com, thunder.leizhen@huawei.com
References: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
 <1653035003-70312-4-git-send-email-john.garry@huawei.com>
 <e65e7329-67e3-016f-e213-86e51b8021d6@opensource.wdc.com>
 <d5a31b82-4134-a7fb-1a51-446e32db2fd0@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d5a31b82-4134-a7fb-1a51-446e32db2fd0@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/23 15:53, John Garry wrote:
> On 21/05/2022 00:30, Damien Le Moal wrote:
>>> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
>>> index f69b77cbf538..a3ae6345473b 100644
>>> --- a/drivers/scsi/hosts.c
>>> +++ b/drivers/scsi/hosts.c
>>> @@ -225,6 +225,11 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
>>>   	shost->cmd_per_lun = min_t(int, shost->cmd_per_lun,
>>>   				   shost->can_queue);
>>>   
> 
> Hi Damien,
> 
>>> +	if (dma_dev->dma_mask) {
>>> +		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
>>> +				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
>>> +	}
>> Nit: you could drop the curly brackets here.
> 
> Some people prefer this style - multi-line statements have curly 
> brackets, while single-line statements conform to the official coding 
> style (and don't use brackets).

OK.

> 
> I'll just stick with what we have unless there is a consensus to change.
> 
> Thanks,
> John
> 
>>
>>> +
>>>   	error = scsi_init_sense_cache(shost);
>>>   	if (error)
>>>   		goto fail;
> 


-- 
Damien Le Moal
Western Digital Research
