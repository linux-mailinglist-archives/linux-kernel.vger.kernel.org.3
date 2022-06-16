Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F4854DE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbiFPJpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbiFPJpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:45:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163AA5A163
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EZ8NU+0w2F5SD78Q+6uxvFt+DO+F+fvNNYXfPlfLgcI=; b=lynUDM/hMhZEZmLGxZWZU+3h1Q
        8V0+gQMhmdZfNddmtIlBBjkwLJf7KOk3T4eljm8z7suhTpxNCNU8ny1wCZllNNEO7SGebgoPkjNRP
        lfafb3kJi459hMdxH9f+cvYnyQKajRNSLry4r+hPBghzZdZwn73JUV4c+GzOU2Uj+TsUrea30z9mq
        v/99kdh62FfTN0GwwUY/M3G2W/qrOMlKVl4QBYBwS5/8jEJgsl22Stjq7nLFlOE3LVuMJ6x9/deiG
        yObiPXD8mQ3v8a3SA22ncYWQoR6aSt+RfgcRpdOEpYb4OsY2qZmG+eJ4jFWYYyE9eMpdvsytfNefR
        /u3EH0UQ==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1m3g-008Njg-EB; Thu, 16 Jun 2022 09:45:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3C333031CB;
        Thu, 16 Jun 2022 11:44:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF5BB2014ABD6; Thu, 16 Jun 2022 11:44:59 +0200 (CEST)
Date:   Thu, 16 Jun 2022 11:44:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "kcc@google.com" <kcc@google.com>, Andi Kleen <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Message-ID: <Yqr7mzvX1+hWM8NL@hirez.programming.kicks-ass.net>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
 <c3b4f3ccf8ee547a588bf8a971064e4d62b6a44c.camel@intel.com>
 <20220610180635.l44opq2votd3gxpl@black.fi.intel.com>
 <5b56c88e477d879e5a0e3c15627cb05901a812f4.camel@intel.com>
 <dda083610d4c8b8d8d0b09021345e9cc0cb35bbe.camel@intel.com>
 <5d3b281f-3d8b-4bbd-9681-b226810c3e8b@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d3b281f-3d8b-4bbd-9681-b226810c3e8b@www.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 02:03:43PM -0700, Andy Lutomirski wrote:

> >> > > > +       /* LAM has to be enabled before spawning threads */
> >> > > > +       if (get_nr_threads(current) > 1)
> >> > > > +               return -EBUSY;

> >> > > Does this work for vfork()? I guess the idea is that locking is

vfork() isn't the problem, the problem is that Linux allows CLONE_VM
without CLONE_THREAD. Now, mostly nobody does that these days, but it is
possible.

> get_nr_threads() is the wrong thing.  Either look at mm->mm_users or
> find a way to get rid of this restriction entirely.

mm->mm_users should indeed be sufficient here.

> IMO it would not be insane to have a way to iterate over all tasks
> using an mm.  But doing this for io_uring, etc might be interesting.

That has come up so often over the past 15+ years I've no idea how come
we've still not managed to actually do that ;-)
