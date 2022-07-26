Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCEF580E33
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbiGZHsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbiGZHsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:48:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DC91DFDA;
        Tue, 26 Jul 2022 00:48:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CF721FB;
        Tue, 26 Jul 2022 00:48:02 -0700 (PDT)
Received: from [10.57.13.197] (unknown [10.57.13.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48D1F3F73B;
        Tue, 26 Jul 2022 00:48:00 -0700 (PDT)
Message-ID: <500c8773-12e0-1e3a-fb11-4d7a5da11b71@arm.com>
Date:   Tue, 26 Jul 2022 08:47:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 00/12] thermal OF rework
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, rafael@kernel.org
References: <20220722200007.1839356-1-daniel.lezcano@linexp.org>
 <1aa3ae56-84ae-8a96-7a52-3181c47dcb07@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1aa3ae56-84ae-8a96-7a52-3181c47dcb07@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 7/25/22 17:34, Daniel Lezcano wrote:
> 
> Hi Rafael,
> 
> On 22/07/2022 21:59, Daniel Lezcano wrote:
>> The thermal framework initialization with the device tree appears to
>> be complicated and hard to make it to evolve.
>>
>> It contains duplication of almost the same thermal generic structures
>> and has an assymetric initialization making hard any kind of serious
>> changes for more complex features. One of them is the multiple sensors
>> support per thermal zone.
>>
>> In order to set the scene for the aforementioned feature with generic
>> code, we need to cleanup and rework the device tree initialization.
>>
>> However this rework is not obvious because of the multiple components
>> entering in the composition of a thermal zone and being initialized at
>> different moments. For instance, a cooling device can be initialized
>> before a sensor, so the thermal zones must exist before the cooling
>> device as well as the sensor. This asynchronous initialization forces
>> the thermal zone to be created with fake ops because they are
>> mandotory and build a list of cooling devices which is used to lookup
>> afterwards when the cooling device driver is registering itself.
>>
>> As there could be a large number of changes, this first series provide
>> some steps forward for a simpler device tree initialization.
>>
>> More series for cleanup and code duplication removal will follow.
>>
>> Changelog:
>>
>>   - v6:
>>      - Folded patches 8, 9, 10
>>      - Removed thermal_zone_get_trips() and thermal_zone_get_num_trips()
>>      - Moved tz->ntrips => tz->num_trips changes into patch 11 to fix the
>>        git bisecting
>>
> 
> I believe all the comments were addressed, is it fine if I merge this 
> series ?
> 
> 

My apologies for being quiet, I was on holiday last week.
Please don't wait for me, I'm still catching up with internal stuff.
Based on your changelog I can see you've addressed my comments.

Regards,
Lukasz
