Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63195695B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 01:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbiGFXOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 19:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbiGFXN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:13:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEDE2BB05
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 16:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657149226; x=1688685226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MsH9VfZ6s5BBxdiYFO1xXZm3xVBgILtliRATJrH+FVI=;
  b=dAUi/dSFMUqofWzUUR98KwSecIZanummffzuBDzXro1RSQF/jRLeorgA
   Qsn90W3mFo62zEpSkifugJ/EBA4Ktd1xfqVTw1mDdbQZEYiaGqCyV87pY
   UCivTkvDCbEkY6ltVrS5H2yzWOpnBz2lHye87MoxGY/Vf5gkuJtTklBk4
   NhmFVuZfpLwPAs295cefOsehCReoMKoXhDJlkP/xn7eenc7Ydsx4iZDmL
   CBT4ROJbpp/NC6FMpGTEfr/DZNkBdu4eAoiRTAtSYa3lUeCd+CCPsXP8G
   51OoVHrpnFkIh04nV7Wh2E9HomQLcGCLaCnaCYfbRQwlbRS10JCdr20vt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="272680677"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="272680677"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 16:13:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="770216669"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 06 Jul 2022 16:13:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id A5F0E11D; Thu,  7 Jul 2022 02:13:49 +0300 (EEST)
Date:   Thu, 7 Jul 2022 02:13:49 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv4 3/8] mm: Pass down mm_struct to untagged_addr()
Message-ID: <20220706231349.4ghhewbfpzjln56u@black.fi.intel.com>
References: <20220622162230.83474-1-kirill.shutemov@linux.intel.com>
 <20220622162230.83474-4-kirill.shutemov@linux.intel.com>
 <CAG_fn=WgyitSd9h2ni2xpBBvgnoGTcwZOpWyNE5QRSRn+PcC=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=WgyitSd9h2ni2xpBBvgnoGTcwZOpWyNE5QRSRn+PcC=A@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 05:42:21PM +0200, Alexander Potapenko wrote:
> Kirill,
> 
> 
> > diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
> > index feeb935a2299..abc096a68f05 100644
> > --- a/lib/strnlen_user.c
> > +++ b/lib/strnlen_user.c
> > @@ -97,7 +97,7 @@ long strnlen_user(const char __user *str, long count)
> >                 return 0;
> >
> >         max_addr = TASK_SIZE_MAX;
> > -       src_addr = (unsigned long)untagged_addr(str);
> > +       src_addr = (unsigned long)untagged_addr(current->mm, str);
> 
> In a downstream kernel with LAM disabled I'm seeing current->mm being
> NULL at this point, because strnlen_user() is being called by
> kdevtmpfs.
> IIUC current->mm is only guaranteed to be non-NULL in the userspace
> process context, whereas untagged_addr() may get called in random
> places.
> 
> Am I missing something?

Hm. Could you show a traceback?

As strnlen_user() intended to be used on an user string I expected it to
be called from a process context. I guess I'm wrong, but I don't yet
understand why.

-- 
 Kirill A. Shutemov
