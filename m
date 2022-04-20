Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA990508DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380768AbiDTQtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380759AbiDTQtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:49:52 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E89444A20
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:47:06 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 79so2459498iou.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4kWqTU8/11z4FGTT7w8HybBeD0Jsvi/MPxPw1kkyct8=;
        b=aqrbgx37XpNBMKqxX6gTj1xOa1AdrQnXRe2HUJ4vfj7uVfl25XjQuH46tTduJsyUkH
         IgKkifmsdQfjPFBS3gcTzCVr1sRc2Col2RlPFtSkGrrZ9QYWrY8imqCEgUDFEBmmnmJB
         C5CgIlaG4gi77LgvwQIei4izQoPgcMGzNtWBXDjU3plszZe6Rs8+DWLeB/dw/KInEPra
         ctdUfySrl/kP+jtfo8X8BXJQq5aYdwJ+9NT+gT1zt85XPShsjLhXGW8iQ5jaU2B9b3ll
         KIaLr40WZOsNipglYcSij0kGEuWSG9r5wLghCFdczgTycn6BpFGKKXBLWApUanuPE7SQ
         8TQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4kWqTU8/11z4FGTT7w8HybBeD0Jsvi/MPxPw1kkyct8=;
        b=4eJOTdg6+7MIXAPzIeT7ZUlc3tH2N5qyYsu51M5s41heCoRFQLHmLjbEcRWJDK1r9E
         KF7wt+ANV2DNrmyFvKiBWysU5+bctapS3Cg3G+63ngNpvw7/Zm0NBdcjwjbHYicQUUtM
         KV6xplm2jfKCruzm21caPaiVUxSHe9CJpeQaMHu7CB6QMvOtKK0gDxmikDkdm3km7NhV
         cJrDv75pZKRa7v146f9nLqWy3YElr7jdVFV0Y8EQ7udb6Ncblj4bYFBv4sfPNCgFnHBy
         KFYWaom1yTwAWHD72PdcqNSbFTl2uoba6xIFDGk1scRylI6yIH/7MdQu4YChNz8yy8y7
         PakQ==
X-Gm-Message-State: AOAM53186Diy6QeTaNqWxGBG1wpJyJLi5L1N9YuJCbwRGAONOWOOLnQX
        kNgFkWfyuqy07OntWApAWYHkfTp0HcbTdblt2zle1scD91Y=
X-Google-Smtp-Source: ABdhPJxRTbmqlJ7i1WoOUmbDTP8JjJjXF/VWbsgUV6b48tCKcfVxF9EJaDBA82x837CF7qZmOqUhZX/umYLt2dHCiZ8=
X-Received: by 2002:a5d:9448:0:b0:657:24e0:c0b2 with SMTP id
 x8-20020a5d9448000000b0065724e0c0b2mr1678055ior.167.1650473225232; Wed, 20
 Apr 2022 09:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220420144823.35277-1-peterx@redhat.com> <YmAnUQdQ63jD48ad@cmpxchg.org>
In-Reply-To: <YmAnUQdQ63jD48ad@cmpxchg.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 20 Apr 2022 09:46:29 -0700
Message-ID: <CAJHvVcgepLYwTaiRsn6AqpfSRRimSoVjWFLsxNEsGzmRD6HJmw@mail.gmail.com>
Subject: Re: [PATCH] mm/uffd: Move USERFAULTFD configs into mm/
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Xu <peterx@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

On Wed, Apr 20, 2022 at 8:31 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Apr 20, 2022 at 10:48:23AM -0400, Peter Xu wrote:
> > We used to have USERFAULTFD configs stored in init/.  It makes sense as a
> > start because that's the default place for storing syscall related configs.
> >
> > However userfaultfd evolved a bit in the past few years and some more
> > config options were added.  They're no longer related to syscalls and start
> > to be not suitable to be kept in the init/ directory anymore, because
> > they're pure mm concepts.
> >
> > But it's not ideal either to keep the userfaultfd configs separate from
> > each other.  Hence this patch moves the userfaultfd configs under init/ to
> > be under mm/ so that we'll start to group all userfaultfd configs
> > together.
> >
> > We do have quite a few examples of syscall related configs that are not put
> > under init/Kconfig: FTRACE_SYSCALLS, SWAP, FILE_LOCKING, MEMFD_CREATE..
> > They all reside in the dir where they're more suitable for the concept. So
> > it seems there's no restriction to keep the role of having syscall related
> > CONFIG_* under init/ only.
> >
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
