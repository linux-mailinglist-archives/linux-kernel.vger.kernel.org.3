Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BF4550F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 06:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiFTEOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 00:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiFTEOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 00:14:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4E23655D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 21:14:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 273441042;
        Sun, 19 Jun 2022 21:14:39 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92A4F3F7D7;
        Sun, 19 Jun 2022 21:14:36 -0700 (PDT)
Message-ID: <8da7bf08-0234-2d57-afb0-012b94fd8889@arm.com>
Date:   Mon, 20 Jun 2022 09:44:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V3 2/2] mm/mmap: Drop generic protection_map[] array
Content-Language: en-US
To:     "hch@infradead.org" <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220616040924.1022607-1-anshuman.khandual@arm.com>
 <20220616040924.1022607-3-anshuman.khandual@arm.com>
 <7cf922f4-2367-e173-0280-cb498391d9f7@csgroup.eu>
 <YqrJvV/dWK/iyVvR@infradead.org>
 <7c72a97f-d7d4-db27-faa5-fec01673cca7@arm.com>
 <43205917-0517-4e45-6fbf-4fc849fb0325@csgroup.eu>
 <Yqw0pxSNLZWPyPIG@infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Yqw0pxSNLZWPyPIG@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/17/22 13:30, hch@infradead.org wrote:
> On Fri, Jun 17, 2022 at 05:48:11AM +0000, Christophe Leroy wrote:
>> Is it a good idea to duplicate vm_get_page_prot() in each architecture ? 
> 
> It is a completely trivial array index.  And I really like the idea
> of not having the protection_map in common code - it really is an
> implementation detail.  But what we could do is something like
> 
> #define DECLARE_VM_GET_PAGE_PROT				\
> pgprot_t vm_get_page_prot(unsigned long vm_flags)		\
> {								\
>         return protection_map[vm_flags &			\
> 		(VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)];	\
> }								\
> EXPORT_SYMBOL(vm_get_page_prot);
> 
> as a helper for the architectures.

Agreed, this will ensure the exact same implementation for all platforms
(except those custom vm_get_page_prot), without deviations and mistakes.
