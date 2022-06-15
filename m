Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0DD54CA66
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349133AbiFONzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238853AbiFONze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:55:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ECF255AF;
        Wed, 15 Jun 2022 06:55:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FBA561B23;
        Wed, 15 Jun 2022 13:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC44BC34115;
        Wed, 15 Jun 2022 13:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655301332;
        bh=d+8lzxk/kDyn5dLFABLSgfNZYo8yluhEL/UrzIgZfGc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SoEi8z37HGLzRUqHBB4XEH+zLh5P/4QAvyOGu8fUwndms7aDNIFFo1q+RAlO8xnYc
         GMdjId1hrnNUeViOfGIofs8q6efgByPCv9y8AvQiOc/rQIHS1dQG4JuBE9JCMHOG9S
         iQzfVnlhYWwAE8foN7LemIfR0xUEb4LPL/SYOOHZKvglCXJYGUZS/hEp+GTQ/H110L
         ysaF4Ao0bbgh6w3ESBC//iGk0FGhpVLY2Q98vEhxMdtJFr4udkrhl0FSLjKRq9ek5G
         gwtkhq7cpj+vt8arGTa5rme0NTGjGq256pvXM8i6mT7lP1raC39IwxI99+uiV3Uu7C
         ZxWuug4jwR4UQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7CE3C5C00D9; Wed, 15 Jun 2022 06:55:32 -0700 (PDT)
Date:   Wed, 15 Jun 2022 06:55:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the rcu tree
Message-ID: <20220615135532.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220615153802.49eeb827@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615153802.49eeb827@canb.auug.org.au>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 03:38:02PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the rcu tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> Documentation/RCU/Design/Requirements/Requirements.rst:2220: WARNING: Malformed table.
> 
> +-----------------------------------------------------------------------+
> | **Quick Quiz**:                                                       |
> +-----------------------------------------------------------------------+
> | But what if my driver has a hardware interrupt handler that can run   |
> | for many seconds? I cannot invoke schedule() from an hardware         |
> | interrupt handler, after all!                                         |
> +-----------------------------------------------------------------------+
> | **Answer**:                                                           |
> +-----------------------------------------------------------------------+
> | One approach is to do ``ct_irq_exit();ct_irq_enter();`` every so    |
> | often. But given that long-running interrupt handlers can cause other |
> | problems, not least for response time, shouldn't you work to keep     |
> | your interrupt handler's runtime within reasonable bounds?            |
> +-----------------------------------------------------------------------+
> 
> Introduced by commit
> 
>   6c5218715286 ("context_tracking: Take IRQ eqs entrypoints over RCU")

Apologies and thank you, will fix.

							Thanx, Paul
