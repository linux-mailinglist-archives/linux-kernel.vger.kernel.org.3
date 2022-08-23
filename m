Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F54B59E48D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbiHWNgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 09:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241821AbiHWNgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582661DC34D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661250979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I+XmamW+3KCH3IL/ZlnTQBO91CZuDPkzzeMMrWghge4=;
        b=hqOPuJ9NFwy8/dQOCO/nCRDWJbwweehywyBHsjMU/fvnVUY/fHUGBUZvtokkONCnHeVE55
        gI5WfSeTD/NBBY+tz2UhhA6SQnk/PJNsSvkTnI0UsDy3Q1WVLdvKSwGfXMEhzV4LTvpJl7
        iGfmTs08K1xZP1ix9CzzRyes9MsG1F4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-8ji8OPBSMvCbUbO_I6gcUw-1; Tue, 23 Aug 2022 06:36:18 -0400
X-MC-Unique: 8ji8OPBSMvCbUbO_I6gcUw-1
Received: by mail-wm1-f72.google.com with SMTP id i132-20020a1c3b8a000000b003a537064611so7738885wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=I+XmamW+3KCH3IL/ZlnTQBO91CZuDPkzzeMMrWghge4=;
        b=huV5PZdn7M0mr7DFv43rAUzBjmBmdycyqLokeRkwnC3S4vNcYD6JKX+eOds04L4FSB
         233Zaymg1BpQ7dhmvDOnYirF4QJklfxX9CQQzPKvU0O6nFuRbkfJ54v97QnaIby8E0tT
         o91V3f/ObiJCUncRLWb7TMeMPo7JknIpC2crvlnVyz5NesQRoR6sMdL68lRBhTN65RIz
         2uhdqe4GE7OXKeepcd5IMCRfopvGkebFOGQii35/Fn15gO0PKJXO2fr0rrFnhomFZzMt
         31x4yulog8OJyM76lJHwHE3RZzilQm1I9+PawZo03j2e9RBZvQH1uvdwjBkvrbp8PiJi
         6Lug==
X-Gm-Message-State: ACgBeo1DKVoPOHu/WAGbFFYSbt33AK9NDCDU771pw4wlwGTGarKFQ05R
        PvbxGJaxdH6lCXBWJ2rJGkBlL4fi+RVWepVKLNxfvEDrUgiI834eGK889EXnJmrpyueFenFlVTr
        VY+ybLoQLoi4U3scY2FV9etzD
X-Received: by 2002:a7b:c045:0:b0:3a5:ff4e:5528 with SMTP id u5-20020a7bc045000000b003a5ff4e5528mr1802862wmc.150.1661250977101;
        Tue, 23 Aug 2022 03:36:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR50zssAIWyW1NcEa71aF+5HM7fzk5YasmUkHJtycFU+9mNi8F9TjaaXWZSXDKmO118IQz2YPQ==
X-Received: by 2002:a7b:c045:0:b0:3a5:ff4e:5528 with SMTP id u5-20020a7bc045000000b003a5ff4e5528mr1802841wmc.150.1661250976859;
        Tue, 23 Aug 2022 03:36:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:1600:c48b:1fab:a330:5182? (p200300cbc70b1600c48b1faba3305182.dip0.t-ipconnect.de. [2003:cb:c70b:1600:c48b:1fab:a330:5182])
        by smtp.gmail.com with ESMTPSA id c9-20020a05600c100900b003a2f6367049sm16693484wmc.48.2022.08.23.03.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 03:36:16 -0700 (PDT)
Message-ID: <30dd7d1f-df39-ad89-94aa-d1562b84fa8b@redhat.com>
Date:   Tue, 23 Aug 2022 12:36:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2 06/12] fs: proc: use pageblock_nr_pages for
 reschedule period in read_kcore()
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        James Houghton <jthoughton@google.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
References: <20220811231643.1012912-1-zi.yan@sent.com>
 <20220811231643.1012912-7-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220811231643.1012912-7-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.08.22 01:16, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> MAX_ORDER_NR_PAGES can be increased when it becomes a boot time parameter
> in later commits. To make sure read_kcore() reschedule its work in a
> constant period, use pageblock_nr_pages instead for reschedule period,
> since pageblock_nr_pages is a constant and either the same or half of
> MAX_ORDER_NR_PAGES.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Ying Chen <chenying.kernel@bytedance.com>
> Cc: Feng Zhou <zhoufeng.zf@bytedance.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  fs/proc/kcore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index dff921f7ca33..7dc09d211b48 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -491,7 +491,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  			}
>  		}
>  
> -		if (page_offline_frozen++ % MAX_ORDER_NR_PAGES == 0) {
> +		if (page_offline_frozen++ % pageblock_nr_pages == 0) {
>  			page_offline_thaw();
>  			cond_resched();
>  			page_offline_freeze();

Yeah, the exact number doesn't actually matter here.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

