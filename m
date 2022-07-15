Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3716576141
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiGOMZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiGOMZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:25:54 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 539EC814B2;
        Fri, 15 Jul 2022 05:25:53 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oCKOG-00082w-00; Fri, 15 Jul 2022 14:25:52 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id BAF77C0499; Fri, 15 Jul 2022 14:24:36 +0200 (CEST)
Date:   Fri, 15 Jul 2022 14:24:36 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@vger.kernel.org, fancer.lancer@gmail.com,
        gerg@kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] MIPS: Fixed __debug_virt_addr_valid()
Message-ID: <20220715122436.GA2705@alpha.franken.de>
References: <20220714222514.1570617-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714222514.1570617-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 03:25:12PM -0700, Florian Fainelli wrote:
> It is permissible for kernel code to call virt_to_phys() against virtual
> addresses that are in KSEG0 or KSEG1 and we need to be dealing with both
> types. Rewrite the test condition to ensure that the kernel virtual
> addresses are above PAGE_OFFSET which they must be, and below KSEG2
> where the non-linear mapping starts.
> 
> For EVA, there is not much that we can do given the linear address range
> that is offered, so just return any virtual address as being valid.
> 
> Finally, when HIGHMEM is not enabled, all virtual addresses are assumed
> to be valid as well.
> 
> Fixes: dfad83cb7193 ("MIPS: Add support for CONFIG_DEBUG_VIRTUAL")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v2:
> 
> - handle lack of HIGHMEM and EVA
> 
>  arch/mips/mm/physaddr.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
