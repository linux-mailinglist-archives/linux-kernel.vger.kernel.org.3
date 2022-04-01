Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27BF4EFA6C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 21:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351654AbiDATdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 15:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbiDATdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:33:52 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E63176654;
        Fri,  1 Apr 2022 12:32:02 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1naN03-0001hH-O7; Fri, 01 Apr 2022 21:31:59 +0200
Date:   Fri, 1 Apr 2022 21:31:59 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Vasily Averin <vasily.averin@linux.dev>
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>, kernel@openvz.org,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH nft] nft: memcg accounting for dynamically allocated
 objects
Message-ID: <20220401193159.GB28321@breakpoint.cc>
References: <bf4b8fe3-6dd6-4f3a-12f4-1b5bf2e45783@linux.dev>
 <e730480d-9396-6486-ab98-67ecb683e819@linux.dev>
 <20220401120342.GC9545@breakpoint.cc>
 <7bfa2e2e-b22d-7561-661b-41ef7714caf5@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bfa2e2e-b22d-7561-661b-41ef7714caf5@linux.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin <vasily.averin@linux.dev> wrote:
> > Same problem as connlimit, can be called from packet path.
> > Basically all GFP_ATOMIC are suspicious.
> > 
> > Not sure how to resolve this, similar mechanics in iptables world (e.g.
> > connlimit or SET target) don't use memcg accounting.
> > 
> > Perhaps for now resend with only the GFP_KERNEL parts converted?
> > Those are safe.
> 
> It is safe for packet path too, _ACCOUNT allocation will not be able to find memcg
> in case of "!in_task()" context.
> On the other hand any additional checks on such path will affect performance.

I'm not sure this works with ksoftirqd serving network stack?

> Could you please estimate how often is this code used in the case of nft vs packet path?

It depends on user configuration.
Update from packet path is used for things like port knocking or other
dyanamic filter lists, or somehing like Limiting connections to x-per-address/subnet and so on.

> If the opposite is the case, then I can add __GFP_ACCOUNT flag depending on in_task() check.

But what task/memcg is used for the accounting in that case?
