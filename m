Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA0A530A96
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiEWHd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiEWHdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:33:04 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BA57651
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653291180; x=1684827180;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OcwGBUpAAJiWZ5v/YJ1Btd+c99uDP5yJACtABgy45zE=;
  b=UeKI+Tgn9KESzV74Ti2PhBM3V69hGRuJQ+cO5Th9WT9h1OKD5/yz+w0d
   IX2vYQSkAqdV8/C7Zp1KXz878X3/YnmBI9lrwq0RFRdHwQ7EYXoPHlUzZ
   UeAVwhiDf+sq7GZqXzi4qYEn/I6fO2cT4nkcpAKDjJVGpxRUHbs35Mz/8
   wfoadrXx2kFcV6vRj4OXx2ipE2myElyFSFLkpw3/1QboBc9LWyssk+Utp
   V6WZs6FNvsyCfcc2E14AjCp7UdbfySelBTgCtS+SCJyyiJooGvrirbIFJ
   xCo46oUVAzpF2/PUw/WF/EcTH0IFtqMTkeA1WHak4l1tqTVUrORIh7890
   w==;
X-IronPort-AV: E=Sophos;i="5.91,245,1647273600"; 
   d="scan'208";a="201136177"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2022 15:33:00 +0800
IronPort-SDR: yw7r8hy0uk8CBRdwE6eZ94tiysC5y8+m842PCxdemZvzbsUkjfKHwc7Dvus+K/EKCZ6/AbNdMq
 BecptYedcZnRDz2V0O7ConBa5XmiaK+zebfWjhUiTQXHjHAGpRW6Re3WPCDbclIi/mUhtmHUDp
 YNMKwltvOVPBGcuIQQy0MsF/nuWLQ8ZX1flSzqsXfzSLEyCAeqTJbp+tMqk7xkaWUPFbJwJM4/
 5nM8TNs6K2iNznFLHXoeLCgxctJZHuH2NjQHRDp2w+rdkyApuSF3OSgmk8uB16KoRNfwOl0R//
 RVMBiWkD33X63a0oB4eytPxf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2022 23:57:00 -0700
IronPort-SDR: A06DTfuVJ8gc2oirFFPi69+r1tlfoHZ8rpnxVUCgQiyO6Fl422CQ63UNpYMIWEhSbXfrueB3oV
 PaQwjx3U/U+76hkBcpftAZ0qEFiaBH1IK8MYe8HcoEVjLeAZh10W1xKinkSKjR+pI17oUzqZUx
 uo12etVnzJ5f/dp68/cGtWAy8MCryqat/7xj954mb2Hp1OtkOaokS43zceuMCOnFtSBsnhWmFu
 Cd4IpLDdfNI1TXgWu0gf1ubWi3YnNHWWWIiGRaUkIYVyQr8p3vGk3NN+FbPn6jjxVx2zys9OWE
 VhM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 May 2022 00:33:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L68F812VJz1SVp7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:33:00 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653291178; x=1655883179; bh=OcwGBUpAAJiWZ5v/YJ1Btd+c99uDP5yJACt
        ABgy45zE=; b=KZLz5DNGE1EMHNc36tC3TAUZznz7ftzzJaC+XiqPThzU7wLVAYA
        WLfUP8He0YrJ1gLCARo0/rcSA1aAH7gEGyIPMYkb7xghe04wZPIdJhQ8Es8KrLsc
        voIAEVbQJRFEc+Kxs6E1ri4+rWS5+xkrOuLAP3jnkhTo70t8Wbl8uj/UZ/YY+Lgw
        O3NGzPEeIi8+9CqJe58gWphzlDmDbknR9HbRHwAwEsWnKFPHmcJ5tMuefSKLZ6Iq
        +s/9fC+dLrW26sIuZuoBl/X7bU4mDN/82cAyOB5T5dTmSEapTUa4mN1TpD3nXx76
        /vX5OQdlr//R6ve+zl4hlPdx4hHENJ++HSg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id af63hnJrPK-7 for <linux-kernel@vger.kernel.org>;
        Mon, 23 May 2022 00:32:58 -0700 (PDT)
Received: from [10.89.85.73] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.73])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L68F40HYpz1Rvlc;
        Mon, 23 May 2022 00:32:55 -0700 (PDT)
Message-ID: <2b4426a6-88ac-1bce-ea80-52902897cd0f@opensource.wdc.com>
Date:   Mon, 23 May 2022 16:32:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 2/4] dma-iommu: Add iommu_dma_opt_mapping_size()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, liyihang6@hisilicon.com,
        chenxiang66@hisilicon.com, thunder.leizhen@huawei.com
References: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
 <1653035003-70312-3-git-send-email-john.garry@huawei.com>
 <250a10e6-40ae-e4e8-ae01-4f7144b089f8@opensource.wdc.com>
 <655b915c-e8d2-d65b-676a-a51e788f1695@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <655b915c-e8d2-d65b-676a-a51e788f1695@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/23 16:01, John Garry wrote:
> On 21/05/2022 00:33, Damien Le Moal wrote:
> 
> Hi Damien,
> 
>>> +unsigned long iova_rcache_range(void)
>> Why not a size_t return type ?
> 
> The IOVA code generally uses unsigned long for size/range while 
> dam-iommu uses size_t as appropiate, so I'm just sticking to that.

OK.

> 
>>
>>> +{
>>> +	return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
>>> +}
>>> +
> 
> Thanks,
> John


-- 
Damien Le Moal
Western Digital Research
