Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8949A53015C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 08:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243675AbiEVGuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 02:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239944AbiEVGuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 02:50:14 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08D536699
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 23:50:12 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id p139so20363156ybc.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 23:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xBwtB9T65QzhNPtQZ0QXYA7XAPyjsJvSWqKsiu1+O3c=;
        b=1tl+DtjUID/Yit6XMR1sy4CgTCo7HJWlhuAjY9JG40KKnRyzU6DDTBO7B8l8eQHvs5
         HCM1hEkHgCiX8lbuD66I4Wg6aom5XMll2U7YYcjZ8YFM9a1TDI+HJflEKyxUunm8Lx5t
         2DN0t8GjjEE5K2TKo4NqLvLu6Dqrx8grDcdVi34AwfAju6scjTPeKVdb0NuAEAZ9oDAh
         CqTsDqWcF3ZoMr7K1uQmsMtv5yVqDCA+QZsfWMEPE9pcfKpzks4o+OoxvCn8OjO9fHY+
         u+6D2zwnTQKV7bZYNGgg6da2F230kRqfS2eXe9sPxUX9yJLUnrjbvXDNsYzkpHqJeN0V
         kKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xBwtB9T65QzhNPtQZ0QXYA7XAPyjsJvSWqKsiu1+O3c=;
        b=bbYtD58JuyzVNIjDQH983Jv37egNrTTDUhUtSun4ux8BQpuMUrqmb3HM4kX+b9DDbU
         AmgfrVykQmaA/rGnCcLAr+/k8MUnezI4PI/By9ypA2hZOsOIWZIPW2sOmkzoN8DMkZjJ
         FOZgtoNZ5F75i7j+KqYZqSNjWDDYqOf/klQUjXVCsIFbS8QsiLvQHcpL/oBXm9HxwUc+
         dqOmCf4MfSOVlOXwP5/ksnVBKdV49xQEikJCNVBVpNcultwWnlc3GYt1Ta9SewaQQuRx
         3T8kXlmrxWPTGfNdJQ9HvDLBAkQhDzluGOvjssehVx5Y82KZLWNxznOGSazC6U+OPtSO
         OcJA==
X-Gm-Message-State: AOAM531rPMK+gQh+X45HyWcMEz7hEkiL2Ay+sz9HEIVWzBZVh7Lb7fpz
        0ngP83cZlPBxBS4Qthd0VZCVeXG+ATh3XhWjKclmiA==
X-Google-Smtp-Source: ABdhPJxG7bFPCW5S+Nizupv0nufUjwDo2jXDHFEk/7XVc3m5J4NbnaL1ymOAP0Uw17amoGe2vIpChAn7wQbK1KbLxrY=
X-Received: by 2002:a25:3452:0:b0:64e:1776:ce90 with SMTP id
 b79-20020a253452000000b0064e1776ce90mr16686330yba.261.1653202212242; Sat, 21
 May 2022 23:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <Yn6aL3cO7VdrmHHp@carbon> <46bbde64-7290-cabb-8fef-6f4a30263d8c@openvz.org>
In-Reply-To: <46bbde64-7290-cabb-8fef-6f4a30263d8c@openvz.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sun, 22 May 2022 14:49:36 +0800
Message-ID: <CAMZfGtUg65D2KemysdhcQM3-gnz+c_tahzJ=WzBUcY451WBv4Q@mail.gmail.com>
Subject: Re: [PATCH mm v2 8/9] memcg: enable accounting for allocations in alloc_fair_sched_group
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 12:39 AM Vasily Averin <vvs@openvz.org> wrote:
>
> Creating of each new cpu cgroup allocates two 512-bytes kernel objects
> per CPU. This is especially important for cgroups shared parent memory
> cgroup. In this scenario, on nodes with multiple processors, these
> allocations become one of the main memory consumers.
>
> Memory allocated during new cpu cgroup creation:
> common part:    ~11Kb   +  318 bytes percpu
> cpu cgroup:     ~2.5Kb  + 1036 bytes percpu
>
> Accounting for this memory helps to avoid misuse inside memcg-limited
> contianers.
>
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
