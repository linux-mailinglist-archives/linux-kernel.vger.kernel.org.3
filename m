Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F19520A79
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 03:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiEJBIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 21:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiEJBHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 21:07:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F5521B146
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 18:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33740B81A50
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 01:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763C0C385C2;
        Tue, 10 May 2022 01:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652144637;
        bh=aQB+EIItZRmuzbO4IcL2oBYPBcYCUUntWM5wji7KkFc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mu8TGd39OAW4aZVLqxOVW1+zcH/47f1GRgIZ/HnfOCz1j48b31nMyGpuyUtCbKyPU
         h+2mwCSfI5byIFCiq5b40sTsONdFq8eCK4TG9UXSAeP2XqeWYsuFO278Bn/FXjC1/O
         1HW8ebntV6+ARDkp2oimhDmFMik1yBxUnNuhTgdY=
Date:   Mon, 9 May 2022 18:03:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Zi Yan <zi.yan@sent.com>, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v11 0/6] Use pageblock_order for cma and
 alloc_contig_range alignment.
Message-Id: <20220509180356.24ff0403cf3ffc3fd01ffe98@linux-foundation.org>
In-Reply-To: <20220425143118.2850746-1-zi.yan@sent.com>
References: <20220425143118.2850746-1-zi.yan@sent.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 10:31:12 -0400 Zi Yan <zi.yan@sent.com> wrote:

> This patchset tries to remove the MAX_ORDER-1 alignment requirement for CMA
> and alloc_contig_range(). It prepares for my upcoming changes to make
> MAX_ORDER adjustable at boot time[1].

I'm thinking this looks ready to be merged into mm-stable later this week, for
the 5.19-rc1 merge window.

I believe the build error at
https://lkml.kernel.org/r/CA+G9fYveMF-NU-rvrsbaora2g2QWxrkF7AWViuDrJyN9mNScJg@mail.gmail.com
was addressed in ARM?

I have one -fix to be squashed,
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-make-alloc_contig_range-work-at-pageblock-granularity-fix.patch

