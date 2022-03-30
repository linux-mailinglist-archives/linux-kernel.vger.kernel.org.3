Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A674EB86B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 04:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242078AbiC3CnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 22:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242076AbiC3CnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:43:19 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDF0614A90F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:41:33 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22U2fEwB018988;
        Wed, 30 Mar 2022 04:41:14 +0200
Date:   Wed, 30 Mar 2022 04:41:14 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [PATCH v2 0/9] Add dynamic memory allocator support for nolibc
Message-ID: <20220330024114.GA18892@1wt.eu>
References: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
 <2504aa03-e3cf-a120-44dc-af70ec7c9d5c@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2504aa03-e3cf-a120-44dc-af70ec7c9d5c@gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ammar,

On Tue, Mar 29, 2022 at 05:20:31PM +0700, Ammar Faizi wrote:
> On 3/29/22 5:17 PM, Ammar Faizi wrote:
> > Hi,
> > 
> > This is a patchset v2 to add dynamic memory allocator support
> > for nolibc after 2 RFCs, please review the changes carefully.

Thank you! For me it's OK for all the series:

Acked-by: Willy Tarreau <w@1wt.eu>

I do have a minor comment about the use of __builtin_mul_overflow() here.
While this code is included in the kernel and mostly for use with kernel
related stuff, till now I've been careful to support older compilers (I'm
still seeing 4.8, 4.7 and 4.4 commonly in field). I don't find it urgent,
but I think that sooner or later it would be nice to implement an
alternative for compilers missing this builtin, especially if it's the
only one that prevents older compilers from being used. Probably that
something like this (untested) would do the job:

	if (nmemb && ~(size_t)0 / nmemb < size) {
		SET_ERRNO(ENOMEM);
		return NULL;
	}
	size *= nmemb;

But again, for me it's not a showstopper and can be improved later.

> Sorry, forgot to replace === with --- in for each patch.
> Should I resend?

Let's see what Paul prefers. sed 's/===/---/' on the mbox should fix
it otherwise a resend will be needed.

Thanks!
Willy
