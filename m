Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6BF54F140
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 08:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380350AbiFQG4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 02:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380062AbiFQG4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 02:56:11 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36104D61C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 23:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655448970; x=1686984970;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1h2b47a7yQ4psgtiKa1vXTHgS2gxDIb5ubjtosDpiqE=;
  b=oXI0IjO7e9N0QTI+LyI9xNJ1X4HnLi1s0n5l/siowSPt4Xy29wOeMA+D
   HLrGeF12fQ0E1KJXZcfgujdlHmRwg7I9xmXJCZ6ZIIMZgscc67PHvv7Ch
   XJytmyqV7Qr0MaaMy1GpNCg0n+jnxWdh0rSOXqoBClWJbFqgbhrKr0Z4Z
   cMsM/XcmXt4ACsiSL3ci5dflRjm4zlA+UWyS5CZH6/bOcqR8sz7ZjjIdG
   h2ZX1gmqh1ijCDhK1YYNCJGPf6s2qAmfb/hyIe093NQoxZYqEtauPizRE
   lBZWz5wPl2ZtSgmk6/KoYLfjWZFPgDUXWLLx/mDlwAYZIIaSBH5Y+/LZE
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="204164972"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 14:56:10 +0800
IronPort-SDR: DnRa8m8Rnk9hFFQKfy8ZPcYeLAXXfXBcqfcryu/GZ9C8r4D9sB+olvbvclSCfWRa52Cp9zMia7
 qFpfMWw+zuSlyF2QhOYAtBs3/8qcQkvvagTyxzIo2wI2cHyKVTSvrOBW7XS0S22o52zo6fbjDS
 gBoxTD7RqKYnFxRUHmDVFzX7JfM7GjCJkGoNlskyCWuycEqeytZp6YRdTNCDzp3b7ZSw+vKECJ
 AO8tz5lXGjOaiK9jUg6gB721IU8fnlfYPI43T6yjCWsYC5/hB6a5JUBlsCtHL2lpaooMENJCdn
 20khcBtdhKEsYFpRSVxsGswR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 23:14:21 -0700
IronPort-SDR: JQhzyK9PfCu7LhYoHhcqXD0l2S04Pf/rBokLv7t4sSDS8VoE9myec2Ed/v0s5Q2Pvbet+pncrc
 3SXOgfuEF6kz6gYQmfLoddbyMxlChEF3jTISpMYTyml6+UTt2Nr99FCzKiM9/Iulem3zT9GVab
 EBQsAorng50IZQNt7tEFEBEUhnBPvnlyELfV8hMUzqj403rKnqgD30lMifJisdjCl8eKvN9oeV
 Xa68A+R856m5HQK/VUVGDWnSlmUVo8TDGJeNoVVBRU0rEurFbzHph/H/nAKdQ58wigkK/mpcG1
 4UQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 23:56:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPVF43gCxz1Rwrw
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 23:56:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655448967; x=1658040968; bh=1h2b47a7yQ4psgtiKa1vXTHgS2gxDIb5ubj
        tosDpiqE=; b=j1atsB5LvKvor6LNUEAg43gvXa37A3NJUa7sAfj9QCf/EYpfJHa
        J5oymJfQjtZy6XwtfcpxshMlV7cCp+t59qFyugVB4FLYtsbzJazW3KR/JD5OhMQk
        bHFAe3xxclVqFRUazTnSh9uZfU6EFYa2jUtNdDt9dJ4vgMNb91VutEARBWy4oTPS
        PA8Nl5n148hrOnVoOq8B8mwacDcbEAYTZOEcHsLNKeMwkjTajn5r26ZX5ihuMMf8
        Ve8K1OpbbfXvQFFpDQmvgOfBnPIgDmnK3iemnUw6x1c/vbdXs4tQk6986dYAorr0
        J8GoU5q8Q1JfRaj0M6RcV4IsmyO2rY03CqA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1a0-eLDW0ZH4 for <linux-kernel@vger.kernel.org>;
        Thu, 16 Jun 2022 23:56:07 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPVF05H8mz1Rvlc;
        Thu, 16 Jun 2022 23:56:04 -0700 (PDT)
Message-ID: <f4cf6348-dd94-aa82-7519-318248c51151@opensource.wdc.com>
Date:   Fri, 17 Jun 2022 15:56:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 13/13] dm: add non power of 2 zoned target
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        snitzer@redhat.com, axboe@kernel.dk
Cc:     bvanassche@acm.org, linux-kernel@vger.kernel.org,
        jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
        dm-devel@redhat.com, jonathan.derrick@linux.dev,
        gost.dev@samsung.com, dsterba@suse.com, jaegeuk@kernel.org,
        linux-nvme@lists.infradead.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615102011eucas1p220368db4a186181b1927dea50a79e5d4@eucas1p2.samsung.com>
 <20220615101920.329421-14-p.raghav@samsung.com>
 <63b0cfb6-eb24-f058-e502-2637039c5a98@opensource.wdc.com>
 <0b819562-8b16-37b6-9220-28bf1960bccb@samsung.com>
 <0c4f30f2-c206-0201-31e3-fbb9edbdf666@opensource.wdc.com>
 <4746a000-2220-211e-1bd6-79c15c18a85c@samsung.com>
 <e0dc08fd-cd00-240d-edc4-5799d51aa5a8@opensource.wdc.com>
 <a945def3-ba5a-7539-e96a-43ade0ae674a@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a945def3-ba5a-7539-e96a-43ade0ae674a@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/22 15:40, Pankaj Raghav wrote:
> On 2022-06-17 08:12, Damien Le Moal wrote:
>>> I think this is a cleaner approach using features flag and io_hints
>>> instead of messing with the revalidate zone function:
>>>
>>> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
>>> index 135c0cc190fb..c97a71e0473f 100644
>>> --- a/drivers/md/dm-table.c
>>> +++ b/drivers/md/dm-table.c
>>> @@ -1618,6 +1618,9 @@ static int device_not_matches_zone_sectors(struct
>>> dm_target *ti, struct dm_dev *
>>>  	if (!blk_queue_is_zoned(q))
>>>  		return 0;
>>>
>>> +	if(dm_target_supports_emulated_zone_size(ti->type))
>>> +		return 0;
>>> +
>>
>> This should be in validate_hardware_zoned_model(), not here.
>>
> I am not sure about this comment. We need to peek into the individual
> target from the table to check for this feature right?
> 
> if (dm_table_any_dev_attr(table, device_not_matches_zone_sectors,
> &zone_sectors)) {
> 	DMERR("%s: zone sectors is not consistent across all zoned devices",
>         dm_device_name(table->md));
> 	return -EINVAL;
> 	}
> 
> So we call this function device_not_matches_zone_sectors() from
> validate_hardware_zoned_model() for each target and we let the validate
> succeed even if the target's zone size is different from the underlying
> device zone size if this feature flag is set. Let me know if I am
> missing something and how this can be moved to
> validate_hardware_zoned_model().

Your change does not match the function name
device_not_matches_zone_sectors(), at all. So I think this is wrong.

The fact is that zone support in DM has been built under the following
assumptions:
1) A zoned device can be used to create a *zoned* target (e.g. dm-linear,
dm-flakey, dm-crypt). For this case, the target *must* use the same zone
size as the underlying devices and all devices used for the target must
have the same zone size.
2) A zoned device can be used to create a *regular* device target (e.g.
dm-zoned). All zoned devices used for the target must have the same zone size.

This new target driver completely breaks (1) and does not fit with (2). I
suspect this is why you are seeing problems with dm_revalidate_zones() as
that one uses the underlying device instead of the target report zones.

Based on this analysis, validate_hardware_zoned_model() definitely needs
to be changed. But device_not_matches_zone_sectors() is to check the
assumptions (1) and (2) so changing it for your new case is wrong in my
opinion. You need another set of assumptions (3) (define that well please)
and modify validate_hardware_zoned_model() so that the defined constraints
are checked. Using a target flag to indicate the type of zoned target is
fine by me.

-- 
Damien Le Moal
Western Digital Research
