Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06468547A8C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 16:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbiFLOpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 10:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbiFLOpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 10:45:13 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D903E0EE
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 07:45:11 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id v81so6246198ybe.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 07:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nEdR+JbeZcNXqk7Oize93k4cETioRbi+nld4A68DmHI=;
        b=HDA1tKvKCLx8xGKrKJIHKZH6CszMl5x397hw2tMs5e0A++sOMsZ818nKfFqwQsALO5
         DNWqZy2w1iJpSmKxoriAD+OOx/RRRrQ7n4krIhcuyIW9Mav80M1OlqOxup8pd52elUDP
         Vg9++E6KfiJAxIBgLfO4ZcChlEfjCCalCPUQCpJq05H9av94LvnoD/4l0SV/V2Coisk2
         r13NvbVAb/qEBerdtWuAo/IRW5Pr0CAO7VDiWZId72k0avbBZrxO4k2maGqWYoYmWbrW
         IKI+kmhLIGkWSzDS6012dED/nKIyGRF1WWoEw+orASaSmly+18xjmIdEXA4YjLrAJACq
         TgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEdR+JbeZcNXqk7Oize93k4cETioRbi+nld4A68DmHI=;
        b=5kBoFZV+tNswvI3WnYbJ5B8Bvx8crf5CKpHc3v7S2Ea+sQGpZAp0RN2xbZAwsi2B6r
         DcnB2Hit5jr/RKRDROVpOiyPSbxDGCN62ILy0sAoaM61O7YS6NIPHRIbBuI4Ckjcd/7E
         obIfDytdXFONH++nq5eONR8129+YWoaYPgjCIhvMrha5JRc8pXqU1Q4AoEozyFVXFs6C
         rsVeE32/eq4KLbhza/rdDSjpsqosG4vtTpRq4e9peUaZVUyvYEvVEGnKf5NmdC2x0Hc7
         wwuxBWocgEpUQOue+nc8FE/qXaOHp7lEdGYEEtd9deCLHLV6A/PUSbtiAFZZZVaqKrbE
         eAUg==
X-Gm-Message-State: AOAM531M1/gyCqNOXct4SmiSCZgTGmv7IC8VY+9d6n26LwOxyJhtw1jh
        Y9XbrBM6MctA8be65c8rcKtHvk/6iWsgU20gtz4bsg==
X-Google-Smtp-Source: ABdhPJyfdCfKcUXduNxctDUAwhfLi+QiaFlKyTIqzGi5M8U04rsK2Risq7tlWOaOA8yMzPUTlIsHF9ipmTILj0S4WbI=
X-Received: by 2002:a25:d7d3:0:b0:664:d4d4:43e8 with SMTP id
 o202-20020a25d7d3000000b00664d4d443e8mr1118381ybg.427.1655045110755; Sun, 12
 Jun 2022 07:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220610180310.1725111-1-roman.gushchin@linux.dev>
In-Reply-To: <20220610180310.1725111-1-roman.gushchin@linux.dev>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sun, 12 Jun 2022 22:44:34 +0800
Message-ID: <CAMZfGtV3eHB_Nh_crKgR4-oAvT=Lx-2F6F7xLhTN65Fmefdd0g@mail.gmail.com>
Subject: Re: [PATCH] mm: kmem: make mem_cgroup_from_obj() vmalloc()-safe
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Vasily Averin <vvs@openvz.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 2:04 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> Currently mem_cgroup_from_obj() is not working properly with objects
> allocated using vmalloc(). It creates problems in some cases, when
> it's called for static objects belonging to  modules or generally
> allocated using vmalloc().
>
> This patch makes mem_cgroup_from_obj() safe to be called on objects
> allocated using vmalloc().
>
> It also introduces mem_cgroup_from_slab_obj(), which is a faster
> version to use in places when we know the object is either a slab
> object or a generic slab page (e.g. when adding an object to a lru
> list).
>
> Suggested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Acked-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
