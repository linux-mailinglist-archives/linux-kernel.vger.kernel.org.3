Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510B359BC45
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbiHVJF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiHVJFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:05:52 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBD72ED52;
        Mon, 22 Aug 2022 02:05:51 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3321c2a8d4cso274816417b3.5;
        Mon, 22 Aug 2022 02:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Aeo8ReWVormZ3Su0nDv7qbyLSxPqv1EwjsntP4W6vow=;
        b=BxNP9+oaCWk1O0H73aeTwP9i/5v+n3OwSlCxXXV47U8uuq/QgYa9N9IoQIUVg5rFLr
         P+8TQ2yuCnAUFys/FG8jkDRE8y27UVnFLHRMXesihghPlOcS1/XlVyh/vbai7nXQUITY
         eeQtoxLa2YZlzkEiQOy0t9WbQ2g6lguD7KnHwicLxvy+DC3B0hCt832HL79+zitwYLZF
         2Kd42E+JXvafXnnwrXVpfHYAFdX4J4x9CqC5CQlyNdgh9g+2HyW04wyiGcY1dM0SWXdO
         RxrXts+/0bZRViAdyJqtQyj0CmXucQ3Ph1c+ukMFwAmgBvhbUVt1yGi4Jqw3JGOZTkO6
         d0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Aeo8ReWVormZ3Su0nDv7qbyLSxPqv1EwjsntP4W6vow=;
        b=K5jnazmWZU0J9dyCubD2/OVRk5HpfZ0VqWiOUl0XJdqpvdIIoisyhT3wnbyXfaiwhW
         fQxXf+so9mjYY1A9terU+ZHqUFNpAeo0YO2GtpQ38eDqxB4iqMbAVey3fpZRjKME6XcD
         aDBHHeVPlSQeMEra53EmAx9a6aVLHiIUIAW4XL0wVDz2kGebWnG6nLyDmEhY1+uFasQX
         alNuysUNCZeU7iw4BmMxhQ8W0SByMUsciH/jta/i69M3LaXTBhEl0WNBpBoyUn2hyKO2
         o+nfDyfW6SKWUq4B7vq+UnMw8kddIwX9G25JqtKy+kKY+6FvZwnojw2/W3Piy35MUfwT
         TmSw==
X-Gm-Message-State: ACgBeo1ml90RCNM58ljMZHtD0r1s3Ybs7Js2BGPl1Za///h2Uq6ZkYyL
        v0HEGyixsleKmkfLlUWccS8Azufp0KeHIDmsrmQ=
X-Google-Smtp-Source: AA6agR6nuKeAAbpMOM/QLSq2H5gNqI4/sBSaI9Ud8l6hSWBIGqSI8wXkMoz3+U5yiVIvUnJhnDzCOICFFF0LsYMiRck=
X-Received: by 2002:a05:6902:10c:b0:671:68b7:ab41 with SMTP id
 o12-20020a056902010c00b0067168b7ab41mr17315104ybh.608.1661159150370; Mon, 22
 Aug 2022 02:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220822082525.26071-1-lukas.bulwahn@gmail.com> <08fec67b-788e-1c9e-606e-903db3bcad67@huawei.com>
In-Reply-To: <08fec67b-788e-1c9e-606e-903db3bcad67@huawei.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 22 Aug 2022 11:05:39 +0200
Message-ID: <CAKXUXMysz=6NHq6tJcxHbm5vy4usVq2XEDp9q+ydmcHcqGw94A@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: remove unused local variable dst_entry in copy_hugetlb_page_range()
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
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

On Mon, Aug 22, 2022 at 10:51 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2022/8/22 16:25, Lukas Bulwahn wrote:
> > Commit a0e4f7b82610 ("mm/hugetlb: make detecting shared pte more reliable")
> > modifies copy_hugetlb_page_range() such that huge_ptep_get(dst_pte) and the
> > local variable dst_entry is not used explicitly in this function.
> >
> > Remove this unused local variable dst_entry in copy_hugetlb_page_range().
> > No functional change.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>
> LGTM. Thanks for your patch.
>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
>
> BTW: I will send a v2 of that series soon. So the above commit id might change.
>

Feel free to just squash this code improvement into your next v2 patch.

Lukas
