Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E39563880
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 19:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiGARUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 13:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiGARUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:20:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1743B2E6BF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 10:20:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFB54113E;
        Fri,  1 Jul 2022 10:20:12 -0700 (PDT)
Received: from [10.1.196.218] (eglon.cambridge.arm.com [10.1.196.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B5D33F792;
        Fri,  1 Jul 2022 10:20:11 -0700 (PDT)
Subject: Re: [PATCH RESEND] perf/marvell_cn10k: Add MPAM support for TAD PMU
To:     Tanmay Jagdale <tanmay@marvell.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Amit Singh Tomar <amitsinght@marvell.com>
References: <PH0PR18MB5017CB19D896DADFCEAB6ED6D6B99@PH0PR18MB5017.namprd18.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <72856daa-ef83-caee-b0d0-6b5018d1bafa@arm.com>
Date:   Fri, 1 Jul 2022 18:20:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <PH0PR18MB5017CB19D896DADFCEAB6ED6D6B99@PH0PR18MB5017.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tanmay,

On 27/06/2022 14:18, Tanmay Jagdale wrote:
>> On 2022-06-24 13:14, Will Deacon wrote:
>>> On Sat, May 28, 2022 at 12:26:47AM +0530, Tanmay Jagdale wrote:
>>>> The TAD PMU supports following counters that can be filtered by MPAM
>>>> partition id.
>>>>      - (0x1a) tad_alloc_dtg : Allocations to DTG.
>>>>      - (0x1b) tad_alloc_ltg : Allocations to LTG.
>>>>      - (0x1c) tad_alloc_any : Total allocations to DTG/LTG.
>>>>      - (0x1d) tad_hit_dtg   : DTG hits.
>>>>      - (0x1e) tad_hit_ltg   : LTG hits.
>>>>      - (0x1f) tad_hit_any   : Hit in LTG/DTG.
>>>>      - (0x20) tad_tag_rd    : Total tag reads.
>>>>
>>>> Add a new 'partid' attribute of 16-bits to get the partition id
>>>> passed from perf tool. This value would be stored in config1 field
>>>> of perf_event_attr structure.
>>>>
>>>> Example:
>>>> perf stat -e tad/tad_alloc_any,partid=0x12/ <program>
>>>>
>>>> - Drop read of TAD_PRF since we don't have to preserve any
>>>>    bit fields and always write an updated value.
>>>> - Update register offsets of TAD_PRF and TAD_PFC.
>>>
>>> It would be great if you could document some of this under
>>> Documentation/admin-guide/perf like many of the other PMU drivers have
>>> done.
>>
>> Especially documenting how the user obtains the required partid value to
>> pass.

> We created MPAM partitions using the resctrl filesystem interface.
> Example:
>         $ cd /sys/fs/resctrl
>         $ mkdir p1
>         $ echo "L3:0=f" > p1/schemata (configure 4 L3 cache ways)
>         $ mkdir p2
>         $ echo "L3:1=ff0" > p2/schemata (configure 8 L3 cache ways)
> 
> Here directory name 'p1' creates a MPAM partid 0x1 and 'p2' creates
> 0x2 and so on.

You can't rely on this.

See the KNOWN_ISSUES file in the the mpam tree: PARTID 0 should be reserved for unknown
hardware. In fact any number of PARTID may be reserved for in-kernel users. You can't
guess what the offset might be from user-space.


> Right now, there is no file which exposes the partid to userspace.
> We must rely on the sequential order in which we create partitions
> via resctrl and use that to derive the partid.

If you dig in the MPAM tree you'll find how I intend to solve this for exposing the MPAM
counters via perf. But this is a user-space visible change to resctrl, so it will need to
wait until all the refactoring is done and the bulk of the MPAM driver is upstream.


Thanks,

James
