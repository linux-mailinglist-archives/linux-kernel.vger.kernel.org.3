Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D734475922
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242636AbhLOMys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:54:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54436 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbhLOMyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:54:47 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3FC3A1F387;
        Wed, 15 Dec 2021 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639572886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6G74eF57Xv4t6JFouHLmcNr7BnEUyjP+vnWHmDH4sfw=;
        b=2OAjKgi47I5WkECU1uNTESMohBN/N11JSx10cZaxNoPcGTSRSbHqK3bU1tpCWOIRlUlOQq
        Xei98jx2Wu/qiE7HfOi20M2vy3iJOShyeSVJvqOgrojFEnwAyXdQMUyL5cWaz7frs1ZrrW
        KxFP/nMknhgz5KSnxZRW7oUNqj1sYms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639572886;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6G74eF57Xv4t6JFouHLmcNr7BnEUyjP+vnWHmDH4sfw=;
        b=Ntnor+dcDUkTZGBpk3v1l7rUs5mswEgKrn/oP25/U5fCPOOZJXPtpzhFJbM2WnSK7IDjYT
        EyfgRxFvH7dMQpBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB0451330B;
        Wed, 15 Dec 2021 12:54:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JUG+OJXluWFMPAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 15 Dec 2021 12:54:45 +0000
Message-ID: <f727adcf-5967-0b71-92a8-3269c0256948@suse.cz>
Date:   Wed, 15 Dec 2021 13:54:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 05/66] Maple Tree: Add new data structure
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-6-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-6-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:29, Liam Howlett wrote:
> +/*
> + * mt_find() - Search from the start up until an entry is found.
> + * @mt: The maple tree
> + * @*index: Pointer which contains the start location of the search
> + * @max: The maximum value to check
> + *
> + * Handles locking.
> + *
> + * Return: The entry at or after the @*index or %NULL

Noticed later that the comment doesn't say how *index is updated.

> + */
> +void *mt_find(struct maple_tree *mt, unsigned long *index, unsigned long max)
> +{
> +	MA_STATE(mas, mt, *index, *index);
> +	void *entry;
> +#ifdef CONFIG_DEBUG_MAPLE_TREE
> +	unsigned long copy = *index;
> +#endif
> +
> +	trace_ma_read(__func__, &mas);
> +
> +	if ((*index) > max)
> +		return NULL;
> +
> +	rcu_read_lock();
> +retry:
> +	entry = mas_state_walk(&mas);
> +	if (mas_is_start(&mas))
> +		goto retry;
> +
> +	if (unlikely(xa_is_zero(entry)))
> +		entry = NULL;
> +
> +	if (entry)
> +		goto unlock;
> +
> +	while (mas_searchable(&mas) && (mas.index < max)) {
> +		entry = mas_next_entry(&mas, max);
> +		if (likely(entry && !xa_is_zero(entry)))
> +			break;
> +	}
> +
> +	if (unlikely(xa_is_zero(entry)))
> +		entry = NULL;
> +unlock:
> +	rcu_read_unlock();
> +	if (likely(entry)) {
> +		*index = mas.last + 1;
> +#ifdef CONFIG_DEBUG_MAPLE_TREE
> +		if ((*index) && (*index) <= copy)
> +			printk("index not increased! %lx <= %lx\n",
> +			       *index, copy);
> +		MT_BUG_ON(mt, (*index) && ((*index) <= copy));
> +#endif
> +	}
> +
> +	return entry;
> +}
> +EXPORT_SYMBOL(mt_find);

