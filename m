Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B943059FDE1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiHXPIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237858AbiHXPIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:08:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD2598A5D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:08:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BD1E618CD
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434F1C433C1;
        Wed, 24 Aug 2022 15:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661353689;
        bh=tU6B0BG1UHnHAoMKPgWcGVLqH2nUONmFmE9trFqxNww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YJfG3FMjAIJtjpl2xQ1ePVd6EGaCkFYP3ExWdnUVdxapmWC9Nng4gpke02wcyH/Jr
         jFsmBl9mxtCIRqm1fbEHmcaOMpKFqnYbBMRrVDYwVB2VxqC2AQz8ieCuB3cGTcIRs6
         RcEnbELd0YeoA60p3L5vS2pGnzc24XyfZvhtf0yeDdNKXfDcu32oH86hLViswEhklM
         YFpXKPnO2JsvakVE64lHCuSBVkLgXw6W3zqqhL2Jllhw6rdd9k4uQYwnKk7KJWtCmZ
         1VVyUmhBGyBwfRN7F/cIIO6dK7flOGje2dF/TngLPm5GSBkfiohmZ5W+bh1RV8iT0a
         6Q/gN+eFyXyFQ==
Date:   Wed, 24 Aug 2022 08:08:07 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 7/6] mm: pagewalk: add back missing variable
 initializations
Message-ID: <YwY+1xD52ep54M3y@dev-arch.thelio-3990X>
References: <3200642.44csPzL39Z@devpool047>
 <2123960.ggj6I0NvhH@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2123960.ggj6I0NvhH@mobilepool36.emlix.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 01:00:11PM +0200, Rolf Eike Beer wrote:
> These initializations accidentially got lost during refactoring.
> 
> The first one can't actually be used without initialization, because
> walk_p4d_range() is only called when one of the 4 callbacks is set, but relying
> on this seems fragile.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Rolf Eike Beer <eb@emlix.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  mm/pagewalk.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Looks like my testing had just the right callbacks set so I never hit this. In 
> case you want to have this squashed into the original one just drop me a note 
> and I'll redo the whole series.
> 
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index d8be8a30b272..22e4bcca9bee 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -223,7 +223,7 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
>  
>  	p4d = p4d_offset(pgd, addr);
>  	do {
> -		int err;
> +		int err = 0;
>  
>  		next = p4d_addr_end(addr, end);
>  		if (p4d_none_or_clear_bad(p4d)) {
> @@ -262,7 +262,7 @@ static int walk_pgd_range(unsigned long addr, unsigned long end,
>  	else
>  		pgd = pgd_offset(walk->mm, addr);
>  	do {
> -		int err;
> +		int err = 0;
>  
>  		next = pgd_addr_end(addr, end);
>  		if (pgd_none_or_clear_bad(pgd)) {
> @@ -308,7 +308,7 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
>  	const struct mm_walk_ops *ops = walk->ops;
>  
>  	for (; addr < end; addr = next) {
> -		int err;
> +		int err = 0;
>  		pte_t *pte = huge_pte_offset(walk->mm, addr & hmask, sz);
>  
>  		next = hugetlb_entry_end(h, addr, end);
> -- 
> 2.37.2
> 
> -- 
> Rolf Eike Beer, emlix GmbH, https://www.emlix.com
> Fon +49 551 30664-0, Fax +49 551 30664-11
> Gothaer Platz 3, 37083 Göttingen, Germany
> Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
> Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055
> 
> emlix - smart embedded open source
> 
> 
