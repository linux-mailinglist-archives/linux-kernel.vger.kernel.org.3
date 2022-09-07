Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724E85AF963
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 03:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiIGB1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 21:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIGB1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 21:27:01 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DB176D9E2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 18:27:00 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.218:47248.1217073643
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-110.188.55.54 (unknown [172.18.0.218])
        by chinatelecom.cn (HERMES) with SMTP id F0DEB2800D4;
        Wed,  7 Sep 2022 09:26:46 +0800 (CST)
X-189-SAVE-TO-SEND: lic121@chinatelecom.cn
Received: from  ([172.18.0.218])
        by app0025 with ESMTP id ec71a940db7a43cab5eb89777746d3ec for akpm@linux-foundation.org;
        Wed, 07 Sep 2022 09:26:58 CST
X-Transaction-ID: ec71a940db7a43cab5eb89777746d3ec
X-Real-From: lic121@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: lic121@chinatelecom.cn
Date:   Wed, 7 Sep 2022 01:26:33 +0000
From:   Cheng Li <lic121@chinatelecom.cn>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: use mem_map_offset instead of mem_map_next
Message-ID: <20220907012633.GA21996@vscode.7~>
References: <1662358159-22780-1-git-send-email-lic121@chinatelecom.cn>
 <Yxd+Nz1wAwiIOWsd@monkey>
 <20220906171048.1cd24a27b71ded17f89ddb00@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906171048.1cd24a27b71ded17f89ddb00@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 05:10:48PM -0700, Andrew Morton wrote:
> On Tue, 6 Sep 2022 10:07:03 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> > On 09/05/22 06:09, Cheng Li wrote:
> > > To handle discontiguity case, mem_map_next() has a parameter named
> > > `offset`. As a function caller, one would be confused why "get
> > > next entry" needs a parameter named "offset". The other drawback of
> > > mem_map_next() is that the callers must take care of the map between
> > > parameter "iter" and "offset", otherwise we may get an hole or
> > > duplication during iteration. So we use mem_map_offset instead of
> > > mem_map_next.
> > > 
> > > Signed-off-by: Cheng Li <lic121@chinatelecom.cn>
> > > Fixes: 69d177c2fc70 ("hugetlbfs: handle pages higher order than MAX_ORDER")
> > 
> > The Fixes tag implies there is a user visible bug.  I do not believe this is
> > the case here.  Is there a user visible bug?
> 
> A Fixes: with a cc:stable would indicate a user-visible bug.  But IMO a
> bare Fixes: is simply a when-to-stop guide to backporters - a
> convenience.  And, I suppose, it has some documentation benefit.
> 
> And if people are really that interested, they can read the dang
> changelog ;)
> 

Thank you for the reviews and the "Fixes" tag tips.

So seems we are agrenment on replacing mem_map_offset() with nth_page().
I may need to send the version 3 :)

I learnt the "Fixes" tag usage from this kenrel contribution guide.[1]

[1]
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes


