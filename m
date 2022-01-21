Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD7B4962A6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbiAUQNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381770AbiAUQNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:13:16 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4C4C06173D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 08:13:15 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x37so5326725pfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 08:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nHlCwPmMEn/YiZ8pnMummdA5yNnFdGTRy0EIU8YdvTA=;
        b=j18/byAixcHkXvKnOv7VC4/Y2d9aV08L1GVVPzBjxLYBIIHbKUlxvwPmijzVbngZZz
         gpS6HqqYgA0pcbKspza9e169IUNkKqVfUylDaJ+qI4/kD/nqxe4VpSic6bW/Cxf0VJse
         O1R+UDI77rMDLmGTEKAgI0uLZR1J6jLinw6Elv1zBa4UF++90doM40XtDUh4gTvBOWYQ
         j8aDRdju6ShyKEy2e7cp7O4k7vy8qS9TS37IilaM9Lp5AdNrRr5O78uoUSg9bINxP1j3
         q5Qm4qfC087EZp7SQcbXUPwMDVBgodlx2QUF9TgeV0K39yf7pi/f2e7pBZ+0+eSF/4As
         wSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nHlCwPmMEn/YiZ8pnMummdA5yNnFdGTRy0EIU8YdvTA=;
        b=qb8a8DyT7If5d1hZul14idNStVGuSJLBjGVlNLBfMHM5GQTdUdjXgC0xBLzhcMsQnp
         iDHrQm9fh2o5Dr3oUE9EHKVjvcLU778mzITifzobVWuJ1Kf9+Mykvn1usTLdfbR2vIZH
         bXBVDoqk870OK9zKzcNfIyyYcYGuRHi06cVzxxHxLKCdnBG1w84UE7j49mKahjWNAM6c
         u1ET4iLCrZA0kq5P7vFccn+3E68/yz2GP+57cIYcU+qZk7WSuO5VHmAwa47MNhYGOR22
         dgnOphIByiR1pDhRpkcXV8K4cqqCkbIyRuniMm73YDwsz8SPNW6Zf7JCujDtuL0JCzXr
         ADPw==
X-Gm-Message-State: AOAM5325DSUi0a6QuzTZrwUWWPM0LXeOQ72gPQKu/cFpxj150Qf7Eo3z
        EDSMl0QqduJupeHAy3o11VIdng==
X-Google-Smtp-Source: ABdhPJyWEkgLOGmK9rQ1mELG6RVy7ZTD8COqzNFBIlJbG6n9fvNba4MzsEPV6Svv4uyxRLU756Ktnw==
X-Received: by 2002:a63:bf0f:: with SMTP id v15mr3452250pgf.528.1642781595042;
        Fri, 21 Jan 2022 08:13:15 -0800 (PST)
Received: from hermes.local (204-195-112-199.wavecable.com. [204.195.112.199])
        by smtp.gmail.com with ESMTPSA id g18sm5380152pgh.45.2022.01.21.08.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:13:14 -0800 (PST)
Date:   Fri, 21 Jan 2022 08:13:11 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     ycaibb <ycaibb@gmail.com>
Cc:     davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: missing lock releases in ipmr_base.c
Message-ID: <20220121081311.2518068f@hermes.local>
In-Reply-To: <20220121032210.5829-1-ycaibb@gmail.com>
References: <20220121032210.5829-1-ycaibb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022 11:22:10 +0800
ycaibb <ycaibb@gmail.com> wrote:

> From: Ryan Cai <ycaibb@gmail.com>
> 
> In method mr_mfc_seq_idx, the lock it->lock and rcu_read_lock are not released when pos-- == 0 is true.
> 
> Signed-off-by: Ryan Cai <ycaibb@gmail.com>
> ---
>  net/ipv4/ipmr_base.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
> index aa8738a91210..c4a247024c85 100644
> --- a/net/ipv4/ipmr_base.c
> +++ b/net/ipv4/ipmr_base.c
> @@ -154,6 +154,7 @@ void *mr_mfc_seq_idx(struct net *net,
>  	it->cache = &mrt->mfc_cache_list;
>  	list_for_each_entry_rcu(mfc, &mrt->mfc_cache_list, list)
>  		if (pos-- == 0)
> +			rcu_read_unlock();
>  			return mfc;
>  	rcu_read_unlock();
>  
> @@ -161,6 +162,7 @@ void *mr_mfc_seq_idx(struct net *net,
>  	it->cache = &mrt->mfc_unres_queue;
>  	list_for_each_entry(mfc, it->cache, list)
>  		if (pos-- == 0)
> +			spin_unlock_bh(it->lock);
>  			return mfc;
>  	spin_unlock_bh(it->lock);
>  

Another buggy patch, perhaps you write python or research papers?
