Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7082514025
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 03:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353874AbiD2BTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 21:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353762AbiD2BTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 21:19:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC67E42A29
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 18:16:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C0D9621F5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B74FC385A9;
        Fri, 29 Apr 2022 01:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651194982;
        bh=8rkO3kGLo8oHISZ4CrKIFImdjcz1oia8ezyV6cjg3zY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JEhlgYZ0Euy2nONZV9GCgJtpHQj1q1Y7sMi5M6ccGRJMVhdkpn5ggNtrtayoXMwAo
         r6afTry/M0nFgJxzzzXKbDLGCBnDDdMZZFnn4jwMuip0j4dE/eGCdqk+Ba45Jeq5y0
         xqqCBJqFy75/eDads3u/hqeBH7dgBMh26iKkpKtk=
Date:   Thu, 28 Apr 2022 18:16:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Message-Id: <20220428181621.636487e753422ad0faf09bd6@linux-foundation.org>
In-Reply-To: <20220429003841.cx7uenepca22qbdl@revolver>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
        <20220426150616.3937571-24-Liam.Howlett@oracle.com>
        <20220428201947.GA1912192@roeck-us.net>
        <20220429003841.cx7uenepca22qbdl@revolver>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 00:38:50 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> > mm/mmap.c: In function 'do_brk_flags':
> > mm/mmap.c:2908:17: error: implicit declaration of function
> > 	'khugepaged_enter_vma_merge'; did you mean 'khugepaged_enter_vma'?
> > 
> > It appears that this is later fixed, but it hurts bisectability
> > (and prevents me from finding the actual build failure in linux-next
> > when trying to build corenet64_smp_defconfig).
> 
> Yeah, that khugepaged_enter_vma_merge was renamed in another patch set.
> Andrew made the correction but kept the patch as it was.  I think the
> suggested change is right.. if you read the commit that introduced
> khugepaged_enter_vma(), it seems right at least.

Things are a bit crazy lately.  Merge issues with mapletree, merge
issues with mglru on mapletree, me doing a bunch of retooling to start
publishing/merging via git, mapletree runtime issues, etc.

I've dropped the mapletree patches again.  Please scoop up all known
fixes and redo against the (non-rebasing) mm-stable branch at
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

The mm-unstable branch is a rebasing tree which contains mm-stable as
well as all the quilt-based MM material which isn't final enough to get
into mm-stable.  So before sending please do a test merge with mm-unstable,
evaluate any issues which might be encountered.

I'd prefer to concentrate on getting mapletree stabilized and landed
for now, worry about mglru after that.
