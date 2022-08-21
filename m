Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289A359B6C0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 01:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiHUXb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 19:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiHUXbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 19:31:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D044183A4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 16:31:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC674B80E6C
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2C4C433C1;
        Sun, 21 Aug 2022 23:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661124681;
        bh=93frIIZD4/yh9PJpmvMIraSV7amDnWg//cgKG28t8Ac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DIejz73nGK0sraa6YCTmiNxF8hiK3k38BjQWFkn31D+ghdIOUVkxt7cItO4cRpqvz
         G5fRavDspWQ898Ps0Po3KYXYhAQRhs29rITOflDaa1QVqF5Ea1zlTy+tiSIR3gMG0D
         CkeN9KOMrzZ/U8DV1PBTURCDrM8lrIelm4C5+rgY=
Date:   Sun, 21 Aug 2022 16:31:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     syzbot <syzbot+681bbbb80445ead3c040@syzkaller.appspotmail.com>,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [syzbot] general protection fault in vma_is_shmem
Message-Id: <20220821163120.df7d936c9f47b6dc875ab763@linux-foundation.org>
In-Reply-To: <0004c00e-e50f-5dcf-20f9-1b8da0822bfd@nvidia.com>
References: <0000000000002c73fd05e6ba3e0b@google.com>
        <20220821013246.a706fa7c2d8cb494efdba02e@linux-foundation.org>
        <0004c00e-e50f-5dcf-20f9-1b8da0822bfd@nvidia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Aug 2022 16:18:48 -0700 John Hubbard <jhubbard@nvidia.com> wrote:

> > vmas[] array.  We haven't messed with gup.c much this time around -
> > just one patch from Alistair ("mm/gup.c: simplify and fix
> > check_and_migrate_movable_pages() return codes").  It does touch this
> > area, but I can't immediately see how it could newly cause this.
> > 
> 
> Neither can I, even after looking at both of these recent commits to
> gup.c in this branch:
> 
> commit 4d1225cd5560 ("mm/gup.c: simplify and fix
> check_and_migrate_movable_pages() return codes")
> 
> commit 0e5d6dac6b65 ("mm/gup: fix FOLL_FORCE COW security issue and
> remove FOLL_COW")
> 
> As you say, a bisection would really help here.

Might
https://lkml.kernel.org/r/20220821183547.950370-1-syoshida@redhat.com
save us?


