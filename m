Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAF058EFFC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbiHJQDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiHJQDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:03:44 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB5A6557C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:03:40 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id e28so3451945qts.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc;
        bh=UHxiF+XuP7hU3FjOndl9IpIiJjXqbFZ8FqBDkR7ajJ8=;
        b=L6fdqwBfXI+mWVQfuqtb269qsWIopZVJnWrfmcUIPasXNa1rrbHrHt/Cuv27SQg65U
         AG576/loHOwg1lj2WJ82tOhWI6zXYDcc3TOezK1fIPj8w0aXMPWQerwbnTn9s4PzQW8d
         rvSHazTbiMZrZcl85wFAVNaJDLf0OtZhLLrdLPICaqD68UP1Jag5DULJqxkRLA63tF5l
         48Q0W3a7aEFUPIcl3iaD3J/kJ25QJ8TtsPZih4GWkyXPTJDRSKsLkdvZi+xgSF9IvaMx
         jITVYgf8f0Boasj2RXg1i2s3PqdXm+5THC16MMhMMJUFnAfHJd51+l5N3JtylFkqV7CD
         HzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc;
        bh=UHxiF+XuP7hU3FjOndl9IpIiJjXqbFZ8FqBDkR7ajJ8=;
        b=xVHAJIpBHkNaBI1oEklx6gPP9HtZp9j+QzOkLtMaLPSsMpLZJ0WQNb48yOb7jyzn9y
         d3cP6Exqr2WVGciGHznPILdKxaj3giH47anG0/IkE+j5SrWhU1NjARBGn3ejCdAK/cby
         8nuLg/SRoeRQbZYJJTMo75HLvyOTSEl+SxqqRHq4i9es5FD6LaFW7fWiuX9AdBE6gYHP
         /w4hf2dID3HhNjTDL83mTQPQj11BRV0LK3gt1eR/b/5KZhGttCLf6Ri5Qdqp00AkxfsK
         Qi4aC0feC1dlnAFzIiaE8zN2rPmHYefpSbe22+0VrINPElEeGpZJux2t4jEwTUBtMl22
         eupw==
X-Gm-Message-State: ACgBeo3zvpU6Yocgf9reyHK+nWCU13ftQEzACQ5pkx18ak+b8HC27w1P
        Yv3cXBf/3j258Q3mW6IQNYDVkA==
X-Google-Smtp-Source: AA6agR4yCbCk22g/TShSJ5wK1vy32ZWD7A2GASm9IKqA1yPzcdUg3cNGgF2DFqOPM9bnEdQnLmULCw==
X-Received: by 2002:a05:622a:512:b0:343:6f1:a026 with SMTP id l18-20020a05622a051200b0034306f1a026mr7393305qtx.323.1660147419927;
        Wed, 10 Aug 2022 09:03:39 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k13-20020ac8604d000000b00342f8d4d0basm55075qtm.43.2022.08.10.09.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 09:03:39 -0700 (PDT)
Date:   Wed, 10 Aug 2022 09:03:37 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zdenek Kabelac <zkabelac@redhat.com>
Subject: Re: [PATCH] shmem: Update folio if shmem_replace_page() updates the
 page
In-Reply-To: <20220730042518.1264767-1-willy@infradead.org>
Message-ID: <9ec4de13-3f7-ba55-924-75d825ec12ed@google.com>
References: <20220730042518.1264767-1-willy@infradead.org>
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

On Sat, 30 Jul 2022, Matthew Wilcox (Oracle) wrote:

> If we allocate a new page, we need to make sure that our folio matches
> that new page.  This will be solved by changing shmem_replace_page()
> to shmem_replace_folio(), but this is the minimal fix.
> 
> Fixes: da08e9b79323 ("mm/shmem: convert shmem_swapin_page() to shmem_swapin_folio()")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Hugh Dickins <hughd@google.com>

I hit this myself just once, at about the very time you sent the fix.
But, thinking that shmem_replace_page() was special for gma500, couldn't
understand how I (or most people) would ever get there.  Turns out that
nowadays tmpfs symlinks longer than 128 can come this way on 32-bit (I
had been testing kmap_local stuff for other reasons).

And today I see that Zdenek hit it on 5.19-rc back in June:
https://lore.kernel.org/lkml/584ae788-05e3-5824-8c85-cbb833677850@redhat.com/
so this patch is definitely one for -stable.

Hugh

> ---
>  mm/shmem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index a6f565308133..bcc0a3c7b5bf 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1771,6 +1771,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  
>  	if (shmem_should_replace_folio(folio, gfp)) {
>  		error = shmem_replace_page(&page, gfp, info, index);
> +		folio = page_folio(page);
>  		if (error)
>  			goto failed;
>  	}
> -- 
> 2.35.1
