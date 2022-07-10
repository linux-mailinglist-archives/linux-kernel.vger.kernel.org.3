Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B936C56CFB0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 17:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiGJPQ3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 10 Jul 2022 11:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJPQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 11:16:23 -0400
Received: from relay4.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA547CE1B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 08:16:22 -0700 (PDT)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id B4F1433DEA;
        Sun, 10 Jul 2022 15:16:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 9A0636000B;
        Sun, 10 Jul 2022 15:16:19 +0000 (UTC)
Message-ID: <75e3bb4f88fa43097540f3e2023df8388def5719.camel@perches.com>
Subject: Re: [PATCH 2/2] lib/string.c: Optimize memchr()
From:   Joe Perches <joe@perches.com>
To:     Yu-Jen Chang <arthurchang09@gmail.com>, andy@kernel.org,
        akinobu.mita@gmail.com
Cc:     jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org
Date:   Sun, 10 Jul 2022 08:16:17 -0700
In-Reply-To: <20220710142822.52539-3-arthurchang09@gmail.com>
References: <20220710142822.52539-1-arthurchang09@gmail.com>
         <20220710142822.52539-3-arthurchang09@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 9A0636000B
X-Stat-Signature: 1orab4y3gfh1ujkwaxt1cfkuuw7itmxy
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/2jHyohJ7OktbUuEf+voQ7wKQCZ84grBg=
X-HE-Tag: 1657466179-188916
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-07-10 at 22:28 +0800, Yu-Jen Chang wrote:
> The original version of memchr() is implemented with the byte-wise
> comparing technique, which does not fully use 64-bits or 32-bits
> registers in CPU. We use word-wide comparing so that 8 characters
> can be compared at the same time on CPU. This code is base on
> David Laight's implementation.
> 
> We create two files to measure the performance. The first file
> contains on average 10 characters ahead the target character.
> The second file contains at least 1000 characters ahead the
> target character. Our implementation of “memchr()” is slightly
> better in the first test and nearly 4x faster than the orginal
> implementation in the second test.

It seems you did not test this with 32bit compilers as
there are 64 bit constants without ull

> diff --git a/lib/string.c b/lib/string.c
[]
> @@ -905,21 +905,35 @@ EXPORT_SYMBOL(strnstr);
>  #ifndef __HAVE_ARCH_MEMCHR
>  /**
>   * memchr - Find a character in an area of memory.
> - * @s: The memory area
> + * @p: The memory area
>   * @c: The byte to search for
> - * @n: The size of the area.
> + * @length: The size of the area.
>   *
>   * returns the address of the first occurrence of @c, or %NULL
>   * if @c is not found
>   */
> -void *memchr(const void *s, int c, size_t n)
> +void *memchr(const void *p, int c, unsigned long length)
>  {
> -	const unsigned char *p = s;
> -	while (n-- != 0) {
> -        	if ((unsigned char)c == *p++) {
> -			return (void *)(p - 1);
> +	u64 mask, val;
> +	const void *end = p + length;
> +
> +	c &= 0xff;
> +	if (p <= end - 8) {
> +		mask = c;
> +		MEMCHR_MASK_GEN(mask);
> +
> +		for (; p <= end - 8; p += 8) {
> +			val = *(u64 *)p ^ mask;
> +			if ((val + 0xfefefefefefefeffu) &
> +			    (~val & 0x8080808080808080u))

here.

