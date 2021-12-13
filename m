Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54880472791
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbhLMKCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:02:43 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44116 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbhLMJ5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:57:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBBCDB80DEC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 09:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FE1C34602;
        Mon, 13 Dec 2021 09:57:11 +0000 (UTC)
Date:   Mon, 13 Dec 2021 09:57:08 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jianyong Wu <Jianyong.Wu@arm.com>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gshan@redhat.com" <gshan@redhat.com>,
        Justin He <Justin.He@arm.com>, nd <nd@arm.com>
Subject: Re: [PATCH v2] arm64/mm: avoid fixmap race condition when create pud
 mapping
Message-ID: <YbcY9Kjd2ZzDxOZu@arm.com>
References: <20211210095432.51798-1-jianyong.wu@arm.com>
 <f9b090b9-d730-c3d0-ef6f-5170d9809026@arm.com>
 <AM9PR08MB7276135C8586C80BD51A5A68F4749@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <3366ba9f-5993-1c52-de0c-53e618f20cd8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3366ba9f-5993-1c52-de0c-53e618f20cd8@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 08:37:04AM +0100, David Hildenbrand wrote:
> On 13.12.21 08:27, Jianyong Wu wrote:
> >>> @@ -359,6 +365,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
> >>>  	} while (pudp++, addr = next, addr != end);
> >>>
> >>>  	pud_clear_fixmap();
> >>> +	spin_unlock(&fixmap_lock);
> >>>  }
> >>>
> >>>  static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> >>>
> >>
> >> As the race could only happen with memory hotplug being enabled, could
> >> not we wrap this around with CONFIG_MEMORY_HOTPLUG, just to narrow
> >> its scope possibly speed up other non-hotplug cases ?

Assuming you can quantify the speed-up...

> > I think it's better.
> 
> We better avoid using ifdef if not really necessary, it just uglifies
> the code. We could add
> 
> if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> 	...
> 
> But should we really try to micto-optimize this code and make it harder
> to read for the purpose of an unproven performance gain? (if there is no
> contention, we'll most probably not even recognize that we're taking a lock)

I agree, I don't see the point of this optimisation.

-- 
Catalin
