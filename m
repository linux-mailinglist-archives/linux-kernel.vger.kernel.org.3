Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EA24ED32B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 07:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiCaFQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 01:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiCaFQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 01:16:22 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEA955BFD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 22:14:35 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id 10so20546079qtz.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 22:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=h3ZBjraaX1G+wSwlOxYGmIuns3nUNLh3W7WdCDpX/fU=;
        b=AAlCwujbppS/7hrSGg2MOz7PkK10apKlzk/HPUg/z85+8mtYcdfaj2E1ySSJCVKlws
         Sgy6PtK8ylIHHcB+CftadR5OWWcUKGsX6HhZ4CgeJT8kvR0yQ1awk8QbDHw5fdJNAPYD
         L/RjwulQ60sO9WepVUdO/bTv1iVW53+xKYIcixxUq6pLGGyre7xJeokSNePzU8wVCKNf
         6V0yeLhQmlLIKrLKC5PmwavSFGTBego1id8+8OtaZxbemvFRvQxQTi8LUXqxqZ4rIxw4
         rb4nyFoSyKFzFtb1JAz+fzfLr0Geiz0ZC96jXa5Mst52RsoTGGlOzaDehMy+B0vp3sGX
         xOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=h3ZBjraaX1G+wSwlOxYGmIuns3nUNLh3W7WdCDpX/fU=;
        b=itLq3+y1qwR2asCQjpPVRdRaDR4qEyPLDkHE4rJ54dZcvPoTkYdgR2Y/fx++Kq5aKe
         dX4i87Onh8DPS5pqMEj6PBqyMAkcyUzaKU9qPnDwufMMj5DlBEZ0yXIfg/l6EPxElEgZ
         uZyxGHyfgad51RhHWPK6hTqnTapiBTC2fNZBGGjFfCPK6VfDMIV6imcAWol3Gr9s8f7G
         pyoRjyFgZNtS7CCw7FOmTTgzABClSJxwIhloXp9gCzeZRRv33yjpIVSTLQSC1gVNnV54
         L6FsUmy9VYQvQLO8EprXQncwkRe7HisN0j4u8Cel0ksaxZFUNVk/6aS/VdFqPHR2ucZa
         +2dw==
X-Gm-Message-State: AOAM532D1Pb3/R1BxEb57hlJZNgy/+Z7zFWzfffHkSJAj8BDumR2FqrT
        a9Dkgl54ooUglqfDehZlIf/gGKEBuqjY2g==
X-Google-Smtp-Source: ABdhPJzBpWHvtKH0HY0IY96uia/Nnn0dQEf8xtN5cXz+y/+VP3qsalBtnp5fgETiFNKP4GKyx/I9/w==
X-Received: by 2002:a05:622a:116:b0:2e1:efb7:4a3d with SMTP id u22-20020a05622a011600b002e1efb74a3dmr2767075qtw.298.1648703674420;
        Wed, 30 Mar 2022 22:14:34 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c11-20020a05620a134b00b006809a92a94fsm11678306qkl.79.2022.03.30.22.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 22:14:33 -0700 (PDT)
Date:   Wed, 30 Mar 2022 22:14:22 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: WARNING: mm/workingset.c:567 shadow_lru_isolate
In-Reply-To: <YkTPUmMitEDHfjeH@casper.infradead.org>
Message-ID: <20f5a12f-416b-458b-80f1-e4c13cd1ec64@google.com>
References: <55db706b-9bce-b820-7d88-6392374cd4fc@google.com> <YkTPUmMitEDHfjeH@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022, Matthew Wilcox wrote:
> On Mon, Mar 28, 2022 at 09:24:00PM -0700, Hugh Dickins wrote:
> > I'm not familiar with workingset.c, I'll make no guesses, over to you!
> 
> I haven't been able to reproduce it, but I applied Feynman's Problem
> Solving Algorithm, and I think this will do the trick:

Excellent! Yes, this fixes it - thanks.

Hugh

> 
> diff --git a/lib/xarray.c b/lib/xarray.c
> index b95e92598b9c..d3b168f619b1 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -1079,6 +1079,7 @@ void xas_split(struct xa_state *xas, void *entry, unsigned int order)
>  					xa_mk_node(child));
>  			if (xa_is_value(curr))
>  				values--;
> +			xas_update(xas, child);
>  		} else {
>  			unsigned int canon = offset - xas->xa_sibs;
>  
> @@ -1093,6 +1094,7 @@ void xas_split(struct xa_state *xas, void *entry, unsigned int order)
>  	} while (offset-- > xas->xa_offset);
>  
>  	node->nr_values += values;
> +	xas_update(xas, node);
>  }
>  EXPORT_SYMBOL_GPL(xas_split);
>  #endif
> 
> (the key insight is that the update function should have removed the
> node from the list; the WARN_ON really means "this node should not be on
> the list", so there's somewhere that we're forgetting to call
> xas_update(), or somewhere that we're forgetting to call
> mapping_set_update().  I didn't find any of the latter, but I did find
> one of the former)
