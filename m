Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B511C4E2E96
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348765AbiCUQzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbiCUQzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:55:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF75C21
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V+O0n8/T4dlnw+eFISA8GklnAyL5enGecea22UcMUKI=; b=BXgSQrrCqsWiMQP7k8drCxU/OO
        RqT41oNEyhZLVS0EB2cF4dTwPFXw+SEM8YR9sfEKHFoTEo4urcJFrg+qzvr0sLPvUp7ahg+QmMf78
        L4UOvrJqM2QlWcjnu6RdLg3dVVzMeZtH++J29YYFDE2WHjiNBP+8bzRAbT2/CsoTaOjYrhXO0ZrEi
        bwv+iwawWuZz2HzWgxFJL4G9DhJC7FmyC/0r8S+ctoZoFVW8Ibh1OC2fD19TrE5102wdR1N8V3V1y
        bsdOVWA7mM0YCbBEX1JHId38236HomQUVOF0gk0o8QhPQ2idXds9WTEGgtb1yehaKGmzQtCgNMIeJ
        pvxnZrOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWLIK-00AlSB-Kg; Mon, 21 Mar 2022 16:54:12 +0000
Date:   Mon, 21 Mar 2022 16:54:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [GIT PULL] Folio patches for 5.18 (MM part)
Message-ID: <YjittBLCYpft5ALc@casper.infradead.org>
References: <Yjh+EuacJURShtJI@casper.infradead.org>
 <9ae0a8e4-41b7-04f4-4435-17cbba9850fb@redhat.com>
 <d5676cf0-30f9-8497-95a8-332767dede46@redhat.com>
 <YjiaSbUBLJP+9Jtt@casper.infradead.org>
 <9ece8da5-ae0c-fe1c-ff2f-961f641c00fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ece8da5-ae0c-fe1c-ff2f-961f641c00fe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 04:38:22PM +0100, David Hildenbrand wrote:
> On 21.03.22 16:31, Matthew Wilcox wrote:
> >>>> Alex Sierra (10):
> >>>>       mm: add zone device coherent type memory support
> >>>>       mm: add device coherent vma selection for memory migration
> >>>>       mm/gup: fail get_user_pages for LONGTERM dev coherent type
> >>>>       drm/amdkfd: add SPM support for SVM
> >>>>       drm/amdkfd: coherent type as sys mem on migration to ram
> >>>>       lib: test_hmm add ioctl to get zone device type
> >>>>       lib: test_hmm add module param for zone device type
> >>>>       lib: add support for device coherent type in test_hmm
> >>>>       tools: update hmm-test to support device coherent type
> >>>>       tools: update test_hmm script to support SP config
> >>>>
> >>>> Alistair Popple (2):
> >>>>       mm: remove the vma check in migrate_vma_setup()
> >>>>       mm/gup: migrate device coherent pages when pinning instead of failing
> >>>
> >>> ... I thought DEVICE_COHERENT is still under development?
> >>>
> >>
> >> After verifying that I'm not daydreaming [1] (and realizing that I had
> >> review comments to some of these patches that have not been resolved
> >> yet) and also not spotting these change in your changelog above, I
> >> assume this stuff was included by mistake. NACK to merging
> >> DEVICE_COHERENT at this point.
> >>
> >> [1] https://lkml.kernel.org/r/20220310172633.9151-1-alex.sierra@amd.com
> > 
> > That patch ("split vm_normal_pages for LRU and non-LRU handling") isn't
> > included in this pull request.  The patches I have were those sent by
> > Christoph here:
> > 
> > https://lore.kernel.org/linux-mm/20220210072828.2930359-1-hch@lst.de/
> > 
> > I can drop any patches that you have objections to, but I don't see
> > any objections from you to any patches in that list.
> 
> Well, I was discussing with the original authors about how to proceed.
> 
> Quoting from:
> 
> https://lkml.kernel.org/r/1747447c-202d-9195-9d44-57f299be48c4@amd.com
> 
> "
> Yes, it should be part of that series. Alex developed it on top of the
> series for now. But I think eventually it would need to be spliced into it.

It wasn't clear to me that you were talking about this series.

> Patch1 would need to go somewhere before the other DEVICE_COHERENT
> patches (with minor modifications). Patch 2 could be squashed into
> "tools: add hmm gup test for long term pinned device pages" or go next
> to it. Patch 3 doesn't have a direct dependency on device-coherent
> pages. It only mentions them in comments.
> "
> 
> I can understand that Christoph included a rebased version in his rework
> (to keep it working in -next and/or help the original authors?), but to
> me that doesn't mean that the feature is finally done.

OK, so you object to the last 12 patches from Alistair and Alex?  And
you're OK with the preceeding 15 patches from Christoph?  I can put
together a pull request for that combination.

