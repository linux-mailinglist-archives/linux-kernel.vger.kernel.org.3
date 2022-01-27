Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885DD49DF93
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239320AbiA0KlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:41:17 -0500
Received: from foss.arm.com ([217.140.110.172]:53326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232804AbiA0KlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:41:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 028411FB;
        Thu, 27 Jan 2022 02:41:16 -0800 (PST)
Received: from [10.163.42.218] (unknown [10.163.42.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86DF93F7D8;
        Thu, 27 Jan 2022 02:41:10 -0800 (PST)
Subject: Re: [RFC V1 10/11] perf: Expand perf_branch_entry.type
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
 <1642998653-21377-11-git-send-email-anshuman.khandual@arm.com>
 <YfF7P9flt8D2+Kfr@robh.at.kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <004deaf2-b77b-6b88-7bbb-7508c8feb68f@arm.com>
Date:   Thu, 27 Jan 2022 16:11:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YfF7P9flt8D2+Kfr@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/22 10:17 PM, Rob Herring wrote:
> On Mon, Jan 24, 2022 at 10:00:52AM +0530, Anshuman Khandual wrote:
>> Current perf_branch_entry.type is a 4 bits field just enough to accommodate
>> 16 generic branch types. This is insufficient to accommodate platforms like
>> arm64 which has much more branch types. Lets just expands this field into a
>> 6 bits one, which can now hold 64 generic branch types. This also adds more
>> generic branch types and updates the BRBE driver as required.
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-perf-users@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  drivers/perf/arm_pmu_brbe.c           |  7 ++++++-
> 
> This patch should come before the BRBE support so that it can be applied
> sooner rather than later. If another field is added to the end before 
> expanding this field, then you will be stuck with assembling bits from 2 
> fields.

Should I just split this patch from the series and post it separately
right away, to be included in perf while BRBE support gets reviewed ?

> 
>>  include/uapi/linux/perf_event.h       | 10 ++++++++--
>>  tools/include/uapi/linux/perf_event.h | 10 ++++++++--
>>  tools/perf/util/branch.c              |  8 +++++++-
>>  4 files changed, 29 insertions(+), 6 deletions(-)
