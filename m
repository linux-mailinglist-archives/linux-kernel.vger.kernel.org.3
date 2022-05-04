Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F635519C36
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345788AbiEDJuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346296AbiEDJuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:50:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2BC81D0F0;
        Wed,  4 May 2022 02:46:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9070FED1;
        Wed,  4 May 2022 02:46:24 -0700 (PDT)
Received: from [10.57.1.74] (unknown [10.57.1.74])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D1D03FA50;
        Wed,  4 May 2022 02:46:22 -0700 (PDT)
Message-ID: <e19b1b96-f5b0-b4c0-00ab-2d793d6476fe@arm.com>
Date:   Wed, 4 May 2022 10:46:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/6] coresight: Add config flag to enable branch
 broadcast
To:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     coresight@lists.linaro.org, leo.yan@linaro.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20220113091056.1297982-1-james.clark@arm.com>
 <20220113091056.1297982-2-james.clark@arm.com>
 <b3545a88-4743-db95-4676-b0b193cbea78@arm.com>
 <CAJ9a7Vi584BcY49TaRn5CJT=wcpafMf-3cA0R+sZ54p6iUKmeQ@mail.gmail.com>
 <7fae6630-fdec-3f95-9eac-3f7a5c789272@arm.com>
 <CAJ9a7VjTJ4E7=qdPgfTTVjoW01rCzd-f1mFYHjtA3BHk25saMA@mail.gmail.com>
 <ae5a3464-1f07-e7b4-0f25-c3774c0e5922@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <ae5a3464-1f07-e7b4-0f25-c3774c0e5922@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 11:18, James Clark wrote:
> 
> 
> On 11/03/2022 15:56, Mike Leach wrote:
>> Hi James,
>>
>> On Fri, 11 Mar 2022 at 14:58, James Clark <james.clark@arm.com> wrote:
>>>
>>>
>>>
>>> On 02/02/2022 20:25, Mike Leach wrote:
>>>> Hi James, Suzuki
>>>>
>>>> On Fri, 28 Jan 2022 at 11:19, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>>>>
>>>>> On 13/01/2022 09:10, James Clark wrote:
>>>>>> When enabled, all taken branch addresses are output, even if the branch
>>>>>> was because of a direct branch instruction. This enables reconstruction
>>>>>> of the program flow without having access to the memory image of the
>>>>>> code being executed.
>>>>>>
>>>>>> Use bit 8 for the config option which would be the correct bit for
>>>>>> programming ETMv3. Although branch broadcast can't be enabled on ETMv3
>>>>>> because it's not in the define ETM3X_SUPPORTED_OPTIONS, using the
>>>>>> correct bit might help prevent future collisions or allow it to be
>>>>>> enabled if needed.
>>>>>>
>>>>>> Signed-off-by: James Clark <james.clark@arm.com>
>>>>>> ---
>>>>>>    drivers/hwtracing/coresight/coresight-etm-perf.c   |  2 ++
>>>>>>    drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 ++++++++++
>>>>>>    include/linux/coresight-pmu.h                      |  2 ++
>>>>>>    3 files changed, 14 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
>>>>>> index c039b6ae206f..43bbd5dc3d3b 100644
>>>>>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>>>>>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>>>>>> @@ -52,6 +52,7 @@ static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
>>>>>>     * The PMU formats were orignally for ETMv3.5/PTM's ETMCR 'config';
>>>>>>     * now take them as general formats and apply on all ETMs.
>>>>>>     */
>>>>>> +PMU_FORMAT_ATTR(branch_broadcast, "config:"__stringify(ETM_OPT_BRANCH_BROADCAST));
>>>>>>    PMU_FORMAT_ATTR(cycacc,             "config:" __stringify(ETM_OPT_CYCACC));
>>>>>>    /* contextid1 enables tracing CONTEXTIDR_EL1 for ETMv4 */
>>>>>>    PMU_FORMAT_ATTR(contextid1, "config:" __stringify(ETM_OPT_CTXTID));
>>>>>> @@ -97,6 +98,7 @@ static struct attribute *etm_config_formats_attr[] = {
>>>>>>        &format_attr_sinkid.attr,
>>>>>>        &format_attr_preset.attr,
>>>>>>        &format_attr_configid.attr,
>>>>>> +     &format_attr_branch_broadcast.attr,
>>>>>
>>>>> Does it make sense to hide the option if the bb is not supported ? I
>>>>> guess it will be tricky as we don't track the common feature set. So,
>>>>> that said...>>>>
>>>>>>        NULL,
>>>>>>    };
>>>>>>
>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>>>> index bf18128cf5de..04669ecc0efa 100644
>>>>>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>>>> @@ -692,6 +692,16 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>>>>>>                ret = cscfg_csdev_enable_active_config(csdev, cfg_hash, preset);
>>>>>>        }
>>>>>>
>>>>>> +     /* branch broadcast - enable if selected and supported */
>>>>>> +     if (attr->config & BIT(ETM_OPT_BRANCH_BROADCAST)) {
>>>>>> +             if (!drvdata->trcbb) {
>>>>>> +                     ret = -EINVAL;
>>>>>
>>>>> Should we fail here ? We could simply ignore this and generate the trace
>>>>> normally. This would work on a big.LITTLE system with one set missing
>>>>> the branch broadcast, while the others support.
> 
> Hi Suzuki,
> 
> I think if the user really needs branch broadcast because they've modified their
> binaries then they would want feedback that one of the cores doesn't support it.
> Otherwise their decode would silently go wrong and they could get stuck.
> 
> Perf already opens an event per core, so it wouldn't be much effort to manually
> modify the command line to only select cores where it is supported.
> 
> I think for that scenario the current patch already works that way because the
> feature is checked on the active core when the event is enabled?

Fair enough. We could let the user pin the perf to the CPUs where this
is supported. This information is available to the user via sysfs.

So, let us proceed with the changes here.

Cheers
Suzuki
