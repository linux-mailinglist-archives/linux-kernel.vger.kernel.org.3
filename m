Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3C846E03C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbhLIB3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 20:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhLIB3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 20:29:33 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20DEC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 17:26:00 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id o20so14405042eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 17:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+fuNXLJ3fQkPjB7+VT61GrrAWzjVIzpFysNrMVt/Cc=;
        b=g3rfkKvF6kzXSfsCgWvrU21T/Ck0C4i9MxJJBdmYZzdAAWjdS+EbZSKCmvH2hmgLi2
         BBjRf0i4fVJwoLJGDs0DIh2LMKKm14ht/n0drXR1DcaqyOXwnX+fapyn97W9fsD7R4kY
         QhdIfS8ujS9yuv0ETgNo1Eq7RHzj5HkMwtQWKVb1CiTEtPQMIpw0qxPN+YSFQebSodj0
         pdplRkcyKOqp325cl+kJ9JTgm1PfmghTy6UTHhmvqeq7seXMeii+b6cYwJn5TfmdGK12
         LNf6JhV1d8etfWFgdWzCPZHMFfgbLR0G4piURqkIJiiuJpPLho1I0turb+fO8DNpwO6q
         aN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+fuNXLJ3fQkPjB7+VT61GrrAWzjVIzpFysNrMVt/Cc=;
        b=HxoKshAHo2r2Z4WvGJDKsJX+vZTcd8d8mx8XQ6sTuEhfriA07Q2l+f0ns0vaedwxuj
         nLVcMlK/ph60r3TzaTPVp0+rwE1wNMDXrA7RBZqFtQAFOn6qhDgsPzs7C8rVzQH5UpYN
         0zwybAfc0owrbRIPYnDNuU6euCzD9phQfY24WN7bmm6r18UTMpT7YNL1JyHF8Ed5sES6
         FI0CRyLqk+sukOWWp30G0qAmKoKI2jzpdh7Ave2ICKsGJNR++gussawfXgM4vO+dVhbx
         GXTsezAeACmBV1qzXeqXl7j5GVNWiShp4EOOYmQwCD1OM4CWGwgFHw3zVUNZjSjkb4DZ
         6xzg==
X-Gm-Message-State: AOAM5321Dv+7PBdswm9AA6nbuE+87Cw8HzAy7XGStmhkxwrzKkLpF1tz
        49w+RMPoyuCEXqzeGKMyBIJRO679lVswJlRQIWR9UQ==
X-Google-Smtp-Source: ABdhPJz8C2Y7erRJC6NmYq7ap+UoZBDEPHFWBCGse7K+mEgnOYzI2F+CDkmK3hjtJMdGob6dVFc0G22KDL74Lels1tM=
X-Received: by 2002:a17:907:608f:: with SMTP id ht15mr11470872ejc.300.1639013159172;
 Wed, 08 Dec 2021 17:25:59 -0800 (PST)
MIME-Version: 1.0
References: <20211208203544.2297121-1-pasha.tatashin@soleen.com>
 <20211208203544.2297121-2-pasha.tatashin@soleen.com> <YbEbvwU81QKK/wUu@casper.infradead.org>
In-Reply-To: <YbEbvwU81QKK/wUu@casper.infradead.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 8 Dec 2021 20:25:22 -0500
Message-ID: <CA+CK2bCLkMoJXooxGw-z+-qz20YtE96JxmDYPYM8N0f0eFb52w@mail.gmail.com>
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

On Wed, Dec 8, 2021 at 3:55 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Dec 08, 2021 at 08:35:35PM +0000, Pasha Tatashin wrote:
> > In other page_ref_* functions all arguments and returns are traced, but
> > in page_ref_add_unless the 'u' argument which stands for unless boolean
> > is not traced. However, what is more confusing is that in the tracing
> > routine:
> >       __page_ref_mod_unless(struct page *page, int v, int u);
> >
> > The 'u' argument present, but instead a return value is passed into
> > this argument.
> >
> > Add a new template specific for page_ref_add_unless(), and trace all
> > arguments and the return value.
>
> The special casing of '1' for device pages is going away, so NAK
> to this user-visible change.

I can drop this patch, as it really intended to fix existing oddities
and missing info. However, I do not really understand your NAK reason.
Can you please explain about the special casing of "1" for device
pages?

Pasha
