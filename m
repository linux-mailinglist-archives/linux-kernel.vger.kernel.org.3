Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0805F58EE77
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiHJOgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiHJOgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:36:36 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F5445F6C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660142195; x=1691678195;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Puv/2c7VmUYZ5sr10JH3gji4MxoaIPhu9aLiFvJPf8g=;
  b=e3oXUa2L+1nHS0WbQ9z276hoYQXM9rqqFkYUtX5Iv6pIuODtGJMaiJOi
   B+b9xD5ot1P4KWHpA5WLhM7QtEt0HVXEt8ZH28FUyZRF83CVTFFA6J7kf
   /o9BsaZ1Yo49LU00Ok0nkezUUNGfGXQmIekgoWVFNHGRUkdQqhUTS81EZ
   LWSmkcE4hd3rxTuo6A3GsMqFcN5yMgz0v7M2+krk5s1fB/JCYjtq5Xv3p
   LplI/5IcsV3ek7khSJjYYrMct+N2U8H+ev9MauR60EiVgD6JaC2WW1Iit
   3grkwkfFKocvN91Z2cxMPczXKmQgEefBGBKy2yqDVOd+Lz5DyNFVfC9kM
   w==;
X-IronPort-AV: E=Sophos;i="5.93,227,1654531200"; 
   d="scan'208";a="320446692"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2022 22:36:34 +0800
IronPort-SDR: Sbc+WRGK/wiELiRZ5pGPDRTf07hxO3CRFigdC10eHwmaatdEN4SKl9C5HpQTgMkM8pY5c+mjcw
 9anFlQjmbVP/yUpM6SsUS6KUXOcgiYrU1qyByGWsgRxHW/J/vafxL8ehapMj1rzBE5MJU7MZVv
 UQnJs/4VpnELjOP9aCljjqsyP89sUrHLDJjoLdscspJafv1TLscV+wsOASz4OpuLIGuSOLe8nJ
 yZJyA2WJ/VYU1Lm9OEfQUNAKqcbQ73W4R7PoN9HTmGdskubQK1ra5uHMKecsuaYtO+dMjX4S6H
 qnGU9DzfP0q2ZIQR45TB0U4I
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 06:57:29 -0700
IronPort-SDR: Q8gen0tAGqkPDwtJrPax/giFZTD6BHw1revnp0JXCoWMCQCcCzcqDpophV3zbr/fuU/OlttXYl
 5Mddw2VxNNous5EPiAgXpJlluY5+5PAvROUvt2HNPsct1Qd2JfCVFRidSobir1Z/cfEPfFP82N
 x0hQJydccnHBIcCcB/Z9Fc+SZkVsUNWo33mITL9sColDOU9JcjPO1KRMY8p49AggHrVxWznAmn
 ps4W+DfawZ/d10D6ToCH8c5AbObt+jXAifV722Jns5lGgJwMdhnFH6jpCm+tXi946P/SOmLm6T
 szQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 07:36:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M2svP64z8z1Rwnx
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:36:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660142193; x=1662734194; bh=Puv/2c7VmUYZ5sr10JH3gji4MxoaIPhu9aL
        iFvJPf8g=; b=UseI6l7kjPax8Ls0wp34uofl9yWM1/JwSzeDhqWaXjNnjwcn55c
        NwNjj/zZ/VgQB5i9xvdXBVJbaXxjARZz3Hn1H5aXbIIjuDjouDCiVJFnIAeomqnu
        uplDDHfWZIXOlu+r7f516F6gtmYMwVGACXarpeb6c23SEQ2btMoc44shqPD7qJpa
        TO/YMOrjKPD2N33hETHLVT5LpMmF1OPhvIhfLaldAzIfFHr5/asZT1/HHc2NVin6
        I7zVS9tu+iOJRoI/TjG0CLbB3gaUEHziyp91vPZci5WhdUe+CqpCbvvJ/gL2fswj
        19ZFXUU6FPol7stsgZGerD0USrpyqtszUFg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MAflXr7ds131 for <linux-kernel@vger.kernel.org>;
        Wed, 10 Aug 2022 07:36:33 -0700 (PDT)
Received: from [10.111.68.99] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.68.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M2svN5nJJz1RtVk;
        Wed, 10 Aug 2022 07:36:32 -0700 (PDT)
Message-ID: <24b7e027-e098-269b-ccf7-b14deb499c33@opensource.wdc.com>
Date:   Wed, 10 Aug 2022 07:36:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: fs/zonefs/./trace.h:22:1: sparse: sparse: cast to restricted
 blk_opf_t
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <202208061533.YBqXyzHm-lkp@intel.com>
 <affa6eee-3b7c-105a-8f4a-35f1ed81f0cd@opensource.wdc.com>
 <b3a6b038-ba0c-2242-3a29-5bcadcaa9d71@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <b3a6b038-ba0c-2242-3a29-5bcadcaa9d71@acm.org>
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

On 2022/08/08 8:37, Bart Van Assche wrote:
> On 8/8/22 07:48, Damien Le Moal wrote:
>> Are you going to send a patch to fix this or do you want me to do it ?
> 
> Hi Damien,
> 
> Thanks for having taken a look. Please help with verifying whether the 
> following patch is sufficient to fix the reported warning: "[PATCH] 
> tracing: Suppress sparse warnings triggered by is_signed_type()" 
> (https://lore.kernel.org/all/20220717151047.19220-1-bvanassche@acm.org/).
> 
> Bart.

With the current Linus tree, I do not see this sparse warning. However, applying
the above patch, "make M=fs/zonefs C=1" generates a lot of warnings:

make -j64 M=fs/zonefs C=1
  CC [M]  fs/zonefs/super.o
  CC [M]  fs/zonefs/sysfs.o
  CHECK   fs/zonefs/sysfs.c
  CHECK   fs/zonefs/super.c
fs/zonefs/sysfs.c: note: in included file (through include/linux/bitops.h,
include/linux/kernel.h, arch/x86/include/asm/percpu.h,
arch/x86/include/asm/preempt.h, include/linux/preempt.h,
include/linux/spinlock.h, ...):
./arch/x86/include/asm/bitops.h:66:1: warning: unreplaced symbol 'return'
fs/zonefs/sysfs.c: note: in included file (through include/linux/bitops.h,
include/linux/kernel.h, arch/x86/include/asm/percpu.h,
arch/x86/include/asm/preempt.h, include/linux/preempt.h,
include/linux/spinlock.h, ...):
./include/asm-generic/bitops/generic-non-atomic.h:29:9: warning: unreplaced
symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:30:9: warning: unreplaced
symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:32:10: warning: unreplaced
symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:32:16: warning: unreplaced
symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:27:1: warning: unreplaced
symbol 'return'
fs/zonefs/sysfs.c: note: in included file (through
arch/x86/include/asm/bitops.h, include/linux/bitops.h, include/linux/kernel.h,
arch/x86/include/asm/percpu.h, arch/x86/include/asm/preempt.h,
include/linux/preempt.h, ...):
./include/asm-generic/bitops/instrumented-non-atomic.h:26:1: warning: unreplaced
symbol 'return'
fs/zonefs/sysfs.c: note: in included file (through include/linux/bitops.h,
include/linux/kernel.h, arch/x86/include/asm/percpu.h,
arch/x86/include/asm/preempt.h, include/linux/preempt.h,
include/linux/spinlock.h, ...):
./arch/x86/include/asm/bitops.h:92:1: warning: unreplaced symbol 'return'
fs/zonefs/sysfs.c: note: in included file (through include/linux/bitops.h,
include/linux/kernel.h, arch/x86/include/asm/percpu.h,
arch/x86/include/asm/preempt.h, include/linux/preempt.h,
include/linux/spinlock.h, ...):
./include/asm-generic/bitops/generic-non-atomic.h:38:9: warning: unreplaced
symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:39:9: warning: unreplaced
symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:41:10: warning: unreplaced
symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:41:16: warning: unreplaced
symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:36:1: warning: unreplaced
symbol 'return'
...

Much more messages after that.

-- 
Damien Le Moal
Western Digital Research
