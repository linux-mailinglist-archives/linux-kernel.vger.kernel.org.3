Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9314EFC13
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 23:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352738AbiDAVQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 17:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245368AbiDAVQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:16:43 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8328148C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 14:14:52 -0700 (PDT)
Date:   Fri, 1 Apr 2022 14:14:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648847690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qQPbMxATgPsqR0bbHUcTP6NBEErFcNaDM6bna/D7CWc=;
        b=S1xB/VeBA2PtdLMYm1TIUy3l5XknOdb7JYkFyCUActTxWOhIhfbV19hvwDT62ns5ZeIN64
        tk4jS6o4OHLGg8jKou/3GF7wwWigcrw4ZsMyVGulwhw/mHUOHnoNyhfn+t90jS/ypz76ur
        Q0PlSXXlJKqdj9aZJT8JGRhk7/8+nL0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Florian Westphal <fw@strlen.de>
Cc:     Vasily Averin <vasily.averin@linux.dev>,
        Pablo Neira Ayuso <pablo@netfilter.org>, kernel@openvz.org,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH nft] nft: memcg accounting for dynamically allocated
 objects
Message-ID: <YkdrRAiO1P7segcd@carbon.dhcp.thefacebook.com>
References: <bf4b8fe3-6dd6-4f3a-12f4-1b5bf2e45783@linux.dev>
 <e730480d-9396-6486-ab98-67ecb683e819@linux.dev>
 <20220401120342.GC9545@breakpoint.cc>
 <7bfa2e2e-b22d-7561-661b-41ef7714caf5@linux.dev>
 <20220401193159.GB28321@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401193159.GB28321@breakpoint.cc>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 09:31:59PM +0200, Florian Westphal wrote:
> Vasily Averin <vasily.averin@linux.dev> wrote:
> > > Same problem as connlimit, can be called from packet path.
> > > Basically all GFP_ATOMIC are suspicious.
> > > 
> > > Not sure how to resolve this, similar mechanics in iptables world (e.g.
> > > connlimit or SET target) don't use memcg accounting.
> > > 
> > > Perhaps for now resend with only the GFP_KERNEL parts converted?
> > > Those are safe.
> > 
> > It is safe for packet path too, _ACCOUNT allocation will not be able to find memcg
> > in case of "!in_task()" context.
> > On the other hand any additional checks on such path will affect performance.
> 
> I'm not sure this works with ksoftirqd serving network stack?
> 
> > Could you please estimate how often is this code used in the case of nft vs packet path?
> 
> It depends on user configuration.
> Update from packet path is used for things like port knocking or other
> dyanamic filter lists, or somehing like Limiting connections to x-per-address/subnet and so on.
> 
> > If the opposite is the case, then I can add __GFP_ACCOUNT flag depending on in_task() check.
> 
> But what task/memcg is used for the accounting in that case?

Root memcg/no accounting, which is the same.

There is a way to account for a specific memcg in such cases, it's used for
bpf maps, for example. We save a pointer to the memcg which created the map and
charge it for all allocations from a !in_task context. But the performance can
be affected, so let's not do without regression tests and a serious need.

Thanks!
