Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4458A4F5EE3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiDFNGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiDFNGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:06:15 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB3F41FD07
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649209693; x=1680745693;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VuoVmwsM1kjAIgmEzd4iWUN0hXYBPqUPYmlYGxx90q0=;
  b=gpvrCNsmTmfW/cXQ+nQCVquU/8tcBIfxMUbDV/oa/zfnOiTYaS8/Th7x
   XrJzOykZ74ZB3tUxJySl1pg8ymyWCJkuloAQSih3z4XOKcpNelq/BWx0U
   VXPLAKfGwDkx0Rnqg78IAxjmhMcH3glMKISWooYmfJZ7KFRJZtOWlTF1Z
   dzVHjoqMpw2HMZP0GN4LKwZnnDqEzeqgLILFz4rnwVZwFZ16g6Pko5Z7P
   37sRKhw2MfHaIIqwnvtVAmC8bxu8qIaH35r/f2wk+5Er24FuQYbAMLaRf
   Aiceg859qK/byZ0tG8iMhZbsVkweFQY1FkOfEtNAdcZWOn/Fy3X/yUrYQ
   g==;
X-IronPort-AV: E=Sophos;i="5.90,238,1643644800"; 
   d="scan'208";a="202037232"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2022 09:48:06 +0800
IronPort-SDR: YYT6ODKAVJo7ucncVjl9vKjgaQLgQNC8X3mHPcZGuhjT+Qi8m9L5Tgpq9ZOpDYOof3MQbM+buO
 6uZCf8ki72FNOYfLb/y6F8c1T+56EMGVfe/6LbhJwYqqz8Myg8yRP4jQh5yRCEQSmaaE8iqjbi
 uejsfsoag0mKMpIZyM90JoIv2sYE/mOIJr7USwU21OPtIwjMbOFAIZV87fh9Gc1yUl7K+rAIDC
 GBxOjhWCagcHo7jKeX2IDcVigsyCyvCPjmWt1HHmu+pr0YtcGyhrCO2+6F036Q5gVfmDuthFzr
 GevYmk98E4dXn7mX0ZVbZYh9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2022 18:18:49 -0700
IronPort-SDR: Z8TzV4KQr29ZzqbnvJ6olDsbWoj7lzZVvf3Mj7zPwTBY0NjO5hQexC/CwxuJ8GWNP4RC4SvY6q
 6UFfeApI3iuCwbrL4dmo/UbHiCwRvHZMYVVvD4qN+04BnVG6EqCE2uggrkF1KqP7RKJLQFdF94
 sdHrrnvl3dBaucfWc61cY+TDSfCNBtk43oFamQ9YNjOhC5xl8adwKdYFc0uH3Lv+8NssonHnVN
 ILNzvSrBUnVOcWEpt5rRyCRThkNZsTQ5W/Gq19E10ilKc6vYj0y+/0UqG8qSRKIrqP3WgAxUng
 Afs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2022 18:48:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KY6ps4pBfz1SVnx
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:48:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649209685; x=1651801686; bh=VuoVmwsM1kjAIgmEzd4iWUN0hXYBPqUPYml
        YGxx90q0=; b=E4UOnw8BjAuFsxgUNz1JVDSZoX8yQLctisFANLe1Z/7C0dFuEJk
        LfdRZDbW8aSOdPPRAKOLeHbtE6mmG+YYKwab0H3EYIozRVzMTdKBgE2ik7HJHuwe
        1b/tZXQrhQEBKn14uwEUh3KXtkYU3AwYxZb/cftSIWs4sLb5Ii1/2OmbJOA5JmTM
        pMTGewU2Q4eeocqSTsJgcr3aFdUI/EEHKR3ZwRZqyhl210d7gKEwFqJzkMZnFvWx
        sVkMFEpQFSvwkCv/cyub/aWGqmuHgeyvyl77QlJzkoPLP94S2ray/pI2ibZtgHr6
        MBrtS9l0xhBIHxhWo4d1BYM4S1B2CX7v4tQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id js7mOVg80Fvw for <linux-kernel@vger.kernel.org>;
        Tue,  5 Apr 2022 18:48:05 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KY6pr31hmz1Rvlx;
        Tue,  5 Apr 2022 18:48:04 -0700 (PDT)
Message-ID: <f7bbb09f-562f-fce2-cd16-a1c67fc334b5@opensource.wdc.com>
Date:   Wed, 6 Apr 2022 10:48:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] libata: Inline ata_qc_new_init() in
 ata_scsi_qc_new()
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, John Garry <john.garry@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-scsi@vger.kernel.org
References: <1649083990-207133-1-git-send-email-john.garry@huawei.com>
 <1649083990-207133-3-git-send-email-john.garry@huawei.com>
 <20220405055252.GA23698@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220405055252.GA23698@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 14:52, Christoph Hellwig wrote:
> On Mon, Apr 04, 2022 at 10:53:10PM +0800, John Garry wrote:
>> From: Christoph Hellwig <hch@lst.de>
>>
>> It is a bit pointless to have ata_qc_new_init() in libata-core.c since it
>> pokes scsi internals, so inline it in ata_scsi_qc_new() (in libata-scsi.c).
>>
>> <Christoph, please provide signed-off-by>
>> [jpg, Take Christoph's change from list and form into a patch]
>> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Although I still think merging the two patches into one to avoid all
> the churn would be much better.

I agree. Let's merge these 2 patches.


-- 
Damien Le Moal
Western Digital Research
