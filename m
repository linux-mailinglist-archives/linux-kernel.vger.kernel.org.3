Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEFB507C94
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358208AbiDSWfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358189AbiDSWft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:35:49 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A372A734
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:33:03 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id j4so7887525vki.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VLPNm1zfYFG8sspty4o9ORFRIBEAx3D1EZl4YM6WiPM=;
        b=Aex8SDRrS5VzWfWlV8iWRhxTbkg8b4dWxKbFr3SMF+tCFKjE+IPPMx16F51NoilY7s
         21rG4wwBx6CoPq8yBlg1ps9EKJcunUoKzUqzpGSZI84Kie/674fmOYdbgurGa8RkFRrs
         rKW+FDdVeXVBWi33KdLRuFtfIHeokXFBUx5QnTm7H0UDJe2qvQ6exPnmq2aGX5w1Jva5
         eiRK3qLEMAdhGPBBscmEY8e5Z74TmukXQM9SI288cjtKyAMxK576z/J2iZdgTInGXKG0
         RgcwEKsAXzQuvMt/REKDj1Zk+2ZWlVRhze2V36wImn0pLRx7cTH3Uy2ycA/1eeWFnTd9
         E+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VLPNm1zfYFG8sspty4o9ORFRIBEAx3D1EZl4YM6WiPM=;
        b=FMcjxgyEsRqXiUiPYJw2Qm3P1I03RmmTML/m23XnKfIMKQXtU1bJN0SjLzhFPVzZ3+
         NHaaXWZ+XxOXhvx3D1pH1/k01iD/PHnje1CyLEDiBLrBH4YBLsX98nZ624ptmgDz7jTH
         KxVNi5WKgnWafDMbtdXhSVuENe/7JGfWqneNnjIUUQ1NGlpIRpO2EboseBRVTAQCi5IY
         vvPNUincc373tlFPjwCmZBzbg+y9pugNWAOVCVKw9prtMlSdwAxX3/bva8Wlkk7bcunL
         RxhayXPTXDrKmuvt9HeWjk5CMiS2jT3+aXP9TamCyMDE0hh4gni6jq2pRYzS+sDTf3y2
         bfFg==
X-Gm-Message-State: AOAM531b/i5iUL3uU1RpYEjKEXDtd30VWoPGVY2sz4fJOYHrDOuCK7jI
        pSz5sh06/qeR1xmhczQG/sSYSavZygk+ekOPjRqnHg==
X-Google-Smtp-Source: ABdhPJygTdEuCeOCg/yL/LJQl7X3o9uh4wxdlNfmN7Kha46mxOdlOP3/DVBLPMHaGFHWrHYIYiGUGhK6BLx6vNi5Hy0=
X-Received: by 2002:a05:6122:887:b0:332:699e:7e67 with SMTP id
 7-20020a056122088700b00332699e7e67mr5134984vkf.35.1650407582433; Tue, 19 Apr
 2022 15:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-9-yuzhao@google.com>
 <20220411191621.0378467ad99ebc822d5ad005@linux-foundation.org>
 <CAOUHufYeC=Kuu59BPL_48sM67CqACxH2wWy-SYGXpadgMDmY3w@mail.gmail.com>
 <20220414185654.e7150bcbe859e0dd4b9c61af@linux-foundation.org>
 <CAOUHufYy6yQS9ARN9C5+ODkopR+ez4TH3hZNZo4HtNHBExS1mA@mail.gmail.com>
 <20220415121521.764a88dda55ae8c676ad26b0@linux-foundation.org>
 <CAOUHufYsjwMGMFCfYoh79rFZqwqS1jDihcBS9sHd-gBxEAD3Ug@mail.gmail.com>
 <20220415143220.cc37b0b0a368ed2bf2a821f8@linux-foundation.org> <CAFbkSA3jdtDrWz9-i2ZED5k8uBx6nwrikSO6x22qGeWqj8bgHg@mail.gmail.com>
In-Reply-To: <CAFbkSA3jdtDrWz9-i2ZED5k8uBx6nwrikSO6x22qGeWqj8bgHg@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 19 Apr 2022 16:32:26 -0600
Message-ID: <CAOUHufZL8T=e8U_gSE+9tg5MZduRfs_CODLrnPydvimiq78BDQ@mail.gmail.com>
Subject: Re: [PATCH v10 08/14] mm: multi-gen LRU: support page table walks
To:     Justin Forbes <jforbes@fedoraproject.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2022 at 10:32 AM Justin Forbes
<jforbes@fedoraproject.org> wrote:
>
> On Fri, Apr 15, 2022 at 4:33 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Fri, 15 Apr 2022 14:11:32 -0600 Yu Zhao <yuzhao@google.com> wrote:
> >
> > > >
> > > > I grabbed
> > > > https://kojipkgs.fedoraproject.org//packages/kernel/5.18.0/0.rc2.23.fc37/src/kernel-5.18.0-0.rc2.23.fc37.src.rpm
> > > > and
> > >
> > > Yes, Fedora/RHEL is one concrete example of the model I mentioned
> > > above (experimental/stable). I added Justin, the Fedora kernel
> > > maintainer, and he can further clarify.
>
> We almost split into 3 scenarios. In rawhide we run a standard Fedora
> config for rcX releases and .0, but git snapshots are built with debug
> configs only. The trade off is that we can't turn on certain options
> which kill performance, but we do get more users running these kernels
> which expose real bugs.  The rawhide kernel follows Linus' tree and is
> rebuilt most weekdays.  Stable Fedora is not a full debug config, but
> in cases where we can keep a debug feature on without it much getting
> in the way of performance, as is the case with CONFIG_DEBUG_VM, I
> think there is value in keeping those on, until there is not.  And of
> course RHEL is a much more conservative config, and a much more
> conservative rebase/backport codebase.
>
> > > If we don't want more VM_BUG_ONs, I'll remove them. But (let me
> > > reiterate) it seems to me that just defeats the purpose of having
> > > CONFIG_DEBUG_VM.
> > >
> >
> > Well, I feel your pain.  It was never expected that VM_BUG_ON() would
> > get subverted in this fashion.
>
> Fedora is not trying to subvert anything.  If keeping the option on
> becomes problematic, we can simply turn it off.   Fedora certainly has
> a more diverse installed base than typical enterprise distributions,
> and much more diverse than most QA pools.  Both in the array of
> hardware, and in the use patterns, so things do get uncovered that
> would not be seen otherwise.
>
> > We could create a new MM-developer-only assertion.  Might even call it
> > MM_BUG_ON().  With compile-time enablement but perhaps not a runtime
> > switch.
> >
> > With nice simple semantics, please.  Like "it returns void" and "if you
> > pass an expression with side-effects then you lose".  And "if you send
> > a patch which produces warnings when CONFIG_MM_BUG_ON=n then you get to
> > switch to windows95 for a month".
> >
> > Let's leave the mglru assertions in place for now and let's think about
> > creating something more suitable, with a view to switching mglru over
> > to that at a later time.
> >
> >
> >
> > But really, none of this addresses the core problem: *_BUG_ON() often
> > kills the kernel.  So guess what we just did?  We killed the user's
> > kernel at the exact time when we least wished to do so: when they have
> > a bug to report to us.  So the thing is self-defeating.
> >
> > It's much much better to WARN and to attempt to continue.  This makes
> > it much more likely that we'll get to hear about the kernel flaw.
>
> I agree very much with this. We hear about warnings from users, they
> don't go unnoticed, and several of these users are willing to spend
> time to help get to the bottom of an issue. They may not know the
> code, but plenty are willing to test various patches or scenarios.

Thanks, Justin. Glad to hear warnings are collected from the field.

Based on all the feedback, my action item is to replace all VM_BUG_ONs
with VM_WARN_ON_ONCEs.
