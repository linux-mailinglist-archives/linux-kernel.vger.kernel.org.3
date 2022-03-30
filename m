Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C74A4ECCB9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348876AbiC3Sxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350105AbiC3Sxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:53:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0A14DF5A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:51:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7BFBB81D85
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 18:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADCBC340F0;
        Wed, 30 Mar 2022 18:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648666312;
        bh=ibrcnI4Sh2c6Hpc0kjpQBswypoj77BsVt19VYyJOL4E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pJLcyWJd3S6r6tVrlN0fz7PGG6FPoP7C33G3cuHsUM0hdDOc6/g6eb9ROMLaLW8BM
         Xp16xq6HxTrMII6JkiBq7/HSUXfYT2AtRj1AQkEkfqqrxYujQ/gnUW+B2nRi85+TlS
         QDpnu0EP9sNjzFNn56m7+n/sGYkpBSm4I8wRCwRvyuzq+Xx4bokWzu2xItauI+kF9q
         hQY0SnO4QLLF2jhbEs625Zqntg8AbmLy+C00zWuR3lTgbrjDigda70YDCGKRjt6RqV
         H4XIKtI+yBJTHYWN3a4K2uol+wiCh1dRNX8UhG1uOBhlDiwRrJPVeqHg9RLDh1jCW1
         r1Gt3V3RqpWHA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0FE7B5C12E4; Wed, 30 Mar 2022 11:51:52 -0700 (PDT)
Date:   Wed, 30 Mar 2022 11:51:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [PATCH v2 0/9] Add dynamic memory allocator support for nolibc
Message-ID: <20220330185152.GK4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
 <2504aa03-e3cf-a120-44dc-af70ec7c9d5c@gnuweeb.org>
 <20220330024114.GA18892@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330024114.GA18892@1wt.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 04:41:14AM +0200, Willy Tarreau wrote:
> Hi Ammar,
> 
> On Tue, Mar 29, 2022 at 05:20:31PM +0700, Ammar Faizi wrote:
> > On 3/29/22 5:17 PM, Ammar Faizi wrote:
> > > Hi,
> > > 
> > > This is a patchset v2 to add dynamic memory allocator support
> > > for nolibc after 2 RFCs, please review the changes carefully.
> 
> Thank you! For me it's OK for all the series:
> 
> Acked-by: Willy Tarreau <w@1wt.eu>
> 
> I do have a minor comment about the use of __builtin_mul_overflow() here.
> While this code is included in the kernel and mostly for use with kernel
> related stuff, till now I've been careful to support older compilers (I'm
> still seeing 4.8, 4.7 and 4.4 commonly in field). I don't find it urgent,
> but I think that sooner or later it would be nice to implement an
> alternative for compilers missing this builtin, especially if it's the
> only one that prevents older compilers from being used. Probably that
> something like this (untested) would do the job:
> 
> 	if (nmemb && ~(size_t)0 / nmemb < size) {
> 		SET_ERRNO(ENOMEM);
> 		return NULL;
> 	}
> 	size *= nmemb;
> 
> But again, for me it's not a showstopper and can be improved later.
> 
> > Sorry, forgot to replace === with --- in for each patch.
> > Should I resend?
> 
> Let's see what Paul prefers. sed 's/===/---/' on the mbox should fix
> it otherwise a resend will be needed.

Given that I am adding your Acked-by anyway, why not?  ;-)

But please check the commits to make sure that this had the desired
effect.

							Thanx, Paul
