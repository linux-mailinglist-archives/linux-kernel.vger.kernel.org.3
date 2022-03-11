Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3354D67E8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349877AbiCKRnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243506AbiCKRni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:43:38 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCBB427D0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:42:32 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id i66so5513629wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Kiu69aDCpOmK6ciVX6BptEVNLoBkh9vUCLUZJD90Aw=;
        b=FfxxQCuMcndqghCiuePJsvBOm9QSsZiPT/dhpuLws8R4GTUWvMPWc7Ulz+ocnE2aLN
         fl9ZtKyoAUphXwzoUGca/TZTla82GTDiaNsXwTz5OnzUxbs1ehjpfkjYa0eku8v/XEFh
         NKVNaozFF9n+FRas3NRVAMOThO6TKt7NRgklcSEUE0CPtJ5Ao9KH+AFz5utIQUNWA1u3
         MxT+f4X3bewiasvHTTwd0lucb7PhmOu4ZGCnEdVw7ROPp2dfIOoAafXY3XSm5nToslAK
         Nj+B6kDtok3YQxXgQJHLZJnRfKPftcDo5R1t1ws7n2wbzK4ezQO0KpJC46PCnrPDFk2k
         vVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Kiu69aDCpOmK6ciVX6BptEVNLoBkh9vUCLUZJD90Aw=;
        b=DG4dijIKQDo1I7YmpDHmLcvoBa4HocCWsNSKKdyCorZK3jYwQHok71nfSNg0M9oLJ9
         /quXZ24onklV+5eItxiocFK6+95hWKLnl4IL50sCk4xCnOV0c1c08xhZqdXLWsiZE4jU
         wlCm7es9R0+MMvbX5woW/v8GI8/K21RugjexnljqHqAGssIL8YTyLWWufkr97mmBhD3j
         xbVrpH3WZbCe7MiSRMN5sZaqhHiM5g4KKMJLsx8jIMp5c62AWlDsd8VpFhx2cf9J6Mu+
         Afv1Vha/WhiVwsY51eBYrHJo8p69NYaF2hQRauZK95ruVEdxQ4+6qAqmUh8gOSMmpm57
         l68w==
X-Gm-Message-State: AOAM530PtNhnYHGg/SumGaNXpgctnV2v6QonBIRoDBDWW2N8ad0knO1Y
        4RxkUqrBo3GQY0kip1/Fn6Mzmg==
X-Google-Smtp-Source: ABdhPJyBVbe+lJqevWTofJpC2w6AmNhvp3PyRshXSZW5zn2gyZvlY2ZNtCiPYAv5Dkbq1UeVm3N2Lg==
X-Received: by 2002:a1c:4489:0:b0:389:8b0f:9a67 with SMTP id r131-20020a1c4489000000b003898b0f9a67mr8516780wma.40.1647020550979;
        Fri, 11 Mar 2022 09:42:30 -0800 (PST)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id f15-20020a0560001a8f00b0020397ea11d2sm1806633wry.20.2022.03.11.09.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 09:42:30 -0800 (PST)
Date:   Fri, 11 Mar 2022 18:42:26 +0100
From:   "Steinar H. Gunderson" <sesse@google.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf intel-pt: Synthesize cycle events
Message-ID: <YiuKAk7SaXP7B7Ee@google.com>
References: <20220310093844.982656-1-sesse@google.com>
 <586de5fc-858b-2693-1986-5c77e8c0e3d0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <586de5fc-858b-2693-1986-5c77e8c0e3d0@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 11:10:30AM +0200, Adrian Hunter wrote:
>> @@ -1633,7 +1639,7 @@ static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
>>  	else
>>  		sample.period = ptq->state->tot_insn_cnt - ptq->last_insn_cnt;
>>  
>> -	if (ptq->sample_ipc)
>> +	if (ptq->sample_ipc || pt->sample_cycles)
> This is not quite right.  ptq->sample_ipc is set to indicate when the
> cycle count is accurate for the current instruction.  It can be weakened
> by using "Approx IPC" which was introduced for dlfilter-show-cycles.
> Probably that approach should be followed for a "cycles" event also.

Thanks for the review!

I'm not sure if I understand this entirely. The point of the code here
is to get sample.cyc_cnt computed, even if we're not sampling IPC.
I've seen the approx IPC code, but I'm not entirely sure how it
interacts with this?

>>  		sample.cyc_cnt = ptq->ipc_cyc_cnt - ptq->last_in_cyc_cnt;
>>  	if (sample.cyc_cnt) {
>>  		sample.insn_cnt = ptq->ipc_insn_cnt - ptq->last_in_insn_cnt;
>> @@ -1643,8 +1649,30 @@ static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
>>  
>>  	ptq->last_insn_cnt = ptq->state->tot_insn_cnt;
> There are variables here that are specific to the "instructions" event, so
> mixing "cycles" with "instructions" means duplicating those, however maybe
> it would be better not to allow "y" and "i" options at the same time?

Given that a decode can easily take an hour, it would be really nice to
be able to keep y and i at the same time :-) (A long-standing pet peeve
of mine in perf is that you can't show two events side-by-side;
oprofile did that back in the day, at least on annotations.)

What specifically do you mean by duplicating? That we need to calculate
them twice in a way I don't do in my current patch, or something else?
It feels like I'm missing some context here.

>> -	return intel_pt_deliver_synth_event(pt, event, &sample,
>> -					    pt->instructions_sample_type);
>> +	if (pt->sample_instructions) {
>> +		err = intel_pt_deliver_synth_event(pt, event, &sample,
>> +						   pt->instructions_sample_type);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>> +	/*
>> +	 * NOTE: If not doing sampling (e.g. itrace=y0us), we will in practice
>> +	 * only see cycles being attributed to branches, since CYC packets
>> +	 * only are emitted together with other packets are emitted.
>> +	 * We should perhaps consider spreading it out over everything since
>> +	 * the last CYC packet, ie., since last time sample.cyc_cnt was nonzero.
>> +	 */
>> +	if (pt->sample_cycles && sample.cyc_cnt) {
>> +		sample.id = ptq->pt->cycles_id;
>> +		sample.stream_id = ptq->pt->cycles_id;
> A "cycles" sample needs to set the sample period to the number of cycles since the
> last "cycles" sample.

OK. If I understand you right, is this as simple as sample.period =
sample.cyc_cnt?

/* Steinar */
