Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4922C5717CF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiGLK76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiGLK75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:59:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438C1EE30
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B79DAB817DD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43BDC3411C;
        Tue, 12 Jul 2022 10:59:51 +0000 (UTC)
Date:   Tue, 12 Jul 2022 11:59:48 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     patrick wang <patrick.wang.shcn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, dennis@kernel.org,
        tj@kernel.org, cl@linux.com,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: percpu: use kmemleak_ignore_phys() instead of
 kmemleak_free()
Message-ID: <Ys1UJMYa7UW0+Bt0@arm.com>
References: <20220705113158.127600-1-patrick.wang.shcn@gmail.com>
 <20220705142000.4679acaaf1238a73a555ea58@linux-foundation.org>
 <CAGcnep_1QSdkNYqvgYC+ec2XVmqvG6rjZud-NfG22f_wQrJHKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGcnep_1QSdkNYqvgYC+ec2XVmqvG6rjZud-NfG22f_wQrJHKQ@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 10:44:11PM +0800, patrick wang wrote:
> On Wed, Jul 6, 2022 at 5:20 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue,  5 Jul 2022 19:31:58 +0800 Patrick Wang <patrick.wang.shcn@gmail.com> wrote:
> >
> > > Kmemleak recently added a rbtree to store the objects
> > > allocted with physical address. Those objects can't be
> > > freed with kmemleak_free(). Use kmemleak_ignore_phys()
> > > instead of kmemleak_free() for those objects.
> >
> > Thanks.  What are the user-visible runtime effects of this?
> 
> According to the comments, percpu allocations are tracked
> by kmemleak separately. Kmemleak_free() was used to avoid
> the unnecessary tracking. If kmemleak_free() fails, those
> objects would be scanned by kmemleak, which is unnecessary
> but shouldn't lead to other effects.
> 
> I didn't observe any anomaly without this commit on riscv
> and arm64.

What could happen is an increased rate of false negatives as it scans
more than necessary.

> > And are we able to identify a commit for the Fixes: line?
> 
> 0c24e061196c (mm: kmemleak: add rbtree and store physical
> address for objects allocated with PA)
> Current in mm-stable.

I think we could add a Fixes line for the above. For the patch:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
