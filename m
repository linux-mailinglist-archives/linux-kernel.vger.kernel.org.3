Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AC74C29B1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbiBXKjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiBXKjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:39:44 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EC525A321
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 02:39:14 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id e140so2857870ybh.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 02:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ceIcUX/9qXWYi7bqd3UebABFIg2gF7nv6q+zr1MeNJA=;
        b=JmXSJsusXt5h6HUCTku7gcagy4uYEZ7ywKo+0SGtujyt7clN5JUq5ZuepwcUwQk/on
         9rEIiHtqJJaNRs1a35zVx+X7vrS9HQfAJSo2Zkku3QGSBkG3HQ1q4mTRJ8hp/F/on/Md
         xVLWuo4oNNVHHjH/dyApKEySNU450JWRWle2sXNMijhFTHnQAt1vm4cAD+N1P8aVoDTB
         z4LpMFV9yCr19JRL/RaQT0nle1Qw/SOAJTpup2wcqj2bARfqHbn5uvs4zMj+8vm1z26f
         7VizGQfr89XRWpprdZOGxrH/6UzSvAP5LOzJq5KvfoyoNkDgWz0i81p0ov6SN2346RI9
         chyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ceIcUX/9qXWYi7bqd3UebABFIg2gF7nv6q+zr1MeNJA=;
        b=jPW91biXWyk/s59dMCazeViotVgByB6IoaGGO7tbPi33pulzueuIonEmyejkGVhaT/
         OyEb9BRd9ZeczvlpmuDLrNutTz3gVZaC0PHU0s2UQdeaMG+ceZQmGVWeH8v4AzBzk8u7
         RD9TEysZE5/Gl1AIT9lGVzyuoAnPAYm4ItfRz5wLU1P1RJVq9Soukl+g0x7QdQfTgpYG
         dto+usGOgzYKfDKWZX9oX7UlvqUzfJp+8d9BrHecwBeFEc/ngRGgunxVctSfR0YjDPf2
         7DXlSXwVDJ8oYQevufZCeV6Ov39F5Uce8tN66MvbjTldSi4mCQJ7UAgWHbDeK9lGXBMo
         JQog==
X-Gm-Message-State: AOAM5327W4LluS0l9Lmj7mx3+hVo7KK8BVN3cW/gjhh5E7RllqSYiWRl
        UEF1pAGlFtljhF1/0flyFtwZO7nEMylitAESjYFISw==
X-Google-Smtp-Source: ABdhPJz3rD+Awu54HUU3fKPBSSEc5phjmDzLwguk2UzHmyPEJOLNMV0P940MHAEMLH2MnG0YfcW+SJYZBu3cDe+Ip5Y=
X-Received: by 2002:a25:3d47:0:b0:624:7b42:9f0f with SMTP id
 k68-20020a253d47000000b006247b429f0fmr1833401yba.254.1645699153839; Thu, 24
 Feb 2022 02:39:13 -0800 (PST)
MIME-Version: 1.0
References: <20220222112731.33479-1-linmiaohe@huawei.com>
In-Reply-To: <20220222112731.33479-1-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 24 Feb 2022 18:38:36 +0800
Message-ID: <CAMZfGtVUJC0i_1ccQE3wAFwR+GVQ5gfz=y0Abo6T0czb6zOPtg@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: use helper macro __ATTR_RW
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 7:28 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Use helper macro __ATTR_RW to define HSTATE_ATTR to make code more
> clear. Minor readability improvement.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

More simple.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
