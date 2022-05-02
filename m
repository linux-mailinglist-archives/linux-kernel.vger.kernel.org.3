Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72529516909
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 02:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378333AbiEBA1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 20:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiEBA1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 20:27:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE5F193F8
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 17:24:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D804B8103C
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 00:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81730C385AA;
        Mon,  2 May 2022 00:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651451058;
        bh=SqhX8SZwcjF2pMzzAuYY1ZAQuRHMrG48hG12yR1lOjw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lVU15tA50Tr8/QIIQwWdgzB72893QGDOFybnnK748npe4DaEwwLMjSGXxuanObB7h
         PoBttkys9XzPRwVfng3d1CnXuf31bte5ZEoj23MopK26ZG6Tj/5If/mYp+u11iBAsi
         vIHvZhiKtP/nsV7URoATbclGjsCIyEiXF4asQZvQ=
Date:   Sun, 1 May 2022 17:24:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Juergen Gross <jgross@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Message-Id: <20220501172412.50268e7b217d0963293e7314@linux-foundation.org>
In-Reply-To: <20220502001358.s2azy37zcc27vgdb@revolver>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
        <20220426150616.3937571-24-Liam.Howlett@oracle.com>
        <20220428201947.GA1912192@roeck-us.net>
        <20220429003841.cx7uenepca22qbdl@revolver>
        <20220428181621.636487e753422ad0faf09bd6@linux-foundation.org>
        <20220502001358.s2azy37zcc27vgdb@revolver>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc S390 maintainers)
(cc stable & Greg)

On Mon, 2 May 2022 00:14:21 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> * Andrew Morton <akpm@linux-foundation.org> [220428 21:16]:
> > On Fri, 29 Apr 2022 00:38:50 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> > 
> > > > mm/mmap.c: In function 'do_brk_flags':
> > > > mm/mmap.c:2908:17: error: implicit declaration of function
> > > > 	'khugepaged_enter_vma_merge'; did you mean 'khugepaged_enter_vma'?
> > > > 
> > > > It appears that this is later fixed, but it hurts bisectability
> > > > (and prevents me from finding the actual build failure in linux-next
> > > > when trying to build corenet64_smp_defconfig).
> > > 
> > > Yeah, that khugepaged_enter_vma_merge was renamed in another patch set.
> > > Andrew made the correction but kept the patch as it was.  I think the
> > > suggested change is right.. if you read the commit that introduced
> > > khugepaged_enter_vma(), it seems right at least.
> > 
> > Things are a bit crazy lately.  Merge issues with mapletree, merge
> > issues with mglru on mapletree, me doing a bunch of retooling to start
> > publishing/merging via git, mapletree runtime issues, etc.
> > 
> > I've dropped the mapletree patches again.  Please scoop up all known
> > fixes and redo against the (non-rebasing) mm-stable branch at
> > git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> 
> Okay, sounds good.
> 
> I have been porting my patches over and hit a bit of a snag. It looked
> like my patches were not booting on the s390 - but not all the time. So
> I reverted back to mm-stable (059342d1dd4e) and found that also failed
> to boot sometimes on my qemu setup.  When it fails it's ~4-5sec into
> booting.  The last thing I see is:
> 
> "[    4.668916] Spectre V2 mitigation: execute trampolines"
> 
> I've bisected back to commit e553f62f10d9 (mm, page_alloc: fix
> build_zonerefs_node())
> 
> With the this commit, I am unable to boot one out of three times.  When
> using the previous commit I was not able to get it to hang after trying
> 10+ times.  This is a qemu s390 install with KASAN on and I see no error
> messages.  I think it's likely it is this patch, but no guaranteed.
> 

Great, thanks.  So mapletree is absolved.

Unfortunately 059342d1dd4e was cc:stable.  Greg, you might want to pull
the plug on that one if it isn't too late.

I'll await input from the S390 team, but from my reading the issues
which that patch addresses aren't terribly serious, so perhaps the
thing to do is to revert 059342d1dd4e (with a cc:stable) while
059342d1dd4e gets a redo?
