Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076E54C0A20
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbiBWDUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiBWDUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:20:20 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F3643EF4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645586393; x=1677122393;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uLQNTA8Dse26+aqzoQaJ+44rdDc0MrIUCcoB8U3WzWM=;
  b=JqIz8pg/bbj7tZmnMQd3ah0uWzlgkQsgsn22zqMvOlAUwI0jd8hqSH9v
   sKGR+4WNXYQ9De+xY2M4Eus/O/D45dooRwxEx5dEVvnqromqyWqUbgm+g
   FpBPa/l6RVWdqPPpHcaUvB9w5Z15ELqkQR0ov2h4xYZqhCo3UNt4HNQs+
   zWeuhTrj5aoGx9lRwxyWMLSQeaGQ9Nu1L3i+a+Vwgg358XJ/apz1VCcKF
   tiPPyi/7bwuJrMIZSU98MyKo7eS1p69tfT3pQALX239hImygFryRYJf/k
   bRRuToAt/Cuaj3C/gUG1t+eq1iqmoDMdZmwh9CQbrUJOdu2Wkl/9ODmqo
   g==;
X-IronPort-AV: E=Sophos;i="5.88,390,1635177600"; 
   d="scan'208";a="297843753"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2022 11:19:53 +0800
IronPort-SDR: 1+uej5Djgt6O/K+v7efk7zrt1/1Q2YjqZ7rObLAQSjIxWzyz5F8KGQ65tuc1T5LiXbOMsjVIpx
 GZmSzX1X8dVWOXDyFiqyj4KmGbbmMcEE/9SOEaxzZWMP0UsdTi2Rk8gHHBfRPOyeoG0fPRZerC
 hdnEexiU0/NhSZ0ZX5r5J/y9Y8owZiUS30FgraYJo/BRmnmFn8gxu9QTpiTNVNzStCb47tBwWx
 JS/+JStuIkXXwF4S5dZqH9wRm/vt0VUke/BPx1fHyp94SWqcV/zc00+tOqPlEOakg9ih4L1E9Q
 lNy+9jTexNTBBzrPQbHsQ9ih
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 18:51:25 -0800
IronPort-SDR: e7c7kIGnBndtivdjxAsR1TiEwZSTxdm/CCUn3Hrdk6rqwCUzn5UH3AMT7opi1jeoM+rPFV0vB1
 /6pJJ/d9effysIuAP64ymyeRIniehY9ku2LEC2X7QJSdpva3zNc3nArYBMZk+7jvrv1kCRf05r
 nVhRzT5GCKFdJk/p10YaHoR8UL+xB95sWLbunmcjYlRo7MTCnEBogbyMsgogSVRYkfya1YEA/X
 /FnO1F31xn+YdEJN20UOdTv49xhLybTyfOaKmCdq10JIGiwWnhl90ZLwmsPQUMI+x72KZi9gzn
 8hE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 19:19:53 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K3Lr86V8wz1SVnx
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:19:52 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645586392; x=1648178393; bh=uLQNTA8Dse26+aqzoQaJ+44rdDc0MrIUCco
        B8U3WzWM=; b=YyaEO8OB6qc8vSbWbbNngsb5YwhQ6lCuK3IHOvX5wzRataUkMiw
        MMOLPZj8x49sT4XJNb9GPUW8cOJZWlYnE6Yft9sugqsFvh2lgEvej/8Bj21OoALZ
        yFMgr8xfGsAQKB6i1TPnhD7/nLErl+GtkLFqok9RrMycp4/Hj+hYkO67mtIBb7xt
        BMGGZvHxzrouMZDqovcWnwim/H7egsTQsj5+g2xUc0/vr9goPIvLBoE3m94LZOXI
        NI/PTrgTeVqx7kmKFuDvptVxwSeFeYb0sN5mvGPTbut04MZZBZihqVe7a+BeZt6A
        msZHulLpX8TvOt3MRdGGmrmpOxTh4TCJeCQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5-M0Tj__npg4 for <linux-kernel@vger.kernel.org>;
        Tue, 22 Feb 2022 19:19:52 -0800 (PST)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K3Lr73CX1z1Rvlx;
        Tue, 22 Feb 2022 19:19:51 -0800 (PST)
Message-ID: <cf99d18e-d8e5-cd41-5541-9d1e1d81adc8@opensource.wdc.com>
Date:   Wed, 23 Feb 2022 12:19:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RESEND v2] dm: Fix use-after-free in
 dm_cleanup_zoned_dev()
Content-Language: en-US
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <c64d2143-284e-7621-440c-971e3405b4d8@virtuozzo.com>
 <d209a0b1-2514-79a0-257a-22bcb372785a@virtuozzo.com>
 <1d287c7e-8aff-beea-1bd6-4b2226f9f3db@opensource.wdc.com>
 <CAH6w=ayrR0yRCumgjtyB+mt_+33S6PHxBQDcwYVcuQ79ECYd7A@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAH6w=ayrR0yRCumgjtyB+mt_+33S6PHxBQDcwYVcuQ79ECYd7A@mail.gmail.com>
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

On 2/23/22 12:02, Mike Snitzer wrote:
> On Thu, Feb 17, 2022 at 5:49 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> On 2/17/22 19:13, Kirill Tkhai wrote:
>>>
>>> dm_cleanup_zoned_dev() uses queue, so it must be called
>>> before blk_cleanup_disk() starts its killing:
>>>
>>> blk_cleanup_disk->blk_cleanup_queue()->kobject_put()->blk_release_queue()->
>>> ->...RCU...->blk_free_queue_rcu()->kmem_cache_free()
>>>
>>> Otherwise, RCU callback may be executed first,
>>> and dm_cleanup_zoned_dev() touches freed memory:
>>
>> Mike,
>>
>> Can you queue this please ?
> 
> I queued it earlier today, please see:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.18&id=588b7f5df0cb64f281290c7672470c006abe7160
> 
> Thanks,
> Mike

Thanks !


-- 
Damien Le Moal
Western Digital Research
