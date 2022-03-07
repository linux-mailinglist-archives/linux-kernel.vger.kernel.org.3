Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112BB4CEFC6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 03:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbiCGCs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 21:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiCGCsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 21:48:25 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99B72646
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 18:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646621250; x=1678157250;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S3CNHgFgY3oCg1DWvQns4vK6LhLi6oQDlgq0N5RP9R8=;
  b=f8O9lD0AWZPIT1WQt5cxStz/3QL7+IOqOEM6+Zgik4hMsAOhcC8rBnMa
   5WTRecinqIyhea3f0LQtpZfNsyUuNT1Pj6tXGnxO78zWUpaaMZ2ddCy/n
   VvSUNPoQNYsYXtUovrfBlewJEXZ22Ejg1/wH0wAQlE6CXM7bGKUrEMlBn
   yWepmBnKn0D4HlUPzNsNCw+VOH4iAwP/FI9SJ8uy8UsgLSUrMscsMMkxb
   /A9J0NojEEJLxO595aiCTVLqJjR/BEvZZqZGKgv055ThRjOnJFdPie0Fs
   bGRzdxjHDyWvMJ8o25V8Cs8AeUu3Swo55bZzKTlezcD0kwKtbK6ZKynHK
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,160,1643644800"; 
   d="scan'208";a="193559015"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 10:47:29 +0800
IronPort-SDR: dLeUCSy3p6hCkS+rdwtjRRICbcXma4aXL7qZr3J5w/j0iIncIxirKI4Eskz3URbmokhqZx6rYP
 h8RgpOQgGbEnEHjpJr1C2ATmi11CS1Mm9oGjmzft91yLAQAUH5Bjgyn+PSECoL/q0whIF4gRjc
 3GgLrJWuwvqI3Hn+kvmvk/l7PNMwyu2I+WePNWnB2QJnCl1QVM8IX75g9A0kW/f/uu1l4Lg01z
 OdJ59NKgTHG4r2VteCQScziTBDa2GQJQF+UtzU6l2q1cvtCrKvLdwNxhRlF1LzJTNQ7k772G0a
 GoHL4+K2osufkSUp0+tlV9aq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 18:19:49 -0800
IronPort-SDR: KBYLt6Z+ojWYOT/z2hhr/eMTcuFVSpN2QbbqLbSDH0xp5yXmo+4/tbMuySNRxE4bmoDJNOsBDH
 TPCxXbT9osnSGX+RsG/7CU9eMrlprOg9PFTEHI+ZADCPWgCOPsiJeu2fnBS+5UB7a8uVqY0aQd
 m4FJt1fuuVdTn1rLL53aS+8+3F5L+Giv652h8ab5d3mKNPjIP8PG6ohCcaQjWwX9Go8tHbC3vH
 CuXwqZeK6o5Z2/qlT9dsR5YYxed+58XbktMvcjRMCLPw+hs4AlqUfBvdhiJc+JiYzNurTtUj6R
 iUE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 18:47:30 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KBjYF3vdZz1SVp4
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 18:47:29 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646621248; x=1649213249; bh=S3CNHgFgY3oCg1DWvQns4vK6LhLi6oQDlgq
        0N5RP9R8=; b=dxjJpj6a+u8iQNILv9GEd1qZqkHYkR1HHziK+B65hLiPi/K/gV2
        70uAsCZZf/6BcxgvJ6pVUqgKkSv9GcaPKoSAuYI0/TKABmhijB7pY3+nnHfr9lRq
        ocyGupyR0QUsam6lGlxrtjCkOk0YM+lnUyVNUflXmps1r2CrEWPALh9DLNjihRtj
        qQXAuLspmS20zKv52PHcNxieBAZKCfOiroNXc1jQepc2BP3roNqR71vZ7+DGGr5x
        9SYKN0rWitWWmqLiuwMs9AG6Vs3Tgar+dSTLXrVR/WrBLtGOA9UPKaU28GfGPH2u
        kcBRD/V6ct018NCvNmNiPaQpl9gxzyABIew==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nv9Rh1WIK6MQ for <linux-kernel@vger.kernel.org>;
        Sun,  6 Mar 2022 18:47:28 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KBjYB6btGz1Rvlx;
        Sun,  6 Mar 2022 18:47:26 -0800 (PST)
Message-ID: <d5145a6b-0985-030a-0288-1f7853b518d4@opensource.wdc.com>
Date:   Mon, 7 Mar 2022 11:47:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] scsi: pm8001: Use libsas internal abort support
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajish.Koshy@microchip.com, linuxarm@huawei.com,
        Viswas.G@microchip.com, hch@lst.de, liuqi115@huawei.com,
        chenxiang66@hisilicon.com
References: <1646309930-138960-1-git-send-email-john.garry@huawei.com>
 <1646309930-138960-4-git-send-email-john.garry@huawei.com>
 <85a33515-043d-00f4-3bd3-ecb9a1349a68@opensource.wdc.com>
 <966a1048-cd14-d796-8b9d-734605796652@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <966a1048-cd14-d796-8b9d-734605796652@huawei.com>
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

On 3/4/22 18:41, John Garry wrote:
>>>   /**
>>>     * pm8001_queue_command - register for upper layer used, all IO commands sent
>>>     * to HBA are from this interface.
>>> @@ -379,16 +428,15 @@ int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags)
>>>   	enum sas_protocol task_proto = task->task_proto;
>>>   	struct domain_device *dev = task->dev;
>>>   	struct pm8001_device *pm8001_dev = dev->lldd_dev;
>>> +	bool internal_abort = sas_is_internal_abort(task);
>>>   	struct pm8001_hba_info *pm8001_ha;
>>>   	struct pm8001_port *port = NULL;
>>>   	struct pm8001_ccb_info *ccb;
>>> -	struct sas_tmf_task *tmf = task->tmf;
>>> -	int is_tmf = !!task->tmf;
>>>   	unsigned long flags;
>>>   	u32 n_elem = 0;
>>>   	int rc = 0;
>>>   
>>> -	if (!dev->port) {
>>> +	if (!internal_abort && !dev->port) {
>>>   		ts->resp = SAS_TASK_UNDELIVERED;
>>>   		ts->stat = SAS_PHY_DOWN;
>>>   		if (dev->dev_type != SAS_SATA_DEV)
>>> @@ -410,7 +458,8 @@ int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags)
>>>   	pm8001_dev = dev->lldd_dev;
>>>   	port = &pm8001_ha->port[sas_find_local_port_id(dev)];
>>>   
>>> -	if (DEV_IS_GONE(pm8001_dev) || !port->port_attached) {
>>> +	if (!internal_abort && (DEV_IS_GONE(pm8001_dev) ||
>>> +				!port->port_attached)) {
>> Wrapping the line after "&&" would make this a lot cleaner and easier to read.
> 
> Agreed, I can do it.
> 
> But if you can see any neater ways to skip these checks for internal 
> abort in the common queue command path then I would be glad to hear it.

Would need to check the locking context, but if there is no race
possible with the context setting the device as gone, libata should
already be aware of it and not issuing the command in the first place.
So these checks should not be needed at all.

Will try to have a look when I have some time.

There are several things that needs better integration with libata
anyway, like the "manual" read log on error. We should try to address
these for 5.19.


-- 
Damien Le Moal
Western Digital Research
