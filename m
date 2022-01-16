Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E57148FEA6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 20:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbiAPTYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 14:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiAPTYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 14:24:17 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199FDC06161C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 11:24:17 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m3so35636403lfu.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 11:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c6evELW+tkD7CtjU/q82JAh8zwV9sibyS+oVT1wgMIo=;
        b=pS/LRlqPd2v795c2ySY+8PL8UpC5Zl/zUN5+ti7B4CoFeYTvYKCSFwKmMbUVOPcDVc
         7eDStVWQH+iALVLXbJ//2+WauF9fp7eC+h+NWylp10lReOm2dExRzmxX6TmsUpamL0FA
         3mhzljQgdxIjCnOhaoIUlIh/xT31WP7v/ZND528u73eUybliaipUhuZ8Myurkri9/Bn0
         VMYcEsiO5g5dBYFv1judak18DlWxlI2misGKjlM0Uy/c9j5/lFYy/XHbPdCQhuXVVchu
         erkNGuEzUvBLWQC3ykVipjL4zjFm2geGKSIDKJvecb5eGqp9umVpwKPwj9v6mlgDm1G1
         E4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c6evELW+tkD7CtjU/q82JAh8zwV9sibyS+oVT1wgMIo=;
        b=RjMMdmkYfv8MYvTfYsCxB279PZexzsFsQKJ0Pqa7Ws0yQU00Akjx7ioppiknXp8gIM
         mUoBIT6PWh7V+/45dBaIoLh0JXKXRnrdEErro/lstp7GYcO8l7xt6+P7FBLhbZiGP4F3
         p+q1aC128/8cQKnLAlBfxZDon5f2/DaOz51MLImQKH4j2gowyadSc787G5DeGcQ2Lm6h
         CHzOEQYU/cwi3zgc3tUJZwuumZ229Obcoctu+WVnRXcgyWioKCE77PtckFT3AGiczstw
         xnYl5FdEOLVrH12qA6cru6QD7WJL+L8HR3VljhPVE+A0zjb0OHedWLE0DzmSi2RcSU4X
         mQ2w==
X-Gm-Message-State: AOAM532BrAafbx67AerswvX16UgfbxyrZKt6E0vt8/gHCX19Oks/HEfC
        ZmzMJU9kbDkZ5YED/0I/Ic0kSHYwuTdhLfThdJKfXQ==
X-Google-Smtp-Source: ABdhPJw6mt0uPBES7VWlz/l/3HfrOre8edIq1HG4QyVNrJkP4NMUfE1A5yoz/TNv8wazbvj7f5TgBtQy/ErWCZ/LmWo=
X-Received: by 2002:a05:6512:2629:: with SMTP id bt41mr14284903lfb.264.1642361055116;
 Sun, 16 Jan 2022 11:24:15 -0800 (PST)
MIME-Version: 1.0
References: <20220111010302.8864-1-richard.weiyang@gmail.com> <20220111010302.8864-2-richard.weiyang@gmail.com>
In-Reply-To: <20220111010302.8864-2-richard.weiyang@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 16 Jan 2022 11:24:03 -0800
Message-ID: <CALvZod5ycSmk7URBoLGGJAiyjGQ1E0HR2RnJ-3uZai=t+KpEKA@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm/memcg: mem_cgroup_per_node is already set to 0 on allocation
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 5:03 PM Wei Yang <richard.weiyang@gmail.com> wrote:
>
> kzalloc_node() would set data to 0, so it's not necessary to set it
> again.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
