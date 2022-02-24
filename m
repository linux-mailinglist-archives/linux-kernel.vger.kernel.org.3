Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561F24C2122
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 02:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiBXBiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 20:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiBXBhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 20:37:55 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCBE4506E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:37:26 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id m3so773437eda.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7rPcGmjhZFqQTd6oy57LGwV/NoXmOrL2/XyqSHiSpT4=;
        b=FPo99/LglWlYagpTblc5f8caCXuee5xCf55PzVYNgc9j6cWtHyBIxglPXvRcfnlUfF
         cywQpV10FBgt4cKrkKe0LJ/U3hQXJp1QC/+D50STQzk0+YKVpJURbmhFsWT/+lzTVZQE
         E6BF+NnkCbYmiGfAQBjZDa0h61YTfQReUC3CubR63oyJluP/1mihSDEvMBNSzPH9iJQf
         ikH/xinsV5cJeL8NVK32g18s6nnNRNqoXvY1QzMFmxsMjLgslHtoBiTAvdASyKY9JoxR
         DSEA6OPujdQkZLd75KtuahF641dPHXe9rUDo7acoO9641UUS4jqiapSpN0XlZAOTKeeM
         wadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7rPcGmjhZFqQTd6oy57LGwV/NoXmOrL2/XyqSHiSpT4=;
        b=I8MfV+iAagRXYRlQT2Srq851ZoGMS2Rjs8JRu2L44sHbXHjSQC08rh43hTlKKhWXPr
         +cEssZEsEciHf1gjQD93PCp2vT/95zrFpprL/PdMSsMUvtYUqEmIEXg3l9WhI0ScsDZm
         5zafZKfnhxSvKshxs6JmPLy3qyA+DImYEIAmVB/rGmM6q+XQlr2u4+taWMdVh1uLZqQ3
         UO7TIGtbfoLUuBh0ybusDdXJmSExd0jz79MeWVHtbyqk0oJ13ubH1Y2ctGc28AW96MU5
         y8pyjhWfCKmJnM1yc8FI22dfpEPInhs9+jTYZYFn0LUjAYwogc9chUVHE9jxflSiAoga
         iMrQ==
X-Gm-Message-State: AOAM531YJ3lZ84xILLgNWigygCIEicO1cHHBJzrYq4a9DzAGrQV4Uv+e
        ed0DbcXmQtxNfFppVAdS4VcI9DrliAw=
X-Google-Smtp-Source: ABdhPJxqnInks01QQ2dUwRfitRyQdke9fhVXSXZXi2eqzfWyttrlAy/FsDrWU5MrfhqLAvbzzS8VLw==
X-Received: by 2002:a17:906:3ac7:b0:6ce:c3a1:3dcf with SMTP id z7-20020a1709063ac700b006cec3a13dcfmr284921ejd.182.1645664639761;
        Wed, 23 Feb 2022 17:03:59 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id er17sm555582edb.34.2022.02.23.17.03.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Feb 2022 17:03:59 -0800 (PST)
Date:   Thu, 24 Feb 2022 01:03:58 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        peterz@infradead.org, will@kernel.org, linyunsheng@huawei.com,
        aarcange@redhat.com, feng.tang@intel.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove offset check on page->compound_head and
 folio->lru
Message-ID: <20220224010358.ttc2mgdevfqddvea@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220106235254.19190-1-richard.weiyang@gmail.com>
 <Yde6hZ41agqa2zs3@casper.infradead.org>
 <20220107134059.flxr2hcd6ilb6vt7@master>
 <Ydi6iMbSZ/FewYPT@casper.infradead.org>
 <20220107160825.13c71fdd871d7d5611d116b9@linux-foundation.org>
 <YdjfsbAR0UlwyC6b@casper.infradead.org>
 <20220108081340.3oi2z2rm3cbqozzt@master>
 <20220123013852.mm7eyn3z26v3hkc2@master>
 <93c48e68-2266-72ee-0763-65805b94c968@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93c48e68-2266-72ee-0763-65805b94c968@suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:30:10AM +0100, Vlastimil Babka wrote:
[...]
>> Hi, Matthew
>> 
>> Are you back from vocation? If you could give more insight on this check, I
>> would be appreciated.
>
>I can offer my insight (which might be of course wrong). Ideally one day
>page.lru will be gone and only folio will be used for LRU pages. Then there
>won't be a  FOLIO_MATCH(lru, lru); and FOLIO_MATCH(compound_head, lru);
>won't appear to be redundant anymore. lru is list_head so two pointers and
>thus valid pointers are aligned in such a way they can't accidentaly set the
>bit 0.
>

Hmm... I see your change on struct slab. I guess I got your point.

Seems we would shrink struct page...

-- 
Wei Yang
Help you, Help me
