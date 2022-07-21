Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A3957C67A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiGUIh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiGUIhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:37:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317D87F502
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/waEL92ZUjXVpyZQLVT0SgQb3olAeZWoorHC9Ns4fIg=; b=HxnTYQo+qITEJ6oSSbWJAZ/yI/
        lyKER31rJ7VVPVww3Xea1b9bKkpDn0mY4GpnLbNc529I7g/4qrI4T1l2pMuTgGSqAkWZQBfkZhYNk
        mY1c5jiHj1A7LpVZTsdTUhjuTXeFo0jEUHkOlJpkddoqc5rkGiNXAMho9fr4Gek+qIuCCOcpGp4Wb
        5j7q7oomDKCPvg/miF1xrRDUfgUcnmUfTkO3UAX3ElcUGcEpB4yBCTE+Hqs5Kb5sFG1IJrVzwQDR/
        p/CmQHNYBLoWxXYHn1R76uY8w0ryC24Aq5QGeIU1l5ZYw90nqZTp9s0QiL5zLHBkuHFOcsXABtzi3
        QyUBgebw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oERgH-005W43-0Y; Thu, 21 Jul 2022 08:37:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81215300790;
        Thu, 21 Jul 2022 10:37:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B41C2011B913; Thu, 21 Jul 2022 10:37:08 +0200 (CEST)
Date:   Thu, 21 Jul 2022 10:37:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/4] munmap() vs unmap_mapping_range()
Message-ID: <YtkQNA4jkhfEfWzs@hirez.programming.kicks-ass.net>
References: <20220708071802.751003711@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708071802.751003711@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 09:18:02AM +0200, Peter Zijlstra wrote:
> Hi,
> 
> These 4 patches implement the suggestion by Linus.
> 
> The first patch nukes all architecture implementations of tlb_{start,end}_vma()
> by adding two additional MMU_GATHER config knobs.
> 
> DaveM, please clarify the sparc64 case, it seems a little odd to have
> flush_cache_range() but to explicitly not call it at unmap time. It would be
> nice to remove this one special case.
> 
> The second patch isn't strictly needed for this series but since I was looking
> at all this, I figured C-SKY didn't make a whole lot of sense. Guo, please
> have a look.
> 
> The third patch cleans up the #ifdeffery and provides a single
> tlb_{start,end}_vma() implementation for everyone.
> 
> The fourth, and final, patch does the force TLB-flush on VM_PFNMAP thing.
> 
> I've had the first three patches exposed to the robots and they've (so far) not
> reported build (or other) fail.
> 

What are we doing with these patches? Andrew will you pick them up, or
will I smuggle them in x86/mm or something ?
