Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A29749D98D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 05:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbiA0EQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 23:16:21 -0500
Received: from foss.arm.com ([217.140.110.172]:33780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235900AbiA0EQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 23:16:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4BD31FB;
        Wed, 26 Jan 2022 20:16:18 -0800 (PST)
Received: from [10.163.42.218] (unknown [10.163.42.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14F723F7D8;
        Wed, 26 Jan 2022 20:16:16 -0800 (PST)
Subject: Re: [RFC V1 01/31] mm/debug_vm_pgtable: Directly use
 vm_get_page_prot()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
 <1643029028-12710-2-git-send-email-anshuman.khandual@arm.com>
 <YfD1Lijf+UKGBBzb@infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <1f75e638-7b72-1c1b-c493-eb4b62dcf280@arm.com>
Date:   Thu, 27 Jan 2022 09:46:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YfD1Lijf+UKGBBzb@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/22 12:45 PM, Christoph Hellwig wrote:
>> +	 *
>> +	 * Protection based vm_flags combinatins are always linear
>> +	 * and increasing i.e VM_NONE ..[VM_SHARED|READ|WRITE|EXEC].
>>  	 */
>> -	for (idx = 0; idx < ARRAY_SIZE(protection_map); idx++) {
>> +	for (i = VM_NONE; i <= (VM_SHARED | VM_READ | VM_WRITE | VM_EXEC); ix++) {
>>  		pte_basic_tests(&args, idx);
>>  		pmd_basic_tests(&args, idx);
>>  		pud_basic_tests(&args, idx);
> 
> This looks rather convoluted.  I'd prefer to add a helper for the body
> of this loop, and then explicitly call it for all the valid
> combinations.  Right now all are valid, so this dosn't change a thing
> except for generating larger code due to the explicit loop unrolling,
> but I think it is much easier to follow and maintain.

IIUC, then will just keep this unchanged.
