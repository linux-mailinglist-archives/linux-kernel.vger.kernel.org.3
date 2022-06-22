Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82918554107
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 05:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356547AbiFVD4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 23:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbiFVD4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 23:56:30 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B35E0AC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 20:56:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d5so14255989plo.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 20:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7h4tU4Rx3U/aIsjIhPJPJ//Klp0wPGPWFG+nXRn0z4k=;
        b=VoGA3tGfVl0A535ILyhPoL2KpOukdlOj3rNC5fsvPcm3///hr+HGF7a0rFpP8pHwug
         Ea21Uv2xLBA0CcShpV/WJBq2HirQkCEvE/jTFghhSG4buBAj+24nc7n/OwDZX77uQfIh
         UmJ5Cy+kXhjpC0hjjWlvjd7msMTEtfdXsH2c2GWRz7uplQ7NV6M6xfJgUPBh871m6CQ7
         qvPhdMAMD1eTig2ShT/piDj3yfdwvo2OEGhdY5Nk5J5UUylEAhhVLZMyyfCX7ugB/Z6f
         fnzq4elp5dEXjZ49mx4oCcMiCEvwbDx3kJpD5Pq18mZFVOAZQ8waL2fpiOfXLbJ7Trmd
         ieBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7h4tU4Rx3U/aIsjIhPJPJ//Klp0wPGPWFG+nXRn0z4k=;
        b=YEDyRCT9GYVrCAKcIl1yxfy7pHjfKaZ8BAAC/hcRbeRaoqH8tSAVe0aL+Ss+VwPjuP
         UAbBFSRs4ZVSelG74otLDfICWTaCBoI+S97eFri6jnQXpAl6A8eoMXAlo4FWQnnCAKtH
         4c7SAHs2wkhUxrOLCegMKfRx+inryT8OofMEISKyMYllB6skxGbZK3KHhsLqe+CuCk7W
         ysJ+o6VtD/u2n8+l7wN4GvdLpEHXZ/O2/XAW4n0U/T/MFi+qTMwdLYmd+vC6xLWn6KX3
         S2VwnR981K8TDCXwzDDLuzW8JzqgR+4Vb54yixAdX37yrUqGxOgi5znFPwDEGnN4UA/J
         KphA==
X-Gm-Message-State: AJIora8pjXo1nIiZjysxwyEaMlw3kHrtMcGlE7fN5ihJq4V8ZFv/ZzwD
        sBBMwDmqktEn6AxqBPk/UzzmtGNS13Fnn3pj
X-Google-Smtp-Source: AGRyM1vomi7WtYi0MwLGcNqNMDkpdNI3UJkQxUuWSDdYYFFOq/OjMCfULai2r84xUu1AoWniSXrphg==
X-Received: by 2002:a17:90a:eb05:b0:1ec:b85a:e1ac with SMTP id j5-20020a17090aeb0500b001ecb85ae1acmr1434571pjz.103.1655870188983;
        Tue, 21 Jun 2022 20:56:28 -0700 (PDT)
Received: from localhost ([2404:9dc0:cd01::23])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902d88900b001663185e654sm11440301plz.280.2022.06.21.20.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 20:56:28 -0700 (PDT)
Date:   Wed, 22 Jun 2022 11:56:25 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/page_alloc: Do not calculate node's total
 pages and memmap pages when empty
Message-ID: <YrKS6aFHKRyZzAwi@FVFYT0MHHV2J.usts.net>
References: <20220621041717.6355-1-osalvador@suse.de>
 <20220621041717.6355-2-osalvador@suse.de>
 <506203e3-1de0-1187-5234-7afc66d4ddfe@redhat.com>
 <YrKQyhwDwMvueOUc@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrKQyhwDwMvueOUc@localhost.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 05:47:22AM +0200, Oscar Salvador wrote:
> On Tue, Jun 21, 2022 at 09:44:47AM +0200, David Hildenbrand wrote:
> > 
> > 
> > It's worth noting that the check in pgdat_is_empty() is slightly
> > different. I *think* it doesn't matter in practice, yet I wonder if we
> > should simply fixup (currently unused) pgdat_is_empty().
> 
> I guess we could change it to
> 
>  static inline bool pgdat_is_empty(pg_data_t *pgdat)
>  {
> 	 return node_start_pfn(pgdat->node_id) == node_end_pfn(pgdat->node_id)
>  }
> 
> ? And maybe even rename it to to node_is_empty (not sure why but I tend to like

At least I like this name (node_is_empty) as well.

Thanks.

> that more than pgdat) 
> 
> I could squeeze a "fixup" patch for that before this one. 
> 
> > 
> > Anyhow
> > 
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> Thanks!
> 
> 
> -- 
> Oscar Salvador
> SUSE Labs
> 
