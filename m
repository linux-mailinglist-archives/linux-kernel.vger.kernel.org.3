Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BEC4DA40D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351737AbiCOUfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241887AbiCOUfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:35:44 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7224313D55
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:34:31 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id h10so551086oia.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=HuxzPBFcNGizUpUFeFsNjMUynwK/YImVehMj2Mb+h5A=;
        b=K3HGrbkU3n9yvQYCY/kzElGn6znziTraIc5bj7MoyQgemj6Jy89aSAsaWRBNeSQirf
         5XAGCDiWwqOiXzbReSY3yKhwLgKrG7zIljAb0MxtNcmhyYqdc+BbqjG11NdnvjIGO7pF
         WhYkc0Pj2Lpv6CKFjhncgf5mGTCONSuF6qVBOAl3I/yiUt3sNVL9My/LEgJzuZ9PNz1+
         KNp706Dq/JKj2fKDY5vdz4tqkqUxLy0tS2/hFySkXnSULhgAZIqeLKYu1+UvCMNJsCH5
         IhISLb9TUOzNwHkwJbSji4zTaCSKtDvaR3Ge1ojWe2ATreVqSqdLJBV+Jk1aDaeLLEjs
         owUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=HuxzPBFcNGizUpUFeFsNjMUynwK/YImVehMj2Mb+h5A=;
        b=7P4AhAdsVDdula2Z0XnFwyl/00YhdsK12RdFm7pa15kDhquVfed4Oex6IK3cdOYCsc
         vsWzNLcTyoR4EppminxPpnugwzBMn7zrYzkC+b1wtBzJ+DrnR07sUAFmOZWYWDMYu17X
         63SCIE+rtmcMJ97RKwZVrtl9okLYAG+Yn92PjMIw6fySmirFLhxrkrS3Cnvt7Unir/oG
         wpC2bNpItc31fdyhW5v2DnZmBUVCMK8SsLsJy0SJfLP+yWj1ch05DZyQmcJde8RfRn0v
         /7Uja10/yXQRC5wk5pFhYpeiqw+vtd7fQ1hmtKKP+sTrDg0QQQTQqBC5X3zZYHTH9ddy
         iTWQ==
X-Gm-Message-State: AOAM532NfpaFkZ1JCMddVqyWUpTisyoqWfmgomwW5d/UMalWWpfqXB+1
        pXcEEpKfqt659lRazNzHAQDJ1MXAVmXA8A==
X-Google-Smtp-Source: ABdhPJyIXsrs++KyhkbY8OaCTfEwShUw+XWKA+egNWequzBiJdYyCj3Gy31D2jBYT9eCoIr7cy9G0w==
X-Received: by 2002:a54:4e11:0:b0:2ec:e0ee:ac29 with SMTP id a17-20020a544e11000000b002ece0eeac29mr2429740oiy.257.1647376470526;
        Tue, 15 Mar 2022 13:34:30 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a10-20020a056808120a00b002d404a71444sm95511oil.35.2022.03.15.13.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 13:34:29 -0700 (PDT)
Date:   Tue, 15 Mar 2022 13:34:02 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     David Hildenbrand <david@redhat.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrew Yang <andrew.yang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Howells <dhowells@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Yang Shi <shy828301@gmail.com>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Nicholas Tang <nicholas.tang@mediatek.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Subject: Re: [PATCH] mm/migrate: fix race between lock page and clear
 PG_Isolated
In-Reply-To: <4cb789a5-c49c-f095-1f7e-67be65ba508a@redhat.com>
Message-ID: <883877a-30b0-96e0-48a6-7cfc3c59de93@google.com>
References: <20220315030515.20263-1-andrew.yang@mediatek.com> <20220314212127.a2797926ee0ef8a7ad05dcaa@linux-foundation.org> <4cb789a5-c49c-f095-1f7e-67be65ba508a@redhat.com>
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

On Tue, 15 Mar 2022, David Hildenbrand wrote:
> On 15.03.22 05:21, Andrew Morton wrote:
> > On Tue, 15 Mar 2022 11:05:15 +0800 Andrew Yang <andrew.yang@mediatek.com> wrote:
> > 
> >> When memory is tight, system may start to compact memory for large
> >> continuous memory demands. If one process tries to lock a memory page
> >> that is being locked and isolated for compaction, it may wait a long time
> >> or even forever. This is because compaction will perform non-atomic
> >> PG_Isolated clear while holding page lock, this may overwrite PG_waiters
> >> set by the process that can't obtain the page lock and add itself to the
> >> waiting queue to wait for the lock to be unlocked.
> >>
> >> CPU1                            CPU2
> >> lock_page(page); (successful)
> >>                                 lock_page(); (failed)
> >> __ClearPageIsolated(page);      SetPageWaiters(page) (may be overwritten)
> >> unlock_page(page);
> >>
> >> The solution is to not perform non-atomic operation on page flags while
> >> holding page lock.
> > 
> > Sure, the non-atomic bitop optimization is really risky and I suspect
> > we reach for it too often.  Or at least without really clearly
> > demonstrating that it is safe, and documenting our assumptions.
> 
> I agree. IIRC, non-atomic variants are mostly only safe while the
> refcount is 0. Everything else is just absolutely fragile.

It is normal and correct to use __SetPageFlag(page) on a page just allocated
from the buddy, and not yet logically visible to others: that has refcount 1.

Of course, it might have refcount 2 or more, through being speculatively
visible to get_page_unless_zero() users: perhaps through earlier usage of
the same struct page, or by physical scan of memmap.

Those few such others - compaction's isolate_migratepages_block() is the
one I know best - must be very careful in their sequence of operations.

Preliminary read-only checks are usually okay (but some VM_BUG_ON_PGFLAGS
are increasingly problematic: I've had to turn off that CONFIG), then
get_page_unless_zero(), then read-only check that the page is of the
manageable kind (PageLRU in my world), and only then can it be safe to
lock the page - which of course touches page flags, and so would be
problematic for a racing user's __SetPageFlag(page).

But PageMovable and PageIsolated are beyond my ken: I can't say there.

Hugh
