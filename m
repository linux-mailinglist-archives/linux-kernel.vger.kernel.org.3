Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3EA5393E2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345630AbiEaPXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345623AbiEaPXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:23:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454FE3055F
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:23:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3817B811B3
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 15:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE3CC385A9;
        Tue, 31 May 2022 15:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654010621;
        bh=rvCDwJ0hSuoGhQKZqMB0CsXgOEOaEeVa58TiJiQ58sk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lHYsvkkj+2zBkZjN9XmgNJ6RexuJkoBIEK3bIqu6LTeU3xaJGVnLxGV/9vSY4dL8H
         t8kzu6Q5sCCJ+Fz3ZCuwdJ+xpvTYvU8V4to4u/3wCOmtMQlzpdfs+Vfv07vTKMMV3q
         4ra4U601EN5mZEEgDT25MmIoQPXte2bO01YeEEdcDJCJeIX4FaM9DqYudpWee5ZZhE
         6SKNiy6V24BJDfokRX/BvIYEZCSKJwY6PK3JDiahqZxKKniy1jYaqc/XiaQpa48Qf1
         qx9JWIWytj2rEGvcs/dE+dZtHyIH5UVOy75gl1NOC3pRXVYXO5z7kwx7yrsLj2Kqsi
         DIsjMnVKEdK0Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 465AB5C02A9; Tue, 31 May 2022 08:23:41 -0700 (PDT)
Date:   Tue, 31 May 2022 08:23:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] tools/nolibc: fix build issues when building from
 tools/
Message-ID: <20220531152341.GI1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220528154546.8261-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220528154546.8261-1-w@1wt.eu>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 05:45:43PM +0200, Willy Tarreau wrote:
> Hi,
> 
> Linus reported build issues when trying nolibc according to the
> documented procedure in "make tools/help":
> 
>   https://lore.kernel.org/lkml/CAHk-=wgpAHhPVSqBWb4gYT=CRJzKAZ4inmrL_kcpeNWGkcg3pg@mail.gmail.com/
> 
> This series addresses this by setting the ARCH and OUTPUT variables and
> adding a few targets to match default expectations. A "help" target also
> explains what the existing targets do. This will be particularly useful
> once the test suite is merged since it will add new targets.
> 
> Thanks,
> Willy

Queued for testing and review, thank you!

							Thanx, Paul

> ---
> Willy Tarreau (3):
>   tools/nolibc: fix the makefile to also work as "make -C tools ..."
>   tools/nolibc: make the default target build the headers
>   tools/nolibc: add a help target to list supported targets
> 
>  tools/Makefile                |  3 +++
>  tools/include/nolibc/Makefile | 37 +++++++++++++++++++++++++++++++++--
>  2 files changed, 38 insertions(+), 2 deletions(-)
> 
> -- 
> 2.17.5
> 
