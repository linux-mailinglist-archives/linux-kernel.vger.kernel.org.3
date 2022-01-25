Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BC549AD74
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443988AbiAYHSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:18:21 -0500
Received: from foss.arm.com ([217.140.110.172]:39688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230400AbiAYDmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:42:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1A911FB;
        Mon, 24 Jan 2022 19:42:00 -0800 (PST)
Received: from [10.163.42.113] (unknown [10.163.42.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 478853F766;
        Mon, 24 Jan 2022 19:41:57 -0800 (PST)
Subject: Re: [RFC V1 08/31] m68k/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, akpm@linux-foundation.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-m68k@lists.linux-m68k.org
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
 <1643029028-12710-9-git-send-email-anshuman.khandual@arm.com>
 <87mtjl8bnl.fsf@igel.home>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <aef5318e-0b48-2a9e-1a1b-386894b116f4@arm.com>
Date:   Tue, 25 Jan 2022 09:12:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87mtjl8bnl.fsf@igel.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/22 7:43 PM, Andreas Schwab wrote:
> On Jan 24 2022, Anshuman Khandual wrote:
> 
>> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
>> +{
>> +	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
>> +	case VM_NONE:
>> +		return __pgprot(pgprot_val(PAGE_NONE_C)|_PAGE_CACHE040);
> 
> _PAGE_CACHE040 should only be present when running on a 040 or 060.
> 

Right, seems like I have missed the conditionality on CPU_IS_040_OR_060
while moving the code, will fix it.
