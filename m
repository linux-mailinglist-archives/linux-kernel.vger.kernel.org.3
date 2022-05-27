Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3555365FD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 18:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353629AbiE0QaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 12:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiE0QaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 12:30:22 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE583B2B6
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 09:30:22 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id 63so1733305uaw.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 09:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9g6mz1ylmv173XWWIuI9CzS3Wpc02dZXxX1VqooLv6M=;
        b=ICPj8M19sLww6myKVnMx7K4vHlePmm+tmuVa2CCBroqezT99t1DinF9BZu3oSQWi95
         PpHxUge67hCiEN+WbmdFcFmp8LoaNqXmtffkzJy1t2bg6QFSpt+0cta9Vh/exFeakeY8
         ES6R1K20FZEi8DvnQo+3jrpIm5FGofSrhASDaagpHZYCBydJb1rbBRkKTUKmMN2hpZbm
         FRCTGunZ2yKbLACuUH57tkyr0bh7HuM09UnLIwgdDTL+WogL5Yjb2zxog50f0Rjsgd8z
         Cctn/w1tgtMEDvEQuXCz2/zfx4aQ/YRaYg3+SGh/W7Ihl0m86+RY8kWo0ZD2STUDzwff
         u6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9g6mz1ylmv173XWWIuI9CzS3Wpc02dZXxX1VqooLv6M=;
        b=S9UfGCvXRtWeJsG6aomG4Keq/v0lvolTsizZdHeyRGLX3bbkQc8hy+/Jgcf7wPgzuZ
         DipF6sV3octCax5DTGQDiD1BEIVHXbSefjwU5UAzaY3jjz1P0p0fgNvC8NzSGDp9Jemj
         o32L+xFShfqUQel2bY4qY5LaaWitkFRngLaQ0ywAysaUoI2FzTJrizf0bKBZT1s3yWbb
         9WRaLxGMr+eHUJgU2Ei0eLcQvK+OmEpZJTUc4LBqeCTmmBFG9yjaBmXwNseITKVmhz71
         5SfS0E4u4kh4FU7Bys31dgrwaqW59tBxygnxmUoeuMn93K6V5WJwGNosfymbzgDYWcEW
         4SCg==
X-Gm-Message-State: AOAM533CojZTdobz1LDNsKMgOtRF6HWFYAZ2cSCR3hosDIdLQMqThq4l
        GR/YsOlqOsOV2JCtBRvblB3vK06Cx9Sex8a22fQsRg==
X-Google-Smtp-Source: ABdhPJzt+PohqIGTGjBpgaRI7q35Gs5Fzbmr+cx7m/7GoZaI2EB6hlNIf7D72yOYQIlLGACN2Xz+OWyWgoTOKR9NHJQ=
X-Received: by 2002:a9f:3592:0:b0:365:ef07:68c9 with SMTP id
 t18-20020a9f3592000000b00365ef0768c9mr15993279uad.60.1653669021023; Fri, 27
 May 2022 09:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <c453491b-6dc1-a008-d6f4-3c806eebd2ef@linux.ibm.com>
In-Reply-To: <c453491b-6dc1-a008-d6f4-3c806eebd2ef@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 27 May 2022 09:30:10 -0700
Message-ID: <CAAPL-u_NwJuxWe7Wfn3A1sut+QwEmoZh2QUBQKNPq4bU=NjybA@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v3)
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>, Linux MM <linux-mm@kvack.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 6:41 AM Aneesh Kumar K V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 5/27/22 2:52 AM, Wei Xu wrote:
>
> >    The order of memory tiers is determined by their rank values, not by
> >    their memtier device names.
> >
> >    - /sys/devices/system/memtier/possible
> >
> >      Format: ordered list of "memtier(rank)"
> >      Example: 0(64), 1(128), 2(192)
> >
> >      Read-only.  When read, list all available memory tiers and their
> >      associated ranks, ordered by the rank values (from the highest
> >       tier to the lowest tier).
> >
>
> Did we discuss the need for this? I haven't done this in the patch
> series I sent across.

The "possible" file is only needed if we decide to hide the
directories of memtiers that have no nodes.  We can remove this
interface and always show all memtier directories to keep things
simpler.

> We do have
> /sys/devices/system/memtier/default_rank which should allow user to
> identify the default rank to which memory would get added via hotplug if
> the NUMA node is not part of any memory tier.

Sounds good to me to have it.

>
> -aneesh
