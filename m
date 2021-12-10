Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0034707A5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244747AbhLJRwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhLJRwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:52:32 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300F8C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 09:48:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7C8D7CE2C70
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 17:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94365C00446;
        Fri, 10 Dec 2021 17:48:49 +0000 (UTC)
Date:   Fri, 10 Dec 2021 17:48:46 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 08/34] kasan: only apply __GFP_ZEROTAGS when memory is
 zeroed
Message-ID: <YbOS/jskofqqOc0y@arm.com>
References: <cover.1638825394.git.andreyknvl@google.com>
 <cca947c05c4881cf5b7548614909f1625f47be61.1638825394.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cca947c05c4881cf5b7548614909f1625f47be61.1638825394.git.andreyknvl@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 10:43:45PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> __GFP_ZEROTAGS should only be effective if memory is being zeroed.
> Currently, hardware tag-based KASAN violates this requirement.
> 
> Fix by including an initialization check along with checking for
> __GFP_ZEROTAGS.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
> ---
>  mm/kasan/hw_tags.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 0b8225add2e4..c643740b8599 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -199,11 +199,12 @@ void kasan_alloc_pages(struct page *page, unsigned int order, gfp_t flags)
>  	 * page_alloc.c.
>  	 */
>  	bool init = !want_init_on_free() && want_init_on_alloc(flags);
> +	bool init_tags = init && (flags & __GFP_ZEROTAGS);
>  
>  	if (flags & __GFP_SKIP_KASAN_POISON)
>  		SetPageSkipKASanPoison(page);
>  
> -	if (flags & __GFP_ZEROTAGS) {
> +	if (init_tags) {

You can probably leave this unchanged but add a WARN_ON_ONCE() if !init.
AFAICT there's only a single place where __GFP_ZEROTAGS is passed.

-- 
Catalin
