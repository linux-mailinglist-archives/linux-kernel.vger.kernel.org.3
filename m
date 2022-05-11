Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F07523EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347841AbiEKUhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiEKUhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:37:02 -0400
Received: from smtp-2.orcon.net.nz (smtp-2.orcon.net.nz [60.234.4.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA685289A8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:37:00 -0700 (PDT)
Received: from [121.99.247.178] (port=10273 helo=creeky)
        by smtp-2.orcon.net.nz with esmtpa (Exim 4.90_1)
        (envelope-from <mcree@orcon.net.nz>)
        id 1not4n-00080s-4K; Thu, 12 May 2022 08:36:53 +1200
Date:   Thu, 12 May 2022 08:36:48 +1200
From:   Michael Cree <mcree@orcon.net.nz>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: Alpha: rare random memory corruption/segfault in user space
 bisected
Message-ID: <YnweYF9E5mt2HIwV@creeky>
References: <YnWRVd5slCy5H0fC@creeky>
 <20220507015646.5377-1-hdanton@sina.com>
 <CAOUHufY=xAvDKSaV8vybgObXPBEsPqqS7R3+T_-6ix7bUvQc6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufY=xAvDKSaV8vybgObXPBEsPqqS7R3+T_-6ix7bUvQc6w@mail.gmail.com>
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 11:27:15AM -0700, Yu Zhao wrote:
> On Fri, May 6, 2022 at 6:57 PM Hillf Danton <hdanton@sina.com> wrote:
> >
> > On Sat, 7 May 2022 09:21:25 +1200 Michael Cree wrote:
> > > Alpha kernel has been exhibiting rare and random memory
> > > corruptions/segaults in user space since the 5.9.y kernel.  First seen
> > > on the Debian Ports build daemon when running 5.10.y kernel resulting
> > > in the occasional (one or two a day) build failures with gcc ICEs either
> > > due to self detected corrupt memory structures or segfaults.  Have been
> > > running 5.8.y kernel without such problems for over six months.
> > >
> > > Tried bisecting last year but went off track with incorrect good/bad
> > > determinations due to rare nature of bug.  After trying a 5.16.y kernel
> > > early this year and seen the bug is still present retried the bisection
> > > and have got to:
> > >
> > > aae466b0052e1888edd1d7f473d4310d64936196 is the first bad commit
> > > commit aae466b0052e1888edd1d7f473d4310d64936196
> > > Author: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > Date:   Tue Aug 11 18:30:50 2020 -0700
> > >
> > >     mm/swap: implement workingset detection for anonymous LRU
> 
> This commit seems innocent to me. While not ruling out anything, i.e.,
> this commit, compiler, qemu, userspace itself, etc., my wild guess is
> the problem is memory barrier related. Two lock/unlock pairs, which
> imply two full barriers, were removed. This is not a small deal on
> Alpha, since it imposes no constraints on cache coherency, AFAIK.
> 
> Can you please try the attached patch on top of this commit? Thanks!

Thanks, I have that running now for a day without any problem showing
up, but that's not long enough to be sure it has fixed the problem. Will
get back to you after another day or two of testing.

Cheers,
Michael.
