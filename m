Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DA14BEE4E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 00:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiBUXZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:25:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiBUXZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:25:52 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02E52458B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645485928; x=1677021928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Gv3hpY5QZY53Ir15UzbMUvC3S5cQYGic9ErfjLXk7c=;
  b=MS1izsLQsG52k5GYDKKkwSrmQ/5ujH9yLNtcsmgnLLjM1Oi3AWlIHioQ
   IUnDfKgU6edy/vljBdH393TZAx6P1Isg9DSt7HJbBk720PgzjCKuuGU10
   Cwn7B1UqzN3S+OyLJ7dQc3g6C3ZxnIwv0FdewL9ilbckNQzg3kdjuGScT
   S+4snctdD8eVZLV+jaCbJUdwsILcPhAbMxk8USI7dVTVHXy/L26YoYit6
   NGMktnVUQm7evJq+YgFqnfj6XpFC8OwppLbdyNlBDlIWrdvGTYFMR5sYJ
   ZZTemYxldlWRng8sdT5fnxoXPFcJhpJJKAaEQdJxEHqHxTm4CQAmYODYh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="250400864"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="250400864"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 15:25:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="638695715"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 21 Feb 2022 15:25:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 8923A12C; Tue, 22 Feb 2022 01:25:38 +0200 (EET)
Date:   Tue, 22 Feb 2022 02:25:38 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Subject: Re: [PATCHv3.1 2.1/2] x86/coco: Add API to handle encryption mask
Message-ID: <20220221232538.3pd3w63s5v3us5xt@black.fi.intel.com>
References: <YhAWcPbzgUGcJZjI@zn.tnic>
 <20220219001305.22883-1-kirill.shutemov@linux.intel.com>
 <20220219001305.22883-2-kirill.shutemov@linux.intel.com>
 <YhP+kES/UVx7RwYz@zn.tnic>
 <20220221221049.p5zvappg4s2mjem7@black.fi.intel.com>
 <YhQUB2dIQJ/Ov3zp@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhQUB2dIQJ/Ov3zp@zn.tnic>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 11:36:55PM +0100, Borislav Petkov wrote:
> On Tue, Feb 22, 2022 at 01:10:49AM +0300, Kirill A. Shutemov wrote:
> > I'm not sure it is a good idea. It leaves room for code between these two
> > calls. I believe they conceptually has to initialized in one shot. That's
> > the only way we get consistent state.
> 
> Really, where?

I'm talking about potential issue if cc_set_vendor() and cc_set_mask()
would drift apart.

But, okay, I see that you don't feel it an issue. Will do your way.

-- 
 Kirill A. Shutemov
