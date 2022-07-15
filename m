Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B480575E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiGOJXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiGOJXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:23:12 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB8F606BB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:23:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id ay25so2473321wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=TD4qyCc2/sj7H2ZxOu63AnfBrd6X3bmHJua9yUIs4LE=;
        b=IOdQtUmzYtMIGdBcmR6YH4RTXqeuv1jnKhGuBLoH3LaqCbrVfundg54tIGrIMTYixv
         1IQHYKENaJTmi1M8SD3lZsTpuBJRl6oC5YIl4biet5e4pc3S+NyTa6jNnTcgkNInC0Ni
         EWXLHr6QYRmB6NRO8DOyI538nAi5/98etXrXVN55tYd+PqeBKco5DqXRlnMNfQGeEk/Y
         clYXCnfIufKZZf0JmdhIDgwkcVwwrIM2b/iPYrtkG0b3AnfO1dbZam0mVh4FAq/qvglY
         MbSefbBwrU4chpClZqTrDMwRJUmaIdVlhqbU97C0OylOTT659Vi0kHLPkEoghvPkWiFm
         XIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=TD4qyCc2/sj7H2ZxOu63AnfBrd6X3bmHJua9yUIs4LE=;
        b=caQ3QklD8+gawT9iCD2ILytVfD/r1+blj89yCgARdt+RjlZ8kioPKzIdD6yaOpbFzv
         rVu+MNvcxOWIKExjKrMViA+CxA1tLchBY95HkKQLNSDTmGqNlaZoB+7mUti/5l/3gvYW
         mBxkTWiW0omMBK2d+zjWbEziApC1msxQ39tgTAzoxgREE5QOQkjS/AwzdW90p1t8K0Pf
         KrG0k8o+yhxJkzTsARERExpFZCUESpSNqG+Zz2CGNqwIlD8TFwyDOwnPrD+hv6A63U48
         Q7NViedgJ0V+cJ3+xogT+u8XkdYwLWiS+znoKWzHYPfAxIVEoLA5B9KyPCbq7iGUNQdg
         Ru+g==
X-Gm-Message-State: AJIora8kyY2HvpdzzxGChPvIAqozscV2W8TyFrGiv+6SXZ6fgXN1aMPB
        Sqd99ozHmXOFFmZZ4e4BbwjZdpcAGnOPmA==
X-Google-Smtp-Source: AGRyM1uZDO5RdEZUnigND+aq38xqzwRHQH2N+0pWWuc1pZ7vtok2+eITyUYFneksMuwlfv3KLBue+g==
X-Received: by 2002:a05:600c:3510:b0:3a0:f957:116e with SMTP id h16-20020a05600c351000b003a0f957116emr13028177wmq.179.1657876989101;
        Fri, 15 Jul 2022 02:23:09 -0700 (PDT)
Received: from localhost ([109.180.234.208])
        by smtp.gmail.com with ESMTPSA id n66-20020a1ca445000000b003a02de5de80sm8181569wme.4.2022.07.15.02.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 02:23:08 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     William Lam <william.lam@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: compaction: include compound page count for
 scanning in pageblock isolation
In-Reply-To: <20220711202806.22296-1-william.lam@bytedance.com> (William Lam's
        message of "Mon, 11 Jul 2022 21:28:06 +0100")
References: <20220711202806.22296-1-william.lam@bytedance.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Fri, 15 Jul 2022 10:23:07 +0100
Message-ID: <874jzin30k.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

William Lam <william.lam@bytedance.com> writes:

> The number of scanned pages can be lower than the number of isolated
> pages when isolating mirgratable or free pageblock. The metric is being
> reported in trace event and also used in vmstat.
>
> This behaviour is confusing since currently the count for isolated pages
> takes account of compound page but not for the case of scanned pages.
> And given that the number of isolated pages(nr_taken) reported in
> mm_compaction_isolate_template trace event is on a single-page basis,
> the ambiguity when reporting the number of scanned pages can be removed
> by also including compound page count.

A minor suggestion - It maybe useful to include an example trace output
to highlight the issue.

>
> Signed-off-by: William Lam <william.lam@bytedance.com>
> ---
>  mm/compaction.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 1f89b969c12b..1b51cf2d32b6 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -616,6 +616,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>  			break;
>  		set_page_private(page, order);
>  
> +		nr_scanned += isolated - 1;
>  		total_isolated += isolated;
>  		cc->nr_freepages += isolated;
>  		list_add_tail(&page->lru, freelist);
> @@ -1101,6 +1102,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  isolate_success_no_list:
>  		cc->nr_migratepages += compound_nr(page);
>  		nr_isolated += compound_nr(page);
> +		nr_scanned += compound_nr(page) - 1;
>  
>  		/*
>  		 * Avoid isolating too much unless this block is being
> @@ -1504,6 +1506,7 @@ fast_isolate_freepages(struct compact_control *cc)
>  			if (__isolate_free_page(page, order)) {
>  				set_page_private(page, order);
>  				nr_isolated = 1 << order;
> +				nr_scanned += nr_isolated - 1;
>  				cc->nr_freepages += nr_isolated;
>  				list_add_tail(&page->lru, &cc->freepages);
>  				count_compact_events(COMPACTISOLATED, nr_isolated);

Regardless of the comment above -

Reviewed-by: Punit Agrawal <punit.agrawal@bytedance.com>
