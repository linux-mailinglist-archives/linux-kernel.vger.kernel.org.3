Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29BF535243
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244348AbiEZQlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiEZQlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:41:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA10C3B3C0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653583267; x=1685119267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tjBaAbh6HrriUT68SvY0WLPr98BrVKnGVpNLD4OjveA=;
  b=KTDaH4gFvMvaH/yMPmsfyEDwmI0AnUFZwJKawOx8XXg7gmSCaahRAgPy
   uEEY9X2q8eRZHPq6RIr5nJoNatFb2A7CLbizzOnxCk2xoZn/1xM13/AYz
   Wx/kKkUbUP/08Uzv59Lz5PZsTics9YhB8AMmFli2RC0HlI46yea6mY7LA
   Mu33NIGUZbrrZFPdLvnHXLEurh3/X2XeB3wVBX6TywdVrLFafHHtSyRTH
   stF8UNfe4L1hRWZpGCZqCLmW4eKRWPJotFD7mW+QMJEC0hOl06bizPcej
   Uu1jkuJ+s0f4HVqmfAS1WU1nLEyfWhOGrSTihBR8MHmcSxvyGZbjm4FOd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="360599659"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="360599659"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 09:41:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="573973495"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 09:41:07 -0700
Date:   Thu, 26 May 2022 09:41:06 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Taint addresses
Message-ID: <Yo+tomN1kNkvXiBk@agluck-desk3.sc.intel.com>
References: <20220524185324.28395-1-bp@alien8.de>
 <20220524185324.28395-4-bp@alien8.de>
 <Yo2ASBAElqrQvzh3@agluck-desk3.sc.intel.com>
 <20220525065940.GF2578@worktop.programming.kicks-ass.net>
 <Yo3cpb1yZhwhHEga@zn.tnic>
 <4644ff0530ba40948ed1f0e2e45a24d8@intel.com>
 <Yo5LAenZIsYmM9Ie@zn.tnic>
 <c40151ec88db4b7aa7dcadf6428b019e@intel.com>
 <Yo5SupgZjT/a1p5m@zn.tnic>
 <Yo9uYL9eL9KBuzam@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo9uYL9eL9KBuzam@zn.tnic>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 02:11:12PM +0200, Borislav Petkov wrote:
> I guess something like this:
> 
> ...
> [    2.591532] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    2.592678] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G S       C        5.18.0+ #7
> [    2.593079] Last taint addresses:
> [    2.593079]  S:start_kernel+0x614/0x634
> [    2.593079]  C:kernel_init+0x70/0x140

Maybe something a little more user friendly than addresses?

If there was a new macro:

#define add_taint(flag, lockdep) __add_taint(flag, lockdep, __FILE__, __LINE__)

then renmame existing add_taint() to __add_taint() and have it save the
file/line values.

Then you could print filename:line

Also: Is it more useful to store the most recent taint of each type,
or the first of each type?

-Tony
