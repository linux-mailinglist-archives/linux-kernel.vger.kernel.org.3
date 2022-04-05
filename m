Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656624F4ACE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452951AbiDEWv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349186AbiDEJt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:49:27 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DD0320181;
        Tue,  5 Apr 2022 02:42:23 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 0518E92009D; Tue,  5 Apr 2022 11:42:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id F2E5592009B;
        Tue,  5 Apr 2022 10:42:21 +0100 (BST)
Date:   Tue, 5 Apr 2022 10:42:21 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Andrew Powers-Holmes <aholmes@omnom.net>
cc:     yaliang.wang@windriver.com, rppt@kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        huangpei@loongson.cn, Andrew Morton <akpm@linux-foundation.org>,
        kumba@gentoo.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        anshuman.khandual@arm.com, penberg@kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] MIPS: pgalloc: fix memory leak caused by pgd_free()
In-Reply-To: <b273a9b7-82f7-5883-14d2-973dd005b005@omnom.net>
Message-ID: <alpine.DEB.2.21.2204051027490.47162@angie.orcam.me.uk>
References: <20220310113116.2068859-1-yaliang.wang@windriver.com> <alpine.DEB.2.21.2204021446370.47162@angie.orcam.me.uk> <9cc88b1c-8a8c-95ea-2cf7-31be3b771495@omnom.net> <alpine.DEB.2.21.2204031122020.47162@angie.orcam.me.uk>
 <b273a9b7-82f7-5883-14d2-973dd005b005@omnom.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2022, Andrew Powers-Holmes wrote:

> Fair enough :) apologies, didn't mean to sound combative or ungrateful.
> I know there's far more work to go around than people to do it,
> everyone's doing the best they can, and I have nothing but appreciation
> for all the work the kernel community does.

 No offence taken; I just wanted to make it absolutely clear what the 
situation currently is.

> It's just surprising that this *could* go unnoticed for over a year -
> though I suppose most of the MIPS64 systems out there are running on one
> or another old vendor SDK kernel so won't have been affected...

 That's subject to the probability theory and depending on what people's 
usage models are.

> Would the best way to get this merged into 5.10/15 (and maybe .16 just
> for good measure) be to email the stable team (since it's already in
> Linus' tree)? Documentation/process/stable-kernel-rules seems to say
> yes, but I'd like to avoid stepping on anyone's toes given that it's not
> my patch.

 You seem the most severely affected so far, so why not act in your best 
interest?  I think option #2 applies here and seems quite straightforward 
to follow, referring commit 2bc5bab9a763 and using your use case as the 
justification.  It doesn't have to be the author to request a backport.

 NB I think it has to be backported to all the stable branches made since 
the original breakage; i.e. v5.9+ (I haven't kept track of what they are).

  Maciej
