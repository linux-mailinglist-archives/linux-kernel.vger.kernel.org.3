Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C3746188F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378328AbhK2OcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 09:32:07 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45348 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378315AbhK2O3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:29:47 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A4C461FD38;
        Mon, 29 Nov 2021 14:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638195973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P/2mMER5BWy4uVFtFkCYgpdYQadaiIdXAQCEaONlzSI=;
        b=NHoyZ8/ObXjEjSR5g2Mumxcfogs07QrJjTw/QzeZOq761ClUixVSxCarDfvX8rbW2peTDP
        46FOnOM81cFzFRGzOmpJbYQscM54ZFaLKxb0tWbFLugfY/gA6Vha6xqoPqrEsaJpS1wekt
        xKKTpdDNgaHOiIPrIMZj6+RK2Dfe360=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638195973;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P/2mMER5BWy4uVFtFkCYgpdYQadaiIdXAQCEaONlzSI=;
        b=DcLDjsksdtpwoGQWVjqPhkL0r2a1jvvtnsnb6/q8CAaUK6+uaBT8bJkb/ZpfJfB6GaXGnj
        ZO6pdKEZU45FUDDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7EDDC13B15;
        Mon, 29 Nov 2021 14:26:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hSkyHgXjpGGFfwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 29 Nov 2021 14:26:13 +0000
Message-ID: <9cd2e67b-4769-ad91-2b2a-1899bdf3f8fc@suse.cz>
Date:   Mon, 29 Nov 2021 15:26:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] mm/slub: fix endianness bug for alloc/free_traces
 attributes
Content-Language: en-US
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <7c909b82-8e1c-a8ce-516d-e3aa9bc2fd81@suse.cz>
 <20211126171848.17534-1-gerald.schaefer@linux.ibm.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211126171848.17534-1-gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/21 18:18, Gerald Schaefer wrote:
> On big-endian s390, the alloc/free_traces attributes produce endless
> output, because of always 0 idx in slab_debugfs_show().
> 
> idx is de-referenced from *v, which points to a loff_t value, with
> 
> unsigned int idx = *(unsigned int *)v;
> 
> This will only give the upper 32 bits on big-endian, which remain 0.
> 
> Instead of only fixing this de-reference, during discussion it seemed
> more appropriate to change the seq_ops so that they use an explicit
> iterator in private loc_track struct.
> 
> This patch adds idx to loc_track, which will also fix the endianness bug.
> 
> Link: https://lore.kernel.org/r/20211117193932.4049412-1-gerald.schaefer@linux.ibm.com
> Fixes: 64dd68497be7 ("mm: slub: move sysfs slab alloc/free interfaces to debugfs")
> Cc: <stable@vger.kernel.org> # v5.14+
> Reported-by: Steffen Maier <maier@linux.ibm.com>
> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

With a nit below:

> ---
>  mm/slub.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index a8626825a829..abe7db581d68 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5081,6 +5081,7 @@ struct loc_track {
>  	unsigned long max;
>  	unsigned long count;
>  	struct location *loc;
> +	loff_t idx;
>  };
>  
>  static struct dentry *slab_debugfs_root;
> @@ -6052,11 +6053,11 @@ __initcall(slab_sysfs_init);
>  #if defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS)
>  static int slab_debugfs_show(struct seq_file *seq, void *v)
>  {
> -
> -	struct location *l;
> -	unsigned int idx = *(unsigned int *)v;
>  	struct loc_track *t = seq->private;
> +	struct location *l;
> +	unsigned long idx;
>  
> +	idx = (unsigned long) t->idx;
>  	if (idx < t->count) {
>  		l = &t->loc[idx];
>  
> @@ -6105,16 +6106,18 @@ static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
>  {
>  	struct loc_track *t = seq->private;
>  
> -	v = ppos;
> -	++*ppos;
> +	t->idx = ++(*ppos);
>  	if (*ppos <= t->count)
> -		return v;
> +		return ppos;

What I had in mind, and to be more in line with the seq_file example, would
be to return &t->idx here. Then it's what gets passed to slab_debugfs_show()
as 'v'. But since we ignore 'v' there, it probably doesn't matter.

>  
>  	return NULL;
>  }
>  
>  static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
>  {
> +	struct loc_track *t = seq->private;
> +
> +	t->idx = *ppos;
>  	return ppos;

And same here.

>  }
>  
> 

