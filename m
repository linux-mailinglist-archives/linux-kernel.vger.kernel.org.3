Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9364FC3A6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 19:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348981AbiDKRu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 13:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbiDKRuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 13:50:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF9630559
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 10:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADE48B81190
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 17:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF972C385A3;
        Mon, 11 Apr 2022 17:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649699318;
        bh=mCeBQOom8NlCqItQrm9XkYJs+WtEQ7iDURD9UYCLHig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ir/2lHuJv7zwqFbKoSPNY+qIWk9ERT5Mml9ZcphpRERQegxuRqmiywJ7CkwOv6iYX
         5AGYTBi4GJjXlmfB0KqxW9Ld6ACpKkHUMo2p3FvusvVDBkO/ighSmQZj9YVd1bw8Cx
         /yrXAaWmJk1R5FtavTvDOdcc75FEr4rRjSLV3iA7BQfs7h0juJg9ZV0tYw/NEXLq4o
         OVNkrRvqAbmVvwXDr/Jdgcy4a9ycDQn1HdCzxuklCx6dmDjAEICt4jkb8PFsR4gPma
         QoLcRkvezyV+J9xLLaXjs6gpMeamBRJNzEmX4czA5wn8loX6V1XsXe/ye0FTgpRbLQ
         C+QJTZdq+bnyg==
Date:   Mon, 11 Apr 2022 10:48:36 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Jeff Dike <jdike@addtoit.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eduard-Gabriel Munteanu <maxdamage@aladin.ro>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        regressions@lists.linux.dev
Subject: Re: [PATCH 1/1] um: fix error return code in winch_tramp()
Message-ID: <YlRp9KR1mp3/4Txo@thelio-3990X>
References: <20210508032239.2177-1-thunder.leizhen@huawei.com>
 <Yjt31seiNv18HYrf@dev-arch.thelio-3990X>
 <1b03d888-cea3-3e6f-087f-daeb5642a975@leemhuis.info>
 <1087614384.239493.1649583213699.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1087614384.239493.1649583213699.JavaMail.zimbra@nod.at>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Sun, Apr 10, 2022 at 11:33:33AM +0200, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > Von: "Thorsten Leemhuis" <regressions@leemhuis.info>
> > Hi, this is your Linux kernel regression tracker. Top-posting for once,
> > to make this easily accessible to everyone.
> > 
> > Zhen Lei, Richard, what's up here? Below regression report is more than
> > two weeks old now and afaics didn't even get a single reply.
> 
> Sorry, but UML is leisure pursuit, so I can only work on it when my
> schedule permits it.

No worries, it is easy enough to work around for our use case.

> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> > 
> > P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> > reports on my table. I can only look briefly into most of them and lack
> > knowledge about most of the areas they concern. I thus unfortunately
> > will sometimes get things wrong or miss something important. I hope
> > that's not the case here; if you think it is, don't hesitate to tell me
> > in a public reply, it's in everyone's interest to set the public record
> > straight.
> > 
> > 
> > 
> > On 23.03.22 20:41, Nathan Chancellor wrote:
> 
> [...]
> 
> >> in case it helps. I am happy to provide more information or test patches
> >> as necessary.
> 
> Nathan, can you provide me the error code from os_set_fd_block()?
> My best guess is that setting the fd is optional here and UML does
> not expect failure here.

I attempted to print out the error code but it seems like there is no
output in the console after "reboot: System halted". If I add an
unconditional print right before the call to os_set_fd_block(), I see it
during start up but I do not see it during shutdown. Is there some way
to see that console output during shutdown?

Cheers,
Nathan
