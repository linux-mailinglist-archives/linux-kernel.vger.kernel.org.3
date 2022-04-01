Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DF74EFCF1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 01:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350222AbiDAXD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 19:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiDAXD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 19:03:57 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8499C15D39D;
        Fri,  1 Apr 2022 16:02:06 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1naQHG-0002QZ-2v; Sat, 02 Apr 2022 01:01:58 +0200
Date:   Sat, 2 Apr 2022 01:01:58 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Florian Westphal <fw@strlen.de>,
        Vasily Averin <vasily.averin@linux.dev>,
        Pablo Neira Ayuso <pablo@netfilter.org>, kernel@openvz.org,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH nft] nft: memcg accounting for dynamically allocated
 objects
Message-ID: <20220401230158.GC28321@breakpoint.cc>
References: <bf4b8fe3-6dd6-4f3a-12f4-1b5bf2e45783@linux.dev>
 <e730480d-9396-6486-ab98-67ecb683e819@linux.dev>
 <20220401120342.GC9545@breakpoint.cc>
 <7bfa2e2e-b22d-7561-661b-41ef7714caf5@linux.dev>
 <20220401193159.GB28321@breakpoint.cc>
 <YkdrRAiO1P7segcd@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkdrRAiO1P7segcd@carbon.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Gushchin <roman.gushchin@linux.dev> wrote:
> On Fri, Apr 01, 2022 at 09:31:59PM +0200, Florian Westphal wrote:
> > But what task/memcg is used for the accounting in that case?
> 
> Root memcg/no accounting, which is the same.
> 
> There is a way to account for a specific memcg in such cases, it's used for
> bpf maps, for example. We save a pointer to the memcg which created the map and
> charge it for all allocations from a !in_task context.

Great, so we could use same scheme later on if its required for some
use case.

>  so let's not do without regression tests and a serious need.

Sounds good. Thanks.
