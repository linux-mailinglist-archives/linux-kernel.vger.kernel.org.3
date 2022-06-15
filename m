Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AC554D2BB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348790AbiFOUeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348732AbiFOUeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:34:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063C44F450;
        Wed, 15 Jun 2022 13:34:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95EDC6174B;
        Wed, 15 Jun 2022 20:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE533C3411A;
        Wed, 15 Jun 2022 20:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655325251;
        bh=w9Cn8J1gGKYtrLHbVulC2WFj7bx3TCpe9pBDM5hY/5o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=L1W5mfxLJSUItVhmFIU9DH3W01SAYDg1A50/Yh2sBBSNSFn+la3f1Znv3mfploYbx
         eenH3S4WYjeYUCHavzHztXvF+07JdCjj9a26Fkw35hUa8FskmePLWzv2Hd5HaDo92h
         VvWxc+QPpEGjebj+rosaBhTQl5b6ERthMoe0lUSKY4sz1OhbwGoJyEcCg7WqMDTlQl
         jJKv5Ll0Z1Lsp+OlvAu0ho3DNuhZ4M7u7rOa3CeOiT9deLE5vrABG7enVghy+qHA1A
         KBprp2b2HFZIWZej6IIDCKksoxxCi+HK4znv033sZqA4ST4Ty/KMIU7jcCLXl5O3ci
         F9Y9YE/U3OfJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 898275C027A; Wed, 15 Jun 2022 13:34:10 -0700 (PDT)
Date:   Wed, 15 Jun 2022 13:34:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: Contextual conflict between kspp and rcu trees
Message-ID: <20220615203410.GG1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Yqo5SequJuC2qX6S@dev-arch.thelio-3990X>
 <202206151326.E34CDE453@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206151326.E34CDE453@keescook>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 01:28:00PM -0700, Kees Cook wrote:
> On Wed, Jun 15, 2022 at 12:55:53PM -0700, Nathan Chancellor wrote:
> > Per the above RCU commit and commit 6c5218715286 ("context_tracking:
> > Take IRQ eqs entrypoints over RCU"), it appears that the following diff
> > is the proper fix up. Would you mind applying it to the merge of
> > whichever tree comes second if possible? I did build and boot test it
> > but it would not be a bad idea for Sami and Frederic to verify that it
> > is correct so that Kees/Paul can mention it to Linus :)
> 
> Actually, the CFI fix (and a few others) are meant to be sent for
> -rc3, so if the ct_irq_enter() change is in -next, this can maybe get
> sorted out?

Indeed, Frederic's context-tracking series is for the next merge window.
So once your changes are added, I will adjust.

							Thanx, Paul
