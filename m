Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD62F4EC9D6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348931AbiC3QqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348899AbiC3QqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:46:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A5F21D760C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:44:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41A02153B;
        Wed, 30 Mar 2022 09:44:18 -0700 (PDT)
Received: from [10.1.196.218] (eglon.cambridge.arm.com [10.1.196.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3081D3F73B;
        Wed, 30 Mar 2022 09:44:16 -0700 (PDT)
Subject: Re: [PATCH v3 12/21] x86/resctrl: Calculate bandwidth from the
 previous __mon_event_count() chunks
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
References: <20220217182110.7176-1-james.morse@arm.com>
 <20220217182110.7176-13-james.morse@arm.com>
 <c4088205-a344-5ef8-15e2-9ccc5d1691ea@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <146a1a64-7925-008f-a817-fe0860b30105@arm.com>
Date:   Wed, 30 Mar 2022 17:44:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c4088205-a344-5ef8-15e2-9ccc5d1691ea@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 05/03/2022 00:27, Reinette Chatre wrote:
> On 2/17/2022 10:21 AM, James Morse wrote:
>> mbm_bw_count() is only called by the mbm_handle_overflow() worker once a
>> second. It reads the hardware register, calculates the bandwidth and
>> updates m->prev_bw_msr which is used to hold the previous hardware register
>> value.
>>
>> Operating directly on hardware register values makes it difficult to make
>> this code architecture independent, so that it can be moved to /fs/,
>> making the mba_sc feature something resctrl supports with no additional
>> support from the architecture.
>> Prior to calling mbm_bw_count(), mbm_update() reads from the same hardware
>> register using __mon_event_count().
>>
>> Change mbm_bw_count() to use the current chunks value most recently saved by
>> __mon_event_count(). This removes an extra call to __rmid_read().
> 
>> Instead of using m->prev_msr to calculate the number of chunks seen,
>> use the rr->val that was updated by __mon_event_count(). This removes a extra
>> calls to mbm_overflow_count() and get_corrected_mbm_count().
> 
> "removes a extra calls" -> "removes an extra call" ?
> 
> __mon_event_count() ends with "rr->val += get_corrected_mbm_count()" and
> it is called twice by mbm_update(). The intention in this change is for
> mbm_bw_count() to benefit from the rmid read done just before ...
> but would using rr->val within mbm_bw_count() not result in it getting
> data from both rmid reads due to the increment?

Yes, bother. I thought those were mutually exclusive, but its __mon_event_count() that
uses a different struct mbm_state for each set of raw values, not mbm_update().

[...]

> Should rr.val perhaps be reset before each __mon_event_count() call instead of
> just at the beginning of mbm_update()?

Yes. This is because the struct rmid_read is just to allow __mon_event_count() to do its
thing, nothing used to read those values.


>> Calculating bandwidth like this means mbm_bw_count() no longer operates
>> on hardware register values directly.


Thanks!

James
