Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8F949AB34
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S246131AbiAYEpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:45:08 -0500
Received: from foss.arm.com ([217.140.110.172]:39414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238766AbiAYDgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:36:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18A0B6D;
        Mon, 24 Jan 2022 19:36:43 -0800 (PST)
Received: from [10.163.42.113] (unknown [10.163.42.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6748F3F766;
        Mon, 24 Jan 2022 19:36:40 -0800 (PST)
Subject: Re: [RFC V1 09/31] arm/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, akpm@linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
 <1643029028-12710-10-git-send-email-anshuman.khandual@arm.com>
 <Ye7cs4fNMGPZIV2U@shell.armlinux.org.uk>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <3bab7cde-f394-3e51-57a1-32be271762ae@arm.com>
Date:   Tue, 25 Jan 2022 09:06:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Ye7cs4fNMGPZIV2U@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/22 10:36 PM, Russell King (Oracle) wrote:
> On Mon, Jan 24, 2022 at 06:26:46PM +0530, Anshuman Khandual wrote:
>> This defines and exports a platform specific custom vm_get_page_prot() via
>> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
>> macros can be dropped which are no longer needed.
>
> What is the fundamental advantage of this approach?
> 

Remove multiple 'core MM <--> platform' abstraction layers to map
vm_flags access permission combination into page protection. From
the cover letter ..

----------
Currently there are multiple layers of abstraction i.e __SXXX/__PXXX macros
, protection_map[], arch_vm_get_page_prot() and arch_filter_pgprot() built
between the platform and generic MM, finally defining vm_get_page_prot().

Hence this series proposes to drop all these abstraction levels and instead
just move the responsibility of defining vm_get_page_prot() to the platform
itself making it clean and simple.
----------

