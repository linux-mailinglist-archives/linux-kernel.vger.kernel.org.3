Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7A154C9F9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354189AbiFONjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354092AbiFONjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:39:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2E6633374;
        Wed, 15 Jun 2022 06:39:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4DC7153B;
        Wed, 15 Jun 2022 06:39:14 -0700 (PDT)
Received: from [10.57.84.186] (unknown [10.57.84.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75B2E3F7F5;
        Wed, 15 Jun 2022 06:39:11 -0700 (PDT)
Subject: Re: [PATCH V6 6/8] perf/tools: Extend branch type classification
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, acme@kernel.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220610035101.424112-1-anshuman.khandual@arm.com>
 <20220610035101.424112-7-anshuman.khandual@arm.com>
 <e0f29bc9-eae4-e433-2d4e-4dd53e31967d@arm.com>
 <8bfce917-84a6-23a2-d926-a1efa901f4f1@arm.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <60d21662-aa8f-b50a-b0a3-462f1b3dec43@arm.com>
Date:   Wed, 15 Jun 2022 14:39:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8bfce917-84a6-23a2-d926-a1efa901f4f1@arm.com>
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


On 15/06/2022 04:21, Anshuman Khandual wrote:
> [...]
>  
> +const char *get_branch_type(struct branch_entry *e)
> +{
> +	if (e->flags.type == PERF_BR_UNKNOWN)
> +		return "";
>> There is a small change of behavior in "perf script --field brstack".
>> Unknown branches were printed as "-" before but now it's an empty
>> string.
> get_branch_type() replaces print output in two different functions.
> branch_stack__printf() used to print a space " " for PERF_BR_UNKNOWN,
> and print_bstack_flags() used to print a "-" for PERF_BR_UNKNOWN.
> When they are factorized via get_branch_type(), one of those print
> formats need to be choosen.

Thanks for clarifying, Anshuman. I only bring it up in case somebody is
parsing this line for their use case. While running on x86 I came across
some UNKNOWN branches during my runs.

I have updated and sent a generic branch stack sampling perf test that
supports both ("-" and empty string) just in case. Hope it's useful.

https://lore.kernel.org/all/20220615130901.1151397-1-german.gomez@arm.com/

Thanks,
German
