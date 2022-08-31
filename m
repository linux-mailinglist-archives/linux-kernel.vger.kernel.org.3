Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FC95A827F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiHaP47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiHaP4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:56:38 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2064DC0B5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:56:22 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-32a09b909f6so312203877b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=cCRpuq5ugrZCMPNASqLzmnmQqSHwIbDaqesnsW6hpVY=;
        b=dp7ag/s/XswteEOQhIlZJ0Nr9OSh2piBWOaxYRC3sJJA1h7P9YiBLyTj5ZbqtTA5s/
         QVBATN/coisioHRuuIpGq3gJNfqJZeq14BoEa/ktEy7OjVkakgw2dN07PvsjfH2DKU0B
         bxLma1WzIl4FKw+quVea/qjMwPtAOmq0TevZHzdNCNncQhM1PD4uyKVu4HWZvLI6BqTx
         H7kaRy09fBu1xgcDeDqWrzFeKvin7yA3AAOKZ6MQsBsn3T/kb8YICvKVh7LgyXMq+5Bi
         FLuEciavzkBG7ruhxzyjiDdwLtfbNolH0swGrGj9z+IyuUE/sK6RMxqKOGNWiAhwfBa3
         5mXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cCRpuq5ugrZCMPNASqLzmnmQqSHwIbDaqesnsW6hpVY=;
        b=2TcPJ3N0k0CwHqx5+vLTKFto6cYDwYdYX+L+aAi7FNhsSdASIgIbX6rcuhgyFA9X54
         5XECQyOCGTCSYId09EWLhm2gCiRfDnoIBXKCjVN/xcVYIbEEuB9z9+AEWHZJTOYrsXHh
         z8O8gGg7K9JV+1Ad6RxNAoVeHr+zacwOM+4dHaFyP4Qs9ncjHLxMiTSamUJhooycYYMg
         VXvhwsei008J1JT+XLXBmmn25AJnUW7ukuDTmbxnOiPtGswk8znPVCfAWhj/BXaBptI2
         2T9ef6QZQ0Mv750WMnj8TBKVY0BR+EQZGAQyynx4AUJRMKh5xRW0RDMv3EY1jSMNeo8h
         rN4g==
X-Gm-Message-State: ACgBeo3rJJv/7bbEM6mY8tk1NZt1j3n9XrXNzmUTDpiKdc7xeU4kgYyM
        RYYXzgjDjUk1JqvWovx88+EVFIr+3SeO1uY+/u59ww==
X-Google-Smtp-Source: AA6agR7Lu6PK9CdXu23xIn3AG3MYNgxqZ4pzHv7Fy3xw9o0fL/gGGSH+N2uXtSf2ZsqL9IuP0dnF/6Y/gY//h7qjU0c=
X-Received: by 2002:a81:85c3:0:b0:33d:a4d9:4599 with SMTP id
 v186-20020a8185c3000000b0033da4d94599mr18562781ywf.237.1661961381492; Wed, 31
 Aug 2022 08:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220830214919.53220-1-surenb@google.com> <20220830214919.53220-23-surenb@google.com>
 <b252a4e0-57a1-0f27-f4b0-598e851b47ea@infradead.org>
In-Reply-To: <b252a4e0-57a1-0f27-f4b0-598e851b47ea@infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 31 Aug 2022 08:56:10 -0700
Message-ID: <CAJuCfpFff1iVx50QeJWE7=sJUZ2enig34VTAOCz75u_SY2EXKw@mail.gmail.com>
Subject: Re: [RFC PATCH 22/30] Code tagging based fault injection
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Mel Gorman <mgorman@suse.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        David Vernet <void@manifault.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, changbin.du@intel.com,
        ytcoode@gmail.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Christopher Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, 42.hyeyoo@gmail.com,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>, dvyukov@google.com,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>, arnd@arndb.de,
        jbaron@akamai.com, David Rientjes <rientjes@google.com>,
        Minchan Kim <minchan@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        kernel-team <kernel-team@android.com>,
        linux-mm <linux-mm@kvack.org>, iommu@lists.linux.dev,
        kasan-dev@googlegroups.com, io-uring@vger.kernel.org,
        linux-arch@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-bcache@vger.kernel.org, linux-modules@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 6:52 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 8/30/22 14:49, Suren Baghdasaryan wrote:
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > This adds a new fault injection capability, based on code tagging.
> >
> > To use, simply insert somewhere in your code
> >
> >   dynamic_fault("fault_class_name")
> >
> > and check whether it returns true - if so, inject the error.
> > For example
> >
> >   if (dynamic_fault("init"))
> >       return -EINVAL;
> >
> > There's no need to define faults elsewhere, as with
> > include/linux/fault-injection.h. Faults show up in debugfs, under
> > /sys/kernel/debug/dynamic_faults, and can be selected based on
> > file/module/function/line number/class, and enabled permanently, or in
> > oneshot mode, or with a specified frequency.
> >
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>
> Missing Signed-off-by: from Suren.
> See Documentation/process/submitting-patches.rst:
>
> When to use Acked-by:, Cc:, and Co-developed-by:
> ------------------------------------------------
>
> The Signed-off-by: tag indicates that the signer was involved in the
> development of the patch, or that he/she was in the patch's delivery path.

Thanks for the note! Will fix in the next respin.

>
>
> --
> ~Randy
