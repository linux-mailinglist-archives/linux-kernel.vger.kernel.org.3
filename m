Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79FF4DBAF3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbiCPXYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343572AbiCPXYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:24:24 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454AC65B4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 16:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647472989; x=1679008989;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YG3c9enGf73FZQYfT2r6IIW+DLqVkhyrPxUwVJug/IQ=;
  b=EW1e6JhGdH+gt1ahwHGvTBRAVUD9KWrjkOa/MTAw7X4xnh0Wrjf7V9WH
   hFy7f4BGWOWjmQCNBRei73F+RP1Xk6x8gcoiBYmmuECqxEohN8uynHENS
   M5DjtCVwlgSugITT6g2caGxX+v4Ye1YPQbopM078OyyNPccqp5H2gZmE4
   EugnOCznm0bfWvDBddnIlDJfFBLYT6dRJdAoaqUPCPEswBIhS1nJcNzlu
   y1VBJ0bQHYmEjUrV9tNlgg7H0LmUQDZb17gu3WcKhelDaIb1eKvTVccJs
   Voy0danfk3+x0qsLThHYme25oWZqZFdnlzLMB6Vtq6E2GRMHmkiFduBdb
   w==;
X-IronPort-AV: E=Sophos;i="5.90,187,1643644800"; 
   d="scan'208";a="194466687"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2022 07:23:07 +0800
IronPort-SDR: hbIdOk3vU4FPpo3fQhQ1kONk0mOKX6eMH7WC9iRweOltebpXYYZSDwz9XzQVU5jThQy+2czU8O
 UXF62fW44OLDS/Vd51MqtZmEjNliX53hbpJg/rjXdKVKVQqnb4nbyfatDkVo1JDtSwJaeCXSI1
 xGGaCH6FJ2a6xebTq/wQLDmImuM2oX8okS8kE4Esbn02oavTPv+Zaf/RyxCzTX4HRGLsN1zrtx
 T0uE8ieZbbPs7sTSWAbQYeELj+0V4lnSxGwt9UOgL4EfI+6XlwkaHfSYAKX/SgyUqWeriECoou
 S/77slVith/UqZ0pePD+POhC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 15:54:13 -0700
IronPort-SDR: kamlRWwlZXu3IeeJikqoJsCsfT4BmoJWwBS932xBtha4MjerxxpBz+gkmKSc8sfRFmuqJxt7+u
 b+nkw1poQo57kadrnrrW2O3MLZE8p2GkEuv2AGaODGU2H9PJJtwv+Gnz+//6T/kvMVsPaR4wqG
 YcRIrilw1bXCv41w8WVHaI4NGR7Pb/P6laf0+zPiJl5aVnc9Bb/HYn2gtRWzcZLsMwEaTYaUsE
 vuQQt4+RTjaevBN9xSEHD6EtrBw6p6Ihd1kBZySV+NVYpnD4zRS8zM3IIs6Fz5p9Q1z25tcZBO
 fLo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 16:23:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KJmXq4PrLz1SVp5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 16:23:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647472986; x=1650064987; bh=YG3c9enGf73FZQYfT2r6IIW+DLqVkhyrPxU
        wVJug/IQ=; b=ZlcFFOQcJwkYtdSKzLDONIb2R/8b/na7A+bzhx2GgA5SDvB/32c
        W3MDmSMa/WPnB99MS3E1rylqGWPLP1zOl6AnqutB5uKozKsB4PmK2QNbGPcRF3Ne
        VWaa5kPeuuTkmecfDDpAYrVMwCHAIINOokN6PGxDb1+HuyD1Pzodt5wlyLmRi6+v
        zC79Vpvs1jEVY/NM+9ApnR3tamSuJf1Eo7T9pd8ibyFhW+akqTRpdS2FjvVKKUdv
        twzp+zrY/IWyri/yAc+DmYYqIU+POmlNaRym8nAiFfJKXewULvxLpHsX514orlaE
        blxs+zkHba7Gr9YGe8TqBYT7QvhOGG3TsWg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Q0j1p7noCbPp for <linux-kernel@vger.kernel.org>;
        Wed, 16 Mar 2022 16:23:06 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KJmXn10xpz1Rvlx;
        Wed, 16 Mar 2022 16:23:04 -0700 (PDT)
Message-ID: <c44014e6-37ca-8a6b-3e8a-5d659bbe1f1d@opensource.wdc.com>
Date:   Thu, 17 Mar 2022 08:23:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH RFC 2/2] libata: Use scsi cmnd budget token for qc tag for
 SAS host
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, Christoph Hellwig <hch@lst.de>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, bvanassche@acm.org,
        ming.lei@redhat.com, hare@suse.de, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.wilck@suse.com
References: <1647340746-17600-1-git-send-email-john.garry@huawei.com>
 <1647340746-17600-3-git-send-email-john.garry@huawei.com>
 <99541f2d-2aea-6bd7-e3b6-21dbc355875d@opensource.wdc.com>
 <650c667f-ca55-821d-4e0f-29fce69a68fc@huawei.com>
 <20220316083439.GA6701@lst.de>
 <4dfcddff-7736-e01e-7fcf-804de77ac623@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <4dfcddff-7736-e01e-7fcf-804de77ac623@huawei.com>
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

On 3/16/22 19:46, John Garry wrote:
> On 16/03/2022 08:34, Christoph Hellwig wrote:
>> In addition to the comments from Damien:  I think we should kill
>> ata_qc_new_init as well.  It is a bit pointless and having it in
>> libata-core.c when it pokes into scsi internals also doesn't make sense.
>>
>> So maybe something like:
> 
> Seems reasonable to me at least.

Yep, that will be a nice cleanup.

> 
> But I'd send these as 2x separate patches.
> 
>>    *	sata_async_notification - SATA async notification handler
>>    *	@ap: ATA port where async notification is received
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index ed8be585a98f7c..5e0bc7b05a107e 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -638,24 +638,44 @@ EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
>>   static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
>>   					      struct scsi_cmnd *cmd)
>>   {
> ...
> 
>>   
>> -		if (scsi_cmd_to_rq(cmd)->rq_flags & RQF_QUIET)
>> -			qc->flags |= ATA_QCFLAG_QUIET;
>> +	if (ap->flags & ATA_FLAG_SAS_HOST) {
>> +		/* XXX: add a comment here why SAS is different */
> 
> I think this is simply because SAS hosts have shost.can_queue > 32
> 
>> +		if (WARN_ON_ONCE(cmd->budget_token >= ATA_MAX_QUEUE))
>> +			goto fail;
>> +		tag = cmd->budget_token;
> 
> thanks,
> John


-- 
Damien Le Moal
Western Digital Research
