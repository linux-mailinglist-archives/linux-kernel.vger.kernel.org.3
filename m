Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3B7507BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356070AbiDSV1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239279AbiDSV1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:27:15 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9F041FB0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:24:30 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id y129so6602251qkb.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ibsdoBgiJuDiIdRsXH0t+hdnEs4Yi8O9Fhx00crlPtE=;
        b=3SelgyL75xPSUHO5atKbLBSCLfMUldyCMHajJey2fc9NSopOB2JqQ/z15Ya578w5dZ
         rreFLzcs+BffPfZIulsSaSZBk1tcjf6gzmym+2B7jhQLMCEJUNBudFbkv7eRYLPbW9ml
         rHOKzxpXci8P7wjlWiDbWWQHsUzEq/2TIRCxR6/PRfVABWQoGlV1MZMkEDNzcL/ooXrO
         rfKaHTwM39bv/EHp01tJe57y+0K/2F+rpyld7ZJZI49jqTcMwmvX649k0EopQVVbJsZH
         s+xA2t/7XeB+6VwMGgtv1uLKVMha2wuCKoqzBH6977fOf23aduQ0e9XRNWsFjwJ4CQhw
         c6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ibsdoBgiJuDiIdRsXH0t+hdnEs4Yi8O9Fhx00crlPtE=;
        b=kHhuoPmYspjn9HBG3ZkU8+rEKtdFzOXx/f4o4OK0XMSU7IbeCVt2HNF2+UozIGU+uF
         ln3jaC4kqJoAsdM7s+z7YCIfqJG6NkdOeNSJwX3K6llKBySjuwbLWF6jnRY4/SVJecOe
         y04J2sNAQxA3OK4CTKT3ILKHbl1fb3Ta5D5kojMTgCg/Ajb9UYzbo1tnNI7mhFeHMACb
         MiVmgQySsHEOw/fU+gzeApJs1qDVK4SKq6A2QUgac8ZRZIy15JeJk1nZCWvaeRyC56s3
         dO8kca0QXbGasG9ncw9pODEaBCaLSbRZf6x+vPHq+G89WbDBOKGsAP06YUduOd7WPKaY
         WmEg==
X-Gm-Message-State: AOAM532vfWudEtyJgOGRJra0iv/ae/a/h+Y28r9sDtyS9GpTXocrEfq9
        Gk7t8KKCT3A+1fJo8GoJYQg3xg==
X-Google-Smtp-Source: ABdhPJz2oh1C+IuJOt5EhDLsX8SfnMQz7pOi3Y6SmEfuithJotmjkv6ukh/Drox0ndy27gyjiC3lwA==
X-Received: by 2002:a05:620a:1344:b0:69e:6485:646f with SMTP id c4-20020a05620a134400b0069e6485646fmr10944276qkl.264.1650403469848;
        Tue, 19 Apr 2022 14:24:29 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id p3-20020a05620a15e300b0069e5b556f75sm533642qkm.5.2022.04.19.14.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 14:24:29 -0700 (PDT)
Date:   Tue, 19 Apr 2022 17:24:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v8 22/23] mm: Enable PTE markers by default
Message-ID: <Yl8ojDwxsD/wqWM4@cmpxchg.org>
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014929.15158-1-peterx@redhat.com>
 <Yl7RrKV5mXtNAAzi@cmpxchg.org>
 <Yl8UmWQodLX+JkZ7@xz-m1.local>
 <Yl8YE+w+OWz5RNOL@cmpxchg.org>
 <Yl8bYKOJGW2py7Q0@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl8bYKOJGW2py7Q0@xz-m1.local>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 04:28:16PM -0400, Peter Xu wrote:
> On Tue, Apr 19, 2022 at 04:14:11PM -0400, Johannes Weiner wrote:
> > On Tue, Apr 19, 2022 at 03:59:21PM -0400, Peter Xu wrote:
> > > @@ -910,16 +910,16 @@ config ANON_VMA_NAME
> > Btw, this doesn't do much without userfaultfd being enabled in
> > general, right?
> 
> So far yes, but I'm thinking there can be potential other users of
> PTE_MARKERS from mm world.  The most close discussion is on the swap read
> failures and this patch proposed by Miaohe:
> 
> https://lore.kernel.org/lkml/20220416030549.60559-1-linmiaohe@huawei.com/
>
> So I hope we can still keep them around here under mm/ if possible, and
> from the gut feeling it really should..

Agreed, mm/ seems a good fit for PTE_MARKER.

If it's invisible and gets selected as needed, it's less of a concern,
IMO. I'm somewhat worried about when and how the user-visible options
show up right now, though...

> > Would it make sense to have it next to 'config USERFAULTFD' as a
> > sub-option?
> 
> Yes another good question. :)
> 
> IIUC CONFIG_USERFAULTFD resides in init/Kconfig because it introduces a new
> syscall.  Same to the rest of the bits for uffd since then, namely:
> 
>   - USERFAULTFD_WP
>   - USERFAULTFD_MINOR
> 
> What I am thinking now is the other way round of your suggestion: whether
> we should move most of them out, at least the _WP and _MINOR configs into
> mm/?  Because IMHO they are really pure mm ideas and they're irrelevant to
> syscalls and init.

I'm thinking the MM submenu would probably be a better fit for all
user-visible userfaultfd options, including the syscall. Like you say,
it's an MM concept.

But if moving the syscall knob out from init isn't popular, IMO it
would be better to add the new WP option to init as well. This ensures
that when somebody selects userfaultfd, they also see the relevant
suboptions and don't have to chase them down across multiple submenus.

Conversely, they should also have the necessary depend clauses so that
suboptions aren't visible without the main feature. E.g. it asked me
for userfaultd options even though I have CONFIG_USERFAULTFD=n.

What do you think?
