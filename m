Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620B0535AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347965AbiE0HrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239205AbiE0HrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:47:12 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ED9F68B8
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:47:11 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z11so3898032pjc.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2ldm8EWiIwlfTDrJygxjlJTr0fnRfKqWmoWrYzwj5Ms=;
        b=zORVVErp74/aJLOMVHlbo0nG2Xc2sgTAaQ4wQ/Mr1KMvBY/xep7hg2lsXDhmc/z7OL
         S3h5Wf2pKaXwukoWY2B1SdaYoOsnlOziQtDQ4tG4dWbXnWi7IY+dhK01saL5R8YnIsuf
         TvPukeDGWQWEUphXBKnsk70avh3a/Ju0rE1oi/2kYfV0dEg5IUn3+fcPlcD2/HsNmQO7
         /dEdSncM+GEu3l4/pPugWgfoR7MZDoYdcCm3IwS5oTLkQsGn2Q/jNnPPlWH1E7IpjlnR
         wOZ64/sKJTBa25heB4MvMJ8ZLMvVgCJ4reiDdKgyZCbd7DSYVce8qP51sLf7BAkFM6XY
         UCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2ldm8EWiIwlfTDrJygxjlJTr0fnRfKqWmoWrYzwj5Ms=;
        b=bpSG/yro2TUIW3+fKfqyerJh0s+5WOR56rwFXFU4hSLIRL6M6Uoo03XsIbAcbpBbt9
         aCHQXTjlb0xCVhF9GxpJ2N7vZJ5mpjpF731q+OYplnB8qmxY+vYd6t+fad4e+J8c+0F+
         PnRxFdrcvpRdueBiFWGWZOXo8tP3q2Wo74kOLdc+iSqlC6BfDm5p5Mg/PryahHEgEU73
         5vlpu39J8vd4lSGOXfWy1g+CwQ0oin3ukXFo1aYLoscFQFzpqP5tJV9dt5x5cso73lBZ
         giWJEEf20+2tlS2SmvZlzHURfmWlnAoIrK8IdiKJahUEhoOs+ccGykRLDBkAPzk5lTUe
         ZT5w==
X-Gm-Message-State: AOAM533/Vqk7rDjkjFtSTeax8I0Zs+7ZWG0C7v7AXIHZuipihDdWV8w9
        pCHP/KviBDWNz+dj0HUd31cIFg==
X-Google-Smtp-Source: ABdhPJx3vE73dYEeKbsUD6iX5Y76xhiEjlK9ILC5gmBeKPv+KlLx5FCNqceTefulVNS9gSn8ndwwYw==
X-Received: by 2002:a17:902:b193:b0:158:c040:5cf8 with SMTP id s19-20020a170902b19300b00158c0405cf8mr41802475plr.146.1653637630950;
        Fri, 27 May 2022 00:47:10 -0700 (PDT)
Received: from localhost ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id jc12-20020a17090325cc00b00161996b9a66sm2890596plb.233.2022.05.27.00.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 00:47:10 -0700 (PDT)
Date:   Fri, 27 May 2022 15:47:04 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        smuchun@bytedance.com
Subject: Re: [PATCH 3/3] mm: hugetlb_vmemmap: cleanup
 CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*
Message-ID: <YpCB+Acm5qktFlsT@FVFYT0MHHV2J.usts.net>
References: <20220404074652.68024-1-songmuchun@bytedance.com>
 <20220404074652.68024-4-songmuchun@bytedance.com>
 <f25c03d7-d9e2-2ae3-4dcc-0d054a15ad2c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f25c03d7-d9e2-2ae3-4dcc-0d054a15ad2c@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 09:39:41AM +0200, Vlastimil Babka wrote:
> On 4/4/22 09:46, Muchun Song wrote:
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -188,7 +188,7 @@
> >  #define RESERVE_VMEMMAP_NR		1U
> >  #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
> >  
> > -DEFINE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
> > +DEFINE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
> >  			hugetlb_optimize_vmemmap_key);
> >  EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
> 
> Hi,
> 
> looks like just below here you forgot to update:
> 
> static enum vmemmap_optimize_mode vmemmap_optimize_mode =
>         IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON);
>

Good catch!

> so it refers to CONFIG name that no longer exists?
>

Right. My bad. I forgot to replace it.  Will fix it ASAP.

Thanks.
 
