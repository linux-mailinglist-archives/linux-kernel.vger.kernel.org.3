Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B983752E38E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 06:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbiETETf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 00:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiETET2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 00:19:28 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C449EBAA0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 21:19:27 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 24K4JFAk005135;
        Fri, 20 May 2022 06:19:15 +0200
Date:   Fri, 20 May 2022 06:19:15 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Facebook Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v1 1/2] tools/nolibc/stdlib: Support overflow checking
 for older compiler versions
Message-ID: <20220520041915.GC5001@1wt.eu>
References: <20220519172116.283687-1-ammarfaizi2@gnuweeb.org>
 <20220519172116.283687-2-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519172116.283687-2-ammarfaizi2@gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ammar,

On Fri, May 20, 2022 at 12:21:15AM +0700, Ammar Faizi wrote:
> diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
> index 8fd32eaf8037..92378c4b9660 100644
> --- a/tools/include/nolibc/stdlib.h
> +++ b/tools/include/nolibc/stdlib.h
> @@ -128,10 +128,9 @@ void *malloc(size_t len)
>  static __attribute__((unused))
>  void *calloc(size_t size, size_t nmemb)
>  {
> -	void *orig;
> -	size_t res = 0;
> +	size_t x = size * nmemb;
>  
> -	if (__builtin_expect(__builtin_mul_overflow(nmemb, size, &res), 0)) {
> +	if (__builtin_expect(size && ((x / size) != nmemb), 0)) {

Ah, that approach is even better than mine, I'm seeing that on x86 the
compiler simply checks the overflow flag after the multiply, that's
perfect!

Acked-by: Willy Tarreau <w@1wt.eu>

Willy
