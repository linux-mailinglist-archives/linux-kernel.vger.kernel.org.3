Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADA054D362
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347459AbiFOVM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiFOVM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:12:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EA751E7B;
        Wed, 15 Jun 2022 14:12:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7452BB82185;
        Wed, 15 Jun 2022 21:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170CBC3411A;
        Wed, 15 Jun 2022 21:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655327541;
        bh=KvZbkPsYHPy1CP4cP4B8D3AbbBahxVtKDnXpikA2PzA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GZIZXxNdTDPFdNxWxd2vu5buItGBwGqu4Co/QAne2ocDNVAbSN1h5M5mXC5RQWYsm
         G7fBjwtzdiagL7634Yj1vgBfWEWM+auammDz/Tg1GARXU6tn35+Mv9gpkaTY85dCnB
         m+HqzAsPdVaTTjSbfnlaZTwOJnJVKEtamGNBMW36/Zh46eRQlYSQEMmvAKkS35shjV
         ukXnRldow5JlcJwydSOgtLZfkEX2Mp8Yx2XX5dKfqs8wwRGTmNvwDjr6PPAp6UYAOO
         RXgm0EFvuATqDP3WHHcRcRlWvP9/wNUKCp4vMR7lxDC1N1C5M6xuPxg/k0AdBbgUuo
         Ic9RljOwmJs+Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9170D5C027A; Wed, 15 Jun 2022 14:12:20 -0700 (PDT)
Date:   Wed, 15 Jun 2022 14:12:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: Contextual conflict between kspp and rcu trees
Message-ID: <20220615211220.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Yqo5SequJuC2qX6S@dev-arch.thelio-3990X>
 <202206151326.E34CDE453@keescook>
 <YqpCkAVTwpNn+6p9@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqpCkAVTwpNn+6p9@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 01:35:28PM -0700, Nathan Chancellor wrote:
> On Wed, Jun 15, 2022 at 01:28:00PM -0700, Kees Cook wrote:
> > On Wed, Jun 15, 2022 at 12:55:53PM -0700, Nathan Chancellor wrote:
> > > Per the above RCU commit and commit 6c5218715286 ("context_tracking:
> > > Take IRQ eqs entrypoints over RCU"), it appears that the following diff
> > > is the proper fix up. Would you mind applying it to the merge of
> > > whichever tree comes second if possible? I did build and boot test it
> > > but it would not be a bad idea for Sami and Frederic to verify that it
> > > is correct so that Kees/Paul can mention it to Linus :)
> > 
> > Actually, the CFI fix (and a few others) are meant to be sent for
> > -rc3, so if the ct_irq_enter() change is in -next, this can maybe get
> > sorted out?
> 
> Ah, I had assumed that branch was destined for the next release. If it
> is for 5.19 and they make -rc3 then it should be trivial for Paul to
> either rebase the changes on -rc3 and apply that diff as part of
> "context_tracking: Take IRQ eqs entrypoints over RCU" (if his tree is
> mutable) or just merge -rc3 and apply that diff as part of the merge. I
> don't really care how it gets resolved, just so long as it does :)

My tree will remain mutable for a few more weeks, so we should be
good.  ;-)

							Thanx, Paul
