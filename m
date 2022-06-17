Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D58F54F934
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382595AbiFQOcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiFQOcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:32:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715CB55351
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n6Zz+aFxdEiHH1MPjSMAigtTz+Sr6l2rlt9fbJVef1U=; b=mo/rwvHK81c63F4hSpgHn0GBGR
        I0U0TcJKhamYbUi6saojJFb5N9Cng1/PBXNpxcL9rIlx9s1kiGUfh2J4PF1SVBas5dwpKMBSaMYqn
        kcwx5CZ+fUyM3Xf2WHWP/jFiVlvp0SbtAiS055gTLACXSPcl3DnAsV+zVrjeqYGci1Pawr6b+OamB
        ARdjcJ4i53XtOYQeTYaTPCvTwwmIOZ+8g11aszXC/Y1YfXqz5WELYFsW22qmFTCMBJp4j5l2v4Jsk
        lysg3z8KgYe+HTdvBxhvyrM524QQo+US1aW94I0tUNkZvKx85zj+8ZMzA857UhtE67GulW4PIRwQU
        UeObxO4w==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2Cxo-002tc3-Og; Fri, 17 Jun 2022 14:28:44 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1CC059816B5; Fri, 17 Jun 2022 16:28:43 +0200 (CEST)
Date:   Fri, 17 Jun 2022 16:28:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kcc@google.com" <kcc@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv3 5/8] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
Message-ID: <YqyPmhKLzvc7iXxT@worktop.programming.kicks-ass.net>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-6-kirill.shutemov@linux.intel.com>
 <c7e2f8fb44da067e7565d091edeac300977b65ed.camel@intel.com>
 <Yqr4SVMyHRTkc+LN@hirez.programming.kicks-ass.net>
 <20220616164440.vw7sqnof6grrmnvl@black.fi.intel.com>
 <YqxnMbMhvWO9rEy4@worktop.programming.kicks-ass.net>
 <CAMe9rOq_WT-dxS3xthGtagn=aHruHyUJDR_=RDvMi9vX5PCmnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMe9rOq_WT-dxS3xthGtagn=aHruHyUJDR_=RDvMi9vX5PCmnA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 07:22:57AM -0700, H.J. Lu wrote:
> On Fri, Jun 17, 2022 at 4:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Jun 16, 2022 at 07:44:40PM +0300, Kirill A. Shutemov wrote:
> > > Any objection against this variant (was posted in the thread):
> > >
> > >               #define untagged_addr(mm, addr) ({                                      \
> > >                       u64 __addr = (__force u64)(addr);                               \
> > >                       s64 sign = (s64)__addr >> 63;                                   \
> > >                       __addr &= (mm)->context.untag_mask | sign;                      \
> > >                       (__force __typeof__(addr))__addr;                               \
> > >               })
> > >
> > > ?
> >
> > Yeah, I suppose that should work fine.
> 
> Won't the sign bit be put at the wrong place?

sign is either 0 or ~0, by or-ing ~0 into the mask, the masking becomes
no-op.
