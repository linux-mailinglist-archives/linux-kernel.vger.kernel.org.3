Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355424896B7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244232AbiAJKtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:49:14 -0500
Received: from foss.arm.com ([217.140.110.172]:59872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244202AbiAJKtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:49:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49BF0ED1;
        Mon, 10 Jan 2022 02:49:01 -0800 (PST)
Received: from [10.57.36.94] (unknown [10.57.36.94])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79F963F5A1;
        Mon, 10 Jan 2022 02:48:59 -0800 (PST)
Subject: Re: [PATCH v5 6/6] perf arm64: inject missing frames if perf-record
 used "--call-graph=fp"
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Alexandre Truong <alexandre.truong@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20211217154521.80603-1-german.gomez@arm.com>
 <20211217154521.80603-7-german.gomez@arm.com> <YcGfQr43ChIgtacC@krava>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <866deed3-9f01-7b68-9b01-9c9f02fbdfac@arm.com>
Date:   Mon, 10 Jan 2022 10:48:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcGfQr43ChIgtacC@krava>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 21/12/2021 09:32, Jiri Olsa wrote:
> On Fri, Dec 17, 2021 at 03:45:20PM +0000, German Gomez wrote:
>
> SNIP
>
>> +}
>> +
>> +u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thread *thread, int usr_idx)
>> +{
>> +	int ret;
>> +	struct entries entries = {};
>> +	struct regs_dump old_regs = sample->user_regs;
>> +
>> +	if (!get_leaf_frame_caller_enabled(sample))
>> +		return 0;
>> +
>> +	/*
>> +	 * If PC and SP are not recorded, get the value of PC from the stack
>> +	 * and set its mask. SP is not used when doing the unwinding but it
>> +	 * still needs to be set to prevent failures.
>> +	 */
>> +
>> +	if (!(sample->user_regs.mask & SMPL_REG_MASK(PERF_REG_ARM64_PC))) {
>> +		sample->user_regs.cache_mask |= SMPL_REG_MASK(PERF_REG_ARM64_PC);
>> +		sample->user_regs.cache_regs[PERF_REG_ARM64_PC] = sample->callchain->ips[usr_idx+1];
>> +	}
>> +
>> +	if (!(sample->user_regs.mask & SMPL_REG_MASK(PERF_REG_ARM64_SP))) {
>> +		sample->user_regs.cache_mask |= SMPL_REG_MASK(PERF_REG_ARM64_SP);
>> +		sample->user_regs.cache_regs[PERF_REG_ARM64_SP] = 0;
>> +	}
>> +
>> +	ret = unwind__get_entries(add_entry, &entries, thread, sample, 2);
> just curious, did you try this with both unwinders libunwind/libdw?

Yes I did,

This is the program I was using:

  int a = 0;

  void leaf() {
    for (int i = 0; i < 10000000; i++)
      a *= a;
  }

  void parent() {
    leaf();
  }

  int main() {
    parent();
  }

  ... compiled with "gcc -O0 -fno-omit-frame-pointer -fno-inline program.c"

>
> any chance you could add arm specific test for this?

I don't see a reason not to. I'll make a note for a separate patch.

>
> otherwise it looks good to me
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks for the review,
German
