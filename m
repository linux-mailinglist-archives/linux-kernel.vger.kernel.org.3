Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FD6585422
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 19:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiG2RHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 13:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiG2RHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:07:05 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB8054ACD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:07:05 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c3so5119497pfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9o/kpxtwtGSAJRz7togZqH/jX2IzYG9txOU/MkOdGsk=;
        b=d7rrhYFDw6/dZgg1zbGYEELi+Ig6rFIt8U9NslLM0uU54fjiN5LGx1yttndq6MRsU9
         +7RsjMcHBPvo9jWret2P4sPOppbiMdG8cI1kd+akSPTG+EObbBmqLkCpNfuGcK8v3et/
         00EpnIyAJBLgzqog02E2FLDm/yJUXIJ24ox/5REaSArOoUXct80bc5LcGQIzVSKmN6DM
         Zv7n761ElhQDgSA1FTeDvln1HSKX32ZpEXSPVXF5BhIwAT4/VNDBqvWnrmu3oVxPtDXx
         9fH7sPTJB4vfg1PdPzrZtt3Sh82x5Vf8NAASPWzFvLQmI4EvMB13nINjdJy2lWSs8Oo/
         RhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9o/kpxtwtGSAJRz7togZqH/jX2IzYG9txOU/MkOdGsk=;
        b=DSC6DNWWMseEBZqOzRcFP1LBoI3hWNkFshLxWbqwlFKCrPyQxGboGkuxHMeS+YTdrR
         GYb7aicW1ARnA+KKuQeG/A47bM+Zn0ICRFhxmlEIjMMKX385M1N3RdIjN6s+p9vMkAky
         XSg0NQifSYOpwpyXOeFzipkrZtdG/T5HdVFvspeM6ob4cfUNNQLZcSC0zLzpIswmpZ96
         OAzbOF2u8k0O8qm4OPk2enYHCEruBYS4tU5zqxAWNgNMk+0DItdX/wP1nIv5Rpol5Uws
         4i5XRSR+CoPbrUrI9McnW7Eadri8oDTvUfTRv9+pGyZ4ZAWY15qK0htViZSenzBYv0Rb
         uPAA==
X-Gm-Message-State: AJIora+Bpbbox3KcjKU9qlo3P2XQnoaZzJwn0zhgRF550iadNqu6gJDZ
        KAOIEJHkUWvxgXYUIWD2xqU=
X-Google-Smtp-Source: AGRyM1upLon9wbIMfbCwqO3JYhACcZurI2iHO4roReNV/ZHzKqhAtd1uue50i8179qkbq7tKRlvklA==
X-Received: by 2002:a63:1213:0:b0:41a:8d6b:3e80 with SMTP id h19-20020a631213000000b0041a8d6b3e80mr3571086pgl.388.1659114424345;
        Fri, 29 Jul 2022 10:07:04 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.113])
        by smtp.gmail.com with ESMTPSA id y62-20020a62ce41000000b00528d580cb45sm3145326pfg.127.2022.07.29.10.07.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jul 2022 10:07:03 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH RFC 0/4] mm: Remember young bit for migration entries
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20220729014041.21292-1-peterx@redhat.com>
Date:   Fri, 29 Jul 2022 10:07:02 -0700
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C0B267E-E36D-4014-8308-B948247D7FED@gmail.com>
References: <20220729014041.21292-1-peterx@redhat.com>
To:     Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 28, 2022, at 6:40 PM, Peter Xu <peterx@redhat.com> wrote:

> [Marking as RFC; only x86 is supported for now, plan to add a few more
> archs when there's a formal version]
>=20
> Problem
> =3D=3D=3D=3D=3D=3D=3D
>=20
> When migrate a page, right now we always mark the migrated page as =
old.
> The reason could be that we don't really know whether the page is hot =
or
> cold, so we could have taken it a default negative assuming that's =
safer.

Looks good to me.

I just wonder whether the order of the patches should be different. I =
always
understood that separating the =E2=80=9Cenabling=E2=80=9D patch from the =
others is not a
good practice, since it complicates bisection. I guess it is more of a =
minor
issue for such a small patch-set=E2=80=A6

