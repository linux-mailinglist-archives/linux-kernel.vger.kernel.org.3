Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1E759570F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiHPJuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbiHPJuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:50:23 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E4CDABA4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:29:04 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id 66so9434631vse.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5+JNREwE1A4uHAEmXDcDFaNJYYYR64QtVhTwaoPWxKs=;
        b=BcZI6X0enB0qHLc2Ct1J/KkDNfJlGhCI8b15E1w1HHolQiPpqeCJ2koir8AliM9dbq
         HAW/Yk4mnDYIGF/jbmSpSaUCUK56UMbDN9oU3UidOPCWunPcf9Uzwre0g2ywMdwlHAG6
         Z/qDmDTkkrZ43r30niypHjN6bVu13qjEF4cEz2GbbGeGZlNzQlt80/kUDbBk5z38bHz/
         +Km70PwltDktN2QcWPlc7KM1BGcx+YYK1hdVAwlVL2bf5R0UxwyJOJ8zc5wowtR9Dc+q
         qmvpLA39ydXUiOHVE4730u4O6FtjnUYMd+7tdUE0TU9FHuPVQ6bGgjWqKfrYUEcwScxk
         REAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5+JNREwE1A4uHAEmXDcDFaNJYYYR64QtVhTwaoPWxKs=;
        b=CqWXDDKJdkj7+ebkigpx4No2xdNKUHtuaqRbxgIzwk96OOmAesI38yKAqWNpa5WC10
         QrNX5jGGYx1Xhn24+Fc0heXN+s8CFSwSOcJiDEhIW9tumpxV0Tc98yDpIohtWvJIQsxQ
         gzMCX/tr4BUtNVPfaqs97TB+qgCGPO6d+V7FXeqTQWcHBiiw6vgA61BSFuFs/tzE2xt7
         T/ZYX6+cCOmGLo/0kmARi8KG4v61qomIHCSgczW3jdj/SPXQDpXUMit8QdmXJblYsZIK
         EtQbo+ArwY34lXuTcptynXDHHFvqnn3eGgaqpLP9ZDvRJfpG6+rkbgpyalbGwpUkPc6/
         bdOg==
X-Gm-Message-State: ACgBeo03nNjiUYHiGEgsCPM0KklTdLVr1u115Lv0KFTqiqqViap1qsuQ
        C2/yEOV+UcFKII9KnR26xV+ZouCzTIHznWBTHdE=
X-Google-Smtp-Source: AA6agR5Cv9y0PctSYtKsM3IP6P3qlpaHGkogF2MPKOhbQ8gvEwzSqrOfvt9FFQZQse9Xl+U2A3lTiyJ8IZn/Gmsu44o=
X-Received: by 2002:a67:d312:0:b0:388:4bb8:1a2e with SMTP id
 a18-20020a67d312000000b003884bb81a2emr7682696vsj.17.1660638543553; Tue, 16
 Aug 2022 01:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220812055710.357820-1-aneesh.kumar@linux.ibm.com> <20220812055710.357820-2-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20220812055710.357820-2-aneesh.kumar@linux.ibm.com>
From:   huang ying <huang.ying.caritas@gmail.com>
Date:   Tue, 16 Aug 2022 16:28:51 +0800
Message-ID: <CAC=cRTNDN7mHvHfk=bSN5SDUY864+1EOAOAg6Wd030ENWfY+fg@mail.gmail.com>
Subject: Re: [PATCH v14 01/10] mm/demotion: Add support for explicit memory tiers
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Bharata B Rao <bharata@amd.com>
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

On Fri, Aug 12, 2022 at 1:58 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:

[snip]

> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> new file mode 100644
> index 000000000000..bc7c1b799bef
> --- /dev/null
> +++ b/include/linux/memory-tiers.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_MEMORY_TIERS_H
> +#define _LINUX_MEMORY_TIERS_H
> +
> +/*
> + * Each tier cover a abstrace distance chunk size of 128
> + */
> +#define MEMTIER_CHUNK_BITS     7
> +#define MEMTIER_CHUNK_SIZE     (1 << MEMTIER_CHUNK_BITS)
> +/*
> + * Smaller abstract distance value imply faster(higher) memory tiers.
> + */
> +#define MEMTIER_ADISTANCE_DRAM (4 * MEMTIER_CHUNK_SIZE)

This will make the abstract distance of DRAM the start of its memory
tier.  So that any memory type that is slightly slower than DRAM will
be put in a lower memory tier.  So I think it's better to put the DRAM
at the middle of its memory tier by default.  For example,

    4 * MEMTIER_CHUNK_SIZE + MEMTIER_CHUNK_SIZE / 2

> +
> +#endif  /* _LINUX_MEMORY_TIERS_H */

[snip]

Best Regards,
Huang, Ying
