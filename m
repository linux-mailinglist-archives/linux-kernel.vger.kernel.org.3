Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5264510B6A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355520AbiDZVhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346480AbiDZVhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:37:13 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7811B1A5DD1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:34:04 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id h8so203285iov.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zJHneikLXEGfJde4krQasd9PQhsFRpApoS4ZRag7+RU=;
        b=EdwxR0V/0R58E5VQDj0HrytGDcfRa0ZaI7Me6rDBjirAgNHRbWWWvGaw7HmQEIGzu+
         8UTTpBJpVmtohKiGL5cVYIq8PicWJvFUQVly2vSP4TS+56W86k/aX6l5WCrdoFzyILM+
         1Yehf40AqvUszrZodWCBswvT50v8vrsYb0CT9VT0ik1assb3s50rjI/Ghc6ERMC0+hQS
         kngQQpUrenrx0Z/CG7kuYI7vOHHB9pxCvklytawOfmTdu9cTLRddizluzNirEjBtvgHq
         /7wjZvrPSoiAuTCiyBqcBwBGz7SjzYicglmkQ0p2ZcHJZmj17y1/IkCZAoejAg68UMHJ
         xOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJHneikLXEGfJde4krQasd9PQhsFRpApoS4ZRag7+RU=;
        b=Q5QFQj4dxDIG6cf96TDDZ5+F2QYB1kxwsrhABAnl0j1PVcdrhp8RSezTmQEkDs6b5D
         yEke2c737a9BkozNhGWq+um6og4bOAlQdP9dAfia9VB2A6Xgj6f/jd7EM0eygzR/D2md
         dmHFX2k7Mj/2xf9qQfvHs53/qpFOLb1/zKyxEV+kq7T5hAH7hASOkHgBGIFtYCJcnbxs
         CJ0CKybUj+ppjrX8aNuLW7Z7KlGLkT9zJkT2oi2tmElGbQ0a3HqQdf06suQkVyzNmVx2
         x9ud7z2Kk848BNm2ET6b624Ay6frvhjYuN08NNoqC5Q4oFpodFcCEyD26vN/5E/JsGFJ
         LawQ==
X-Gm-Message-State: AOAM531gOpLvITMdDCchWPYUA7O/1r3dtUl3aV53D0Qs7iULnOPD24+S
        3utShs+/n2mVRSbrhBQhBipE6ek7KgmkS177xokT/EPE7DA=
X-Google-Smtp-Source: ABdhPJyGNR5sOXzGqUeKg6keEazd9H9Z8L/jAzBgMCoHI+lyyK7gNjS+2erCu0X4dzgJTpnr7YSLg3mNpJ5fsfcJHI0=
X-Received: by 2002:a5d:9448:0:b0:657:24e0:c0b2 with SMTP id
 x8-20020a5d9448000000b0065724e0c0b2mr10388348ior.167.1651008843696; Tue, 26
 Apr 2022 14:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220422212945.2227722-1-axelrasmussen@google.com>
 <20220422212945.2227722-3-axelrasmussen@google.com> <YmhW+mOuQUWsByj4@xz-m1.local>
In-Reply-To: <YmhW+mOuQUWsByj4@xz-m1.local>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 26 Apr 2022 14:33:27 -0700
Message-ID: <CAJHvVch=8znnY-u1PbPb1qUeczn+9AR_eZOP5z9kD6PgtPQjrQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] userfaultfd: add /dev/userfaultfd for fine grained
 access control
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>
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

On Tue, Apr 26, 2022 at 1:33 PM Peter Xu <peterx@redhat.com> wrote:
>
> Axel,
>
> On Fri, Apr 22, 2022 at 02:29:41PM -0700, Axel Rasmussen wrote:
> > @@ -65,6 +66,8 @@ struct userfaultfd_ctx {
> >       unsigned int flags;
> >       /* features requested from the userspace */
> >       unsigned int features;
> > +     /* whether or not to handle kernel faults */
> > +     bool handle_kernel_faults;
>
> Could you help explain why we need this bool?  I failed to figure out
> myself on the difference against "!(ctx->flags & UFFD_USER_MODE_ONLY)".

Ah, yeah you're right, we can get rid of it and just rely on
UFFD_USER_MODE_ONLY.

Just to add context, in a previous version I never sent out, I had:

ctx->handle_kernel_faults = userfaultfd_allowed(...);

That's wrong for other reasons, but if we were going to do that we'd
have to store the result, since it's a function not just of the flags,
but also of the method used to create the userfaultfd. I changed this
without also dropping the boolean, which can now be cleaned up. I'll
include this change in a v3.

>
> Thanks,
>
> --
> Peter Xu
>
