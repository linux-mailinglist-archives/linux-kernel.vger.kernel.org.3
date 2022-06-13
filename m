Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2808549992
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbiFMRLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241837AbiFMRKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:10:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A332C54BD1;
        Mon, 13 Jun 2022 05:16:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BDA0D6E;
        Mon, 13 Jun 2022 05:16:28 -0700 (PDT)
Received: from [10.1.29.148] (e127744.cambridge.arm.com [10.1.29.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 512913F73B;
        Mon, 13 Jun 2022 05:16:25 -0700 (PDT)
Subject: Re: [PATCH 7/8] arm64/perf: Add BRBE driver
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        will@kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org
References: <20220613100119.684673-1-anshuman.khandual@arm.com>
 <20220613100119.684673-8-anshuman.khandual@arm.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <f84187d1-b7eb-e25e-090a-d09532f15594@arm.com>
Date:   Mon, 13 Jun 2022 13:16:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220613100119.684673-8-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman, thanks for the update,

As I mentioned offline, I have a perf test that I've been using for the
branch records and filters. I'll let you know the result using this set.

On 13/06/2022 11:01, Anshuman Khandual wrote:
> [...]
>
> +
> +static int brbe_fetch_perf_priv(u64 brbinf)
> +{
> +       int brbe_el = brbe_fetch_el(brbinf);
> +
> +       switch (brbe_el) {
> +       case BRBINF_EL_EL0:
> +               return PERF_BR_PRIV_USER;
> +       case BRBINF_EL_EL1:
> +               return PERF_BR_PRIV_KERNEL;
> +       case BRBINF_EL_EL2:
> +               if (is_kernel_in_hyp_mode())
> +                       return PERF_BR_PRIV_KERNEL;
> +               return PERF_BR_PRIV_HV;
> +       default:
> +               pr_warn("unknown branch privilege captured\n");
> +               return -1;

This looks like it should return PERF_BR_PRIV_UNKNOWN.

Thanks,
German

> +       }
> +}
> +
> +static void capture_brbe_flags(struct pmu_hw_events *cpuc, struct perf_event *event,
> +			       u64 brbinf, int idx)
> +{
>
> [...]
>
> +
> +	if (branch_sample_priv(event)) {
> +		/*
> +		 * All these information (i.e branch privilege level) are not
> +		 * available for source only branch records.
> +		 */
> +		if (type != BRBINF_VALID_SOURCE)
> +			cpuc->brbe_entries[idx].priv = brbe_fetch_perf_priv(brbinf);
> +	}
> +}
> +
>
> [...]
