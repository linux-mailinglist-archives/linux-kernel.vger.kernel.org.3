Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C2F462CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbhK3Ggq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:36:46 -0500
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:35746 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233544AbhK3Ggp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:36:45 -0500
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 7A750181D2099;
        Tue, 30 Nov 2021 06:33:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id BEDDD2000519;
        Tue, 30 Nov 2021 06:33:19 +0000 (UTC)
Message-ID: <9bfe2c52eca40102f5175a1421cf3059195d7663.camel@perches.com>
Subject: Re: [PATCH] rbd: make const pointer speaces a static const array
From:   Joe Perches <joe@perches.com>
To:     Colin Ian King <colin.i.king@googlemail.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Nov 2021 22:33:21 -0800
In-Reply-To: <20211127172104.102994-1-colin.i.king@gmail.com>
References: <20211127172104.102994-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.60
X-Stat-Signature: kdsg4eq11duh3qrz1rhf38ujomrs3txq
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: BEDDD2000519
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+vuhErIXIx59F83OJWNIrsJEqGE9rFvJI=
X-HE-Tag: 1638253999-796699
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-11-27 at 17:21 +0000, Colin Ian King wrote:
> Don't populate the const array spaces on the stack but make it static
> const and make the pointer an array to remove a dereference. Shrinks
> object code a little too.  Also clean up intent, currently it is spaces
> and should be a tab.
[]
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
[]
> @@ -6189,7 +6189,7 @@ static inline size_t next_token(const char **buf)
>          * These are the characters that produce nonzero for
>          * isspace() in the "C" and "POSIX" locales.
>          */
> -        const char *spaces = " \f\n\r\t\v";
> +	static const char spaces[] = " \f\n\r\t\v";
>  
>          *buf += strspn(*buf, spaces);	/* Find start of token */
>  

perhaps

	while (isspace(**buf))
		(*buf)++;

and not have or use spaces at all.


