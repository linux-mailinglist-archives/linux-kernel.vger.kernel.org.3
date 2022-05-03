Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A463518881
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbiECPaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbiECPaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:30:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED30225C69
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:26:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id iq10so15652880pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 08:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B6qlSDLxLCXUGUr/KLSuzX/SdSd4Bh+SQDNoC/TYzmE=;
        b=a9V1c+m8xen4XNysutPq9ZRoIjmYYTYB9zba7iFQsLjRQ5MiUhT5H1qYIaKTKEow5g
         g9zhI4udB18LnnSUbJC5H1ywxlNfBz4X7yaZ8BADGRV+iRcj0JZq3Fm/qBAO6m68Qut/
         AsJU2WGQtlHRz7VNCx51AWV6y2nJwJmwinUnui4K7TiD0ENxQJzmmZjbbVHUjMITpxZT
         PCeKS+fagLNIbu8JPK0wy/eJA8AJFD7CaTgVx/EbTbJ8xEFAke8CSHQ2Vu1NHxhErYrH
         VPvsy6+1CXi21U2hs3zBJz6FSetzVDDUjj+SNc5Gp7V9EaORt0dxjzkzNv0W+UQ9i0kd
         JIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=B6qlSDLxLCXUGUr/KLSuzX/SdSd4Bh+SQDNoC/TYzmE=;
        b=cNU4WD7NLdHa6W/qQYXz4fYXU7dbKv0YqKGWnWuKLXGlwUufFhw8s6ZTrNcC/zsKLO
         fEepQueyl8a/NAAA2+53vOWSy3NHDvo4kdUyvLGvg5pZ2kvkTiXEIzJMEUtS1iR1q3vX
         sjWeM+eR9WZkir4D+OuiACKG3Kvql4JZLCnGQxXyf8lmIugXzoUeBam1l2ibKjeQ1xj3
         KBSqy3rLXwQ0RKtrWEaCmP50fZi/PFBE+8Hq34uQ7pkSPkLXdpm5ugr5eXuYfzfBts2X
         AG2W6yQBiUwM6HNWX/a+nFIH+fXGf0kt45Ylq8xRma6B9JrPY26Uv6B0h05iJerljo8f
         ndKQ==
X-Gm-Message-State: AOAM5320yIY2nj3uVM5AArZMf6E44VWsW9SElmYUMyMLfLGlzGMSPNp3
        /nOVr9WpasyzzB96Y+W9p+s=
X-Google-Smtp-Source: ABdhPJwtiCZaJcqzn0puTvFvsxn7j4SOqY0XuNO5Zm+mP9J/jRiQPjvKxr56epNb5EBBYr132XSONQ==
X-Received: by 2002:a17:90a:7e94:b0:1da:3b47:b00e with SMTP id j20-20020a17090a7e9400b001da3b47b00emr5365604pjl.222.1651591604398;
        Tue, 03 May 2022 08:26:44 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:8998:54e:9def:1e7c])
        by smtp.gmail.com with ESMTPSA id m19-20020a17090a7f9300b001cd60246575sm1489865pjl.17.2022.05.03.08.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 08:26:43 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 3 May 2022 08:26:42 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] mm: fix is_pinnable_page against on cma page
Message-ID: <YnFJss0doXGCmq3w@google.com>
References: <20220502173558.2510641-1-minchan@kernel.org>
 <29d0c1c3-a44e-4573-7e7e-32be07544dbe@redhat.com>
 <YnAhaRNjmIhtGUjk@google.com>
 <08e9855c-395d-f40c-de3d-1ec8b644bfe8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08e9855c-395d-f40c-de3d-1ec8b644bfe8@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 03:15:24AM +0200, David Hildenbrand wrote:
> 
> >>>> However, I assume we have the same issue right now already with
> >> ZONE_MOVABLE and MIGRATE_CMA when trying to pin a page residing on these
> > 
> > ZONE_MOVALBE is also changed dynamically?
> > 
> 
> Sorry, with "same issue" I meant failing to pin if having to migrate and
> the page is temporarily unmovable.
> 
> >> there are temporarily unmovable and we fail to migrate. But it would now
> >> apply even without ZONE_MOVABLE or MIGRATE_CMA. Hm...
> > 
> > Didn't parse your last mention.
> 
> On a system that neither uses ZONE_MOVABLE nor MIGRATE_CMA we might have
> to migrate now when pinning.

I don't understand your point. My problem is pin_user_pages with
FOLL_LONGTERM. It shouldn't pin a page from ZONE_MOVABLE and cma area
without migrating page out of movable zone or CMA area.
That's why try_grab_folio checks whether target page stays in those
movable areas. However, to check CMA area, is_migrate_cma_page is
racy so the FOLL_LONGTERM flag semantic is broken right now.

Do you see any problem of the fix?

A thing to get some attention is whether we need READ_ONCE or not
for the local variable mt.
