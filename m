Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658E84CCD3F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbiCDF1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiCDF1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:27:13 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEEB1ADA0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:26:26 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id g24so5718365qkl.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=QrGr+Bl6A1eU/fulzKdJtDbWBbVCzUvn4PhrHXLHZ0A=;
        b=sSwqaIpdVCk4KE77NO/JzSErM9U9UpCb1GP4qocamsBiiP83n/xlhn/YgRuDoZo29/
         Qr6NT+8HOo3itBaNIRAGMkNHeGfnv8nrHiDZeharfJ9cVE755PBslYon40b+lSkPsjcq
         CZ6HG3LSVpO6BO45TeEEu7A1o8mzcQrxquPKwjFlHtTrvP8Qw+HZ60B3rSu4TljFVjgz
         wlqJ5XUyLZKBxK1xakpDh7wuqi0FvJ2qnAjzJdOSzyARYxLi/hbug7NJCcwtJ7ZGq+Cs
         b7IbVu30i+pUNEKDlGDoGYaZFz4tikuvmxc8q+bh/mzuVycDoRzImQZrA7h7Ma0v0MZn
         eerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=QrGr+Bl6A1eU/fulzKdJtDbWBbVCzUvn4PhrHXLHZ0A=;
        b=DKHMCrv1n2Ljr4BNyc3d+iKFjdUgKieBY3NY5zUU+FwKcsqWd4Pp9xsBHANU8JdCfV
         PYUf+MhKTwQZIMdz8bccOSRemyrYwukjorzU+w0oo2bD1HI/ME+esnvXaX6LsODkrdGX
         EP4/P1ylWolhQblN9ID7thnBJcvzxfyEWismcxfQb5L6+/ZxcEupdk45trzJ6Hb6kB+n
         /OrnBAXxWq5SZoeLEhQwJxrMBjqRyOVFJQ/csWXwZSscLqTF+SsUQCK/r9mNRkjI1jeK
         9SEdU7aVKs+x4ocsiEHik44GdQh/4C5HRghbNMsX/63aJ9mHQgWunT+cZzuwW3Bs2cZo
         JOww==
X-Gm-Message-State: AOAM530hoATUON3tKxuzOludu7MT8mC4kvuM3s2oF2ehjbxPDwuZg59R
        FT/jSpEt0A2Dt7sazTWHG4/vEoYhBiwCgA==
X-Google-Smtp-Source: ABdhPJxgIPX0A86WyaHHgPvqN0279b+mgbfO5Ggd0HZDymV7s19wwX88jcTIs8D9mWC79zMQi/XKnQ==
X-Received: by 2002:a05:620a:137c:b0:648:e909:e9f with SMTP id d28-20020a05620a137c00b00648e9090e9fmr1536380qkl.313.1646371585886;
        Thu, 03 Mar 2022 21:26:25 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b137-20020ae9eb8f000000b00648f9736ab0sm1994744qkg.124.2022.03.03.21.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 21:26:25 -0800 (PST)
Date:   Thu, 3 Mar 2022 21:26:15 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mmotm] mm: filemap_unaccount_folio() large skip mapcount
 fixup
In-Reply-To: <YiGW+J4EtjK7KgYn@casper.infradead.org>
Message-ID: <3251e132-35e0-8185-b528-faaa6f3c612@google.com>
References: <879c4426-4122-da9c-1a86-697f2c9a083@google.com> <YiGW+J4EtjK7KgYn@casper.infradead.org>
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

On Fri, 4 Mar 2022, Matthew Wilcox wrote:
> On Thu, Mar 03, 2022 at 08:21:19PM -0800, Hugh Dickins wrote:
> > The page_mapcount_reset() when folio_mapped() while mapping_exiting()
> > was devised long before there were huge or compound pages in the cache.
> > It is still valid for small pages, but not at all clear what's right to
> > check and reset on large pages.  Just don't try when folio_test_large().
> 
> Thanks for bringing this up!  I was really unsure about this chunk of code
> when converting unaccount_page_cache_page() to filemap_unaccount_folio().
> 
> Part of me wants to just delete the whole thing.

A part of me feels the same way.  Accepting to waste 2MB while
footling around over 4kB doesn't help my case for that code -
whose beauty is, umm, questionable.

> I'm unconvinced by
> the argument; surely it's better to leak memory than perhaps reuse a
> page which should not have been freed yet?

I know people who would agree with you.  And in most cases we do prefer
to waste it, because it has become suspicious.

But by far the most common reason for getting here, is that a page table
has got corrupted in some way, so the pte or pmd was never identified to
unmap the page.  Nothing suspect about the page itself, and (barring a
bug in vma unlinking) all the mappings which might hold the page have
been unmapped: we've just got a leftover in the mapcount.

> 
> Also, the code doesn't take into account that folio_mapped() is freaking
> expensive for THP (512 cache lines, blowing away 32kB of your L1 cache!),
> and we may as well calculate folio_mapcount() while we're doing it.

Well, we don't need to optimize the rare case.

As you know, I've long thought that there should be one quick total
mapcount field; but it's never been a priority to work out the details
on that (and Linus seems to be driving mapcount out of fashion; and
you have your own ideas there).

> 
> Do you see this report often on machines that don't have
> VM_BUG_ON_FOLIO() enabled?

No, not often at all.  Almost never.  I think it did come up occasionally
when that code was written, but seems to have faded away in recent years.
Cosmic rays getting weaker, or memory getting better, or fewer bugs perhaps
- I haven't looked back to check, may be wrong, but I think when I added
unmap_mapping_page() last year (now s/page/folio/), that was to fix one
real (but benign) cause of such warnings.

Hugh
