Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B60B4B79DE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244258AbiBOVC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:02:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiBOVCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:02:54 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4D827FF2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:02:44 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id z15so49279qtx.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=RojO1s2ebF9xxfjFY1vNZc8Wc0/GmbtOgVpxelDT3Es=;
        b=AOrHTegYpuTN0vWbGZ1zxEfaoRq+Xa3pSQhdj+hxe4QWQwOovJklU1Mac1cCs3LQ0E
         fAwrLmAeXlKCWaMrZgtHQJhel53qFAYRkdna73DjH1w4LAVndwouTOG4MbFFYCCL9Y2f
         Ju+QjlMsHFz2W6zLiwmavEQqvXNNqMUi9K0GHLEGKnHCWKfa5bY0F9HnbJOJuMe8wyQ6
         vbU5PaZEeQFFD1ftF2g6k0wg0girLYJ395HGrjmUTR1Oj/eMSEYxsPlRnzDqZj6k80qO
         hoIoLJdKaSmNMp9Xdlr/aDqr53+r4k95Msf1pTf6zDgDZqsJ2koKU2Ds3jSPjxk4BjZN
         n1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=RojO1s2ebF9xxfjFY1vNZc8Wc0/GmbtOgVpxelDT3Es=;
        b=Dg95RxDAOSguUcfUEdNWIl++LeeqILDFlYnu6Ko6QhPcfQUsL39g9/L8ANXH3TMflr
         o4aJtMWL0mg/A8m+WsxykJJ3Uy87GQjC4fy5a3SDW2njU/ENA4yFXPyALbn7QCrz0ybZ
         BQoZNivBTZvUgSu4LBMiGC18F395+tu3jr4Yp9YsHcsOkJJ3KmdItiUtf14ILOv9dduu
         uzIMQrqwmZe128uoQay6U6qtUfgQYoR9djCJdudE7fLu1luhYhEgTNkooWgbdo2kzfBh
         o/0ILvKNi5DmvPXIMiVpFgR+t1akksuY45ru5HNYRt8l+YhhS+5hCwq9kzzDNq7MUIkR
         CwYQ==
X-Gm-Message-State: AOAM533cwLv0Bl6GxcfbyIdQ21apj0knpzFtOoPJq+iGM3U5MxvIqT0Y
        MQ74X73z6v9uK/I+clLFY3o95Q==
X-Google-Smtp-Source: ABdhPJyYLAdLBtClvESalRU/1PMX028+T47koEhg36b0JuJd2M9G5i3e6iZxz5oKrtS2SdUrsWnRug==
X-Received: by 2002:ac8:5bc8:: with SMTP id b8mr643716qtb.428.1644958963064;
        Tue, 15 Feb 2022 13:02:43 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p15sm20735921qtk.56.2022.02.15.13.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 13:02:42 -0800 (PST)
Date:   Tue, 15 Feb 2022 13:02:30 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 10/13] mm/munlock: mlock_page() munlock_page() batch
 by pagevec
In-Reply-To: <YgvXjwapRTOXQOuQ@casper.infradead.org>
Message-ID: <ef1e285c-187a-f682-a62b-c6a0f42b5cbf@google.com>
References: <55a49083-37f9-3766-1de9-9feea7428ac@google.com> <1abb94ee-fe72-dba9-3eb0-d1e576d148e6@google.com> <YgvXjwapRTOXQOuQ@casper.infradead.org>
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

On Tue, 15 Feb 2022, Matthew Wilcox wrote:
> On Mon, Feb 14, 2022 at 06:37:29PM -0800, Hugh Dickins wrote:
> > +/*
> > + * Flags held in the low bits of a struct page pointer on the mlock_pvec.
> > + */
> > +#define LRU_PAGE 0x1
> > +#define NEW_PAGE 0x2
> > +#define mlock_lru(page) ((struct page *)((unsigned long)page + LRU_PAGE))
> > +#define mlock_new(page) ((struct page *)((unsigned long)page + NEW_PAGE))
> 
> You've tripped over one of the weirdnesses in the C preprocessor here.
> If the variable passed is not _named_ page, it gets cast to a pointer
> to a struct of the same name as the variable.  There's no way to tell
> cpp that that 'page' after 'struct' is literal and not to be replaced
> by the 'page' argument.
> 
> I'm going to change this to:
> 
> static inline struct page *mlock_lru(struct page *page)
> {
> 	return (struct page *)((unsigned long)page + LRU_PAGE);
> }
> 
> (mutatis mutandi for mlock_new)

Okay, thanks.  (You're not naming your folio "page" :-?)

Hugh
