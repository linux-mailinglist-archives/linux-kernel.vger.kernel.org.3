Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6E6538FC8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 13:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245684AbiEaLXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 07:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238797AbiEaLXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 07:23:23 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E085C76E
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:23:22 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id w2-20020a17090ac98200b001e0519fe5a8so1958866pjt.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5W6O9FWsbTN7+7W8a3vXrmWggK7UX3QsHoPetn89ePY=;
        b=UcqY+fQBeYDgL8+NnzvHltLd1oqfTFAOEaNtQKIgNgfzWGq6A9keuggJzqi6aAoq88
         ECGIMdsQU0hkZbn5jCiog2qtGXphdHShDOuDQF9t4TafZ2XaxD0RAQ829UqwV6jYGXra
         pigsvKvip2kINO6ABzvmJBqm9Q2xQN/M6CQT3Q5unfdtB/RgEa+H1pvYMznb2WFNYFAA
         L2wvernYagIFZKBQwbrPrOU5hz3DUnJynA9OtSCrcIv32yLZCrgB/rl0cee3cQ0CyL6K
         Uw9mwpUtqvuClv+dkWiKpcDv+wUodsqnCUYFZK/4vkPuFZW3Acz2D5Y37lNLiGdV9nWF
         8cqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5W6O9FWsbTN7+7W8a3vXrmWggK7UX3QsHoPetn89ePY=;
        b=xYORh8uML92HHh0RcuVSq3ftwMHLJHD5V/Q1wsOZ+gM3I5ZxMKo99ne1ZyAmzOjvbl
         fLvUj4UjTOLSNIysqy1J55mBFOBSSOZojUd94Hh+5Y8cyo/CI1tu5awf5GIck/jIVcV0
         XfGePZW0WGGXGI9D8ZZmRaXPTo8+r8M2oV5NhJDWoS7NCNL7Dkbij0nooz4xtRhqPkJI
         6c+tFa5EXruqHdgacQBEPVOjrKdQq+kpPOtDe+E4RoK5hEDLA1f73kCTzhKnNN/dLc6g
         F/emo3HAm598pHjJlMzeL8Y952H9BCNvOml+M89XE+FA3VauSN0sLHYoaKr+z7HDeyEc
         BGdQ==
X-Gm-Message-State: AOAM532CmZvry9rFsiS1fWygVOZUMGdNUuOIkc+Ox5HNQjefVA653t60
        +n6upoLmWNmTq83qcj10QfiV1ar5U31e2RqYXTw=
X-Google-Smtp-Source: ABdhPJwkcEConEUXifaSxX15PYiLzhrAahSrS3yCGxdeMCYmjjEPp++lboW5Ga67iSwjYUTyRkv5L2DXUtqywmcL9aU=
X-Received: by 2002:a17:903:124a:b0:154:c7a4:9375 with SMTP id
 u10-20020a170903124a00b00154c7a49375mr60406082plh.0.1653996201684; Tue, 31
 May 2022 04:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220531005550.10613-1-sxwjean@me.com> <YpWAUiwNPpO8l6yh@FVFYT0MHHV2J.googleapis.com>
In-Reply-To: <YpWAUiwNPpO8l6yh@FVFYT0MHHV2J.googleapis.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Tue, 31 May 2022 19:22:55 +0800
Message-ID: <CAEVVKH_YC_eCyXGtMDq-NQK5a9VGYSwsy=+KSFKOzj_=e+p0Tg@mail.gmail.com>
Subject: Re: [PATCH] mm/slub: Simplify __kmem_cache_alias()
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Xiongwei Song <sxwjean@me.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xiongwei Song <xiongwei.song@windriver.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 10:41 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Tue, May 31, 2022 at 08:55:50AM +0800, sxwjean@me.com wrote:
> > From: Xiongwei Song <xiongwei.song@windriver.com>
> >
> > There is no need to do anything if sysfs_slab_alias() return nonzero
> > value after getting a mergeable cache.
> >
> > Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks Muchun.

>
> Thanks.
>
