Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2348D50D548
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 23:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239649AbiDXVd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 17:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbiDXVdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 17:33:24 -0400
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4427826C3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 14:30:20 -0700 (PDT)
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id 9E5FA81956;
        Sun, 24 Apr 2022 21:30:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id B2A9420025;
        Sun, 24 Apr 2022 21:30:16 +0000 (UTC)
Message-ID: <637e370ff1d462cd97bb0dbd85d2aad7abc31d61.camel@perches.com>
Subject: Re: [PATCH] hex2bin: make the function hex_to_bin constant-time
From:   Joe Perches <joe@perches.com>
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Milan Broz <gmazyland@gmail.com>
Date:   Sun, 24 Apr 2022 14:30:15 -0700
In-Reply-To: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: sfgbdzexosni5hcokt6p4sgeue8moiqj
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: B2A9420025
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+nW6m+7YCu4kZxXkdz00uGq0TxpqzRVnQ=
X-HE-Tag: 1650835816-751548
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-04-24 at 16:54 -0400, Mikulas Patocka wrote:
> This patch changes the function hex_to_bin so that it contains no branches
> and no memory accesses.
[]
> +++ linux-2.6/lib/hexdump.c	2022-04-24 18:51:20.000000000 +0200
[]
> + * the next line is similar to the previous one, but we need to decode both
> + *	uppercase and lowercase letters, so we use (ch & 0xdf), which converts
> + *	lowercase to uppercase
>   */
>  int hex_to_bin(char ch)
>  {
> -	if ((ch >= '0') && (ch <= '9'))
> -		return ch - '0';
> -	ch = tolower(ch);
> -	if ((ch >= 'a') && (ch <= 'f'))
> -		return ch - 'a' + 10;
> -	return -1;
> +	return -1 +
> +		((ch - '0' + 1) & (((ch - '9' - 1) & ('0' - 1 - ch)) >> 8)) +
> +		(((ch & 0xdf) - 'A' + 11) & ((((ch & 0xdf) - 'F' - 1) & ('A' - 1 - (ch & 0xdf))) >> 8));

probably easier to read using a temporary for ch & 0xdf

	int CH = ch & 0xdf;

	return -1 +
	       ((ch - '0' +  1) & (((ch - '9' - 1) & ('0' - 1 - ch)) >> 8)) +
	       ((CH - 'A' + 11) & (((CH - 'F' - 1) & ('A' - 1 - CH)) >> 8));


