Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBEA5AF43F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiIFTLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiIFTLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:11:42 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86BE72B60
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:11:41 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b144so7548441pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 12:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=w5HACyk7qZtfk4k6sLXm47Jz7SohkcpzYCPZm4Qovhw=;
        b=diUvTLiw+h79hhqSYAnJNwSPRkd1iPWX5fdPVlO7qXvE+qUW5IlY4N+riprFgHXr6k
         PdunL/+mWBLAV7lPq10sadvcrEh8ttEBQEoBE4IMpHCLvW+0wkoHbrZJYpBY2c1DDua1
         hgXJxgzCWGdvghNgyyutLEQpTzP+RXjqv3cKk9dk4k0O4K5GjHXXr4ezFJcTAziXG0b6
         +WqoqlBz7VXUWFPlByKTBIfNsWU91CO3LzTtufPsmKHryaRKFvnyJS7Wf/m0Sp+UcCc1
         nu/FlDyM07OiWHysKErZlR4CRE19EhFNurevpzExh4vfi7iKocpCJRhFl2AqZBntKi5C
         uwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=w5HACyk7qZtfk4k6sLXm47Jz7SohkcpzYCPZm4Qovhw=;
        b=j9VGgLffLspSA10eCDZ+uE1l54NVWVWzwLTcdpPtpJ1FKj7WaQ5HP9sdF2EROTbGe7
         Tv6Ke3dIxex6ud3PjwHlLBVJxf7YMwujXR+jmLFFt+ycG+o0vu2/FQnbDil5aThNlHXo
         ky9htLbpFZDDLGxP5i+NV5sA3cj7kCSTIIMCWoDx0Ok6Z6UY06zOF36sSJvG4YZSHTcK
         KmUurO/fmO/Y4B2oXB/EBfjIjrFjIjxLDKPONQhWrtjnQOHsM7wec75UIijE3H60ghFS
         mVNiQlspMs07w1IfxbwBkhjl/Iyyz59uTJYsxaGfSbKNJf/2paO05VcNrC5I6J6uvZ9V
         T8Jg==
X-Gm-Message-State: ACgBeo33L+h+ov9wAP7yUtmzHvsepdqhfY2SBvsHwNCd2kqgbbb0KjWi
        0kgXgoPJxtejCnpO21xDkSuKT9e9CywfTj/5th0=
X-Google-Smtp-Source: AA6agR5SVGBUB2XMa2QyGadf0meSM6bevz7OIIXSFjdapIWgrivobT834pCj5HZSTWw4Gui+MtV3s8RzZeJeCyGeFXg=
X-Received: by 2002:a65:6a05:0:b0:42c:87a0:ea77 with SMTP id
 m5-20020a656a05000000b0042c87a0ea77mr84260pgu.75.1662491501469; Tue, 06 Sep
 2022 12:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220901222707.477402-1-shy828301@gmail.com> <e6ad1084-c301-9f11-1fa7-7614bf859aaf@nvidia.com>
 <a969abc5-1ad0-4073-a1f9-82f0431a0104@redhat.com> <YxdPi2E63aO0Dgyd@nvidia.com>
 <4516a349-49cb-fd7b-176a-f1a9479906d9@redhat.com> <YxdZlCly2ad1rtcI@nvidia.com>
 <40486dbb-9f19-6fa6-d46d-99d2b033883d@redhat.com>
In-Reply-To: <40486dbb-9f19-6fa6-d46d-99d2b033883d@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 6 Sep 2022 12:11:28 -0700
Message-ID: <CAHbLzkrot3t5XwvHS4wveOZeK2OxcbC+8DX=UThQTcaFp-Ym_Q@mail.gmail.com>
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
To:     David Hildenbrand <david@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, peterx@redhat.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 7:44 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 06.09.22 16:30, Jason Gunthorpe wrote:
> > On Tue, Sep 06, 2022 at 03:57:30PM +0200, David Hildenbrand wrote:
> >
> >>> READ_ONCE primarily is a marker that the data being read is unstable
> >>> and that the compiler must avoid all instability when reading it. eg
> >>> in this case the compiler could insanely double read the value, even
> >>> though the 'if' requires only a single read. This would result in
> >>> corrupt calculation.
> >>
> >> As we have a full memory barrier + compile barrier, the compiler might
> >> indeed do double reads and all that stuff. BUT, it has to re-read after we
> >> incremented the refcount, and IMHO that's the important part to detect the
> >> change.
> >
> > Yes, it is important, but it is not the only important part.
> >
> > The compiler still has to exectute "if (*a != b)" *correctly*.
> >
> > This is what READ_ONCE is for. It doesn't set order, it doesn't
> > implement a barrier, it tells the compiler that '*a' is unstable data
> > and the compiler cannot make assumptions based on the idea that
> > reading '*a' multiple times will always return the same value.
> >
> > If the compiler makes those assumptions then maybe even though 'if (*a
> > != b)' is the reality, it could mis-compute '*a == b'. You enter into
> > undefined behavior here.
> >
> > Though it is all very unlikely, the general memory model standard is
> > to annotate with READ_ONCE.
>
> The only thing I could see going wrong in the comparison once the stars
> alingn would be something like the following:
>
> if (*a != b)
>
> implemented as
>
> if ((*a).lower != b.lower && (*a).higher != b.higher)
>
>
> This could only go wrong if we have more than one change such that:
>
> Original:
>
> *a = 0x00000000ffffffffull;
>
>
> First modification:
> *a = 0xffffffffffffffffull;
>
> Second modification:
> *a = 0x00000000eeeeeeeeull;

IIUC this is typically a 32-bit thing.

>
>
> If we race with both modifications, we could see that ffffffff matches,
> and could see that 00000000 matches as well.
>
>
> So I agree that we should change it, but not necessarily as an urgent
> fix and not necessarily in this patch. It's best to adjust all gup_*
> functions in one patch.
>
> ... I do wonder if we want to reuse ptep_get_lockless() instead of the
> READ_ONCE(). CONFIG_GUP_GET_PTE_LOW_HIGH is confusing.
>
> --
> Thanks,
>
> David / dhildenb
>
