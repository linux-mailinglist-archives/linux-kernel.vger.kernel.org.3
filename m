Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF930567E14
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 07:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiGFF6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 01:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGFF6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 01:58:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AE201C927;
        Tue,  5 Jul 2022 22:58:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBF5A1570;
        Tue,  5 Jul 2022 22:58:09 -0700 (PDT)
Received: from [10.163.43.16] (unknown [10.163.43.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C01D3F70D;
        Tue,  5 Jul 2022 22:58:01 -0700 (PDT)
Message-ID: <8a6ccbae-7d7c-6e08-cc28-eeb649f86112@arm.com>
Date:   Wed, 6 Jul 2022 11:27:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V6 00/26] mm/mmap: Drop __SXXX/__PXXX macros from across
 platforms
Content-Language: en-US
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     hch@infradead.org, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        x86@kernel.org, openrisc@lists.librecores.org,
        linux-xtensa@linux-xtensa.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-um@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220630051630.1718927-1-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220630051630.1718927-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/22 10:46, Anshuman Khandual wrote:
> __SXXX/__PXXX macros is an unnecessary abstraction layer in creating the
> generic protection_map[] array which is used for vm_get_page_prot(). This
> abstraction layer can be avoided, if the platforms just define the array
> protection_map[] for all possible vm_flags access permission combinations
> and also export vm_get_page_prot() implementation.
> 
> This series drops __SXXX/__PXXX macros from across platforms in the tree.
> First it build protects generic protection_map[] array with '#ifdef __P000'
> and moves it inside platforms which enable ARCH_HAS_VM_GET_PAGE_PROT. Later
> this build protects same array with '#ifdef ARCH_HAS_VM_GET_PAGE_PROT' and
> moves inside remaining platforms while enabling ARCH_HAS_VM_GET_PAGE_PROT.
> This adds a new macro DECLARE_VM_GET_PAGE_PROT defining the current generic
> vm_get_page_prot(), in order for it to be reused on platforms that do not
> require custom implementation. Finally, ARCH_HAS_VM_GET_PAGE_PROT can just
> be dropped, as all platforms now define and export vm_get_page_prot(), via
> looking up a private and static protection_map[] array. protection_map[]
> data type has been changed as 'static const' on all platforms that do not
> change it during boot.
> 
> This series applies on v5.19-rc4 and has been build tested for multiple
> platforms. While here it has dropped off all previous tags from folks after
> the current restructuring. Series common CC list has been expanded to cover
> all impacted platforms for wider reach.
> 
> - Anshuman
> 
> Changes in V6:
> 
> - Converted protection_map[] array as 'static const' on sparc32 platform
> - Rebased on v5.19-rc4
> - Collected tags

There are two linux-next based build fixes for this series (listed below), when
vm_get_page_prot() gets redefined with !CONFIG_MMU. Platform vm_get_page_prot()
is required only with CONFIG_MMU enabled, otherwise there is a generic fallback
stub in include/linux/mm.h

https://lore.kernel.org/all/20220705221411.3381797-1-jcmvbkbc@gmail.com/	[xtensa]
https://lore.kernel.org/all/20220706054002.1936820-1-anshuman.khandual@arm.com/ [sh]

It does not seem CONFIG_MMU can be disabled on other platforms thus exposing a build
failure. But just to be on the safer side, should all vm_get_page_prot() be wrapped
around with #ifdef CONFIG_MMU ? In that case will resend the series with above build
fixes folded back in as well. Please do suggest. Thank you.

- Anshuman
