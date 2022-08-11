Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BA358F707
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 06:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbiHKEuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 00:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiHKEuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 00:50:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3C961DAD
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:50:50 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q9-20020a17090a2dc900b001f58bcaca95so4222591pjm.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=g1tB4PzGwPaYivNuYZQ1WLvbqe8EaYq8NKrVrjSyJXc=;
        b=c+zrxQ6+cdQYCS/N5LRVQuaOTOSbl/9tuRDxcto/BR1ntLwhL783AouGqMnQagkfQe
         CCid8MojN38ExbqX1WzSsJBkBLAydGQBXYKDp8MxwEFdzEmitWBWrpLmWYZCwYrGL4j8
         HKOPetspK0mSldCeqTI7vz1SoFylPycknQeTFFn1amooQyIvUXSW/5JdABj1fIS2FEm3
         vNFfJjvwAfhR7l06ciVTDTuew/4ERRdVcvKqUKfBEmc04RHyFT6YRBmFeS0kBlGqAWCr
         ZSxYzxYCGdT4ENBOZTRXq4/UD92v/+IBVxX/GQBw6NFetVy145HXcNjSqpOkrXP1CPsw
         rW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=g1tB4PzGwPaYivNuYZQ1WLvbqe8EaYq8NKrVrjSyJXc=;
        b=Hxcn14TyMTlndwZ2q5LgoNwb5vd1M8hZrjM5X7uZgvub2wLZ4ugKFEQSPd/86G7Zfg
         OFNfnqNZwoHv3CgyulinpwkU1dGGQbeChUUGu/4Jk7N/WHfIeWr29VF1N/EwCasdBbrR
         q55LNQbHOFztQXxeXgHig2AEztmg9xMKpOgJJFNcaF5ExmZbWO+T8Du6LSPk+hKeVc6g
         xL3j0qkW0Xogpij98awtgFgPnxmJc33oeeufBQ4vFC+Lsw0Y1Vv/KX6hf3yx4u+XuJiy
         k2fHVOv206ddxYi16BibzLPscVrwtj0PPA6++OJl/i3Sn94RltLsTaO/v3EsE/uo3/nT
         mM5A==
X-Gm-Message-State: ACgBeo0V5hjU8p4bC0tL6LPVM4IHgF6LmZBee0F9s79FXIeARTSZsf7J
        ris0Vpi6vADgdUWi1g1UZcI=
X-Google-Smtp-Source: AA6agR5EbzmroQdQvkmFjNJrR7BdWQrjvhL5tELLflY63x02a3iWQJ3Y9mjlt2+z8khOhj6d/KMSUQ==
X-Received: by 2002:a17:90a:a2a:b0:1f3:1479:e869 with SMTP id o39-20020a17090a0a2a00b001f31479e869mr6830467pjo.41.1660193449778;
        Wed, 10 Aug 2022 21:50:49 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-79-20-36.ap-northeast-1.compute.amazonaws.com. [35.79.20.36])
        by smtp.gmail.com with ESMTPSA id h11-20020a17090a3d0b00b001f31d6fe0f3sm2604499pjc.57.2022.08.10.21.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 21:50:48 -0700 (PDT)
Date:   Thu, 11 Aug 2022 04:50:44 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [RFC PATCH 0/4] x86/mm/cpa: merge small mappings whenever
 possible
Message-ID: <YvSKpCWhAz+2Y220@ip-172-31-24-42.ap-northeast-1.compute.internal>
References: <20220808145649.2261258-1-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808145649.2261258-1-aaron.lu@intel.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 10:56:45PM +0800, Aaron Lu wrote:
> This is an early RFC. While all reviews are welcome, reviewing this code
> now will be a waste of time for the x86 subsystem maintainers. I would,
> however, appreciate a preliminary review from the folks on the to and cc
> list. I'm posting it to the list in case anyone else is interested in
> seeing this early version.
> 

Hello Aaron!

+Cc Mike Rapoport, who has been same problem. [1]

There is also LPC discussion (with different approach on this problem)
[2], [4]

and performance measurement when all pages are 4K/2M. [3]

[1] https://lore.kernel.org/linux-mm/20220127085608.306306-1-rppt@kernel.org/
[2] https://www.youtube.com/watch?v=egC7ZK4pcnQ
[3] https://lpc.events/event/11/contributions/1127/attachments/922/1792/LPC21%20Direct%20map%20management%20.pdf
[4] https://lwn.net/Articles/894557/

> Dave Hansen: I need your ack before this goes to the maintainers.
> 
> Here it goes:
> 
> On x86_64, Linux has direct mapping of almost all physical memory. For
> performance reasons, this mapping is usually set as large page like 2M
> or 1G per hardware's capability with read, write and non-execute
> protection.
> 
> There are cases where some pages have to change their protection to RO
> and eXecutable, like pages that host module code or bpf prog. When these
> pages' protection are changed, the corresponding large mapping that
> cover these pages will have to be splitted into 4K first and then
> individual 4k page's protection changed accordingly, i.e. unaffected
> pages keep their original protection as RW and NX while affected pages'
> protection changed to RO and X.
> 
> There is a problem due to this split: the large mapping will remain
> splitted even after the affected pages' protection are changed back to
> RW and NX, like when the module is unloaded or bpf progs are freed.
> After system runs a long time, there can be more and more large mapping
> being splitted, causing more and more dTLB misses and overall system
> performance getting hurt[1].
> 
> For this reason, people tried some techniques to reduce the harm of
> large mapping beling splitted, like bpf_prog_pack[2] which packs
> multiple bpf progs into a single page instead of allocating and changing
> one page's protection for each bpf prog. This approach made large
> mapping split happen much fewer.
> 
> This patchset addresses this problem in another way: it merges
> splitted mappings back to a large mapping when protections of all entries
> of the splitted small mapping page table become same again, e.g. when the
> page whose protection was changed to RO+X now has its protection changed
> back to RW+NX due to reasons like module unload, bpf prog free, etc. and
> all other entries' protection are also RW+NX.
>

I tried very similar approach few months ago (for toy implementation) [5],
and the biggest obstacle to this approach was: you need to be extremely sure
that the page->nr_same_prot is ALWAYS correct.

For example, in arch/x86/include/asm/kfence.h [6], it clears and set
_PAGE_PRESENT without going through CPA, which can simply break the count.

[5] https://github.com/hygoni/linux/tree/merge-mapping-v1r3
[6] https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/kfence.h#L56

I think we may need to hook set_pte/set_pmd/etc and use proper
synchronization primitives when changing init_mm's page table to go
further on this approach.

> One final note is, with features like bpf_prog_pack etc., there can be
> much fewer large mapping split IIUC; also, this patchset can not help
> when the page which has its protection changed keeps in use. So my take
> on this large mapping split problem is: to get the most value of keeping
> large mapping intact, features like bpf_prog_pack is important. This
> patchset can help to further reduce large mapping split when in use page
> that has special protection set finally gets released.
> 
> [1]: http://lkml.kernel.org/r/CAPhsuW4eAm9QrAxhZMJu-bmvHnjWjuw86gFZzTHRaMEaeFhAxw@mail.gmail.com
> [2]: https://lore.kernel.org/lkml/20220204185742.271030-1-song@kernel.org/
> 
> Aaron Lu (4):
>   x86/mm/cpa: restore global bit when page is present
>   x86/mm/cpa: merge splitted direct mapping when possible
>   x86/mm/cpa: add merge event counter
>   x86/mm/cpa: add a test interface to split direct map
> 
>  arch/x86/mm/pat/set_memory.c  | 411 +++++++++++++++++++++++++++++++++-
>  include/linux/mm_types.h      |   6 +
>  include/linux/page-flags.h    |   6 +
>  include/linux/vm_event_item.h |   2 +
>  mm/vmstat.c                   |   2 +
>  5 files changed, 420 insertions(+), 7 deletions(-)
> 
> -- 
> 2.37.1
> 
> 
