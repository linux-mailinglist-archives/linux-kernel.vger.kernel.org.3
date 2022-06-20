Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38B65514B1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbiFTJrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiFTJrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:47:35 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BF613D66
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:47:34 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id i15so9268972plr.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T/D9+9zuknnGmvNROM1Efleq7jN8Hw6RI6lzcGgc6IQ=;
        b=XX86aCfBgl3t0d/6RCMxP9LS53mtvlmGVVj8MUOMzwZv2yoQkTfT9LCJkIC6Lp+gHU
         m+e5CdHtVM8b6iCCiy61tWy5FNqsqjrvZ9P9OCMJZS23RoNDUX8jpAUqbk8bqfLdaHlQ
         hcQlKAWQJEatEqleQE8GFZEF9Ze7mlMvf9B3GIAStRMJbzkrSxhK2H447reigadjVitl
         /JwjkDuaqjcPmFcxjibJzglev8PC7plxSIvKK9/Y9YcCA6Ui433fVyJZv8xpg/kUv0UT
         mEc5R9P38hVJfaPdeiWtch1jDGuLGtTgkikd0GO0U4pkk1llVstOYgpBIzBhqcppCE/x
         S2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T/D9+9zuknnGmvNROM1Efleq7jN8Hw6RI6lzcGgc6IQ=;
        b=xAuL983kqiQuw9VPYN6Y1OknsQdUSgXkKQNSchaaCvvhyD6n5QcPET0NcHQoKwUlOz
         UqfT19GoCxe3LhIFRb7vo7fo4VkRTAr2N1i3E2o/z9myrQC+zBZaapz/JCwGhMCR4u1C
         MNfPj7QO1zhOPLpXd1aaMhVCyDBYMiNsGpXHvR/I0L7OgYpiImbGF/BZ4O899YD7x5le
         hcNFU1IBp++FBogiX4IevX8hzGeeZHABbTasBT+Uq+FCx7MYcsx9uLSGf49W0vPx5jWg
         WWGJJBg59sw7QNnwMJEfcMXDlQIi1bG4Ri7Zk+/CGlPIM5k8n1YJqzOrzY/vL1VFvqlX
         4uNg==
X-Gm-Message-State: AJIora+sD72kjmBSdHvRzQPHHFc40Tfu4irkBe2A1qmaJZRkX7298X/3
        gsEoYdUXaJYy452h3p0TYzfI4g==
X-Google-Smtp-Source: AGRyM1ubP3bXctHBXwws9ZgPXhQSsRzA67NQ6S79Bqf0qSAP2mXsbxcVc0OvELyVs9XZ4ypngOYt7A==
X-Received: by 2002:a17:90a:eb05:b0:1ec:b85a:e1ac with SMTP id j5-20020a17090aeb0500b001ecb85ae1acmr1054643pjz.103.1655718453943;
        Mon, 20 Jun 2022 02:47:33 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id o1-20020a62f901000000b0052285857864sm8835329pfh.97.2022.06.20.02.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 02:47:33 -0700 (PDT)
Date:   Mon, 20 Jun 2022 17:47:28 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] filemap: obey mapping->invalidate_lock lock/unlock order
Message-ID: <YrBCMHLrOwo0XGAr@FVFYT0MHHV2J.usts.net>
References: <20220618083820.35626-1-linmiaohe@huawei.com>
 <Yq2qQcHUZ2UjPk/M@casper.infradead.org>
 <364c8981-95c4-4bf8-cfbf-688c621db5b5@huawei.com>
 <Yq/76OJgZ2GgRReN@casper.infradead.org>
 <72315fc0-eee9-13c8-2d94-43c8c7045a91@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72315fc0-eee9-13c8-2d94-43c8c7045a91@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 02:35:30PM +0800, Miaohe Lin wrote:
> On 2022/6/20 12:47, Matthew Wilcox wrote:
> > On Mon, Jun 20, 2022 at 09:56:06AM +0800, Miaohe Lin wrote:
> >> On 2022/6/18 18:34, Matthew Wilcox wrote:
> >>> On Sat, Jun 18, 2022 at 04:38:20PM +0800, Miaohe Lin wrote:
> >>>> The invalidate_locks of two mappings should be unlocked in reverse order
> >>>> relative to the locking order in filemap_invalidate_lock_two(). Modifying
> >>>
> >>> Why?  It's perfectly valid to lock(A) lock(B) unlock(A) unlock(B).
> >>> If it weren't we'd have lockdep check it and complain.
> 
> It seems I misunderstand your word. I thought you said it must be at lock(A) lock(B) unlock(A) unlock(B)
> order... Sorry.
> 
> >>
> >> For spin_lock, they are lock(A) lock(B) unlock(B) unlock(A) e.g. in copy_huge_pud,
> > 
> > I think you need to spend some time thinking about the semantics of
> > locks and try to figure out why it would make any difference at all
> > which order locks (of any type) are _unlocked_ in,
> 
> IIUC, the lock orders are important to prevent possible deadlock. But unlock orders should be relaxed
> because they won't result in problem indeed. And what I advocate here is that making it at lock(A) lock(B)
> unlock(B) unlock(A) order should be a better program practice. Or unlock order shouldn't be obligatory
> at practice?
>

lock(A) lock(B) unlock(A) unlock(B) is fine. So it is better not to complicate the code.
 
> Thanks.
> 
> > 
> >> copy_huge_pmd, move_huge_pmd and so on:
> >> 	dst_ptl = pmd_lock(dst_mm, dst_pmd);
> >> 	src_ptl = pmd_lockptr(src_mm, src_pmd);
> >> 	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> >> 	...
> >> 	spin_unlock(src_ptl);
> >> 	spin_unlock(dst_ptl);
> >>
> >> For rw_semaphore, they are also lock(A) lock(B) unlock(B) unlock(A) e.g. in dup_mmap():
> >> 	mmap_write_lock_killable(oldmm)
> >> 	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
> >> 	...
> >> 	mmap_write_unlock(mm);
> >> 	mmap_write_unlock(oldmm);
> >>
> >> and ntfs_extend_mft():
> >> 	down_write(&ni->file.run_lock);
> >> 	down_write_nested(&sbi->used.bitmap.rw_lock, BITMAP_MUTEX_CLUSTERS);
> >> 	...
> >> 	up_write(&sbi->used.bitmap.rw_lock);
> >> 	up_write(&ni->file.run_lock);
> >>
> >> But I see some lock(A) lock(B) unlock(A) unlock(B) examples in some fs codes. Could you
> >> please tell me the right lock/unlock order? I'm somewhat confused now...
> >>
> >> BTW: If lock(A) lock(B) unlock(A) unlock(B) is requested, filemap_invalidate_lock_two might
> >> still need to be changed to respect that order?
> >>
> >> Thanks!
> >>
> >>>
> >>> .
> >>>
> >>
> > 
> > .
> > 
> 
> 
