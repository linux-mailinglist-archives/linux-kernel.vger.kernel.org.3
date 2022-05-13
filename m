Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FD3526D58
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 01:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiEMXKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 19:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiEMXKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 19:10:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A0C2E1DD8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 16:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652483404; x=1684019404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AmRezgHHEdw2JBZ1v9lIr+kT3Im+6xmk5HtIS/CA1Mc=;
  b=mq88SsGHEiytXQZkzQYrghDeb1U2DCPBtTrIHjA0IfAJXpW9ZyV+T3J+
   Jg+2gVpLjkUNPAXVqddnZdgQDD7uDbIXjBtaxDO+1Acf9g8tPrnauULDE
   vdmfyEE+zN3Id4+pg+/1ixc/w0QMnbuTsFlW7uIO4lGyC1KFnNleBR5QX
   H2OTXkGABpeYWZDSrrwGp4lnQCLKztXC8IrKJHbvUoWtpZuX7WfocswUY
   bXxCi4J1TqaU8vQrHLmL4MpbQkW1IbZtA4r0EO7ogc9svDSLxfnjWddcE
   83VCuhr+vSSqK3zUhUDT18MP3SwpMrKYMVsMaCsmEd0cDTx+BmQKvdQN8
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="268021474"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="268021474"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 16:10:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="740373181"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 13 May 2022 16:10:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 08838A8; Sat, 14 May 2022 02:09:58 +0300 (EEST)
Date:   Sat, 14 May 2022 02:09:58 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "glider@google.com" <glider@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>
Subject: Re: [RFCv2 03/10] x86: Introduce userspace API to handle per-thread
 features
Message-ID: <20220513230958.dbxp6m3y3lnq74qb@black.fi.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-5-kirill.shutemov@linux.intel.com>
 <CAG_fn=V8k3hiviv3htV6wWZ6fUBri=MORfXGJ+Kz7GdRDZvesA@mail.gmail.com>
 <da0f438bb459050e5a586a17382e961259449761.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da0f438bb459050e5a586a17382e961259449761.camel@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 05:34:12PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2022-05-13 at 16:09 +0200, Alexander Potapenko wrote:
> > > +
> > > +       /* Handle ARCH_THREAD_FEATURE_ENABLE */
> > > +
> > > +       task->thread.features |= features;
> > > +out:
> > > +       return task->thread.features;
> > 
> > Isn't arch_prctl() supposed to return 0 on success?
> 
> Hmm, good point. Maybe we'll need a struct to pass info in and out.

But values >0 are unused. I don't see why can't we use them.

-- 
 Kirill A. Shutemov
