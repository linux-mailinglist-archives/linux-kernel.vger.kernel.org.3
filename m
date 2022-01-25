Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056CA49A875
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1318888AbiAYDHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3416590AbiAYCEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:04:22 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A30C055A86
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:56:25 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id h14so57128566ybe.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lHJliPzR279xWRXhqBN4mhw5A2O3eJYJXWRIXm9nJ7U=;
        b=c4ZrTT0eAdXNGxCG98ZES9L3QEm5taMcchJryHvpEXDGxCvVOiu3C6G6lxqwY4VTeg
         +hEBfZCBfv44EirmJF5ebHWqlo84cIzOI1qv7F93hN623ipeae4AkA4EOHDlxBpma6i8
         3oC9riKAEO3WD13In52b+XIUipp+YCmsjfBbSHRLu4rAzRJMp0zPvMMxtPcRK8mozBAv
         YR4bj87yyQqxZG2GaJKlPp7fLKve6796XzGnmXSff3aRx8VEfu9vet6Vc8uxD3ciiPJU
         nRZzIpUkhq9la0IwcCePM1vFat0ZVJZcFY2Nj1yRggdjJ6mOeb+QV6wEGdiY0v5wvKu5
         V6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lHJliPzR279xWRXhqBN4mhw5A2O3eJYJXWRIXm9nJ7U=;
        b=Yw7tnxP3o2WZ8IQpvOr7g1w1rBEFe7TjwHmgS0RV1nQrIFfk+rS3wCtYG9dhFTF7ED
         piITk8Olq0Y7WXzjxhUW0AwJiJvjhYHmcVx93LvwG481gps6UsObwhhCfJpESDUL8La+
         6sIE6wSpYFnmb+ialLdCoiwdqWH4p2hrXZEF3b5QBpDzF3um0j3fzawMfHpZv01t44MO
         uYh1Joe+sLL27LHUx4j7ZptpTeOaVo4bL2sMHwId+VXa8tl/oRd/IKQUJxaI5BYGyGGA
         CBDUBziFGM5634QH3sTUNrIzAh9GMYPpQrCjOpsymDw7g7RRmZ/B/HqPRBjRYSrJC22m
         fKwQ==
X-Gm-Message-State: AOAM531j0pECuFI/hPxQuYatrQlefzmlP1slYcv2SDZ8Cz0wpUNH4dYx
        bltR+P3Ihv/k8eFcToC7nw6aRC2qnluef4ZZxJ8zoA==
X-Google-Smtp-Source: ABdhPJyi/CJlc+fw5FPZ/8Fg68s6dHRQ87up3INQgfExn142TqnS/ziNQlk5Fgqvs4Fk1AR7Uy6Zx+eJVOg5mx6zbFI=
X-Received: by 2002:a25:af4b:: with SMTP id c11mr26452669ybj.49.1643075784723;
 Mon, 24 Jan 2022 17:56:24 -0800 (PST)
MIME-Version: 1.0
References: <20220124051752.83281-1-songmuchun@bytedance.com>
 <20220124051752.83281-2-songmuchun@bytedance.com> <4d5044e7-cac9-b6e6-1467-59ea6010b0f5@google.com>
 <5D9B52E1-A74B-4964-AACF-ADB91536C4C0@nvidia.com>
In-Reply-To: <5D9B52E1-A74B-4964-AACF-ADB91536C4C0@nvidia.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 25 Jan 2022 09:55:48 +0800
Message-ID: <CAMZfGtXsLyagpo8rM6RmayAFR_hgk0987X1usxYWRZLeA5H45Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: fix missing cache flush for all tail pages of THP
To:     Zi Yan <ziy@nvidia.com>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Lars Persson <lars.persson@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 3:22 AM Zi Yan <ziy@nvidia.com> wrote:
>
> On 24 Jan 2022, at 13:11, David Rientjes wrote:
>
> > On Mon, 24 Jan 2022, Muchun Song wrote:
> >
> >> The D-cache maintenance inside move_to_new_page() only consider one pa=
ge,
> >> there is still D-cache maintenance issue for tail pages of THP. Fix th=
is
> >> by not using flush_dcache_folio() since it is not backportable.
> >>
> >
> > The mention of being backportable suggests that we should backport this=
,
> > likely to 4.14+.  So should it be marked as stable?
>
> Hmm, after more digging, I am not sure if the bug exists. For THP migrati=
on,
> flush_cache_range() is used in remove_migration_pmd(). The flush_dcache_p=
age()
> was added by Lars Persson (cc=E2=80=99d) to solve the data corruption on =
MIPS[1],
> but THP migration is only enabled on x86_64, PPC_BOOK3S_64, and ARM64.

I only mention the THP case. After some more thinking, I think the HugeTLB
should also be considered, Right? The HugeTLB is enabled on arm, arm64,
mips, parisc, powerpc, riscv, s390 and sh.

>
> To make code more consistent, I guess flush_cache_range() in remove_migra=
tion_pmd()
> can be removed, since it is superseded by the flush_dcache_page() below.

From my point of view, flush_cache_range() in remove_migration_pmd() is
a wrong usage, which cannot replace flush_dcache_page(). I think the commit
c2cc499c5bcf ("mm compaction: fix of improper cache flush in migration code=
")
, which is similar to the situation here, can offer more infos.

>
> The Fixes can be dropped. Let me know if I miss anything.
>
> >
> > That aside, should there be a follow-up patch that converts to using
> > flush_dcache_folio()?
>
> Are you suggesting to convert just this code or the entire move_to_new_pa=
ge()
> to use folio? The latter might be more desirable, since the code will be
> more consistent.
>
>
> [1] https://lore.kernel.org/all/20190315083502.11849-1-larper@axis.com/T/=
#u
>
