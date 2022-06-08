Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEF8543FE2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 01:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbiFHXdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 19:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiFHXdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 19:33:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145B3111B85
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 16:33:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A490661982
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 23:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0714C34116;
        Wed,  8 Jun 2022 23:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654731213;
        bh=IB2m+KxJZ2E3SmCFTfE/BcN2qvTp2YgVIEScIlpXSHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o7fOP1R49g146bIR0x4wqfuun5DmckAYCkSHAPnJQZw/EGbM3/h0jVPjU86IYDhjV
         nAXdnQmM2rtn5f6evXJ4/ydpsLWPYM5wBcyPiCyH+kii9WATxpL6LpL3MsGH9kQd6k
         STg3lp9H86wpzn2a10ZVzwcyRWXG5l3PJxnfmWCGsKiP81evvcnbDVmVZp1f4i5oNX
         ucoIQnJ+6fc6q0jpxhbygBT8xBmZQTJbjuCxpjhjd91LO3jB7/qwrYeEjyJZNBEl0w
         8htMrn6fBG9BByoPhWcL4ujrTtCY8KArJpeckPxf2GtyMA4Cj0HWcfOophnKHIyBbO
         YFNztwV7d1CAA==
Date:   Wed, 8 Jun 2022 16:33:30 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Joe Damato <jdamato@fastly.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        jiangshanlai@gmail.com, bp@suse.de, brgerst@gmail.com
Subject: Re: [PATCH] x86/mm: Fix RESERVE_BRK() for older binutils
Message-ID: <20220608233330.rxliy3jiyhzbbjoj@treble>
References: <a802eefebee4d2c01f479a7d3f2008fdd32ce270.1654702810.git.jpoimboe@kernel.org>
 <CALALjgy6=Ebi-k-YrSsEozW3Yy4KJGWLiH_5M8i4neEd9ozj_A@mail.gmail.com>
 <20220608225724.2drhxj5pt2w5gbaf@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220608225724.2drhxj5pt2w5gbaf@treble>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 03:57:27PM -0700, Josh Poimboeuf wrote:
> On Thu, Jun 09, 2022 at 01:12:09AM +0300, Joe Damato wrote:
> > I applied the patch on top of commit 58f9d52ff689 ("Merge tag
> > 'net-5.19-rc1' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net") and the kernel
> > now builds successfully for me.
> > 
> > The resulting kernel boots fine on the machine, as well.
> > 
> > Tested-by: Joe Damato <jdamato@fastly.com>
> 
> Thanks.  Unfortunately, the LLVM linker doesn't like the patch...

I've discovered that if you put a variable in ".bss..whatever", the
section will magically be made NOBITS.  Will try that for v2.

-- 
Josh
