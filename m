Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3956546A92E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350171AbhLFVNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350145AbhLFVNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:13:50 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67113C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:10:21 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id t8so11622101ilu.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 13:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GUxfKoDv8z2/c9DMn4X/UBtkOA/EQ1ICoguN1dwTi3o=;
        b=h7sLOi98izy1L6V0rsFoyeuHGNl8XXTAzBkogJ30HNP4Ajp/bNZiTIPuMtJKYDoJu4
         ByeiXReg/fFEuNF9YnYmZZbTlEdZVz5Hw6VxPnU0VqmrMtuM65B++NGfW7+u/j5QZYda
         8NMUP4AzicaKqJuKzi28IleSeqxkW82a3LNSCOwo8aClhk3OlQhSCvWmqJrgoHRUwVRQ
         wn6ZAVgNuf+cOIy4hanZieaZhgHO4EmFvpETy8w3v4ODft1XcG0OguvqPcK9juboFnaZ
         wXlV75JpCSQRi/icW/3roNB6gX9mZWPzl3MIkvzDaxVoC6zxwlb+/gR6ZndywmOqmAOq
         7vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GUxfKoDv8z2/c9DMn4X/UBtkOA/EQ1ICoguN1dwTi3o=;
        b=lIhdDrnB5gs8AZWE14T6juY9CzOLp9gqPxk2hEhqCYZuadsxudOyKQOo9+u6gMC157
         9dKgSgIqf5EKkaBC5YXNCl0Jfcho+RlQAUZUCro3gyz3p0N7hCm0Pv/FjH+y30qGFMSZ
         gAKbGtNnO2dwTGw/a+OX7n2W+oILxIagBH/d3IpA2d02LvId3BKM9sGcCDumlplOqMyI
         LFbpbuY27o1UFJplArlc+OLh74GVzIA56OWRHrYrEtZDk04Mj+XF6gsljUDO05M/kAui
         I9f6LZOn4Kazgm4i1OXUiTXI35C71mxh6fEkMdHQjXasKKKpMUlIc9ECeauq9b267Z3K
         4mkQ==
X-Gm-Message-State: AOAM5301YNvILxWjeY74NVsUuFnBAhW2ZiBqT5faC52MmbBF6cpl1zBm
        sBLGP60whmTBn0GxksoEVFnPDzUzDuRXHVJlAxc=
X-Google-Smtp-Source: ABdhPJz2DOMXOccZfHQY07e8uJ+O5hNM6bZTVJRok76GZsoeWgURe34Tq0mIXYxGQCIZbGJI+DG4mvJ5OiDElcu1WFo=
X-Received: by 2002:a05:6e02:1d1b:: with SMTP id i27mr37211121ila.248.1638825020893;
 Mon, 06 Dec 2021 13:10:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638308023.git.andreyknvl@google.com> <f90dfb0c02598aab3ad1b5b6ea4a4104b14e099d.1638308023.git.andreyknvl@google.com>
 <YaoPpPAKi0/OZB2f@elver.google.com>
In-Reply-To: <YaoPpPAKi0/OZB2f@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 6 Dec 2021 22:10:10 +0100
Message-ID: <CA+fCnZf08U_nZzR2snKs_SBXjB8WhSDARNpP3d+wMwgFvDgoHg@mail.gmail.com>
Subject: Re: [PATCH 23/31] kasan, arm64: allow KASAN_VMALLOC with SW_TAGS
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 1:38 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Nov 30, 2021 at 11:07PM +0100, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > vmalloc support for SW_TAGS KASAN is now complete.
> >
> > Allow enabling CONFIG_KASAN_VMALLOC.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> This change is small enough that I would have expected the
> lib/Kconfig.kasan change to appear in "kasan, vmalloc: add vmalloc
> support to SW_TAGS" because that sounds like it would fully unlock
> core KASAN support.
>
> However, the arm64 change could be in its own patch, since there may be
> conflicts with arm64 tree or during backports, and only dropping that
> may be ok.
>
> I've been backporting too many patches lately, that I feel that would
> help.

Sounds good, will do in v2. Thanks!
