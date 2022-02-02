Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C85E4A742D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiBBPBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbiBBPBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:01:16 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CFAC06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 07:01:16 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a8so66241065ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 07:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=72XrrB6mERO4zu0ZC1jmLIhTMYt78GipteY6hfr9pG4=;
        b=AcTWIcBBhx8gRbxncQ3mRNyZmmSPkHELQlhxH82XH8IxDl3kToxU26EEONtp3Ya8a9
         jbDUEC3csfKL7XCYnVOSyX0OKFAOKGJkvNqpy30IyOmo9GEZ5hKd+tx9Ie/RvS6Debx6
         Jwn3u0v78MYZL+votLlkHC3kIow3tWss6R6LdRujEa8XD2YRm8V99sOZmtYNS4fpKHde
         5+1hFBuT2B34KfcsA44ZFEztO2uVqGLhCf7lZuu1JHcDR8BYl/a48LTp496+nzGqy7jS
         1wjg64cKVLR6pbXPWjHYgVSPOi8+GUAAikEEBq+YuvwOj/myaDz74xj9QMe7DxbeHkRA
         9pzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=72XrrB6mERO4zu0ZC1jmLIhTMYt78GipteY6hfr9pG4=;
        b=Yitm6ahTdhOC3JWNFPK2T39Y5UaixwitAibE55O202Cw3Fkkl6iCYM3ShAZG+u6x3k
         zhUJPEU/Z7UfA1wM8Hs8IlZg7YOHFbPevjYmQgr+VSRU4scAOQ7PYjJb1rzsiwm7dlPD
         vsl7CvUCe4Hi8LkBGFMLrjEHy9sGC8FB6ALacyA6h2y32nyTeN+vi54Aiq+bNeIDchy8
         6ORXKMhuoqd/z0YLYK+j5jgYhpBzB0/VR117cR/9rgwjoub2dKyDfd1IBK9mKmmnMVdW
         YNb3fBOctwWIDqLZJuZ57gUypekIYGZWVt0k0iqkgd8cBnVcdpv/XTcrhzbf1eZksMy9
         7TzA==
X-Gm-Message-State: AOAM532vNEXUMfmRN9lZouKtVdzvdNzgl0YnQBNr4vE5zp+tMHgCvB8W
        PoXE06TFbEqe8HgLkDnnJgEw/9w8WLT7dExUGh8=
X-Google-Smtp-Source: ABdhPJzoPqmJJteVzaKRVWakld1hcla+iRKTAImn4FR4XmIWo7Q4L6tW8K+d8m845PsImm/1+dY3Cw==
X-Received: by 2002:a17:907:a421:: with SMTP id sg33mr26212543ejc.108.1643814074640;
        Wed, 02 Feb 2022 07:01:14 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.65])
        by smtp.gmail.com with ESMTPSA id j25sm8706420edp.10.2022.02.02.07.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 07:01:13 -0800 (PST)
Date:   Wed, 2 Feb 2022 23:01:04 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>, Al Grant <Al.Grant@arm.com>
Cc:     james.clark@arm.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, german.gomez@arm.com,
        john.garry@huawei.com, jolsa@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH] perf arm-spe: Use SPE data source for neoverse cores
Message-ID: <20220202150104.GB1939745@leoy-ThinkPad-X240s>
References: <0ba26f30-6978-36ad-f7d0-7b8465648e54@arm.com>
 <20220124225333.19864-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124225333.19864-1-alisaidi@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ali, James,

[ + Al ]

On Mon, Jan 24, 2022 at 10:53:33PM +0000, Ali Saidi wrote:

[...]

> >> +static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
> >>  {
> >>  	union perf_mem_data_src	data_src = { 0 };
> >> +	bool is_neoverse = is_midr_in_range(midr, neoverse_spe);
> >>  
> >>  	if (record->op == ARM_SPE_LD)
> >>  		data_src.mem_op = PERF_MEM_OP_LOAD;
> >> @@ -409,19 +418,30 @@ static u64 arm_spe__synth_data_source(const struct arm_spe_record *record)
> >>  		data_src.mem_op = PERF_MEM_OP_STORE;
> >>  
> >>  	if (record->type & (ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS)) {
> >> -		data_src.mem_lvl = PERF_MEM_LVL_L3;
> >> +		if (is_neoverse && record->source == ARM_SPE_NV_DRAM) {
> >> +			data_src.mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
> >> +		} else if (is_neoverse && record->source == ARM_SPE_NV_PEER_CLSTR) {
> >> +			data_src.mem_snoop = PERF_MEM_SNOOP_HITM;
> >
> >I'm not following how LLC_ACCESS | LLC_MISS ends up as HITM in this case (ARM_SPE_NV_PEER_CLSTR)?
> >I thought there was no way to determine a HITM from SPE. Wouldn't one of the other values
> >like PERF_MEM_SNOOP_MISS be more accurate?
> 
> Thanks for taking a look James.
> 
> I'd really like someone familiar with perf c2c output to also end up getting
> similar output when running on an Arm system with SPE. There are obviously large
> micro-architectural differences that have been abstracted away by the data_src
> abstraction but fundamentally my understanding of x86 HITM is that the line
> was found in the snoop filter of the LLC as being owned by another core and
> therefore the request needs to go to another core to get the line.  I'm not
> 100% sure if on x86 it's really guaranteed to be dirty or not and it's not
> always going to be dirty in a Neoverse system, but since the SPE source
> indicates it was sourced from another core it is a core-2-core transfer of a
> line which is currently owned by another cpu core and that is the interesting
> data point that would be used to drive optimization and elimination of frequent
> core-2-core transfers (true or false sharing).

Though I don't know the implementation for the hardware conherency
protocols, here I have the same understanding with Ali.

For x86 arch, it uses HITM to indicate the cache line is "modified"
state; on Arm64 Neoverse platforms, there have two data source values
can tell us if the cache line is "modified" state:
ARM_SPE_NV_PEER_CLSTR and ARM_SPE_NV_PEER_CORE.  The snooping can
happen either within the cluster or cross clusters.

> >> +			data_src.mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
> >
> >This one also adds PERF_MEM_LVL_HIT even though the check of "if (record->type & ARM_SPE_LLC_MISS)"
> >hasn't happened yet. Maybe some comments would make it a bit clearer, but at the moment it's
> >not obvious how the result is derived because there are some things that don't add up like
> >ARM_SPE_LLC_MISS == PERF_MEM_LVL_HIT.
> 
> Assuming the above is correct, my reading of the existing code that creates the
> c2c output is that when an access is marked as an LLC hit, that doesn't
> necessarily mean that the data was present in the LLC. I don't see how it could
> given that LLC_HIT + HITM means the line was dirty in another CPUs cache, and so
> LLC_HIT + HITM seems to mean that it was a hit in the LLC snoop filter and
> required a different core to provide the line. This and the above certainly
> deserve a comment as to why the miss is being attributed in this way if it's
> otherwise acceptable.

As James pointed out, this might introduce confusion.  I am wanderding
if we can extract two functions for synthesizing the data source, one is
for Neoverse platform and another is for generic purpose (which
without data source packets), below code is to demonstrate the basic
idea.

Please note, I don't verify this code piece since I have no Neoverse
platform.  Do you mind to share a perf data file which contains data
source packets so I can study more details for its format?

static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *record,
                                                union perf_mem_data_src *data_src)
{
        switch (record->source) {
        case ARM_SPE_NV_L1D:
                data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
                break;
        case ARM_SPE_NV_L2:
                data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
                break;
        case ARM_SPE_NV_PEER_CORE:
                data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
                data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
                break;
        case ARM_SPE_NV_LCL_CLSTR:
                /* To be decided */
                break;
        /* System cache is L3 cache */
        case ARM_SPE_NV_SYS_CACHE:
                data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
                break;
        /* Snooping between L2 caches crossing two clusters */
        case ARM_SPE_NV_PEER_CLSTR:
                data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
                data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
                break;
        case ARM_SPE_NV_REMOTE:
                data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
                break;
        case ARM_SPE_NV_DRAM:
                data_src->mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
                break;
        default:
                break;
        }

        return;
}

static void arm_spe__synth_data_source_generic(const struct arm_spe_record *record,
                                               union perf_mem_data_src *data_src)
{
       if (record->type & (ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS)) {
               data_src->mem_lvl = PERF_MEM_LVL_L3;

               if (record->type & ARM_SPE_LLC_MISS)
                       data_src->mem_lvl |= PERF_MEM_LVL_MISS;
               else
                       data_src->mem_lvl |= PERF_MEM_LVL_HIT;
       } else if (record->type & (ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS)) {
               data_src->mem_lvl = PERF_MEM_LVL_L1;

               if (record->type & ARM_SPE_L1D_MISS)
                       data_src->mem_lvl |= PERF_MEM_LVL_MISS;
               else
                       data_src->mem_lvl |= PERF_MEM_LVL_HIT;
       }

       if (record->type & ARM_SPE_REMOTE_ACCESS)
               data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;

       return;
}

static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
{
        union perf_mem_data_src data_src = { 0 };
        bool is_neoverse = is_midr_in_range(midr, neoverse_spe);

        if (record->op == ARM_SPE_LD)
                data_src.mem_op = PERF_MEM_OP_LOAD;
        else
                data_src.mem_op = PERF_MEM_OP_STORE;

        if (is_neoverse)
                arm_spe__synth_data_source_neoverse(record, &data_src);
        else
                arm_spe__synth_data_source_generic(record, &data_src);

        if (record->type & (ARM_SPE_TLB_ACCESS | ARM_SPE_TLB_MISS)) {
                data_src.mem_dtlb = PERF_MEM_TLB_WK;

                if (record->type & ARM_SPE_TLB_MISS)
                        data_src.mem_dtlb |= PERF_MEM_TLB_MISS;
                else
                        data_src.mem_dtlb |= PERF_MEM_TLB_HIT;
        }

        return data_src.val;
}

Thanks,
Leo
