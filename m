Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B028B4D0E11
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 03:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244939AbiCHCiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 21:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344382AbiCHCh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 21:37:56 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694A613E9F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:36:56 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id c4so15063068qtx.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 18:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Hf+SYcbvteaeA2Pp6oDme8UIQyTPeK300MDHIaaOJZs=;
        b=ddfciQmjYws8TUQ+/R/l2Asz2YolMt5+q4M9T2HVYx71KxRMPoCtDjXQqbqmrofW+O
         6BSZ6QC6hch7vERGe39Zn4XHaAmt6t8SBRvjFBLKlC/CMwIttICPXGUFpxUo0iVpeXYs
         hGCqsnR7cc7LlFGnRuBbDw6fLaS9vQ34vAQk0mkHdh6Lqhu9L3rFp0bVCCadprImKh0Q
         J+ioin83OmVlxhyTxiysTHxbrulkAwRebUGfdEqPNkjTimBUrlsa+U2o8CnUybkReH8r
         WdyIf7HzSF6u8TtgstJVKH575D0A9SAlqlZ40+vnKM+on21c+25NbegzssllsiPQGlmE
         614Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Hf+SYcbvteaeA2Pp6oDme8UIQyTPeK300MDHIaaOJZs=;
        b=wG6C9uyWAnTb/kLH7QAW3nlW8jbeW62ONmD/fZoyZnCEiB5WnEd275Ijt8dxNkfVCY
         BkCgTQP9w+X3Uj+mMpOdU0aeIQfK6TJRJ0j7S/xCqYMbITlp1CTc1ZhuA22Ptk7x5W6o
         6MwAAdIDAWvMjyBOCRjsvhu983BozvUpASkmwapQRPhwBK5tAYrh72A21ayLxSI6viMk
         VSVk+HcsGZNsu7towa+tLOIkcmYysCMEpifbHQu6epW0XChOqRGYdfaasLha+/9h2AIz
         VsdZMFbzffJEs6thCqhEXR6RPGiPyo/aBFfn6yKSv9WYLH5NCGALJcFzAJwAO0A+jNbs
         Gn+g==
X-Gm-Message-State: AOAM532QeHzRZoANkOTIa+CHSRq3ubet40Tg4Z1xjrO1GFSRm+7g2l0i
        dVvv19FV0Mfvtf8jfy5cBvobOw==
X-Google-Smtp-Source: ABdhPJzwqDRLZOGcQ9TZx0OXr0dzVAXSP9SxhUKKJk0EWgDs+aK5wBK51LJq9ZwVoorkwZB6yjfZYQ==
X-Received: by 2002:ac8:5dcf:0:b0:2df:f2e8:1b89 with SMTP id e15-20020ac85dcf000000b002dff2e81b89mr11892381qtx.632.1646707015401;
        Mon, 07 Mar 2022 18:36:55 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m10-20020a05622a054a00b002e049ff99f2sm8752998qtx.7.2022.03.07.18.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 18:36:54 -0800 (PST)
Date:   Mon, 7 Mar 2022 18:36:42 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] mm: thp: don't have to lock page anymore when splitting
 PMD
In-Reply-To: <20220307165015.77fbcbe9e1fa2fe15f3eb239@linux-foundation.org>
Message-ID: <8f419d19-c83d-bbcd-8936-2d64ced7464c@google.com>
References: <20220303222014.517033-1-shy828301@gmail.com> <CADFyXm6W9CVkO4XPYep-tHg55c8m8NES783kcVYrdjSMbzYoDA@mail.gmail.com> <CAHbLzkriyBy2HqjssurLSnhoyuUzpJRZjMPNx34MTgxeO0dddg@mail.gmail.com> <13ad4ba1-2a88-9459-3995-70af36aba33e@redhat.com>
 <20220306180718.6d4e6233130b94fdad98df88@linux-foundation.org> <84a6c9c1-d18f-6955-2666-0a2d7bce6094@redhat.com> <20220307154326.6494f7fca7def491a23e5df1@linux-foundation.org> <CAHbLzkqY69nFniK+ckQaeu117Q+OqZ2hvFEdVbZaW2C_zAzDbg@mail.gmail.com>
 <20220307165015.77fbcbe9e1fa2fe15f3eb239@linux-foundation.org>
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

On Mon, 7 Mar 2022, Andrew Morton wrote:
> 
> OK, looks sane.  Can someone please test all this?

Only the briefest of testing, but

mmotm 2022-03-06-20-33
minus mm-thp-dont-have-to-lock-page-anymore-when-splitting-pmd.patch
plus mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch
plus mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd-fix.patch

is infinitely better than mmotm 2022-03-06-20-33.

I could just about reach a login on yesterday's mmotm, but graphics no.
Couldn't spend time to investigate, but Naresh's mail today that LTP
thp04 timeouted (hey, I'm English, we say timed out!) inspired me to
try booting with transparent_hugepage=never on cmdline, and that worked.

Again, no time to investigate, but the combination above has booted
and is running load, including transparent hugepages.  And before
setting that load going, I did try LTP thp04, which passed.

(There is an unrelated console printk lockdep spew, and am I the only
one to see these mm/workingset.c:567 shadow_lru_isolate warnings that
started up a week or three ago?)

Must dash,
Hugh
