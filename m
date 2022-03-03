Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B954CC8E9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbiCCW3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236922AbiCCW3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:29:46 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C319A60046
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:28:59 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id z8so2833790oix.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 14:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ZitNuTrI/UQapwn2GiYljxe5fq629INgptH72e1M85g=;
        b=Q/s/lFgi2vAnQUNIfe6ltvc25/t1Io8AISgNKYUNg4p/aKRPCJB86Z6fXBLhKndFVH
         JcBq8nylOFBzIb4UxZt9hJe60/lfD+M6lRwYgEPCgbG7xZkn9I9RoPmLcXbrd6eRBy80
         uw8eTrcNUI+58iefr83oyq1w/jSYBYOWn9MxbfqTlkTfu/yM1iG+pqFx/DnhG05brs5M
         OS4f6rTi471PDC9lHlztrf2XUPXo0tcPNszahut/G5C9b5lDq59ESbjVVrSc4quGtPgt
         nv4aS3mSuALfvOsp+O/xFk9Pp0tiZh48LXsOQkef1HkR1ySA//5DL7ofNhkRMUFrp5+U
         50Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=ZitNuTrI/UQapwn2GiYljxe5fq629INgptH72e1M85g=;
        b=HuJiNysl++gPdcPicZ+ytrJnWID31TYUfjCY1ETnj5E5mmeBcNWanN6cmZxX0zsM+k
         PXVXoJRcsqvgEdfLGaMTHjSeZ1iZxlorccInJTIhayDD7xjkJcGzRWNpb+EXRj/kbXC2
         I0UMjQevxaMH/7Uek0PXIuv9w/6YxFwWsuH0TrXCvjLkKN6piYXZlxfvY+IZhriXWTZT
         tz1kyyCe9GEDyL7YVjAt1FztCcmvExRRT+pBgOBGpMLHa2xC69RkFIP97/s9L0UnOtR1
         bx+NiZ2u3PgVDVDCE7y0dusUyoi525H+mjmGjjQmY6cloBiqF7pZKnsNDOY3L6CdxTH4
         Xqmg==
X-Gm-Message-State: AOAM5310zse7KjUohwxDX4hGwD6t/4cO6tqGZzzheWbRILA1BgE0frRH
        6qfDgIXw1T91+EDOdtNYh50nQw==
X-Google-Smtp-Source: ABdhPJy7CvRfPckxX4gtN7y/KZCotuF9/rGE6qrqB642Eus6Z7w124d4+V7V/4U9ixcrjHEnAQZGOQ==
X-Received: by 2002:a05:6808:14c3:b0:2d9:9229:7d25 with SMTP id f3-20020a05680814c300b002d992297d25mr728807oiw.49.1646346538920;
        Thu, 03 Mar 2022 14:28:58 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t11-20020a4ae40b000000b0031cc933b418sm1534025oov.40.2022.03.03.14.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 14:28:57 -0800 (PST)
Date:   Thu, 3 Mar 2022 14:28:46 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     David Hildenbrand <david@redhat.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH mmotm] mm: delete __ClearPageWaiters()
In-Reply-To: <a2f6aa01-8003-6791-718d-3898f77ef643@redhat.com>
Message-ID: <9dda55d5-eafa-3177-2a4c-32ccb7e146e3@google.com>
References: <351df0af-78f2-c20-2a6d-e5f978e5ca1@google.com> <a2f6aa01-8003-6791-718d-3898f77ef643@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022, David Hildenbrand wrote:
> On 03.03.22 02:56, Hugh Dickins wrote:
> > The PG_waiters bit is not included in PAGE_FLAGS_CHECK_AT_FREE, and
> > vmscan.c's free_unref_page_list() callers rely on that not to generate
> > bad_page() alerts.  So __page_cache_release() and release_pages() (and
> > the presumably copy-and-pasted put_zone_device_private_or_public_page())

Hah, I'm showing my age there, or the patch's age: it's been rebranded
frequently since then, with linux-next calling it free_zone_device_page(),
as you kindly point out.  How long before it's free_zone_device_folio()?

> > are redundant and misleading to make a special point of clearing it (as
> > the "__" implies, it could only safely be used on the freeing path).
> > 
> > Delete __ClearPageWaiters().  Remark on this in one of the "possible"
> > comments in wake_up_page_bit(), and delete the superfluous comments.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> > We've used this since 2018, and I see Yu Zhao posted similar in 2020:
> > https://lore.kernel.org/linux-mm/20200818184704.3625199-3-yuzhao@google.com/
> > I couldn't join in at that time, but think its reception was over-cautious.
> > 
> >  include/linux/page-flags.h |  2 +-
> >  mm/filemap.c               | 22 +++++++---------------
> >  mm/memremap.c              |  2 --
> >  mm/swap.c                  |  4 ----
> >  4 files changed, 8 insertions(+), 22 deletions(-)
> > 
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -1179,24 +1179,16 @@ static void folio_wake_bit(struct folio *folio, int bit_nr)
> >  	}
> >  
> >  	/*
> > -	 * It is possible for other pages to have collided on the waitqueue
> > -	 * hash, so in that case check for a page match. That prevents a long-
> > -	 * term waiter
> > +	 * It's possible to miss clearing waiters here, when we woke our page
> > +	 * waiters, but the hashed waitqueue has waiters for other pages on it.
> >  	 *
> > -	 * It is still possible to miss a case here, when we woke page waiters
> > -	 * and removed them from the waitqueue, but there are still other
> > -	 * page waiters.
> > +	 * That's okay, it's a rare case. The next waker will clear it. Or,
> > +	 * it might be left set until the page is freed: when it's masked off
> > +	 * with others in PAGE_FLAGS_CHECK_AT_PREP, by free_pages_prepare().
> >  	 */
> 
> Does that also apply to ZONE_DEVICE pages via free_zone_device_page()?

I'm sure you could tell me a lot more about ZONE_DEVICE pages than I
could ever tell you.  But, if they don't ever reach the main page freer,
then they're in the same category as other pages not freed until reboot:
any clearing of left-behind PG_waiters will be done by the next waker,
not by reaching free_pages_prepare().  Does that really require special
mention of ZONE_DEVICE pages here?  Would I do better just to remove
the comment on PAGE_FLAGS_CHECK_AT_PREP being one of the clearers?

(I had to do a bit of research before answering: temporarily confused
about the role of PG_waiters, I worried that removing copy-and-pasted
__ClearPageWaiters from free_zone_device_page() might risk gradually
clogging up the hash queues with spuriously waited pages; no, nonsense,
it's just a matter of how efficient the next folio_unlock() will be.)

Hugh
