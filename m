Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F5452F1AF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352258AbiETRcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351925AbiETRcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:32:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED1F17DDC6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:32:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA75DB82D42
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 17:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB75C385A9;
        Fri, 20 May 2022 17:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653067967;
        bh=AkqrkBrEvsXjOSRm5RxhZxVwEH22/E3TuME0JO+lf5A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DeCcmBVx10a0BzGN8pYtdoUTcPsw1MOyHqbOtblfbKbZL4YuU1dFGduDqnu012MSH
         G2/C1vj7v4SJJ6qVcid1PkK0W3qS6j7uKzn4YAXm9iSLq8pYe7aaZPVIjUweK9ynif
         1y4R84ve4KplyZBI7jIkSZlykxhcyFKx9gkwJPusMgQp/iaBwa5w3Zbwkp+tRD4qAa
         nIfwf59KWE8zd73RYEft3E7P9FZx0QpheYUfZchtD8ejMIzqOQqNGPLs2rhrT5Stjf
         5knHSsZQqZGWfv22TeTL14uJJ0KhchMDi8CwhOOZyK6rmz2wYazQSu/ggQO2SXEqfq
         Km80eiUJ/gWiQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 05BAA5C05F8; Fri, 20 May 2022 10:32:47 -0700 (PDT)
Date:   Fri, 20 May 2022 10:32:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>, Willy Tarreau <w@1wt.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Facebook Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v1 1/2] tools/nolibc/stdlib: Support overflow checking
 for older compiler versions
Message-ID: <20220520173247.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220519172116.283687-1-ammarfaizi2@gnuweeb.org>
 <20220519172116.283687-2-ammarfaizi2@gnuweeb.org>
 <CAOG64qO3B_FmaLS9=C+EuWcJhsw2Tr1Cci0BL1=eAkLWG=NDnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOG64qO3B_FmaLS9=C+EuWcJhsw2Tr1Cci0BL1=eAkLWG=NDnQ@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 06:29:56PM +0700, Alviro Iskandar Setiawan wrote:
> On Fri, May 20, 2022 at 12:21 AM Ammar Faizi <ammarfaizi2@gnuweeb.org> wrote:
> > Previously, we used __builtin_mul_overflow() to check for overflow in
> > the multiplication operation in the calloc() function. However, older
> > compiler versions don't support this built-in. This patch changes the
> > overflow checking mechanism to make it work on any compiler version
> > by using a division method to check for overflow. No functional change
> > intended. While in there, remove the unused variable `void *orig`.
> >
> > Link: https://lore.kernel.org/lkml/20220330024114.GA18892@1wt.eu
> > Suggested-by: Willy Tarreau <w@1wt.eu>
> > Cc: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
> > Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> 
> Reviewed-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
> 
> tq
> 
> -- Viro

I have queued both patches with yours and Willy Tarreau's reviews
and acks.  Thank you all!

							Thanx, Paul
