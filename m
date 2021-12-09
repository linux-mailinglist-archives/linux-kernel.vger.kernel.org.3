Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC3E46EAF6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbhLIPWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239497AbhLIPWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:22:03 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8A0C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 07:18:29 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id e3so20861447edu.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 07:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5iLRlZbJOhFJD4EQnidHmyuZneL5KPibp0BnEDW6M4E=;
        b=XKxrG505Sz1sZS8PCxd1z/+1G9hIWyBeHrpW/RGRkYyXmm6hiPJhblWxflzSu4LFqG
         iqpjEgy0taT+ew3UUT4qvw4Dr21XYT55fCWa2WGjYRTvUK+Cig11U6IveF6Tgued8h1+
         g8atBQ6kTRWGPou4+2dAHdJ1afUKqCohQrqU11Ct/RA1PZUuXO6MsDEI+vnsVeFcIZEB
         gfCBkmYq05XNPAbBDL8yMKvAljbhOMaoFqF/NnsU4HwFTc5Rb81ualaP5HEtld9DDX5I
         r7/bM11AMehkrpQUF1WSOgRIWgYI8ld0JyDT98uc4v2Uj7ifdVz5t9T9BDjxVaPD0P+3
         0T6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5iLRlZbJOhFJD4EQnidHmyuZneL5KPibp0BnEDW6M4E=;
        b=fJx9IUdPkzxD04tGOMIr/ntl2GUoa1rX9CS6Bf9D+jsppsT+VBrLsZzHSj4jBvcUNz
         7FgJ1/N1MzMQOUamuZ1vc7CbVt2RC5SG9OrMdkEY5qZU8UMnnaXy3QGqQtpCKEyJo5P9
         iWCPy/LYVgga0W255DDM52a0dbJtdKP37BJQJJV9vmU9m/4R4eYoGnNk9aHP2DSOCCJP
         Ig6qniyyhGwUqAndwDeHHPiZULQ9b5gQphJBZyhFNOt499ZBS9mcPt/87w7+53iXUqkF
         ip7cTVspRhTx4kkB53t1DTyou4gv/nv+Z/fYiMdt27u7XRtAwZ1hQpbhzn3JDi90FcPt
         ZfTw==
X-Gm-Message-State: AOAM530QjZdFb13/xJCik57hDgzF2ry5XZdkbMky9pvYAb7m31v4Y0gt
        qnJQWSlwTrtyMZFFuv1FT5BjSAT6FczZaKC7WxT++w==
X-Google-Smtp-Source: ABdhPJwPXyWfT49E05oQInkSdO194qjrWNF44bvD1ZcSTHL7E7581f+iLrsjJJxu6vli7hBtpZ4WRsKKg47fYbK4fso=
X-Received: by 2002:a50:d74e:: with SMTP id i14mr29231311edj.243.1639062996948;
 Thu, 09 Dec 2021 07:16:36 -0800 (PST)
MIME-Version: 1.0
References: <20211208203544.2297121-1-pasha.tatashin@soleen.com>
 <20211208203544.2297121-2-pasha.tatashin@soleen.com> <YbEbvwU81QKK/wUu@casper.infradead.org>
 <CA+CK2bCLkMoJXooxGw-z+-qz20YtE96JxmDYPYM8N0f0eFb52w@mail.gmail.com> <YbFnMnVxftnsxoF5@casper.infradead.org>
In-Reply-To: <YbFnMnVxftnsxoF5@casper.infradead.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 9 Dec 2021 10:15:59 -0500
Message-ID: <CA+CK2bANo3VJ=8VouqqnE8QWUMg30_Sospizk6eXozpzgUB7VA@mail.gmail.com>
Subject: Re: [PATCH 01/10] mm: page_ref_add_unless() does not trace 'u' argument
To:     Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 9:17 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Dec 08, 2021 at 08:25:22PM -0500, Pasha Tatashin wrote:
> > On Wed, Dec 8, 2021 at 3:55 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Wed, Dec 08, 2021 at 08:35:35PM +0000, Pasha Tatashin wrote:
> > > > In other page_ref_* functions all arguments and returns are traced, but
> > > > in page_ref_add_unless the 'u' argument which stands for unless boolean
> > > > is not traced. However, what is more confusing is that in the tracing
> > > > routine:
> > > >       __page_ref_mod_unless(struct page *page, int v, int u);
> > > >
> > > > The 'u' argument present, but instead a return value is passed into
> > > > this argument.
> > > >
> > > > Add a new template specific for page_ref_add_unless(), and trace all
> > > > arguments and the return value.
> > >
> > > The special casing of '1' for device pages is going away, so NAK
> > > to this user-visible change.
> >
> > I can drop this patch, as it really intended to fix existing oddities
> > and missing info. However, I do not really understand your NAK reason.
> > Can you please explain about the special casing of "1" for device
> > pages?
>
> $ git grep page_ref_add_unless
> include/linux/mm.h:     return page_ref_add_unless(page, 1, 0);
> include/linux/page_ref.h:static inline bool page_ref_add_unless(struct page *page, int nr, int u)
> include/linux/page_ref.h:       return page_ref_add_unless(&folio->page, nr, u);
> mm/memcontrol.c:                if (!page_ref_add_unless(page, 1, 1))
>
> 'u' is always 0, except for the caller in mm/memcontrol.c:
>
>         if (is_device_private_entry(ent)) {
>                 page = pfn_swap_entry_to_page(ent);
>                 /*
>                  * MEMORY_DEVICE_PRIVATE means ZONE_DEVICE page and which have
>                  * a refcount of 1 when free (unlike normal page)
>                  */
>                 if (!page_ref_add_unless(page, 1, 1))
>                         return NULL;
>                 return page;
>         }
>
> That special casing of ZONE_DEVICE pages is being fixed, so 'u' will
> soon always be 0, and I'm sure we'll delete it as an argument.  So
> there's no point in tracing what it 'used to be'.

Sounds good, at the time when 'u' is deleted we can also address
inconsistencies fixed in this patch. So, I will drop it from my series
in the next version.

Thanks,
Pasha
