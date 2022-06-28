Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D908055CA0E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344086AbiF1JOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344088AbiF1JOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:14:33 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15DD120B3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656407672; x=1687943672;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m7ZvDnvdd5GvaUmk2CDtIh9qIt0xOE1YKhnPo7clhXk=;
  b=pEdfKLMZ/m0Rtqr1DBaKi1JebCkMoXyOYwBadxXpARPRUEuX7ykBp+m9
   c0t5GlV1W5vHGRqhmKBZEbmzKjbGU31rjZZSXD3cm8S5MWsauogiChEkc
   7wZ4EIJci/wDZTMBJBOZm0/g3K8+R3LI5ju39gbgjzW3Oe8CawgVtPp4q
   jasLs69SrURed2mJ1uWH7g1QNIbWceTMFNkfunmnllMT5EA1KTCkrKXHw
   RwalAeqSeV93PvQ2vlDmClV9jOtcgyV28jGtw80CpZpmsvkoFAUeJRAGU
   vhX76gJXeBmKgj9MpdImjGWcz5XSRPp9n7SViVIbralVaew2cv5podQKQ
   w==;
X-IronPort-AV: E=Sophos;i="5.92,227,1650902400"; 
   d="scan'208";a="202954162"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2022 17:14:30 +0800
IronPort-SDR: Af3MGvAApKtxwOhyv8Zy7EeLZkxH+QOad7BxnyylGS4VGF1HeIbvjtSTcbdgdjXaG2Lh6hXzgs
 U9+fQUnLQjMWyLRgIY9sNI4BULRq/p6sF1G3XmG8wtgep4XSUFlUDQjZ+hZMeyvRgILnhJs+bH
 9eEFKvKnB9ZGm8Ty+rSN+TuFkt5N3Y2wz7vKrvNgCWSmxP1RCuLnSKfh6u7afYKtDz+SzFuCY+
 3UCXfEy3nF1VKXP0Mr6It0K0QDCNPW6E1CRwXAiCvZQbKlKHGvNzmv/8nbMW0xnpZHcbhtELlS
 qV32qI10vTvb6hBWvhDjzA86
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 01:32:11 -0700
IronPort-SDR: ggxvr5zFN8GVH1x5teq5WErLuSDSBSEdW1dgBSufj0K+Ycq3I6S9l4Vqv/MbmQNn7Wkgy7IVPF
 IzpMxlFFwHGG5N3ym7KSsLkMpJTLEz2Eov/w3rOaSmHOOFBDRq0wlcLX7Z1xgY41IUCDzCtXVp
 DD9omeFyAHFH0lZUG4BZJ999Y6FRwco2CmlQsVsEWLIHrJm7n01lOzke5tpByMCO1oQ8zbElqb
 2scMGcgFIjxZcl6u5WEb5S9426Kb8W6zJYeyFpVRVo6pYFpT/TsoeaqgxQrr1N+cTu9oHZ7hIk
 orI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 02:14:30 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXJnd5LR4z1Rws4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:14:29 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656407669; x=1658999670; bh=m7ZvDnvdd5GvaUmk2CDtIh9qIt0xOE1YKhn
        Po7clhXk=; b=n1Hpc6gcPs/kxiOVTQwyRGR+uFdty2ur8mMpVtR58Kwy2fqXmbI
        HTEscATaBiYXrvQoDsewN6VCSm9M5MIlpqKcq/8hTcw3cjPO33agP8Xd57Tj6DFz
        4R0ljR0v+eB5w4pbvmsQ5m12TQNrFyNz/lIFaUH0ktaZyNqS0r6+dYb80iSY2vIS
        eAjGfzucNGjkx5UDxGIgv1ZF4t8Y8uxziilTeI0bERjb3d5G2iyT+xB/TWonmtz9
        zODt5GChELx+M4SuiD3Cm4Kcm8I7M51ZXMYbgEjMRtCnihX/D9URy755F6CYUCq9
        +ysvrOnAro+PSPbYDdtqx2RasqndSuvPycw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0bCYHYgaYVOA for <linux-kernel@vger.kernel.org>;
        Tue, 28 Jun 2022 02:14:29 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXJnZ4JQfz1RtVk;
        Tue, 28 Jun 2022 02:14:26 -0700 (PDT)
Message-ID: <ba59a0da-a982-e3eb-1cb7-6e60f80fd319@opensource.wdc.com>
Date:   Tue, 28 Jun 2022 18:14:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 5/5] libata-scsi: Cap ata_device->max_sectors according
 to shost->max_sectors
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
        iommu@lists.linux.dev, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
References: <1656343521-62897-1-git-send-email-john.garry@huawei.com>
 <1656343521-62897-6-git-send-email-john.garry@huawei.com>
 <b69c6112-98b7-3890-9d11-bb321a7c877a@opensource.wdc.com>
 <6619638c-52e8-cb67-c56c-9c9d38c18161@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <6619638c-52e8-cb67-c56c-9c9d38c18161@huawei.com>
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

On 6/28/22 16:54, John Garry wrote:
> On 28/06/2022 00:24, Damien Le Moal wrote:
>> On 6/28/22 00:25, John Garry wrote:
>>> ATA devices (struct ata_device) have a max_sectors field which is
>>> configured internally in libata. This is then used to (re)configure the
>>> associated sdev request queue max_sectors value from how it is earlier set
>>> in __scsi_init_queue(). In __scsi_init_queue() the max_sectors value is set
>>> according to shost limits, which includes host DMA mapping limits.
>>>
>>> Cap the ata_device max_sectors according to shost->max_sectors to respect
>>> this shost limit.
>>>
>>> Signed-off-by: John Garry<john.garry@huawei.com>
>>> Acked-by: Damien Le Moal<damien.lemoal@opensource.wdc.com>
>> Nit: please change the patch title to "ata: libata-scsi: Cap ..."
>>
> 
> ok, but it's going to be an even longer title :)
> 
> BTW, this patch has no real dependency on the rest of the series, so 
> could be taken separately if you prefer.

Sure, you can send it separately. Adding it through the scsi tree is fine too.

> 
> Thanks,
> John


-- 
Damien Le Moal
Western Digital Research
