Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1ECD53101E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbiEWMSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbiEWMSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:18:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEED3EF2D
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653308317; x=1684844317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CgscfHbRv1zAuiZTsJog1ODh28vnfZ4B3mVu+ZHpAYM=;
  b=kZY7bkK/hN5aQtwp1s0G8/C4TI6L1N/kcbFLO8inLNwu43siZ0I1KbNd
   SjiBozOqEhC/tnZz5feZQrMGQ7zjp1gap1V61xjAM5Mx1HSwxxCkBJXS0
   5svamsrC5kf0cboxb932ZL0PjfpVK40XK8mpE1AbQsYtResx7enDzxlPe
   ZNUVBQnh2nnGKrGNNTeITrCCqH7aF3H8OSONU9xSet2GT6Gsxqrap4jz8
   nQQPVf3IusYk3QUlwv8Hhailploeq8OUsSZn42YCzEhiZMkfwdmUJrob9
   A49nHc8V+/RSw0lrRODA5xvP/R/IEP4Z6R/Unh3BxcOvn+lDPuk85G0Xu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="333846888"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="333846888"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 05:18:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="600620980"
Received: from jiaqingz-mobl.ccr.corp.intel.com (HELO [10.249.171.16]) ([10.249.171.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 05:18:35 -0700
Message-ID: <2b859cff-2403-0526-f3ae-749920b3fd8b@linux.intel.com>
Date:   Mon, 23 May 2022 20:18:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] mtd: spi-nor: macronix: Add support for mx66l2g45g
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
References: <20220522054802.1719443-1-jiaqing.zhao@linux.intel.com>
 <04c432289041752d113c15245361ade8@walle.cc>
 <b3e85d41-9415-b911-6f61-941885af1955@linux.intel.com>
 <fac4b7877f600a4067534fca672dc842@walle.cc>
 <2bf3394e-0a78-c760-16ce-936c12b66b93@linux.intel.com>
 <24cf182693a522ed1f7afd61c7c37029@walle.cc>
From:   Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
In-Reply-To: <24cf182693a522ed1f7afd61c7c37029@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay I've found this was a driver issue. After switching to the new aspeed
spi-mem driver[1], the sysfs interface works.

# xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
53464450060102ff00060110300000ffc2000104100100ff84000102c000
00ffffffffffffffffffffffffffffffffffe520fbffffffff7f44eb086b
083b04bbfeffffffffff00ffffff44eb0c200f5210d800ff8749bd0084d2
04e24403673830b030b0f7bdff5c4a9e29fff050f985ffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffff7f8fffff215cdcffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffff003600279df9c06485cbffffffffffff
# md5sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
bc3c1443db0c6359432c3cccb6f97943  /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
# cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
c2201c
# cat /sys/bus/spi/devices/spi0.0/spi-nor/partname
mx66l2g45g
# cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
macronix

Since I'm using kernel 5.15, I copied the /drivers/mtd/spi-nor from 5.18-rc7
(I know this it not a clean way, but it works), and applied the SNOR_ID3()
patch. Verified using SNOR_ID3() macro works with this mx66l2g45g and the
values dumped from sysfs are the same.

[    1.696350] spi spi0.0: setup: ignoring unsupported mode bits 200
[    1.703786] spi-nor spi0.0: mx66l2g45g (262144 Kbytes)
[    1.764440] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:2 [0x203c0641]

Due to the lockdown in Shanghai, I am unable to test my 2nd patch at this
time, please temporarily ignore it.

I will perform more tests and update the patch later.

[1] https://lore.kernel.org/linux-mtd/a17b2446-f5a6-d606-8ef4-3931b8bc94da@kaod.org/

Thanks,
Jiaqing

On 2022-05-23 19:59, Michael Walle wrote:
> Hi,
> 
> Am 2022-05-23 12:12, schrieb Jiaqing Zhao:
>>> Am 2022-05-23 10:50, schrieb Jiaqing Zhao:
>>>> Yes this one supports SFDP according to its spec.
>>>>
>>>> On my setup, I cannot see the sysfs object. Do I need to enable some specific
>>>> kernel config or it's SPI controller related? My setup is running kernel 5.15.
>>>
>>> No, it should be there since v5.14. See commit 36ac02286265. And you shouldn't
>>> need to enable any special configuration option.
>>>
>>> Did you do a "find /sys -name sfdp"?
>>>
>>> -michael
>>
>> I tried, it give empty result. The system I'm working on disables kernel module,
>> and the SPI controller driver calls spi_nor_probe() directly, will this be the
>> issue?
>>
>> And is it possible to manually load the spi-nor driver via the bind interface?
>> If it is possible, what should the parameters be?
> 
> Is your spi flash probed at all?
> 
> -michael
