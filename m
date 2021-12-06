Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5423469576
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242835AbhLFMPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:15:48 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50250 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242106AbhLFMPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:15:47 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 9DA451F43FC1
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638792738; bh=H1N5xvnP6xPf/7ipNiSUWtIxodNptQu0CfX5Bidi4rA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dI8Vm9mmkkIcBocxKjqLigBAfcB/cuwc9Mytadg8YxvC9mFd5bQoyEaCGmCHK6yNA
         OuECmKfNEwI0NYKe7hRI2vt/B66sCcvIc1p1EazkeFismSSzG0qLQ73Ue3d/lwL9gV
         j9U4wjjLBf2VUcy/nmQiC0tdx4ZAwpK9bQbjK04FKJ9tA6QK+wdR07wK0DIXNcYdiZ
         OI+OW84gG0V3qRJK2kjrlIc9WA2+jXZHjdpEkMESqEoKoIYsM+Itw0JiNvtrj37eaR
         9dr+deI4QdmCqHU++Uzj2bqiF7jspskL1fLJS5xhVy4sqWVThYSSxeIYp3pBv27v4H
         lUfye2U896C4Q==
Message-ID: <f7d9194b-6681-48f0-b5e9-11f43d2849bd@collabora.com>
Date:   Mon, 6 Dec 2021 09:12:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] futex: Fix a faulty comment.
Content-Language: en-US
To:     6812skiii@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        dvhart@infradead.org, dave@stgolabs.net,
        linux-kernel@vger.kernel.org
References: <20211204181458.10076-1-6812skiii@gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <20211204181458.10076-1-6812skiii@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jangwoong,

Thanks for your patch! However...

Às 15:14 de 04/12/21, 6812skiii@gmail.com escreveu:
> From: Jangwoong Kim <6812skiii@gmail.com>
> 
> We return 1, not the index of futex woken up.
> 
> Signed-off-by: Jangwoong Kim <6812skiii@gmail.com>
> ---
>  kernel/futex/waitwake.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
> index 4ce0923f1ce3..d148e5d4956b 100644
> --- a/kernel/futex/waitwake.c
> +++ b/kernel/futex/waitwake.c
> @@ -455,8 +455,8 @@ static int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *wo
>  
>  		/*
>  		 * Even if something went wrong, if we find out that a futex
> -		 * was woken, we don't return error and return this index to
> -		 * userspace
> +		 * was woken, we don't return error and make userspace aware
> +		 * of this by returning 1.

We return to userspace the value at *woken, so your fix is wrong. Have a
look at futex_wait_multiple():

		ret = futex_wait_multiple_setup(vs, count, &hint);
		if (ret) {
			if (ret > 0) {
				/* A futex was woken during setup */
				ret = hint;
			}
			return ret;
		}

When we return 1 at futex_wait_multiple_setup(), we end up returning the
hint/woken value to userspace.

Let me know if you have questions.

	André
