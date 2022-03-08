Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1B34D1FB9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349393AbiCHSK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349385AbiCHSKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:10:23 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6ED55BF6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:09:25 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id g17so10226376lfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 10:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RS1piInEaOeeJ3BDgDddW1T9qJEE9ha7V/8+KCGHJs4=;
        b=FypS7Blo0qMP7/3LOa6IVn8CAPTMF+izTGzqA3XGVR7D8JIfKdqgYLlYhP86WheDPx
         nzZcVKR0AoJdgAQDhSO5pxK5/n2u3LQAxftxbH5KrQWPdtILAyU5f673z0muQV/8Nxdj
         UQjy7jPKMB6hD5+0kStcLme0wEoTcq2zMZ3uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RS1piInEaOeeJ3BDgDddW1T9qJEE9ha7V/8+KCGHJs4=;
        b=JtFBu0NIAFtfQLXEwaX945KsuJIAG5OkIzeUZMdPXqPC1hhI/R80CuUt8NLg2aXqBx
         7nxJFE1n/j3eg5OVY03AsStsIDiMNvUiBE/vkCN4gJAW3xPfBQ78dAkEZysMjuVMLNuW
         MMqJTJ5baXaPNkb3nr3mpi1ipwVlaOi1uFsFgRI/gBkUpuS8k9ypu5wCSuFtbENes/tu
         i3Bio9p7GI5IXZ7otZcMOY0lgH5flHNdudKlTkzwS1YV0VwhJDGozJ9lqXoR7mXt4w+2
         h7YTCHfr1B72Occl96fkPEqBOOnke32H1K2vstUNAfq01qhi6VctwRI3xPtowzxvSJQZ
         7F6g==
X-Gm-Message-State: AOAM531r8bBDhdzQaI6lVTxPiATIuaIVSP5c0sUMlGuuTwtmFd10FzKl
        2yHGDTF5Y636PSRIlrMqOhQdD3+LG/HN52uM3Ts=
X-Google-Smtp-Source: ABdhPJxAIU+DPwtZZLvVcjpNKlhW+DJZ2vMJD3SElEARl+i5UsglN1zCMsYahtXCJa9ntk+NCQiXBA==
X-Received: by 2002:ac2:4202:0:b0:444:14bf:86dc with SMTP id y2-20020ac24202000000b0044414bf86dcmr11657834lfh.126.1646762961294;
        Tue, 08 Mar 2022 10:09:21 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id m10-20020a19434a000000b0044830bd2d35sm1337234lfj.278.2022.03.08.10.09.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 10:09:17 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id o6so26174465ljp.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 10:09:16 -0800 (PST)
X-Received: by 2002:a2e:924d:0:b0:246:370c:5618 with SMTP id
 v13-20020a2e924d000000b00246370c5618mr11412286ljg.358.1646762956411; Tue, 08
 Mar 2022 10:09:16 -0800 (PST)
MIME-Version: 1.0
References: <20220308141437.144919-1-david@redhat.com> <20220308141437.144919-6-david@redhat.com>
 <D7AB3A84-3FFB-4E8D-9E68-BF721CC4C6FC@vmware.com>
In-Reply-To: <D7AB3A84-3FFB-4E8D-9E68-BF721CC4C6FC@vmware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Mar 2022 10:09:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiYw9hb-EtjcQ2WDSh4TMCWjJmYitfAn=0y_gguhDtf8Q@mail.gmail.com>
Message-ID: <CAHk-=wiYw9hb-EtjcQ2WDSh4TMCWjJmYitfAn=0y_gguhDtf8Q@mail.gmail.com>
Subject: Re: [PATCH v1 05/15] mm/rmap: convert RMAP flags to a proper distinct
 rmap_t type
To:     Nadav Amit <namit@vmware.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 9:15 AM Nadav Amit <namit@vmware.com> wrote:
>
> It would be much easier to read. The last time I made such a suggestion,
> Ingo said "I personally like bitfields in theory =E2=80=A6 [but] older ve=
rsions of
> GCC did a really poor job of optimizing them.=E2=80=9D

Yeah, even not that old versions had serious issues, iirc.

Bitfields can look nice, but they have some _serious_ syntax issues.
In particular, they are nice when you want to *test* one single field
(ie bit in this case), but basically atrociously bad in almost all
other circumstances.

For example, passing a bitfield aggregate as an argument is just
crazy. Oh, you can do it, with syntax like

    (struct type) { .field1 =3D 1, .field3 =3D 1 }

as the argument but when you say "much easier to read" I laugh in your
face and call your mother a hamster.

And that's ignoring all the issues when you want to combine two
bitfields. You can't do it. There is nothing like the binary "or"
operator. Again, it's easy to modify *one* field, but taking two
bitfields and merging them? Not going to happen.

So no. Bitfields have their place, but they are close to useless as
"flags" type things that get passed around as arguments, unless you
have very very specific and limited use.

                              Linus
