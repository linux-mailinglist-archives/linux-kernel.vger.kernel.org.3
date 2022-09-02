Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C49D5AB5C9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbiIBPyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237505AbiIBPxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:53:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21EE088DC2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:48:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68212D6E;
        Fri,  2 Sep 2022 08:48:12 -0700 (PDT)
Received: from [10.1.197.78] (eglon.cambridge.arm.com [10.1.197.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2DC33F766;
        Fri,  2 Sep 2022 08:48:03 -0700 (PDT)
Message-ID: <4ca8b7c8-0b67-d3a0-73c9-a2c4974cdcac@arm.com>
Date:   Fri, 2 Sep 2022 16:47:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 00/21] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
Content-Language: en-GB
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com, Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Xin Hao <xhao@linux.alibaba.com>, xingxin.hx@openanolis.org,
        baolin.wang@linux.alibaba.com
References: <20220622164629.20795-1-james.morse@arm.com>
 <d8f0224a-6cb4-eeb4-59cc-39d6ce4fba5a@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <d8f0224a-6cb4-eeb4-59cc-39d6ce4fba5a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 23/08/2022 18:20, Reinette Chatre wrote:
> On 6/22/2022 9:46 AM, James Morse wrote:
>> The aim of this series is to insert a split between the parts of the monitor
>> code that the architecture must implement, and those that are part of the
>> resctrl filesystem. The eventual aim is to move all filesystem parts out
>> to live in /fs/resctrl, so that resctrl can be wired up for MPAM.
>>
>> What's MPAM? See the cover letter of a previous series. [1]
>>
>> The series adds domain online/offline callbacks to allow the filesystem to
>> manage some of its structures itself, then moves all the 'mba_sc' behaviour
>> to be part of the filesystem.
>> This means another architecture doesn't need to provide an mbps_val array.
>> As its all software, the resctrl filesystem should be able to do this without
>> any help from the architecture code.
>>
>> Finally __rmid_read() is refactored to be the API call that the architecture
>> provides to read a counter value. All the hardware specific overflow detection,
>> scaling and value correction should occur behind this helper.
>>
> 
> Thank you for your patience as I was offline for a while. 

No problem,


> This series looks good to me. I have one remaining comment that I provided
> in reply to "[07/21] x86/resctrl: Abstract and use supports_mba_mbps()" where
> it seems to me that an existing issue could easily be addressed in the new
> function. 

Yup, that made sense to me.


> I do not have tests for the software controller and only did basic sanity
> checks. It would be great if the folks using this feature could test this
> series.
> 
> Thank you very much. From my side it looks good:
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>


Thanks!

James
