Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452CF54A1F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbiFMWO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiFMWOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:14:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE3C23BFC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:14:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45CBE6141B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 22:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C7CC34114;
        Mon, 13 Jun 2022 22:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655158463;
        bh=eD273+X+BzkXpDaLR2HObkBXeSp56Ex7Sjo+sd7QsqM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qeHwFwq8QhV6jatQoViVN070e1CQc33l8WBYFHHVDnoEmiPdN59AyOi+Fbjb0+ACj
         fvwMLeAP0DaeW2CUVwXG3gK8tX9SEUH3uRQcJOQIXbP+WLsoXw0H7WIIILt1q/aNY6
         UJBjIUmr9+vvW8dePY20LfTuRKDqaYCsp6fAQrLY=
Date:   Mon, 13 Jun 2022 15:14:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dave Young <dyoung@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bixuan Cui <cuibixuan@huawei.com>,
        David Vernet <void@manifault.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 0/2] Expose kallsyms data in vmcoreinfo note
Message-Id: <20220613151422.e2173f14909b9149fec8e0a6@linux-foundation.org>
In-Reply-To: <87edzsrzqn.fsf@oracle.com>
References: <20220517000508.777145-1-stephen.s.brennan@oracle.com>
        <20220613142609.3e4be0f2f45671341450232d@linux-foundation.org>
        <87edzsrzqn.fsf@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2022 14:59:44 -0700 Stephen Brennan <stephen.s.brennan@oracle.com> wrote:

> >> Related discussion around the BTF side of this:
> >> https://lore.kernel.org/bpf/586a6288-704a-f7a7-b256-e18a675927df@oracle.com/T/#u
> >> 
> >> Some work-in-progress branches using this feature:
> >> https://github.com/brenns10/dwarves/tree/remove_percpu_restriction_1
> >> https://github.com/brenns10/drgn/tree/kallsyms_plus_btf
> >
> > What's the story on using gdb with this?
> 
> There is no story with GDB as of yet. I was already familiar with the
> code of drgn when I started down this path, so that's what I used. Drgn
> happens to have a very extensible type system which made it quite simple
> to do. I'd love to see support for doing this with GDB, and might look
> into the feasibility of it, but it's not on my roadmap right now.

Naive question - could some standalone tool take this kallsyms-based
info, combine it with a core image and create a minimally-dwarfified
file which any debugger can munch on?
