Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1884B417B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 06:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiBNFnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 00:43:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiBNFnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 00:43:01 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2974EA1B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:42:54 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id 200so13577550qki.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=mgDBiAgrDE+HzdrWiW9X6X5k1U05FMaVyhBfS9IYqQk=;
        b=hyBPt5rxqBrVtpTfh1GbduDPv1o+7rezTszUd0x9z+uTt8/brT5CqtxuiuFhRP+BEi
         SQQS8iL7lt9v7yDR+sjnGpXCUrqAuDoiNeopGu7hvV+JNIzKUcrSlqMy+AYy+yZFAroZ
         uUOtWdSD4vlu51XKZohNmk8KZWs1iQXWoxfdk4XtQmHp95WSw5IEx2/ggNK/6vZerb9l
         +Yn8lXMkVsSRnLMTPMHPWlRmku1ziQLfDp+aSTxWO8Km5KHPr5sa4SlHaETlYb2a1pe3
         W9xRhX1KnHTNdUiJfG/SuKRPQhGjy+TWpmdBgUF2+CNUfCTbb1W5RD/wMk1k8FshKVC8
         rHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=mgDBiAgrDE+HzdrWiW9X6X5k1U05FMaVyhBfS9IYqQk=;
        b=r6BNK/T5QLmAx2ap/YwLqaJGNdGw9Prah0vntRY+6m1E9oudVT3wz0fwInf8KVSUNO
         RqHuPxWn23LgfwY+oZuTdQVSq4vjwl83vqLRQaGtPADpvhgg44IUEe8Pkm3ss7c5gjtC
         rHANs/KaQkqpZQcAcEwjDYHgrhbU7Chc6Rhei3ajJNGv1ank/sO9wiWVsR4NWg/1lv7W
         wXkFPIvSEMARzYUDwDIDbOy7EZrywLjg1rmj9WXGHt2xMuZEm+ghaaOAbwNxzXWfbY2J
         2WKzHlrsecmT2UQbx6Bs6vnai0DYks9KVteqOCK2ja4iu31v+1p6zyanqv458arapzba
         rZTA==
X-Gm-Message-State: AOAM533vP30ZifLw6CVVgHSnpOTuvJLh+c09sML/xHnxx64XaoGr7OGV
        Y4dt5APv5AaohI/MVd5r2xQNlg==
X-Google-Smtp-Source: ABdhPJy3dq7YiFDBVxyQp92TqbStWUS0h8WxS19ewftiosU5Eyqx7PxENsx2f/Yw7ifyCPDm4x6lLQ==
X-Received: by 2002:ae9:eb4f:: with SMTP id b76mr6187977qkg.690.1644817373328;
        Sun, 13 Feb 2022 21:42:53 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j14sm16111320qko.10.2022.02.13.21.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 21:42:52 -0800 (PST)
Date:   Sun, 13 Feb 2022 21:42:49 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 06/13] mm/munlock: maintain page->mlock_count while
 unevictable
In-Reply-To: <826e69d0-c81c-06c1-c675-b54bd4557ff3@suse.cz>
Message-ID: <c04abe82-84e6-5bf5-b420-667f2e20c6c7@google.com>
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com> <3d204af4-664f-e4b0-4781-16718a2efb9c@google.com> <826e69d0-c81c-06c1-c675-b54bd4557ff3@suse.cz>
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

On Fri, 11 Feb 2022, Vlastimil Babka wrote:
> On 2/6/22 22:40, Hugh Dickins wrote:
> > @@ -115,6 +116,7 @@ void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
> >  
> >  	update_lru_size(lruvec, lru, folio_zonenum(folio),
> >  			folio_nr_pages(folio));
> > +	/* This is not expected to be used on LRU_UNEVICTABLE */
> 
> Felt uneasy about this at first because it's just a _tail version of
> lruvec_add_folio, and there's probably nothing fundamental about the users
> of _tail to not encounter unevictable pages. But if the assumption is ever
> violated, the poisoned list head should make it immediately clear, so I
> guess that's fine.

Yes, I could have made that one check against LRU_UNEVICTABLE too, but
thought we would rather see the crash on the poisoned list head: since
specifically choosing the tail of an unordered (and imaginary) list
raises questions - it might turn out to be best permitted, it might turn
out to require a rethink; but until there is a case, let's crash on it.

Hugh
