Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A0654223F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443337AbiFHA54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578040AbiFGXb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:31:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5414351A2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:00:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 22E9ACE2018
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 22:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CD3C385A2;
        Tue,  7 Jun 2022 22:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654639200;
        bh=8sL/rpVGiBwSPrjgFyVx4IBH9TqPDfomNd6mM8hy9kU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YyEmDOruYF7lVaZO4mPnA3SXKSgcKPOjb3an5AivFk4EHvhDPF0FP5i78f89hDw42
         WQh31V72ZEffZrfbpmy7yrLeeHt/26dVf29QXB0juYr2UiuWp/21DT4UlVdrOdeaEl
         xdHSPld+OLAEZ6A0kLMws3s6L7gq0297zHXhPM5w=
Date:   Tue, 7 Jun 2022 14:59:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     HORIGUCHI =?UTF-8?B?TkFPWUE=?= (=?UTF-8?B?5aCA5Y+jIOebtOS5nw==?=) 
        <naoya.horiguchi@nec.com>, zhenwei pi <pizhenwei@bytedance.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH] mm/memory-failure: don't allow to unpoison hw corrupted
 page
Message-Id: <20220607145959.785e54c752f373bcc283732b@linux-foundation.org>
In-Reply-To: <5e7abb3f-56e7-0343-a678-749b6f5238a2@redhat.com>
References: <20220604103229.3378591-1-pizhenwei@bytedance.com>
        <20220604115616.b7d5912ac5a37db608f67b78@linux-foundation.org>
        <584eedd3-9369-9df1-39e2-62e331abdcc0@bytedance.com>
        <20220606043202.GA1328953@hori.linux.bs1.fc.nec.co.jp>
        <3b58adbf-a8b2-8dba-71a7-123ba3850c10@bytedance.com>
        <20220606091503.GA1337789@hori.linux.bs1.fc.nec.co.jp>
        <5e7abb3f-56e7-0343-a678-749b6f5238a2@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022 14:36:00 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 06.06.22 11:15, HORIGUCHI NAOYA(堀口 直也) wrote:
> >>>    [  917.864266]  <TASK>
> >>>    [  917.864961]  clear_huge_page+0x147/0x270
> >>>    [  917.866236]  hugetlb_fault+0x440/0xad0
> >>>    [  917.867366]  handle_mm_fault+0x270/0x290
> >>>    [  917.868532]  do_user_addr_fault+0x1c3/0x680
> >>>    [  917.869768]  exc_page_fault+0x6c/0x160
> >>>    [  917.870912]  ? asm_exc_page_fault+0x8/0x30
> >>>    [  917.872082]  asm_exc_page_fault+0x1e/0x30
> >>>    [  917.873220] RIP: 0033:0x7f2aeb8ba367
> >>>
> >>> I don't think of a workaround for this now ...
> >>>
> >>
> >> Could you please tell me how to reproduce this issue?
> > 
> > You are familiar with qemu-monitor-command, so the following procedure
> > should work for you:
> > 
> >   - run a process using hugepages on your VM,
> >   - check the guest physical address of the hugepage (page-types.c is helpful for this),
> >   - inject a MCE with virsh qemu-monitor-command on the guest physical address, then
> >   - unpoison the injected physical address.
> 
> That's triggered via debugfs / HWPOISON_INJECT, right?
> 
> That's a DEBUG_KERNEL option, so I'm not 100% sure if we really want to
> cc stable.

Sure, it's hardly a must-have.  But let's also take the patch
complexity&risk into account.  This is one dang simple patch.

Or is it.  Should these things be happening outside mf_mutex?  What the
heck is the role of mf_mutex anyway?
