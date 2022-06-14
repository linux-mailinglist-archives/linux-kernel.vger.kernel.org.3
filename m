Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D382554A3BD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 03:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiFNBoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 21:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiFNBoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:44:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 472552872A;
        Mon, 13 Jun 2022 18:44:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A93623A;
        Mon, 13 Jun 2022 18:44:21 -0700 (PDT)
Received: from [10.162.40.17] (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8D463F792;
        Mon, 13 Jun 2022 18:44:16 -0700 (PDT)
Message-ID: <0bc0f99d-41ad-3ce3-deeb-c4c713100e74@arm.com>
Date:   Tue, 14 Jun 2022 07:14:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 7/8] arm64/perf: Add BRBE driver
Content-Language: en-US
To:     German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org
References: <20220613100119.684673-1-anshuman.khandual@arm.com>
 <20220613100119.684673-8-anshuman.khandual@arm.com>
 <f84187d1-b7eb-e25e-090a-d09532f15594@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <f84187d1-b7eb-e25e-090a-d09532f15594@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/22 17:46, German Gomez wrote:
> Hi Anshuman, thanks for the update,
> 
> As I mentioned offline, I have a perf test that I've been using for the
> branch records and filters. I'll let you know the result using this set.

Sure, thanks !

> 
> On 13/06/2022 11:01, Anshuman Khandual wrote:
>> [...]
>>
>> +
>> +static int brbe_fetch_perf_priv(u64 brbinf)
>> +{
>> +       int brbe_el = brbe_fetch_el(brbinf);
>> +
>> +       switch (brbe_el) {
>> +       case BRBINF_EL_EL0:
>> +               return PERF_BR_PRIV_USER;
>> +       case BRBINF_EL_EL1:
>> +               return PERF_BR_PRIV_KERNEL;
>> +       case BRBINF_EL_EL2:
>> +               if (is_kernel_in_hyp_mode())
>> +                       return PERF_BR_PRIV_KERNEL;
>> +               return PERF_BR_PRIV_HV;
>> +       default:
>> +               pr_warn("unknown branch privilege captured\n");
>> +               return -1;
> 
> This looks like it should return PERF_BR_PRIV_UNKNOWN.

Right, return from this function gets into perf branch record's priv
element and '-1' is not something that can be parsed correctly in the
user space tools as the corresponding enum itself starts with 0 i.e
PERF_BR_PRIV_UNKNOWN.

cpuc->brbe_entries[idx].priv = brbe_fetch_perf_priv(brbinf)

Will change the return as PERF_BR_PRIV_UNKNOWN instead.
