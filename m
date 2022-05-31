Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35E9538AF7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 07:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244049AbiEaFkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 01:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244051AbiEaFkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 01:40:49 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BAC95A12
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 22:40:47 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id a63so5681183pge.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 22:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xj2ppwBTubnrrIoaUI7eupnOoNnVC4v3eTLLnDbiLG0=;
        b=juICRplhkiikAtV9FG2KRVdj6JgmGeiIuwdSW2Jg1D7u3nrZPx5ddm5UI8PjHswtHI
         CFymK9SXuV2jaeTnnalAwMLCkvymbGEqCOwQVHWvOckAE/uqtJ+Eo9PdX0+WtDm1oh9K
         ID5f74ReZu/lohoVkFicfiSzvGdPytoO48EfMSiHqOXpTTZXovb58Zx9cAUcYqQkyYs+
         AqjsOKbc8+pLZ1eqzb3AVeN3R6tfCahxu8R9WwWB5KySB9igPwb4he7o/RvSgddyCf/6
         T/LZ2HXjBPnQjU+uXTcxB8W+1JXrVIdNl9UYKvsmH3clvF/lqi5KaYp461c94RCTR5Ve
         amVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xj2ppwBTubnrrIoaUI7eupnOoNnVC4v3eTLLnDbiLG0=;
        b=Qy8vwVB1Qk5vOOPTEX03DMjqBvvPqiMxTr07/6jdZnNbYt8xp2jfI41/mrMXarEXqf
         a88xC5XCriyiulloevFA2ciBohCRzHHRCHmfeFJifyNR3tN4lOETP2iAFiTB0xfvdQhq
         cMNgmYG7bx5hQs0LfGoAtefp98tNReVI1ZgyzafNgfdojaHmNB0D3cHZAmQ5Zu6pPv4z
         3ke4+eNVkslz+KYFgYkTFGa1b8vqETpZUaxNc2ITDYhWCDQYkYdKdSGln1L6D0qUmW/v
         yIxb7Rv966464scRUOzTIUkbQiNs5l5oRefmOCMZ65780/qHaYvZbL1QOur7rveFOxDg
         8BqA==
X-Gm-Message-State: AOAM5330Mp5RQVElvOW37VVuK+ZBj4aQjDcs4689pSpKlNg7Th0cJy6Z
        XQrYO3qOH4CrNWW1gk7p21o8XQ==
X-Google-Smtp-Source: ABdhPJwhxNYAl6sThyj6FBCw9AVxltuG0Rh2A21E2zYsv72fVwQYHfDjIHB6p+DIejj9sWeblTgMng==
X-Received: by 2002:a63:6b4a:0:b0:3fb:b03e:d10 with SMTP id g71-20020a636b4a000000b003fbb03e0d10mr15767535pgc.310.1653975647086;
        Mon, 30 May 2022 22:40:47 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:7163:3a36:783f:6d4a])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902868100b0015e8d4eb25fsm6524570plo.169.2022.05.30.22.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 22:40:46 -0700 (PDT)
Date:   Tue, 31 May 2022 13:40:39 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <quic_qiancai@quicinc.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] mm: page_isolation: use compound_nr() correctly in
 isolate_single_pageblock()
Message-ID: <YpWqV2PKLc5Ss3XB@FVFYT0MHHV2J.usts.net>
References: <20220531024450.2498431-1-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531024450.2498431-1-zi.yan@sent.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 10:44:50PM -0400, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> When compound_nr(page) was used, page was not guaranteed to be the head
> of the compound page and it could cause an infinite loop. Fix it by calling
> it on the head page.
> 
> Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity")
> Reported-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Link: https://lore.kernel.org/linux-mm/20220530115027.123341-1-anshuman.khandual@arm.com/
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
