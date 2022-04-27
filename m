Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69435510D21
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 02:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356399AbiD0A27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 20:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244133AbiD0A25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 20:28:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAA8E13F259
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 17:25:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F07D23A;
        Tue, 26 Apr 2022 17:25:48 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E0443F73B;
        Tue, 26 Apr 2022 17:25:46 -0700 (PDT)
Message-ID: <d72eb7a7-f922-3270-422b-4e27505de530@arm.com>
Date:   Wed, 27 Apr 2022 01:25:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/3] soc: rockchip: power-domain: Replace dsb() with
 smb()
Content-Language: en-GB
To:     Peter Geis <pgwipeout@gmail.com>,
        Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20220426014545.628100-1-briannorris@chromium.org>
 <20220426014545.628100-2-briannorris@chromium.org>
 <CAMdYzYqyDr1HFYB4p8NK8ssq60qfjR2jyoSJ=tcRn8CWsZr16g@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAMdYzYqyDr1HFYB4p8NK8ssq60qfjR2jyoSJ=tcRn8CWsZr16g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-27 00:55, Peter Geis wrote:
> On Mon, Apr 25, 2022 at 9:46 PM Brian Norris <briannorris@chromium.org> wrote:
>>
>> It's unclear if these are really needed at all, but seemingly their
>> purpose is only as a write barrier. Use the general macro instead of the
>> ARM-specific one.
>>
>> This driver is partially marked for COMPILE_TEST'ing, but it doesn't
>> build under non-ARM architectures. Fix this up before *really* enabling
>> it for COMPILE_TEST.
>>
>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>> ---
>>
>> Changes in v3:
>>   * New in v3
>>
>>   drivers/soc/rockchip/pm_domains.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
>> index 1b029e494274..cf16ff9b73b3 100644
>> --- a/drivers/soc/rockchip/pm_domains.c
>> +++ b/drivers/soc/rockchip/pm_domains.c
>> @@ -178,7 +178,7 @@ static int rockchip_pmu_set_idle_request(struct rockchip_pm_domain *pd,
>>                  regmap_update_bits(pmu->regmap, pmu->info->req_offset,
>>                                     pd_info->req_mask, idle ? -1U : 0);
>>
>> -       dsb(sy);
>> +       wmb();
> 
> Just curious, shouldn't this be mb() instead of wmb()?
>  From the arm64 barrier.h:
> 
> #define mb() dsb(sy)
> #define wmb() dsb(st)

As I mentioned on v2, that would be the literal translation, however 
there's no concurrency since this is happening under a mutex, so there's 
no other agent against whose accesses loads would need to be 
synchronised, therefore the only logical reason those DSBs were ever 
there at all must be to ensure that the prior store(s) have been issued 
to their destination before proceeding. The history implies that this 
dates all the way back to RK3288, where Armv7's argument-less DSB lacked 
that distinction anyway.

Robin.

>>
>>          /* Wait util idle_ack = 1 */
>>          target_ack = idle ? pd_info->ack_mask : 0;
>> @@ -285,7 +285,7 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
>>                  regmap_update_bits(pmu->regmap, pmu->info->pwr_offset,
>>                                     pd->info->pwr_mask, on ? 0 : -1U);
>>
>> -       dsb(sy);
>> +       wmb();
>>
>>          if (readx_poll_timeout_atomic(rockchip_pmu_domain_is_on, pd, is_on,
>>                                        is_on == on, 0, 10000)) {
>> --
>> 2.36.0.rc2.479.g8af0fa9b8e-goog
>>
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
