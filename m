Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C953496079
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380966AbiAUOIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:08:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56152 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380967AbiAUOIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:08:44 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642774122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jOE5fu70oB7nuGOxO+dUrxE5TcuzOQCCS2Qr0yX/lps=;
        b=Wcv3w5yuaGp/5LMBJlhbnemZFTY5ubmphbG2gUsZ3b7aXo35vAWLAbiamXkmN6MTOHwxbX
        P9f9+jFiBt+LCF8eZJVqZ9W6amTDphNlpaIMzWK2l+XXuIVYxWeLet2/omyC2sOsYInGwS
        zf2BSCcIOdq0oMOIq4XR3HusvOCJN9qPD5nyu54VnUXyIikfAbPPqJhSq7qI5fuLoIbyB9
        25PMZFAFE84uzIbTM6VJyLTpnh9DKdNMZ+ySM52Lh78vNuofM4l+FJO+v8BKpbsDwEyrRu
        Aeb97w/IkLgmxU6D+APbOI0ucIkhOG+bqn5goubUZRkHfpmUrNayaXinERR6Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642774122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jOE5fu70oB7nuGOxO+dUrxE5TcuzOQCCS2Qr0yX/lps=;
        b=QA+0Awr3qBFjBCjZoQ5sNFHCLmc0W16e7eY7OGhuTaP9waO46r446IWoad2HRqvL7YUFTC
        JYVgg0iXbIMwn9CQ==
To:     Mukesh Ojha <quic_mojha@quicinc.com>, linux-kernel@vger.kernel.org
Cc:     pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH v3] printk: ringbuffer: Improve prb_next_seq() performance
In-Reply-To: <1642770388-17327-1-git-send-email-quic_mojha@quicinc.com>
References: <1642770388-17327-1-git-send-email-quic_mojha@quicinc.com>
Date:   Fri, 21 Jan 2022 15:14:41 +0106
Message-ID: <87tudxfafq.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mukesh,

Thanks for pushing this. I think it got lost somewhere. I have a couple
very minor non-functional change requests.

On 2022-01-21, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> From: Petr Mladek <pmladek@suse.com>
>
> prb_next_seq() always iterates from the first known sequence number.
> In the worst case, it might loop 8k times for 256kB buffer,
> 15k times for 512kB buffer, and 64k times for 2MB buffer.
>
> It was reported that pooling and reading using syslog interface

                       ^^^^^^^ polling

> might occupy 50% of CPU.
>
> Speedup the search by storing @id of the last finalized descriptor.
>
> The loop is still needed because the @id is stored and read in the best
> effort way. An atomic variable is used to keep the @id consistent.
> But the stores and reads are not serialized against each other.
> The descriptor could get reused in the meantime. The related sequence
> number will be used only when it is still valid.
>
> An invalid value should be read _only_ when there is a flood of messages
> and the ringbuffer is rapidly reused. The performance is the least
> problem in this case.
>
> Link: https://lore.kernel.org/lkml/YXlddJxLh77DKfIO@alley/T/#m43062e8b2a17f8dbc8c6ccdb8851fb0dbaabbb14
> Reported-by: Chunlei Wang <chunlei.wang@mediatek.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Changes against v2:
>   Added the hunk suggested by John
>
> Changes against v1:
>   Read @seq by the last finalized @id directly in prb_next_seq() (John)
>
>  kernel/printk/printk_ringbuffer.c | 48 +++++++++++++++++++++++++++++++++++----
>  kernel/printk/printk_ringbuffer.h |  2 ++
>  2 files changed, 46 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index 8a7b736..297bc18 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -2005,8 +2014,38 @@ u64 prb_first_valid_seq(struct printk_ringbuffer *rb)
>   */
>  u64 prb_next_seq(struct printk_ringbuffer *rb)
>  {
> -	u64 seq = 0;
> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> +	enum desc_state d_state;
> +	unsigned long id;
> +	u64 seq;
> +
> +	/* Check if the cached @id still points to a valid @seq. */
> +	id = atomic_long_read(&desc_ring->last_finalized_id);
> +	d_state = desc_read(desc_ring, id, NULL, &seq, NULL);
>  
> +	if (d_state == desc_finalized || d_state == desc_reusable) {
> +		/*
> +		 * Begin searching after the last finalized record.
> +		 * (On 0, the search must begin at 0 because of hack#2
> +		 * of the bootstrapping phase it is not known if a
> +		 * record at index 0 exists.)
> +		*/

               ^^^ whitespace
               
> +		if (seq != 0)
> +			seq++;
> +	} else {
> +		/*
> +		 * The information about the last finalized sequence number
> +		 * has gone. It should happen only when there is a flood of
> +		 * new messages and the ringbuffer is rapidly recycled.
> +		 * Give up and start from the beginning.
> +		 */
> +		seq = 0;
> +	}
> +
> +	/*
> +	 * The information about the last finalized @seq might be inaccurate.
> +	 * Search forward to find the current one.
> +	 */

It is fine to add this comment. But then the following comment should be
removed. It is redundant.

>  	/* Search forward from the oldest descriptor. */
>  	while (_prb_read_valid(rb, &seq, NULL, NULL))
>  		seq++;

Petr can probably just make the changes when committing. I am not
requesting a v4.

@Petr: Feel free to add:

Reviewed-by: John Ogness <john.ogness@linutronix.de>
