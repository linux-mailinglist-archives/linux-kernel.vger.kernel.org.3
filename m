Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E5C54EDE6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 01:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiFPX3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 19:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiFPX3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 19:29:36 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE546004B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655422175; x=1686958175;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M1Jr05JZnR9lUrkDq8vnHTcIMrK8D3ELTGTIx+c8baM=;
  b=onAXHxPyx4rxiAvJoBL8LufbqAy0FCLoJLipjCY0J8eDdeWUacmFoeR0
   XsTBCY1T4Pw1/9aLS0ZXeguNoN7lW28aXETCUZS6teRbUEIcQyYVFh8jW
   otLMJhZYl1X4l5GpOMbJ89yFUYxzQVlLZ88PkoNdK3II1T5gjwXJxPTPb
   EY+h/79vmJAf+oys0iVMBIEZZD562SMGLn+hWM5xbEVywUiOcNy5yqt7m
   SowFCxqEx/yAlPhjv2HweE3tKJPHYVFghzc1FC09ToK26hGFS4+9QZ34A
   HkM6FDt25qa05CdUS/TgTyI3idOhHl5YmCNA5cXMjdIs3XpomL54dNSOj
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="208231058"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 07:29:33 +0800
IronPort-SDR: zuwTNTlh2aeeu6twZM7p9g18OkVThd6qnazrMSrfSyFYOfr5MTmZMnuor9XEh9wVa4ey6DO/bz
 0vgIQoFZzPUL+NdPYUeU7+PzD+FiiO/01f/Rz18JrWGS+9itdcSVqV+nbxA3nHwxeS7vVInvJJ
 oCIzmlN9GUvthhKRp8lzEX2b9E7safxOpRaV8t3q8S2JG9KlCv5z3hVrJ8EdRVKWnwHJ3coUpf
 anGE+N3+Axb+O4mjNn1amv+AO1EyAbVJm5tHseNazZa36nudM3BUjuL1EkxnzPjcqGI8pKkKlE
 IuajMrGtmb/kTCe+GRy9fCTF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 15:47:46 -0700
IronPort-SDR: pYbm7xPQid0cXBmc/avQpm9PUWPpsLgaBNC63sC3iStAkCvXMtK/2sVSQWEpI+QODF963ohI8L
 uCwA2V7ELM6M1icle1y/jGBp5kyAMLOGi9tgCP9ZtQoBIx7kyea0tF201bFsNGWX1PS1psRcsC
 XBOYR7QwfUWy8ZSDHm04Hu4y6wBvNPT5lr4viFChvyl4L0goSck8DI5m3ih4td1uyaYI5ao7LR
 sre6+lsekk8kss1KkoLnO7RsPbnQBWFXwJg9kQ4NAiAQaHQRBnl8iOieDp0aHAcho3osxk8zcM
 1gE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 16:29:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPJKn2WfYz1SVp5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:29:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655422172; x=1658014173; bh=M1Jr05JZnR9lUrkDq8vnHTcIMrK8D3ELTGT
        Ix+c8baM=; b=i+6JJJumlrgRNCcYWcsCF45bt2ecb8JVt57/UQZwPVKB9Y9xlVi
        1GFtdmm9W/cROhD0ul0E796KjYCyQc2As5v8It40xyC7usUlm0PUvk435TQgfYnL
        v3ejtmB2RVfuhEy6vFFyCmZYmZ8MelncumtncOJPBAKtC/m0fsUkSYnXll8GgSUw
        S7z/pTo5/MVw9tPeVY4wvxyp6ldlK0bnNmCWTaLew7A3CMC5blmmvVp6OHM7gDnW
        /kdKsbkT4zg2lD8pZSma7YEw1e1iMCF/T6CrzW9UvDY32bYrIZFfzE9pleN1yoL/
        Qb9Litbg6QNYnKjyxFoLYLaoGlgD7ONJM8w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0o_e57o9fTwQ for <linux-kernel@vger.kernel.org>;
        Thu, 16 Jun 2022 16:29:32 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPJKj0df1z1Rvlc;
        Thu, 16 Jun 2022 16:29:28 -0700 (PDT)
Message-ID: <065e9c29-0ceb-9b5d-ee99-ab501773c883@opensource.wdc.com>
Date:   Fri, 17 Jun 2022 08:29:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 10/13] dm-table: use bdev_is_zone_start helper in
 device_area_is_invalid()
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        snitzer@redhat.com, axboe@kernel.dk
Cc:     bvanassche@acm.org, linux-kernel@vger.kernel.org,
        jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
        dm-devel@redhat.com, jonathan.derrick@linux.dev,
        gost.dev@samsung.com, dsterba@suse.com, jaegeuk@kernel.org,
        linux-nvme@lists.infradead.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615102000eucas1p27720aaa3c309327b2b9a33c5f840f498@eucas1p2.samsung.com>
 <20220615101920.329421-11-p.raghav@samsung.com>
 <064551fa-4575-87cb-d9da-90a34309f634@opensource.wdc.com>
 <50731e57-e0bb-179e-388c-32a18b0c610e@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <50731e57-e0bb-179e-388c-32a18b0c610e@samsung.com>
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

On 6/16/22 18:55, Pankaj Raghav wrote:
> drivers/md/dm-table.c
>>> +++ b/drivers/md/dm-table.c
>>> @@ -251,7 +251,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>>>  	if (bdev_is_zoned(bdev)) {
>>>  		unsigned int zone_sectors = bdev_zone_sectors(bdev);
>>>  
>>> -		if (start & (zone_sectors - 1)) {
>>> +		if (blk_queue_is_zone_start(bdev_get_queue(bdev), start)) {
>>
>> This is wrong. And you are changing this to the correct test in the next
>> patch.
>>
> Yeah, I think I made a mistake while committing it. The next patch
> should only have the removing po2 condition check and these changes
> should have been only in this patch. I will fix it up!

This one and the next patch should be squashed together. They both deal
with non power of 2 zone size.


>>>  			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
>>>  			       dm_device_name(ti->table->md),
>>>  			       (unsigned long long)start,
>>> @@ -268,7 +268,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>>>  		 * devices do not end up with a smaller zone in the middle of
>>>  		 * the sector range.
>>>  		 */
>>> -		if (len & (zone_sectors - 1)) {
>>> +		if (blk_queue_is_zone_start(bdev_get_queue(bdev), len)) {
>>>  			DMWARN("%s: len=%llu not aligned to h/w zone size %u of %pg",
>>>  			       dm_device_name(ti->table->md),
>>>  			       (unsigned long long)len,
>>
>>


-- 
Damien Le Moal
Western Digital Research
