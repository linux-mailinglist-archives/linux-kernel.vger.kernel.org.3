Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CE44B118D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243548AbiBJPWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:22:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243501AbiBJPWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:22:02 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CD61B3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:22:04 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id m6so16372135ybc.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VAdcwDfaAP/WLJZqmjr4eWqfOgNEvTj6OZjQubGMIBs=;
        b=h1zipEqirLbmEMLa8HgqTL+E50cFo/1oq/rNwRelbfsMfp60fc28fqw9c32ZyoBg9h
         YwOL1W7qlfNLaA7LZnd+UTZ3MOsOIgZr04A2TI2183dSajsAQiFsfwcsTr1GzkvoMDxs
         FK+9CE4HN6ZMzfb4hGch5cdQyXRgjr5VETPa9Qy7zsKUSgOcf6lm0nZWYPK1zAG3XhXm
         kDpYEdD5RLAtkgPrQS4WYYhH0k+EQm1dWlKdOLGz7qJlZ2xr1n61DTDDdhd3PKIlQ8Ft
         WhhDb0Cb3ZOBu9/s7V/rTeDv3kPWb0/wWVoNg0TjJACJbiAWCt21IYxL6QOXodbgGZyT
         fJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VAdcwDfaAP/WLJZqmjr4eWqfOgNEvTj6OZjQubGMIBs=;
        b=ZL4bkobJd2qd0b3PbdP40B23mzSb3vkYFHb0HZcIS9FxnkFa/ycvp4Ug93ufHXA9NL
         KuHieSCGYltxeN1DAqtYp4Au2CqVW5Kt+AHCEL2zmMUdeRAB0/IXE+85jtJX/1Leitbi
         USmfy6/QcD98ZMP00aBMx35DzAVvEuGntKXrN7U3p7UOJOZGIllsTzQUyzjXChQUCrH8
         7hMk3Yba8Okf4z5yI5VPbeeSfFnMq0VtwuB+RoxmQqXH67zTT/NsvS7yZl0REc4OlMgn
         WX2nMDPvSsNaArj8ZCkmA2R5RzwgU16VWMk6/Vp2NY8SKwcaRq36x+HBBCt4wTJdorXc
         nEoA==
X-Gm-Message-State: AOAM530/3656GJ03EsIVi+Jka7yf/BimEUA9TmiKwO81Z859HpaHUaHW
        tySfmKURBrro9MaF290vSxRFfrb597AuYZkb8OO0LQ==
X-Google-Smtp-Source: ABdhPJyoX9LD2NLB7m9aiVLXsKWN3CQDcio86Xhxkvd1HKhFlhrQxfzl9DNb9oLp/q3x2dPaGvk8E/kORKY5BWqvGKg=
X-Received: by 2002:a81:56c4:: with SMTP id k187mr7450919ywb.237.1644506523094;
 Thu, 10 Feb 2022 07:22:03 -0800 (PST)
MIME-Version: 1.0
References: <20220210043215.42794-1-surenb@google.com> <YgUSxzp/qDwLkiKb@casper.infradead.org>
In-Reply-To: <YgUSxzp/qDwLkiKb@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 10 Feb 2022 07:21:52 -0800
Message-ID: <CAJuCfpGhWh95wxRxy35d4jbCGUdCyasYQBs7DG2fVn34tSXrRQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: fix use-after-free when anon vma name is used
 after vma is freed
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, brauner@kernel.org,
        legion@kernel.org, ran.xiaokai@zte.com.cn, sashal@kernel.org,
        Chris Hyser <chris.hyser@oracle.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Collingbourne <pcc@google.com>, caoxiaofeng@yulong.com,
        David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
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

On Thu, Feb 10, 2022 at 5:27 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Feb 09, 2022 at 08:32:15PM -0800, Suren Baghdasaryan wrote:
> > +void vma_anon_name_put(struct anon_vma_name *anon_name)
> > +{
> > +     kref_put(&anon_name->kref, vma_anon_name_free);
> > +}
>
> To agree with Michal, make this:
>
>         if (anon_name)
>                 kref_put(&anon_name->kref, vma_anon_name_free);

Ack.

>
> >
> > -     error = madvise_update_vma(vma, prev, start, end, new_flags,
> > -                                vma_anon_name(vma));
> > +     anon_name = vma_anon_name_get(vma);
> > +     if (anon_name) {
> > +             error = madvise_update_vma(vma, prev, start, end, new_flags,
> > +                                        anon_name->name);
> > +             vma_anon_name_put(anon_name);
> > +     } else {
> > +             error = madvise_update_vma(vma, prev, start, end, new_flags,
> > +                                        NULL);
> > +     }
>
> And then this becomes:
>
>         anon_name = vma_anon_name_get(vma);
>         error = madvise_update_vma(vma, prev, start, end, new_flags, anon_name);
>         vma_anon_name_put(anon_name);

As I indicated in the other reply, there is another madvise_update_vma
user which has only the name string, not the anon_vma_name struct. So
this can become:

   anon_name = vma_anon_name_get(vma);
   error = madvise_update_vma(vma, prev, start, end, new_flags,
                                                   anon_name ?
anon_name->name : NULL);
   vma_anon_name_put(anon_name);
