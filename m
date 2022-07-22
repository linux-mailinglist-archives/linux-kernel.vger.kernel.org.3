Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78A157E0DC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 13:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbiGVLe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 07:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiGVLe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 07:34:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC6183203
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 04:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vzFVhxjPLkVoOwlSEMBXDn0Z4QsfC5wfdGmZghD2Xmk=; b=hYknKNwUpfji74BW0PXJy6AVGo
        ELtX1LHHzIGiAsgVfmFdYwbwkJuXHmBbmR92iJiLOQkTa9bRjBbo0IYKzCgQfL+ZDNDCy4TlHB6Dv
        /BEMeQJD3RzTvJ5udf1xq+DyNz6DEqfRJ6Shx1un2jkV2+IvxAUGxjlVn6UV+DsWA674bP8qcuv32
        pTQ96cHZQHyj7Uv0f2FIX9JNitNDqdxN3NAn3RoC1rC/UDGox/vTiMa0ss/3kIlJcnyDLNIHX3DRE
        t3AUYZ0uaJaF4exYvedSoWFQs1C4lAx+VVfUmLwx1mTXUe4BkhVSJdpDQtekh/DSMCjcfBbc8Bi7C
        4buegSww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEqvX-00GGW7-Lf; Fri, 22 Jul 2022 11:34:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E13DE98029B; Fri, 22 Jul 2022 13:34:38 +0200 (CEST)
Date:   Fri, 22 Jul 2022 13:34:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wen Pu <puwen@hygon.cn>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: retbleed on hygon
Message-ID: <YtqLTtd8Euw/UC6K@worktop.programming.kicks-ass.net>
References: <YtVHr1jDOtUXYF0Z@worktop.programming.kicks-ass.net>
 <584296cf-80d7-5c78-8bd0-6eb53a5bc914@hygon.cn>
 <YtVhKtJkb23CcTtb@worktop.programming.kicks-ass.net>
 <1a7c7b91-06d5-5336-279c-6bfacfb209f3@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a7c7b91-06d5-5336-279c-6bfacfb209f3@hygon.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 11:17:19AM +0000, Wen Pu wrote:
> On 2022/7/18 21:33, Peter Zijlstra wrote:
> > On Mon, Jul 18, 2022 at 01:03:41PM +0000, Wen Pu wrote:
> >> On 2022/7/18 19:44, Peter Zijlstra wrote:
> >>> Hi Pu Wen,
> >>>
> >>> Now that retbleed is public could you please review the patches in
> >>> question and clarify the situation vs Hygon please? For development I've
> >>> assumed Hygon is basically Zen1 wrt this issue.
> >>
> >> Hi Peter,
> >>
> >> I'm sorry that there is something wrong with my email these days, so I
> >> haven't received the patches. Do you mean those with "[peterz: add
> >> hygon]" added by you? Thanks a lot for taking Hygon into account. I'll
> >> clarify it as soon as possible.
> > 
> > It's not your email, it was a hardware embargo issue so these patches
> > have never been mailed out before hitting Linus' tree :-/
> > 
> > Please double check the entire series, see the merge commit:
> > 
> >    ce114c866860 ("Merge tag 'x86_bugs_retbleed' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
> > 
> > But in specific pay attention to commits:
> > 
> >    a149180fbcf336e97ce4eb2cdc13672727feb94d
> >    6b80b59b3555706508008f1f127b5412c89c7fd8
> >    3ebc170068885b6fc7bedda6c667bb2c4d533159
> >    d7caac991feeef1b871ee6988fd2c9725df09039
> >    26aae8ccbc1972233afd08fb3f368947c0314265
> > 
> > Basically everything that has HYGON in it. For that first commit, double
> > check with your hardware folks the mitigation actually works for Hygon
> > too. For the other commits validate it DTRT wrt HYGON. Please also send
> 
> We have checked and confirmed the mitigation works for Hygon, so these
> entire series practically DTRT for Hygon. Thanks a lot :)

You're welcome! 
