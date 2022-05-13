Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96063525EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378486AbiEMIlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378317AbiEMIlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:41:35 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819065908B
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:41:34 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so10210401pju.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=80smbfsEHbUPCVxIaatQJ7o5/6SvzQd+/0tsPWryTUc=;
        b=NGX8mUqWRStuTVVcxiA/14gdjYu4w6jDywygRSse2Al0R6vhKjF7ejd4bcd+TWA+NV
         5sE7jkEKPxoXtTxkVMR4FUAg01YByNULcJavkl/EVRq9aP0Ip5hDwH+nG4PCljuM3z/4
         aTxWLTcQX60tDn0jyPYUWx8y1bEIww8iG9VrKL3XZXLKyS/jsvPgrEiPUKVK2I1Jp1U4
         s264uWSJBzFF0nsTBcprvsQB1DAKBErnw/WMFpTFbxOZp469QHWu27Av+dTXg6o2sLfn
         fqW1mNcyhSTprs8HjPzRGCyYHR272nKed8BCfi75Q+wJFhCU1iQVTyF8Tv9G1X5xPKMj
         lOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=80smbfsEHbUPCVxIaatQJ7o5/6SvzQd+/0tsPWryTUc=;
        b=tNbQetY1h6jYwCy792fYFgSaGMAxX/UIueUYvZ8imrK3jxV+HHDkAM254KhkFWgG/f
         ZCxhF6FM+axbKeKvTx5M6xPuSMBwW3Q8xLc3N9wNX4cCzhENtPfWh1lyc7y5lifVD211
         sPAtJxF7px/+PWtcmooJaPfni6L0WRQz6SoO5gdhSV/dy/mIzYrqdTApXlJdLpcPg5pQ
         grB2V1FFHuWqi8zDmB3yECoowWpDbuMW7zMjLlS98Gfz1sSJLF1tBdhoXoDOMqPSBwJ0
         rv25KD+e9QgaFQebQRSBk6PvKK9mMMZUEN93D8PhJqqsicmhEBblxx5uQj1aHsURammP
         3e7A==
X-Gm-Message-State: AOAM530S6vg7ChWMEzNur/icR7GpPSzXxnyX9ITrfwpAjvStH5wHahaO
        6e4e2rlV6aIM+4+frq/PUXM9wdbZEs9/yw==
X-Google-Smtp-Source: ABdhPJzoFuP/7OVqOZRryESPw/ak0ZY19Mcm83pECHoY4nzg8+Terp/RHyOAw5R8D2Fqh8h12yr/ug==
X-Received: by 2002:a17:90a:e641:b0:1da:43b8:95b7 with SMTP id ep1-20020a17090ae64100b001da43b895b7mr3807596pjb.180.1652431293805;
        Fri, 13 May 2022 01:41:33 -0700 (PDT)
Received: from localhost ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id w1-20020a62c701000000b0050dc762815asm1173106pfg.52.2022.05.13.01.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 01:41:33 -0700 (PDT)
Date:   Fri, 13 May 2022 16:41:20 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 1/6] mm/page_alloc: Add page->buddy_list and
 page->pcp_list
Message-ID: <Yn4ZsKEmtnquHhWJ@FVFYT0MHHV2J.usts.net>
References: <20220509130805.20335-1-mgorman@techsingularity.net>
 <20220509130805.20335-2-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509130805.20335-2-mgorman@techsingularity.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 02:08:00PM +0100, Mel Gorman wrote:
> The page allocator uses page->lru for storing pages on either buddy or
> PCP lists. Create page->buddy_list and page->pcp_list as a union with
> page->lru. This is simply to clarify what type of list a page is on
> in the page allocator.
> 
> No functional change intended.
> 

Nice cleanup for me.

> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  include/linux/mm_types.h |  5 +++++
>  mm/page_alloc.c          | 18 +++++++++---------
>  2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 8834e38c06a4..a2782e8af307 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -87,6 +87,7 @@ struct page {
>  			 */
>  			union {
>  				struct list_head lru;
> +
>  				/* Or, for the Unevictable "LRU list" slot */
>  				struct {
>  					/* Always even, to negate PageTail */
> @@ -94,6 +95,10 @@ struct page {
>  					/* Count page's or folio's mlocks */
>  					unsigned int mlock_count;
>  				};
> +
> +				/* Or, free page */
> +				struct list_head buddy_list;
> +				struct list_head pcp_list;
>  			};

Since you have clarified "lru" member, should we go further?
Like union "index" to "pcp_migratetype" and "private" to "order"
since buddy allocator reuses "index" and "private" as well.
My initial idea is as follows, it is more clear for me, what
do you think?

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index dbfd892ac96a..644349a5f901 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -107,6 +107,15 @@ struct page {
                         */
                        unsigned long private;
                };
+               struct {        /* pages manipulated by buddy allocator */
+                       union {
+                               struct list_head buddy_list;
+                               struct list_head pcp_list;
+                       };
+                       unsigned long mapping_pad;      /* Not used */
+                       unsigned long pcp_migratetype;
+                       unsigned long order;
+               };
                struct {        /* page_pool used by netstack */
                        /**
                         * @pp_magic: magic value to avoid recycling non

